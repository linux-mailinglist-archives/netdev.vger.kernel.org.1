Return-Path: <netdev+bounces-275701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DXfNl/902kSpAcAu9opvQ
	(envelope-from <netdev+bounces-275701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:37:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ABA3A6488
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C204A300B9DE
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA3238B7D1;
	Mon,  6 Apr 2026 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="c+wwKQ9t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F7B32695F
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500637; cv=none; b=sGN8xiVWywmt392hKH1AUOeUqS/9RVsl/txnsOVoeYkyBNFmgYXjbVm1EFJTgkpB5UBciAGj2pfFMdUiduuliIbL9shSLWJ5AJfxomiZ/YEdOA5SGbQP4Y1nWPJ87lSOm33y9O8RTD+2vxJEKkp6W9k+bvvPNGsCjeszOsVpC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500637; c=relaxed/simple;
	bh=CP12LEi5xWikBKv139k1WmbpUqAApCKC/R78cqzPPLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVIvNe6yxxSsXH6KHgbMw+RmfyCUyeTdLU1pSEXZmcfmeSbABNlcwFpI3gHpvnzoJmNt94vyqQp1W8rAYoA7RqTKA1q4ae4JHTr+fy8S80M4Oo2u7oZSlOTeQt2ACKYa9VU3+ucPyybBfJaePTqCS8iLGJRCEum9eBFVK9Ap1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=c+wwKQ9t; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so2518681a91.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775500635; x=1776105435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzoMkeGQjHqq5m5NUQcYMb2CsDvxm3DrHbtl/8KcFh8=;
        b=c+wwKQ9tI3hqYicFLui9G/kJDHKCN91dlAa2DRP8CORBmpDqyeCQu6PiVzBSRP6Wys
         RY2KnO4lS05cubdBuIU1kEsA/8rsO2Ft74mddjcMF/mwb1zOQ8Wg9vw+bl+vb7SbfXEd
         RiiclPV9y/klQIyhav6e9P4TqJMMhwltLGtc+XBa1kYBvCqTxa1rMBj01awUw+Gb/bd0
         BYyyrqFK9pkjNitJJiRw8W7orV4qveL2Ao+3f0tB5EkRI0P6BKf048k19NFky9mgpMTq
         9d2+St15L4hx31TbUQqBOkXdAcjnk5uEF1xVUk+CpMsX8KUb5EFADGj3XyyuatNZFikz
         ohZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775500635; x=1776105435;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzoMkeGQjHqq5m5NUQcYMb2CsDvxm3DrHbtl/8KcFh8=;
        b=L+VxuiyzajiAahbZSEsvVjhJ2TwVZIvPwo7i4q+QW5RWOsi/aHeOkyHPoqssLRChGK
         0m5kRo40YbEQ1/UtGlo/DBidNvEqQh1EmmdDbYUzyuirJ7Cg06NlAAEsY5/+dFsx28yK
         /whlrgJeCalM31VHMx7JetMHgBR9W8pQBV/pILJkltxI5NOxsAJ0pQo+/AI8cIaGc+EG
         2fXlHONXHiXPUz+witBC+4c1a9ZcNowom8mwioM7uQlQ9EIA18hytCax3mjuDvXTn+c1
         9OHueymv1WIB9BS9QEOdK+ZvmBFA0yDb4oL7YrtZ8AnaX4osX4rbPogo80x7rHVIaum/
         AF2w==
X-Forwarded-Encrypted: i=1; AJvYcCUZK/sV0oeFWau+o4hk0c92iNY4wLiMtIFPh6ABu/rUX8nQpTdG2cq7cRRhs65ad4ycAtvg3H8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1JR0zkv3gIsSWdZUiIaJm2GYHAJT7qAn5vDZObTv/Nja68CF
	VPbQv8c85LPAacJ43LC+On/jVsOMUfU5gDcL69u7e1Y0dLDya2uIxtLZgabGAX7ihPc=
X-Gm-Gg: AeBDietxw3+NTFvpZEVXtQic4rhC4D66MxvpHe+Edkf458ruYYksFFrywZU7mqVGNjD
	y5L1XlJ9z3C/CJXQBOcfhl4DHf087Es12GNEHDkyxGhiLAgtgTFnLoCj78JMy+VkBKS6JoaJ41v
	jZGClpXXILEk0DiiN4p2WdDJEz6Hd+ZXwcGowKlLRmBpU8thU5l9UtVbzoBn+ziobJg383B7xVg
	G8bB6p88n0JcGGidSM/S+dzoL0b1woZkq33hhvWxJNcfScSD0BTL+vBXEL8sQwrXTpyIatU1eP4
	Gnjm0LU6v7JL71x4m2R4XTlAODvoifeGBujAbKWTXrRjITLjOpBc116IjvX2lKH2c1L6uCO5hdK
	Xi8ME6AHwPnx3D0cn/4XNIho+wSKd1bumd4Kl+4EVeXFOQBE+7jGZa+gMXovQOHNYBrPKOH0EJL
	vR0c8i4kMyrPOSIOQ=
X-Received: by 2002:a17:902:e748:b0:2b0:571f:6f09 with SMTP id d9443c01a7336-2b2818934camr150347155ad.44.1775500635409;
        Mon, 06 Apr 2026 11:37:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27479d0fbsm191461085ad.35.2026.04.06.11.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:37:15 -0700 (PDT)
Date: Mon, 6 Apr 2026 11:37:14 -0700
From: Joe Damato <joe@dama.to>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/2] net: qdisc_pkt_len_segs_init() cleanup
Message-ID: <adP9Wn4D3a8Srhub@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
References: <20260403221540.3297753-1-edumazet@google.com>
 <20260403221540.3297753-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403221540.3297753-2-edumazet@google.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275701-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lunn.ch,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20251104.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: 43ABA3A6488
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 10:15:39PM +0000, Eric Dumazet wrote:
> Reduce indentation level by returning early if the transport header
> was not set.
> 
> Add an unlikely() clause as this is not the common case.
> 
> No functional change.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/dev.c | 62 +++++++++++++++++++++++++-------------------------
>  1 file changed, 31 insertions(+), 31 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

