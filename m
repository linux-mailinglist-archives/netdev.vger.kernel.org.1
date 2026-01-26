Return-Path: <netdev+bounces-253490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E3eHNByd2n7ggEAu9opvQ
	(envelope-from <netdev+bounces-253490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:57:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0129789323
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56D0230AB283
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E95133B6CA;
	Mon, 26 Jan 2026 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbPRlA1Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFFB33A9F0;
	Mon, 26 Jan 2026 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435495; cv=none; b=LGnAtNgDUbybsC8S5KtMRikrNLKMsSjeWiydT+RipwTZC5PyACqd4dB9TVjOn3qHJrrUmDuTpo5duEDpWizggk8h/K7G6tZDyCFNXQjJhyAqdOQZDRfImpez+Bm/EjPoyl/ccJ7oQ1qSALjJFYoTNPFfsnbaIxiNyWlzpM5q+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435495; c=relaxed/simple;
	bh=XSyFZQliVYivXC9UZPpp1bWKU1wp91du4ESxRSORJ+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWxOA78jM/RKuMd1mwACVjlYH/J8zoSBZ2vXn/wv4tLCbbqlhDXiDeF055d0UEOjbMfhOkrU+TcjRo6wo8tt2KIBWebr6zcDYGe4H/TboaXHRpJLGvu/op5Z/qewzSDLVrpF4XoBAK748J/9cy7mqgZLq6hKJKuJeycE+KSMN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbPRlA1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDA5C16AAE;
	Mon, 26 Jan 2026 13:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769435495;
	bh=XSyFZQliVYivXC9UZPpp1bWKU1wp91du4ESxRSORJ+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbPRlA1YiqP/4mlGp2aWMS3SRnslcacCT1HTI1KfyDH6s+PTfAL5FSxgYtBdb9PLp
	 t2tjm19oe/3Ng7P88aNRY/yg57n5zrb925pHhloOmuPpJpax0XPvrEPFBTX3rMr8xi
	 s91rKVSOdDziFwHBBOHV4zp6uU6ms3N8Je0T89X07N9rnW0XIm5j1vtgZeXyprD1u+
	 Lr5PlUSkfklS2L/az+8zkuPqBOeB6jWpFgD2Ezmc4OpYTq7eJWWoaIkW4zSd5fyE9q
	 oWuMXnYIvl7sEIb4/54wSEckU+aX9EgbJhf1K/apvzrxqhpbS3mSS08VBiNVGjok5U
	 KgQSbHuDOgAMw==
Date: Mon, 26 Jan 2026 13:51:31 +0000
From: Simon Horman <horms@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: usb: sr9700: clarify code using BIT and
 GENMASK macros
Message-ID: <aXdxY81-bXBF2sRR@horms.kernel.org>
References: <20260124040226.34390-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124040226.34390-1-enelsonmoore@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253490-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0129789323
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 08:02:20PM -0800, Ethan Nelson-Moore wrote:
> The sr9700 driver contains many hardcoded bit shifts and masks. Make
> the code clearer and adhere to the kernel code style by replacing them
> with the equivalent BIT and GENMASK macros. Also take the opportunity
> to align some indentation.
> 
> To avoid merge conflicts, code which is removed by other pending
> patches is not modified.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Hi Ethan,

I like where you are going with this patch.
And the conversions look correct to me.
However, I don't think this is the right strategy for avoiding conflicts.

I think that either patches that are related - say all the ones posted
recently for sr9700 - should be collected into a patchset. Or,
you should wait for patches to land before posting changes that conflict.

Either way, I think this patch should be more comprehensive
(not excluding splitting it up logically if it becomes too long).

My advice is to wait for all your outstanding sr9700 to settle.  And then
collect up those that are left into a patchset, addressing review of them.
And include, in that patchset, this patch, in it's full form.

-- 
pw-bot: changes-requested

