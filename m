Return-Path: <netdev+bounces-297447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 52WPBAr4KGo5OQMAu9opvQ
	(envelope-from <netdev+bounces-297447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:37:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFF0665F96
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:37:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=Mv88YLx3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297447-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297447-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13D1D3027311
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE5B2FE566;
	Wed, 10 Jun 2026 05:37:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718CD246788;
	Wed, 10 Jun 2026 05:37:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069829; cv=none; b=G2aZnEbj898Oviane7HK0DPByDg71k1AMDHm1PDdfYB8Y90gcJbjy+1HyObrFw2g7136NzB73tuc+aVb5CT4Vvu15tDU4/aisMOaEDXNdjCjpm5BZ4xMOtYO562Vp1xlYOJJOMiM85ft5f89zAtFADJdExPjSNWkuddSv5E/bcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069829; c=relaxed/simple;
	bh=r0zIRam0HY/RGCuXi86KtxWTjO2YQuTrsB6Nq9lKnlc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6/VU+hl4MaI6/Guz/aSvNGbXW12qpbcGhkmvvbL3iZkY/NzIYOwaFXuG/P3C1WxYXX0xj3FPuwBpRVt0fxvjKxVgaV9x9N4lCD6Ytdjo+6v9IYIsdcxx34Khr6hShZc27G0RV0LwUHSvtgERlyTHPa7IHwpFEyotrzd2RML3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Mv88YLx3; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5272C20743;
	Wed, 10 Jun 2026 07:37:04 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YchcY681ui08; Wed, 10 Jun 2026 07:37:03 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B5F392065A;
	Wed, 10 Jun 2026 07:37:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B5F392065A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781069823;
	bh=M8q7M9x/uyiIw2ivZXkSif9yz1VVIbf6870JsMhgCoE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Mv88YLx3apY0MhVoUZqHZTLeEf+7m1lQrLkNrSa1+phZL0E7d8/3iq2OIKwOU6w4t
	 24HRmOETmQTjbA19eVv0tRO6IQDDY7gnIIwizFR7y04gC+jjBxEl1/z1Q3kPh9mcfZ
	 wRt4fd+t3F1e7yNGQRWPelYhm4j1vUvkUAiiya367WCkTHSH8fz252Z/j+FnPkfNCe
	 EXL90cZj1s8aqK5734mWreMiDAbUpPkFVme6eTX7CUuOX09Uf1Q2QU+qNxduVNA9EJ
	 edK0A3yBWp7uh3ynVlzy7gEJcGoeWEGhkDK5Jwp9clSgQ5MGoUF9UuNAxLiNkzPvvX
	 n6LWmXKpv1M/A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 07:37:03 +0200
Received: (nullmailer pid 2119962 invoked by uid 1000);
	Wed, 10 Jun 2026 05:37:02 -0000
Date: Wed, 10 Jun 2026 07:37:02 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Alessandro Schino <7991aleschino@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ipsec v3] esp: fix page frag reference leak on
 skb_to_sgvec failure
Message-ID: <aij3_qm9x7LJUfbG@secunet.com>
References: <20260605122215.825-1-7991aleschino@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605122215.825-1-7991aleschino@gmail.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:7991aleschino@gmail.com,m:netdev@vger.kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297447-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CFF0665F96

On Fri, Jun 05, 2026 at 02:22:15PM +0200, Alessandro Schino wrote:
> In esp_output_tail(), when esp->inplace is false, the old skb page frags
> are replaced with a new page from the xfrm page_frag cache The source
> scatterlist (sg) is built from the old frags before the replacement, and
> esp_ssg_unref() is responsible for releasing the old page references
> after the crypto operation completes
> 
> However, if the second skb_to_sgvec() call (which builds the destination
> scatterlist from the new page) fails, the code jumps to error_free which
> only calls kfree(tmp). The old page frag references captured in the
> source scatterlist are never released:
> 
>   1 sg[] is built from old frags via skb_to_sgvec() (no extra get_page)
>   2 nr_frags is set to 1 and frag[0] is replaced with the new page
>   3 Second skb_to_sgvec() fails -> goto error_free
> 
> Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
> unconditionally unrefs the source scatterlist frags. Since req->src is
> not yet initialized by aead_request_set_crypt() at the point of the
> error, the source scatterlist is obtained directly via esp_req_sg()
> Existing callers pass false to preserve the original behavior
> 
> The same issue exists in both esp4 and esp6 as the code is identical
> 
> Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
> Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>

Applied, thanks Alessandro!

