Return-Path: <netdev+bounces-257497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFwRKyS0hWmbFQQAu9opvQ
	(envelope-from <netdev+bounces-257497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:28:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 513FFFC05D
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F793078B53
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 09:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E4E35CBA1;
	Fri,  6 Feb 2026 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hA7rGr+v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3135B64E
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770369857; cv=none; b=leZUlf3MilXOwSgFYKh3RtR+jOjJHk+bmjxv2ExgDIKTw/BYRMskTjwU8LU/4gXiCiYQfKyaQargI1u9NRQPAKiWEid9pnsKDrj+DwYenwHgaEYLUJwyAPogKWwYXUaLXUocPvCO4nepXFC7dFjydJ5tJ+ThAI1S5SaEN1i1MNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770369857; c=relaxed/simple;
	bh=P50Q9DHDNQka2qrgw513BMd3JIx3mSPm10k7dGqR+X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxtkKfBJnnmQAQJt2EreLEmA/DiS9dwU7/LiTE9t421wJX2eCnfeiMc+i3sN1tZjwI65ml/CKEbLgDkVaPAdMcsTkt1Syk3YF+TCf+X6U5zYskc3sg9pYa+fP481l4Q5/Ef0zP3x5CoLdbnyhClDhyAbQabNqg1bJ40gm6BAcko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hA7rGr+v; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4362c63531bso238757f8f.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 01:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770369856; x=1770974656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P50Q9DHDNQka2qrgw513BMd3JIx3mSPm10k7dGqR+X0=;
        b=hA7rGr+vuf0mvhOas6mZuuAsd6tK6ALSjbAZ/qxozj4H/A7N/1wQ6/FUpAFkUjPxlY
         KKW2OUSCgEYyyF1rdvsxNIKlQ3ooQHN3cUjA59CLk2tipXiEZ/7LbmR44b/OHmONpI0Z
         +mI9Hg5iYcJQ3deDEjmj24WoAhS9xaFNdKSr4TuyL/dyeOkn5wI8H2HIrvCpqpQIJgpB
         pEZoI9Y/tLQDPjP2CwsDuotVOrn/JEJ0OkEk53jvXUOnicnZT/w9/lETYxPpcGNjeu/Q
         UXZmRNmulTQ2UyTUosRWcioXUHcZPaQaGxtEnGMbh6iZmcmikdpmopjcpwCMeGTJL23y
         Po6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770369856; x=1770974656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P50Q9DHDNQka2qrgw513BMd3JIx3mSPm10k7dGqR+X0=;
        b=J9whQCT1H/pLmRClQGJpycosCFf6auo15y7vfnen7nxY0zqA+QgCXgrzrGirO5uOEp
         eXwTRc9vsKUL08AUGYzOlQ63r41FzQrmuScHOsalDB/oAfyGwEHZ5DHOHyI8uY3uIWXX
         kzkBRHx+N9HN61IYcmRTtUH/+Gw5f8Hmv4AKA/ehL8b1cTu4e7qSaUKUBBoknZkxSaNU
         GtBEogAg2wS1wUjDU4dFg1z5ftKj5dFehRnlGyEQasjssQx4HvfDeLh97rp6MN1gR0EJ
         ZT+vQt4OAEoZUTB7mP+VwtC9BWck1aQuTryp3VF2OTwXWJ9TKLRko7CAXQ6tVN76VSf4
         NoWA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ6yLWAwItYa4iVW8iZr4k+uwfYywQ3Q8k/riKnezx278Ls1+TqeypX2U55C4Wx5IJxJkYOBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7eZ8+Ve0nl28GvxW8rtSIKt4jvrSxgayQjKRAkB8ylssaMG2v
	eAiyZOogo3lWAJ201FQEnwjnXHuVNtF1shzOgvSjffKfUj3f7EGhw6HzMddyFFrV8pc=
X-Gm-Gg: AZuq6aIFQkA+3g4639Y9j423fA11e/+aEGlSB5fi9+z4UO4g7bXeuhpzejAfOymdacH
	9kf+v+V0A2IUok8SMYwtTWIpQo9pGy72pCnjM/ilw6htjCQJZzbtNAAxuz07SlDY27ASOKPvDTj
	LsFKWh4G6N0MVOmrzF7tMcvjcfCPLjUfo6sZDKaCEUdXjkEBtpY3qM1lacIsXZ8nY0OknmkjLeq
	wyhJv3QT5ib2TxX8LR644uRFswQSbPNJzBSwxMVmUEsD62HUDpEzHAdFPhahdukmsNj/8Q+fbFw
	rAMggXZKze91uwJQVTlCLpnpuqedsXIpSMkr5ixcj6vy9tlCTZrj/beaaCCeuLeSAw5JrK0LZYi
	ko6U0RwPiaMakpC5n4A/QaZgJJtqqgiVnOl3/kfV5HB19Ch9fM0Y+1n/zPNMkOu/AwKgpZxMmuz
	8KHTtGoU+rY3+pQKKFAvw=
X-Received: by 2002:a5d:5d13:0:b0:432:851d:35ef with SMTP id ffacd0b85a97d-4362937dd22mr3165723f8f.42.1770369855926;
        Fri, 06 Feb 2026 01:24:15 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b25d5sm4583939f8f.2.2026.02.06.01.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:24:15 -0800 (PST)
Date: Fri, 6 Feb 2026 10:24:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V2 0/7] devlink: add per-port resource support
Message-ID: <7rmcwov5zbu4blljlnwfzhobmmjsitih3t7w7vabpmkigat6du@erprfflwyiqx>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205142833.1727929-1-tariqt@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257497-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,nvidia.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 513FFFC05D
X-Rspamd-Action: no action

Thu, Feb 05, 2026 at 03:28:26PM +0100, tariqt@nvidia.com wrote:
>Hi,
>
>This series adds devlink per-port resource support.
>See detailed description by Or below [1].
>
>Regards,
>Tariq
>
>[1]
>Currently, devlink resources are only available at the device level.
>However, some resources are inherently per-port, such as the maximum
>number of subfunctions (SFs) that can be created on a specific PF port.
>This limitation prevents user space from obtaining accurate per-port
>capacity information.
>This series adds infrastructure for per-port resources in devlink core
>and implements it in the mlx5 driver to expose the max_SFs resource on
>PF devlink ports.
>
>Patch #1 refactors resource functions to be generic
>Patch #2 adds port-level resource registration functions
>Patch #3 adds port resource netlink command
>Patch #4 registers SF resource on PF port representor in mlx5
>Patch #5 adds port resource registration to netdevsim for testing
>Patch #6 adds selftest for devlink port resources
>Patch #7 adds documentation for port-level resources

Could you add dumpit op for the current devlink resource? I think that
was indented originally. Will help to see the whole code-picture :)

Thanks!

