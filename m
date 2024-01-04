Return-Path: <netdev+bounces-61469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3173823EE8
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 10:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFEA61C213FC
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 09:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0B4208CF;
	Thu,  4 Jan 2024 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="C2gfuXXM"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7283208CA
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C7017206D0;
	Thu,  4 Jan 2024 10:39:30 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15UytR3iNogf; Thu,  4 Jan 2024 10:39:30 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4D2D9200BC;
	Thu,  4 Jan 2024 10:39:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4D2D9200BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1704361170;
	bh=9omPjJdA/fSZno6oEhaLFBTk/dKoPGtL3FGkIcC9nZY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=C2gfuXXMlr63mHi5m5rM7CqFVRJeLiNb7JHpF8n7JwLKsqinWTYInO1iyAFmRAvsd
	 N5s9Fjlaf+9ep2izpXKJBzWQJjBRYN5oncvW7lpQKdz59W6f9RvMlUdnjDt0+ILury
	 zGU5JrudoU/fug4z+hcyJRkXFSVUNjiELWhKueegWmA4GRBBY5cyvjosfVRa9bYTuo
	 uk5s3xg3F4e/3XomoiIkWrzZo4D/zm7fg7Kh5eLVIy2QexMbXVmGBpFVxflRRV+304
	 KOOlErzhERAnW6NNj7gXfLwGGZOKZX+1xZDsFv/xoqPHXEKqv6V6emvWd9mur5ebrC
	 1GzAFFkdTHHEQ==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 480A380004A;
	Thu,  4 Jan 2024 10:39:30 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 10:39:30 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Jan
 2024 10:39:29 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 8AA5A3182B9E; Thu,  4 Jan 2024 10:39:29 +0100 (CET)
Date: Thu, 4 Jan 2024 10:39:29 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, <devel@linux-ipsec.org>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v5 ipsec-next] xfrm: introduce forwarding of ICMP Error
 messages
Message-ID: <ZZZ80QrAwSyBxzxb@gauss3.secunet.de>
References: <e9b8e0f951662162cc761ee5473be7a3f54183a7.1639872656.git.antony.antony@secunet.com>
 <38d9daba2f601602ef115942f82b80e56b54c560.1703249432.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <38d9daba2f601602ef115942f82b80e56b54c560.1703249432.git.antony.antony@secunet.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Dec 22, 2023 at 01:57:04PM +0100, Antony Antony wrote:
> +
>  int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
>  			unsigned short family)
>  {
> @@ -3549,9 +3672,17 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
> 
>  		for (i = sp->len - 1; i >= 0; i--) {
>  			struct xfrm_state *x = sp->xvec[i];
> +			int ret = 0;
> +
>  			if (!xfrm_selector_match(&x->sel, &fl, family)) {
> -				XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMISMATCH);
> -				return 0;
> +				ret = true;
> +				if (x->props.flags & XFRM_STATE_ICMP &&
> +				    xfrm_selector_inner_icmp_match(skb, family, &x->sel, &fl))
> +					ret = false;

__xfrm_policy_check returns int, not bool. Please fix these
return values.

