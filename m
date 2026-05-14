Return-Path: <netdev+bounces-287859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APNVNNeKBWo5YQIAu9opvQ
	(envelope-from <netdev+bounces-287859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:41:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE60A53F6D2
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48D8530091D9
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 08:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320D53DD840;
	Thu, 14 May 2026 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="EssHxRVR"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D1B3DD52C;
	Thu, 14 May 2026 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778748113; cv=none; b=U83ySflwey7tzhRc0oIZZt6iAD1ckwYKhR0jbdJp5F7SGAVuOJ2mkAx8kRHAzbNWrQ4ykLpJxvsiY44p1W84Qe2OK8uPhztKXsiq4fxKN1M2IYhoOJhMEO4IRcqXFxbSY69jj5BbEGKGV3pXKlwWqb+IOlSqdpEY0YZ3ilpv8h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778748113; c=relaxed/simple;
	bh=BUf6yRc7cfw2DkYZCvBJARr5GmPhS/x9SOsA8vTUsxM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kej3wy4XBZiVpAUvPS4iAC3h1Ttms+4PtetU/CKj2IKW+OMia4U09Pzm/dfq0S8ZrPzR+m5wYr/ZkWC266mFI+uitEQhSG3n4umT6Re3h+FPIxfuWjPqe7crWWNbHLcv/4k2s2T82lgL4yn+9BRDf45M24tkp0wgDph1I28g7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=EssHxRVR; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9559F206BC;
	Thu, 14 May 2026 10:41:42 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gsw1yiwEDnVI; Thu, 14 May 2026 10:41:38 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 38AE02068C;
	Thu, 14 May 2026 10:41:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 38AE02068C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1778748098;
	bh=0tW/UzCnqky1KfmQSl9AmA6QmBv78yWhZjcKJ3d0+Ck=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=EssHxRVRqpLZsn7E8j8nD7eZ3ZdED1EXLFsFM4y2PAwCE2qqWz13UYwyqUMp6slh2
	 pGftnzSNQ/96L2hXh7AdJxSxbIDcPGn0mFkMFyGafOdbGX9hCrJRCdczb483Lfxawb
	 8qt9I9LNvqCZazTLMYk3d532vjuCnM6ghuahc0ByWSJOuZAoyc6MFu5GrBe8j7C1tY
	 E8mtooKSZu9iPVs6r0l9NjuKAl+zz9rsmIT3y9uuPxNvHImBAyCFdolMWqtRAbTz7O
	 Go61vucC9PZPaMrFbwpxV9/gChM7SnwYHPalDnzTC+CE3e10B1ZJ6jGJG7CIQB/pAM
	 RPhMSXjzIw6LA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 10:41:37 +0200
Received: (nullmailer pid 2298820 invoked by uid 1000);
	Thu, 14 May 2026 08:41:36 -0000
Date: Thu, 14 May 2026 10:41:36 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Alessandro Schino <7991aleschino@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <linux-kernel@vger.kernel.org>, e521588
	<alessandro.schino@sbb.ch>
Subject: Re: [PATCH] esp: fix page frag reference leak on skb_to_sgvec failure
Message-ID: <agWKwJor5JSBW_QB@secunet.com>
References: <20260514081123.1626-1-7991aleschino@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260514081123.1626-1-7991aleschino@gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: CE60A53F6D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287859-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sbb.ch:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,secunet.com:mid,secunet.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 10:11:23AM +0200, Alessandro Schino wrote:
> From: e521588 <alessandro.schino@sbb.ch>
> 
> In esp_output_tail(), when esp->inplace is false, the old skb page frags
> are replaced with a new page from the xfrm page_frag cache. The source
> scatterlist (sg) is built from the old frags before the replacement, and
> esp_ssg_unref() is responsible for releasing the old page references
> after the crypto operation completes.
> 
> However, if the second skb_to_sgvec() call (which builds the destination
> scatterlist from the new page) fails, the code jumps to error_free which
> only calls kfree(tmp). The old page frag references captured in the
> source scatterlist are never released:
> 
>   1. sg[] is built from old frags via skb_to_sgvec() (no extra get_page)
>   2. nr_frags is set to 1 and frag[0] is replaced with the new page
>   3. Second skb_to_sgvec() fails -> goto error_free
>   4. kfree(tmp) frees the sg[] memory but old frags are not unref'd
>   5. kfree_skb() only releases frag[0] (the new page), not the old ones
> 
> Fix this by calling esp_ssg_unref() before the goto error_free when the
> second skb_to_sgvec() fails. At this point, the source scatterlist in
> tmp is fully populated, so esp_ssg_unref() can properly release all old
> page frag references.
> 
> The same issue exists in both esp4 and esp6 as the code is identical.
> 
> Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>

As this is a fix, please add a 'Fixes:' tag to the commit message.

Thanks!

