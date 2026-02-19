Return-Path: <netdev+bounces-259587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CYUIrN1l2lpywIAu9opvQ
	(envelope-from <netdev+bounces-259587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:42:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D65AB16261E
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BBD4301AA74
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC21318BAC;
	Thu, 19 Feb 2026 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOM6kNYp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC8234984
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771533744; cv=none; b=csaOGFdF3aVklW02a599OaOILLwhw00aF+Oq6dgqos4ZtBZ5l6SmmLQpw2LAqYDI8EtdQ1uXOBdu6y/Ow9OkfrhVePnFQsGPQHbsLfxVuqDsOwH2i7du74X/0rPCg3f2CaxQZIO+gR+cMNuSR17N7xMLGrIjCPZOkIoPzH4+6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771533744; c=relaxed/simple;
	bh=ME3PrVM7nXtYM402u4zYAGjOM8yN7vDc9ehtk+M6+Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCfAhIIHc8qwDWKS0hUrcPUwE4lnNtt4gp5BlVBPX0pfIFTMKoJkvP6arkuDqCryrZdv5vOA7HDzFIGvp7q9dIqnN8mSBURMrU7+IVSe1G4gEvKSjNjf6OwJ3O4uupDD+NkaXhavkl+KIcnp3oKJ741L3sbTqNxPcecMktgYjeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOM6kNYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76A8C4CEF7;
	Thu, 19 Feb 2026 20:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771533744;
	bh=ME3PrVM7nXtYM402u4zYAGjOM8yN7vDc9ehtk+M6+Dw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iOM6kNYpK5YO12YZ2Oy7IAPw0Hh9Ob/aoYi4rO+8Xgy3qW6zmv6g+YwcXKV+9p7g2
	 A3ucZAgq+kynQDFCL7b2UKUoEsef64kY3Eye+NlWcCztKiVj1eDC3gEKXgDosj4w8t
	 DhwGDlVApPke96kCkOTD9gjjiQ40vS82Nog092nEB+o0YK9DdI95iExrsTfZK6t8v7
	 ShwjdTCLxPHlKLZJ5tx6ToWMgcqvvrSXFvRCfH14UYgSVGVkIIn2RlEAIfWxZ0bU1e
	 VPWbwZdkLHVRevn8e3UVM9x7ltttG83juywAPgdZGM3vCPGyIQNCFvX0M+y4orZxtX
	 81TAykRI6YRzQ==
Date: Thu, 19 Feb 2026 12:42:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org,
 milena.olech@intel.com, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next 2/2] netdevsim: Implement basic ptp support
Message-ID: <20260219124222.211385c5@kernel.org>
In-Reply-To: <20260219140530.2148-3-maciek@machnikowski.net>
References: <20260219140530.2148-1-maciek@machnikowski.net>
	<20260219140530.2148-3-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-259587-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D65AB16261E
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 15:05:30 +0100 Maciek Machnikowski wrote:
> +	gen_tx_tstamp = skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP;
> +	if (gen_tx_tstamp) {
> +		ptp_info = mock_phc_get_ptp_info(ns->phc);
> +
> +		/* Create a copy of tx skb to keep the tx reference */
> +		skb_orig = skb;
> +		skb = skb_copy(skb_orig, GFP_ATOMIC);
> +		skb_shinfo(skb_orig)->tx_flags |= SKBTX_IN_PROGRESS;
> +
> +		/* Timestamp as late as possible */
> +		if (ptp_info)
> +			ptp_info->gettime64(ptp_info, &tx_ts);
> +	}

Like Andrew said we need a test in tree. But Vadim has been promising me
a timestamping test for a while, so adding him here. You can probably
work together (unless you already have such a test).

When you respin - note that mock_phc takes a spin lock without _bh
around its internals. It needs to be changed to _bh() if we call
it form the xmit path.


