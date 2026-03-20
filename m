Return-Path: <netdev+bounces-270099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLZeKT3SvWm8CQMAu9opvQ
	(envelope-from <netdev+bounces-270099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:03:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 452E92E230F
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38E1B305A402
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087D83815CE;
	Fri, 20 Mar 2026 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="ceqaioKz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AED38E11E
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774047757; cv=none; b=b0WLLwaC85FRSh+9WeR0C5JLAS53/Sw12FPvRzA7JbUDnrq+MYL24DawjAO2WZnozBkhjf5Oxwpu+71ksdPXsYWSNdWFVBbZI0j1O5zfRen6A7NDSpuj4taScFQ0h70vPiFGI+gWPPVdPSi3hc7BHzcZ5XZHzDtNddLmrsH2uh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774047757; c=relaxed/simple;
	bh=7UcKqNqUMGElXvB3apCmM1Rrjy8IGPj9FQ52Qpbs9gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAVI4gc0V0pUDhMiYHjC/mFTDHHYl/yPy3HYtmsyAeNX0efArF9FT1dEnL1hSZL/fN0rW0zhBSkbVu8iFkD0774/19wiQ3ZVbjKnA/PJjSnZE0r6xblLOVb7T6yT45BK52X4HG32cvjWW0OCLCIdATIuJnPUmT6G2jqdZoL6cXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=ceqaioKz; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35a1cc6e478so1645846a91.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774047755; x=1774652555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJCb1rgMxhRDKaUdftwMEyliYc1In3VuNS5gMJ0u0Zk=;
        b=ceqaioKz0tzFFt5RQ6hWG6w6rVEO93frW10h88GxPSRWHPACeEtPeR9nzNxI8gHg3s
         Rx5JVpS4OV/KFzqQ6tIhWjzCL/CG2FL8IwEwz4t8B1lgvbRVRAlMtw7fPZp0WsMsh54a
         IpzUkqdoVhCyhci4TW4tinYNXTY0YOkuLjbABAROWDa9nTr77GEOkekC/e9suMgCZF9o
         ZXVxjSDUFzQhsFbda8v3U9KxJPZUkoN1gUDYePt68SAC+sa2L83TlJmNl/8PF8Oe3Lu1
         NxsaD24yUJXquSPNO6Keh6xlyk2neBpQcfXjAlANgQka7Z8ccZimdEz5ycWaI4WIltzB
         AOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774047755; x=1774652555;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJCb1rgMxhRDKaUdftwMEyliYc1In3VuNS5gMJ0u0Zk=;
        b=ctOiqAuYfKR+IXq2sfiCrmQIDM90DWTdEdmP5kbd5hqPxT8+h/XOXsqlG+rsqVLPCa
         rHG8+KPSsg4bq9cukV7jqKAwY4GyswVMoofCHHIyss144rAbQhrRYVJBsYQbpGc0jdZo
         CF0eN0vki20BiwEeoXNPqrKirY1HUBrkTGAIMRpm34D4NZmfLJU0BdDhKKEZNyOWwJfw
         bdyDTzVpYil1o9DjzREl3NyQ6VThfJqJm4iTR5Zvqa+dK9ZRin0AT24qqVMtMM4ShBYe
         U57U+vdjRPK8+bhwKlPvkh685yey1LWumn8DofrN6kLw7GeinDLeKIOHjt+D2VxIAUga
         0+kA==
X-Forwarded-Encrypted: i=1; AJvYcCVkrNfXeNqZkgePMIZ22IUIAIA/+ea2X8vKTSYZqfpzN6/kXSwE/OXxZy4b6VfGefZk2pnxBxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqb8s8prDE3Ck2cXhnWTBNDayOpGAY4E17U3b4I4vZZ1noWDXY
	rZL/dqfjv4eVrxMPOtSDFyHIRttkzkKu5z4NnwmWFqrcaYp2bYOrJCOCl9omBU0qUXL7gFVZ1rJ
	RC/HdF3s=
X-Gm-Gg: ATEYQzxegn/JqAO5BnHAGG0yyzLBsrHZ6QHyUTd2R8b+dcsADOst3jg7ggwRoO4vjle
	VzyobB0g9p+DOtNiUEw5wLVUWn984q5Mslf1zKXDGrhO3G9B1viJ7go9xj80IkdOCswVyz9FfI0
	tQ6OJtvVUQ72SEHPcI+ZgbXh4xOxibzA7IZ757uMNipZ0lzSVVFVLujDN0h6DbYWi4sg2FkSikI
	qPkxj1hmUiAdadyeh/7+E9JqCgzyV+XMireUQaCD9M9xLuutU8Aj2nQidjR8IUBO94PEGeGFxlq
	CGXrdQYgk30T1dDBWCiE9s6+Jb6nqTls13hI/nyFnG2Ue8NgPgeW+11Om3+R2/v85ZHJnBt4XY1
	EVGGK2SLKK/L2qx1njb7/wXo7/Y6ugFM+1YA37ZW/rxIyfcXVBHBEa+/qzDYa0JGNvoPnmadjfz
	208V6kTHTSoeRMYw==
X-Received: by 2002:a17:90b:2242:b0:35b:a7be:ae62 with SMTP id 98e67ed59e1d1-35bd2d2c8e1mr3707375a91.30.1774047754718;
        Fri, 20 Mar 2026 16:02:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd4109c3bsm3000607a91.13.2026.03.20.16.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:02:34 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:02:33 -0700
From: Joe Damato <joe@dama.to>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 1/3] net/mlx5e: Move RX MPWQE slowpath fields
 into a separate struct
Message-ID: <ab3SCcyoqBJfQRmh@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Tariq Toukan <tariqt@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
References: <20260319074338.24265-1-tariqt@nvidia.com>
 <20260319074338.24265-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319074338.24265-2-tariqt@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270099-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim,dama.to:email]
X-Rspamd-Queue-Id: 452E92E230F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 09:43:36AM +0200, Tariq Toukan wrote:
> Move fields that are not read/written in fast path to a different
> struct / cacheline in the RQ structure.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h      |  4 +++-
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 12 +++++++-----
>  2 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

