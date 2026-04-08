Return-Path: <netdev+bounces-276384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BI9NX4g1mklBQgAu9opvQ
	(envelope-from <netdev+bounces-276384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:31:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 434563B9E82
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 136F53007345
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3083539B97E;
	Wed,  8 Apr 2026 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="uGscwb5I"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089153806C0;
	Wed,  8 Apr 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640551; cv=none; b=uWKXech9A1+s5HQbeRwzK2iX+v4GnHpZ8E2Nq/tPj8ESg7s1sHn2xxjiemSm0dcNkBOrVuSaq1UuxildQlYf0fjpO+X/YQ5jKbMqM5ahWqqfV5N9qcxAXFgBIo9TNvsq3t1a1+jTbi0HN06N4Pnpd3P47Vo2F/JLG0EwcG5g8WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640551; c=relaxed/simple;
	bh=xM3dxI7wCCmuQrWY9tPCnY2tOlTn3ywRp7wOSjqdQcQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSuocWVaEsScUuhP4WK/vvoUbhSfFiIlFSPBVpmMeFTlIwiKNMFZWP0yJ0zdXb/nWH9P7GJ2dRQdGrrTO4E8kjWNLLyW8fzbbUp0m4UfiALKd9jugKJml8LLdBtmuXrnMPuZSLdXC5a1w0lmEydr6+6n8YC8ckYVLAI8uMvcB5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=uGscwb5I; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 249F920820;
	Wed,  8 Apr 2026 11:29:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X1dEP7LzZmgd; Wed,  8 Apr 2026 11:29:06 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 800A22080B;
	Wed,  8 Apr 2026 11:29:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 800A22080B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775640546;
	bh=UWXrViHV114G3kY+hJ0t2jQTJK2BBud23h4WlYDJQww=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=uGscwb5Iq+RtmzlJqaj377uNehSoAgz+srl6QODHfzru5C4b2DGfARVf/M24IMh+4
	 JhggxFPYXh5dM0FzNhdmiFHlCkVhRqt+fXq4K5Q/5oAfJe+sgBH3G6OyPW4vhTbDO9
	 di0CDblT4UAX8p1ZNiao2VHe/DVCqWrH0CT/93qxke98YUgOT9eiXW4g8IdeePsDED
	 SfPEfyF0tRZi85CCQvE6Al7CqofnXtwpBS7G/IDZs1D/FxaoJ/nCJyRP3QOZnTq/D9
	 nGUQ5mhzNH1WKdsiNkvVBi9iVwlqQSgPOmpCjNB9tFqzz4O6qHPbNhQJlfsA0aIJ+C
	 SuXAzcCQkT7SA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 11:29:05 +0200
Received: (nullmailer pid 59307 invoked by uid 1000);
	Wed, 08 Apr 2026 09:29:05 -0000
Date: Wed, 8 Apr 2026 11:29:05 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Kotlyarov Mihail <mihailkotlyarow@gmail.com>
CC: <netdev@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>, <fw@strlen.de>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ipsec] xfrm: fix refcount leak in xfrm_migrate_policy_find
Message-ID: <adYf4dQERmCeO0da@secunet.com>
References: <20260404090525.105083-1-mihailkotlyarow@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260404090525.105083-1-mihailkotlyarow@gmail.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276384-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxtesting.org:url,secunet.com:dkim,secunet.com:mid];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 434563B9E82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 12:05:20PM +0300, Kotlyarov Mihail wrote:
> syzkaller reported a memory leak in xfrm_policy_alloc:
> 
>   BUG: memory leak
>   unreferenced object 0xffff888114d79000 (size 1024):
>     comm "syz.1.17", pid 931
>     ...
>     xfrm_policy_alloc+0xb3/0x4b0 net/xfrm/xfrm_policy.c:432
> 
> The root cause is a double call to xfrm_pol_hold_rcu() in
> xfrm_migrate_policy_find(). The lookup function already returns
> a policy with held reference, making the second call redundant.
> 
> Remove the redundant xfrm_pol_hold_rcu() call to fix the refcount
> imbalance and prevent the memory leak.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 563d5ca93e88 ("xfrm: switch migrate to xfrm_policy_lookup_bytype")
> Signed-off-by: Kotlyarov Mihail <mihailkotlyarow@gmail.com>

Applied, thanks a lot!

