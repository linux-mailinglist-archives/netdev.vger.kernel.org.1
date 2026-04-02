Return-Path: <netdev+bounces-274529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIsnHgxozmlRngYAu9opvQ
	(envelope-from <netdev+bounces-274529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:58:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABC438952B
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FAED3020FC9
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 12:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2CC3E5EFF;
	Thu,  2 Apr 2026 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JViMMnuh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5793E51DB
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134510; cv=none; b=agO16YNGENDmPFKXqLoLacB+R9PLdOQ8N7zKdxy4ALCWsrCSC+SEpdfEa51eEYldo4jgtNeJ+VdzzGRDmqk4D31raWreui0KRJ6DL/mn33YoTfaOx26qtk8fxuYrSGfha3WSLuHJlmPyWPRJlIOLdPDoJrir2Bz8LdlmKvyVQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134510; c=relaxed/simple;
	bh=0EExnHRsi8qpzqXO+XeoCnMx5K/0WcTSOtlzYNAHJIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV0YwotMytQHOV+rHmZHzkUsUZFHjhsGuV1Gax8PN7owrvqVGwmY2xdFXO6a/w1LokO6Rw5zdlhXFXl0eRa9nVEnjNQ0qerC9R3Tsw0raGlBX55ctKN5SONsc2g8pc4VCIpD7/xWQM6rVQEEgaSPbw8tpsOd1lrzum4L8xKQHNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JViMMnuh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-483487335c2so8085605e9.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 05:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1775134496; x=1775739296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c5UfMDLJ2KJzfp9G85RI0M9qPEewqJ6RkFSMS1YKOdQ=;
        b=JViMMnuh+7EhVhiXoeNY4nENXzBPNJQRqvInu6vkgqlrUF+uGCvVKCYURq61uY10YT
         4m6NYGI+3Whb3iybZcHjptmSyxN8xtOJUJtkzR/to51wEi/2fH3vg/Zxwk8Q6/3I8GWM
         CskgKnQp21r+KttV3e2dP32SozsKLwhsSUhENyCXQqqg+jbHtNTrIDK9v3Waw4uu012J
         nW0HZV9TwPeWaGhz1/Ov9kJ3jOUXhzLI8gq6HfXGHkdlRo4TqFzfEpsWuKXL8UF+MAKQ
         WQpb9xOS6owzO4sY2aw64j2Krah9khCIGi1+BIBlOVvLYdpv4Of31dnLaXfsqpirGYVq
         ghiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775134496; x=1775739296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5UfMDLJ2KJzfp9G85RI0M9qPEewqJ6RkFSMS1YKOdQ=;
        b=deu2uzk78h1SeBbEQSsKyqg0yIh1LONwVm5z6aQBSR4Qt3glm9jXoyxeV/PTHG/4bk
         kBqBl79rk2gWltgt5izYntllgtZjYsTiP2PT0jlwWqi3couV1KHRbkYiJN0xLZQHVg1t
         NpGrkyDRw84WrbJ649AMdAYVuuirW+qwas+mkLi1fNbKyLA6GJ2gJ+2lpfSm2P3FEyja
         SZgDJ4yiWa5XYgWoJtovIcvjcno+Lhbb9hjg6hqM3dajdcEzEjCGg2UROYw+T1BPQbjm
         bF1CIhi5UMAfvx2tZ1rUxHa+jB6vJY5fAOOvtAh5pSuqc4Ouw8MpMRrhWy01zD4TXSMS
         Gd6w==
X-Forwarded-Encrypted: i=1; AJvYcCW0cD9x4DI5+2fnDZmR2nyzzM2t7hb6Yy22MIudk6+fyGqi/jRNgNvEdJurjabvQtGyKsfO5mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQD7QkXHCgNvDj1PpygYfdepw0X3ewJIsVbhpw+Y2+uepJwYX2
	/YRFYzVNGz4R5Y5IYu4VYATz+qhOC/p5fHs0MWVguovdYcmj9uBb+4KBnzgiwmBZns0=
X-Gm-Gg: ATEYQzxz4wqT4ZagxttUGE9Fo3YLNDpNPW0ihl/sV1klhqNfjeSQ0E1UTGOiXKQigXZ
	CEvPu43RabTEr2nOQdQmoxk0z3GRLwtSu2Bd1E+EeT9sFgPbF5HNOsQ81St/p0BeZymADnSpWxL
	3d/wFySLfp+Zcu5iGjRQrgr/CvUfBB+IHQdc6onUQGHPWVjo8ejAq/YTbHAlbOU0ZqqVfugFylt
	etVj5pPSq2nNOmWJMmwXR/T/2XXbGgq1C+1RHkjnLcPdEwst6xNa0wlWa9x2wxf6NlQYQrQmlDO
	ri3CgLBsX0YyqY3mTM1glKljI4MWMk900O0hFmokDwumCRbhbWcdn+auiThwyZlb74DNpWwyJwp
	vinWFVOgxwBxmqQ5LM8vXP7hWXarXdMudph94/4O9pC56Rar2vAaXuIie0C8jtAlavviOnRUbJX
	Gf4d/TzT3ky//zXd2LVFN/7G4t36uSZBlQORogfizJpQ==
X-Received: by 2002:a05:600c:8b66:b0:480:1e40:3d2 with SMTP id 5b1f17b1804b1-488835b7bd9mr133099685e9.29.1775134495637;
        Thu, 02 Apr 2026 05:54:55 -0700 (PDT)
Received: from FV6GYCPJ69 ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887adc5690sm114520655e9.2.2026.04.02.05.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 05:54:55 -0700 (PDT)
Date: Thu, 2 Apr 2026 14:54:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marc Harvey <marcharvey@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/7] net: team: Decouple rx and tx enablement
 in the team driver
Message-ID: <j4tjzpbsfu57r5bbqcpo4lfnzzonnmgye23kiyu4la5d7cxuq7@63nrgj4f3xto>
References: <20260402-teaming-driver-internal-v3-0-e8cfdec3b5c2@google.com>
 <20260402-teaming-driver-internal-v3-6-e8cfdec3b5c2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-teaming-driver-internal-v3-6-e8cfdec3b5c2@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274529-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6ABC438952B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, Apr 02, 2026 at 08:24:19AM +0200, marcharvey@google.com wrote:
>There are use cases where an aggregated port should send traffic, but
>not receive traffic, and vice versa. For example, in the IEEE
>802.3ad-2000 specification, there is an optional "Independent Control"
>version of the mux machine. Currently there is no way create
>implementations like this for the team driver.
>
>Separate the existing "enabled" per-port option into tx and rx
>specific enablement options, but do so without breaking the existing
>"enabled" option. The existing "enabled" option is now defined as
>(rx_enabled AND tx_enabled), so if one is independently disabled, then
>the old "enabled" option will also not be enabled. However, setting
>the old "enabled" option affects both the rx_enabled and tx_enabled
>options. This is the first case where setting an option can affect
>another option.
>
>Note that teamd and any other software that exclusively uses "coupled"
>enablement will continue to work without any changes.
>
>Signed-off-by: Marc Harvey <marcharvey@google.com>
>---
>Changes in v3:
>- None
>
>Changes in v2:
>- None
>---
> drivers/net/team/team_core.c             | 238 ++++++++++++++++++++++++++-----
> drivers/net/team/team_mode_loadbalance.c |   4 +-
> drivers/net/team/team_mode_random.c      |   4 +-
> drivers/net/team/team_mode_roundrobin.c  |   2 +-
> include/linux/if_team.h                  |  60 +++++---
> 5 files changed, 245 insertions(+), 63 deletions(-)

I see multiple patches squashed here. Could you please split for
easier review?

Renames separate, preparations separate, adding rx_en separate, adding
tx_en separata etc?

Thanks!

