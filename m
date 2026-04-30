Return-Path: <netdev+bounces-282981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BJvA16v82k/6AEAu9opvQ
	(envelope-from <netdev+bounces-282981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 21:37:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F2C4A76BF
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 21:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 303413006924
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60399379979;
	Thu, 30 Apr 2026 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="aEfLqINT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54631925BC
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577815; cv=none; b=jEs9KxelcoEVEZXDl4TV7AYgGB+Jkt4Np6tqivuD4Uym2LVDtkG3UyR9BsHHx1/5O8e2vwa3v0LL2KPWCJ2MRm1CtCw6gvCNLkx1M27ZT4l6VwyVp1E1Gr+vsbZUFhsggR0C2p4uYBp6eh7w7pXvzj6KGCFAte3F4GOzjJfFjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577815; c=relaxed/simple;
	bh=kUaXEcOy3Fb5on2h8tdsrwmdqxEnolVL9+3Df3P/8YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWoEn8PkNxkWXdgITjjPzlbpVjfKB5yZSk+qVftv93ZcZXEczQMKJ7fOSzlFnElXacZrG+7aXHa4I9S1JoyL1nboz3dEwDb1lMoe2Ud+KZGlUH0x1V6pgD7NxASF61yHSx4b3PDOlY8lCJAAlH/4/wvCQdbJoZxq4RJXcwk8cvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=aEfLqINT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so1388285a91.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1777577813; x=1778182613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsb2o8PCwX8XIiel3xz6873qrJeZ59wF+fwyebIss0E=;
        b=aEfLqINTrzKDvsoK+UXuuZ4dTYv3bW7yqwtJKonmGlZ1Ak0m2JBGZtFEUpfODB2j9C
         0obN8mKY82rUnXTN11w0FYJt6kyO5vQ7Co7dVXkudEQ8BpgqWxKOcZpGjt8QxPEV3SI6
         UPLXVsHvld62tITXxmTSEdYRqxeIa++WfpMnn7hjHOgrqtxwZvk9kpnUfx0pM7inl0Yg
         pMG3NGmy0SGbBY3b/EcfOMzYUIDiTVb6gRtt/1R8ywo4bTOiea5HEevbMcR1tvLgYMWK
         NSaQQX96UIgUcuhZ0zisXFtb4d8z4v7iIo8TufIIqHqgfE0daVACPkfoNCE6HWcd16mn
         Ot3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777577813; x=1778182613;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsb2o8PCwX8XIiel3xz6873qrJeZ59wF+fwyebIss0E=;
        b=G8sfTi09y9xm1iZit09ek5PKsWLzb4S5D2bu2YakYpXtGPV1GthJjQQna87KR0K06+
         ojBxjqsebaHNsViuN0Rt98XiUX5p6eExg33Hl5Ef/zkngLeWVKF4peERubZBioarkcWK
         qDGtFs+9JbTcR/3hxeQRrf7QbhdrKg9dfJARSlDRSlamyiujo7OAmxuo9i+batvjjBw5
         39YOiNf80oztx5xEqrhXcKLTKzGqC5ocLLE5O/1cCX38xVQUs7eUDcULQr0rczod8gE7
         omUwbiWB14u2BwjFlxBkqMyCsgAh30lnzSr3EOb4jyQ6mgVhHFG+1sOLU8m4mO9E56PW
         OqmA==
X-Forwarded-Encrypted: i=1; AFNElJ+JItJj9WZyRV5OCwuwloNvmJTwPrDJ64un3ZmpB5G88J6sTsWIcJMjJ1OIcqT1murXH9wnPjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJgp6wyleBV/g+LtlKLAfOOKMTwd+c7I1i9fDogXxnmcBwnwgB
	ea3LOZoSHzAza8k4k/6iMWYOhdvyHt756j4SI2u0UE9Q5keEqsC98MkjLi36MdzqqO/OezDQ9ws
	6B9m/4Qg=
X-Gm-Gg: AeBDieunj0tbNS0iTcwhqEDr26WzsvkdqoyxNJ8B9IfRFoArVAgrXbzd19F+ZZfaMa7
	Zujm+5CwPSGAJwnVdQf4w8McktYv4VEwGoSAGV2Wqj+PV1y7jhnGvHk3gy/yLRhjLLXelOFA4+d
	pPu0LYWGfyDkBZkLde9NeJd4afGqrOPEDjVlphvqWPUZPKRipPE24ieCiEsqVE9tuAWh6blnq4y
	JssexBsXczb5xUzRuH2ohwzeY0K49bOI4ECfxyBTsPG5bkHhC4FWgyNaIpX/sciEBWBNrbQx38+
	rqGDsvB3xQRwWpI/SEdemXTkMKH8QRgb0eIPfe7F4B7bsQuoSc6+E6lYBQg8tEwDnf1694FUXQZ
	wjYSwKZZ5nNk0ejy6vkdCMm4GWQP6Gp/R0B77a39kKvwT7QvP35jcRF1uNAq9S17liNJKvExEQi
	2iOMBF5+xxVTUhY70=
X-Received: by 2002:a17:90b:2e42:b0:364:78a5:8d40 with SMTP id 98e67ed59e1d1-364c30bb1bdmr4231151a91.20.1777577813179;
        Thu, 30 Apr 2026 12:36:53 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm221459a91.2.2026.04.30.12.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:36:52 -0700 (PDT)
Date: Thu, 30 Apr 2026 12:36:51 -0700
From: Joe Damato <joe@dama.to>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>, David Wei <dw@davidwei.uk>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Vishwanath Seshagiri <vishs@fb.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Gal Pressman <gal@nvidia.com>, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: Enable ntuple-filters if
 supported
Message-ID: <afOvUznmpTEPBJrS@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>, David Wei <dw@davidwei.uk>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Vishwanath Seshagiri <vishs@fb.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Gal Pressman <gal@nvidia.com>, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
References: <20260430165217.3700469-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430165217.3700469-1-dimitri.daskalakis1@gmail.com>
X-Rspamd-Queue-Id: 08F2C4A76BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282981-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,kernel.org,redhat.com,meta.com,davidwei.uk,nvidia.com,fb.com,gmail.com,broadcom.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:email,dama-to.20251104.gappssmtp.com:dkim]

On Thu, Apr 30, 2026 at 09:52:17AM -0700, Dimitri Daskalakis wrote:
> From: Dimitri Daskalakis <daskald@meta.com>
> 
> Certain devices which support ntuple-filters do not enable the feature
> by default. The existing tests will skip (if they check for the feature),
> or fail if they blindly attempt to install rules. Therefore, attempt to turn
> on ntuple-filters if the device supports them.
> 
> Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/gro.py         | 10 ++++++++++
>  tools/testing/selftests/drivers/net/hw/gro_hw.py   | 10 ++++++++++
>  tools/testing/selftests/drivers/net/hw/iou-zcrx.py | 12 ++++++++++++
>  tools/testing/selftests/drivers/net/hw/ntuple.py   |  5 ++++-
>  tools/testing/selftests/drivers/net/hw/rss_ctx.py  |  7 ++++---
>  5 files changed, 40 insertions(+), 4 deletions(-)

I suppose a future cleanup might be able to add a generic helper for this for
all of the ethtool settings (tx-udp-segmentation, ntuple, etc) to
EthtoolFamily or something?

That said:

Reviewed-by: Joe Damato <joe@dama.to>

