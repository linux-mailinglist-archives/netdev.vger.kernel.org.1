Return-Path: <netdev+bounces-269986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMxgD/R+vWnH+QIAu9opvQ
	(envelope-from <netdev+bounces-269986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:08:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2922DE457
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1E7C309CC9B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10963D4106;
	Fri, 20 Mar 2026 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/6Z1Un0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E904362127;
	Fri, 20 Mar 2026 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025562; cv=none; b=SVG5thb/mLLs8lOxygtNoF3Vpw6LiAZHGIFlsXl8XB8SK6i9j+HEnm5d4qi6/qF6g5fRtiY813UY6+oC0kYTQIp2GodeUBcsdtM2u0QUOKlO2oS7THSS9U3zR+MjRpjld5cWzkXf3phZ22NWe9IEgetApPGhvKxRT+hPwq5wamA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025562; c=relaxed/simple;
	bh=HeXq9hoRTIdui3pLzWvNo9hMfMxih51b9xlSGqIkEyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifH3AiJekbDS6mnRdF4W2W4dMHv3/UwQYzAMwkFkrDZkiVZ99npq4enjbLoWnCrDjS0BVq2sMHLLlTpr5j4ylce9lGLF+fSMITO/+bHwhUuck3+6fUXpzmhZJ+58X9QJL+8m2+iCgUuosmFrI5bUH0rGGgl5rhSMtTuDHlc1wiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/6Z1Un0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA129C2BCF7;
	Fri, 20 Mar 2026 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774025562;
	bh=HeXq9hoRTIdui3pLzWvNo9hMfMxih51b9xlSGqIkEyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/6Z1Un0ZcDQhv0z2Dz3bvw1vFCgqrRlikNGyNsspjX8Y5g3cXSWT3emxw+tmiKF8
	 /x6x3svNCUwEUdvJtlcmr31VH7qP0Cazp4MIaBAAoXbHcn6nYHG+h4dpbXBlrjiqJq
	 YvFU/1uR0ZoS3TbU3MCNEy6fa/UBLXBBLx9QZPxE9sDt5JFAk9e8MayNS6MoCLABI9
	 BCO+WgrROaLlRUuAZiJDMxuRB5M779Bp8DC30ifisrkqi5chrNZ6pY5iQORjTAJOTj
	 O/XPicNcDC2v83m4YsLRHCA8ruEMCgF5v1y07cZWba/jrJa3/uGZc3jSSjGeb94uzI
	 W9agE+Hl1uAXg==
Date: Fri, 20 Mar 2026 16:52:37 +0000
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	gakula@marvell.com, bbhushan2@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linu Cherian <lcherian@marvell.com>
Subject: Re: [net-next PATCH v2 1/4] octeontx2-af: npa: cn20k: Add NPA Halo
 support
Message-ID: <20260320165237.GC74886@horms.kernel.org>
References: <1773920826-16985-1-git-send-email-sbhatta@marvell.com>
 <1773920826-16985-2-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1773920826-16985-2-git-send-email-sbhatta@marvell.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-269986-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid,marvell.com:email]
X-Rspamd-Queue-Id: 9D2922DE457
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 05:17:03PM +0530, Subbaraya Sundeep wrote:
> From: Linu Cherian <lcherian@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
> index e2a33e46b48a..96904b8eea62 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
> @@ -12,6 +12,11 @@
>  #include "rvu_reg.h"
>  #include "rvu.h"
>  
> +static inline bool npa_ctype_invalid(struct rvu *rvu, int ctype)
> +{
> +	return !is_cn20k(rvu->pdev) && ctype == NPA_AQ_CTYPE_HALO;
> +}

Please drop the inline keyword here.
We can let the compiler chose to inline things (or not).

...

