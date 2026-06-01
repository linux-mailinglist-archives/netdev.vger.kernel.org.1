Return-Path: <netdev+bounces-293576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MiwAbMnHWq6VwkAu9opvQ
	(envelope-from <netdev+bounces-293576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:33:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA9261A396
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E07030053BC
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C9136896D;
	Mon,  1 Jun 2026 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="beqoU31u"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9BF368277
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295585; cv=none; b=TsV+AtwjED5lzcGhoo82xYEzUp7CzWLSEQOA0SvbkJdP/JHOT3hgPz+dA8BpcUNYlCJddk0g2aVSIjaRl0oTYrdPKmKr7Ctbx6zAI7Noi8/RPlxZhydp3Slaler+mtCyoLsnO1p/qgByt3GObU2gWKz4VHXcBmboWTpxfL5Z/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295585; c=relaxed/simple;
	bh=NL9Wjt8FjB2KQ5SUiiIH3dmg0cQGvLdqNQQ8uYk+uiE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKjM5JxZJR37d2M/tQ6E9pTxXS+AZ1qPLQWltsCutTFdz06r9L1V20BJ1CnL7a94VoAjtBMk/ntBEX/tn9fU6VIfvUaXdX6DyZoQa0fL16z1Syn4ChUqLWtLjUGxFt5EoGYU6PQPaShRdGYYSXlL9LYCni1B++OYGimfKwYUC1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=beqoU31u; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id DE04F20764;
	Mon,  1 Jun 2026 08:33:00 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VaOsmmKvvrbh; Mon,  1 Jun 2026 08:32:59 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0D4F82068C;
	Mon,  1 Jun 2026 08:32:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0D4F82068C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780295579;
	bh=f0GuEX3ZToHpM3V7lYw+UH59oveT0kS8KoiBM5Dswj8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=beqoU31uqVRlKsVjgk1yoQ2X0lTycVOAipi2JxItokCMdSelJdSLk46+z8LFXUkYB
	 GHlvLprTJJ1nDwe7h1M3Nb+iqJu4WokO8Q6JgMA9Q6rvzJdApGUqsLQ7TqFe2pkH5x
	 C6VvMmlUQHEoi7bOTra0kK9i8Xm5yqkOBMiVpS9f/YNnehEBbZWAvg10f3JfmaPA8z
	 SKPrU163eF8L4hdNgGnv24NEJfWzalg6uy+/rtB1TPvxJaLcLnMMG2javJr+vQqV3Z
	 oaRUvMSYUM5Rc1R0x67x+rLhRj6mBs/A8MH5z685Y8TS3yxhXv+UFtCp/LjKf08bYG
	 wFqmDq37iY82A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 08:32:58 +0200
Received: (nullmailer pid 3216087 invoked by uid 1000);
	Mon, 01 Jun 2026 06:32:58 -0000
Date: Mon, 1 Jun 2026 08:32:58 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Dong Chenchen <dongchenchen2@huawei.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <tpluszz77@gmail.com>, <netdev@vger.kernel.org>,
	<zhangchangzhong@huawei.com>, <xuchunxiao3@huawei.com>
Subject: Re: [PATCH net] xfrm: Fix dev use-after-free in xfrm async resumption
Message-ID: <ah0nmpeq6TNHtQqd@secunet.com>
References: <20260529092111.1089315-1-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260529092111.1089315-1-dongchenchen2@huawei.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-293576-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email,secunet.com:mid,secunet.com:dkim,linux.dev:url];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6CA9261A396
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 05:21:11PM +0800, Dong Chenchen wrote:
> xfrm async resumption hold skb->dev refcnt until after transport_finish.
> However, xfrm_rcv_cb may modify skb->dev to tunnel dev without taking
> device reference, such as vti_rcv_cb. The subsequent async resumption
> will decrement the tunnel device's reference count, which lead to uaf
> of tunnel dev and refcnt leak of orig dev as below:
> 
> unregister_netdevice: waiting for vti1 to become free. Usage count = -2
> 
> Release refcnt of the original dev after tunnel rcv modify skb->dev to
> fix it.
> 
> Fixes: 1c428b038400 ("xfrm: hold dev ref until after transport_finish NF_HOOK")
> Reported-by: Xu Chunxiao <xuchunxiao3@huawei.com>
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> ---
>  net/xfrm/xfrm_input.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index f65291eba1f6..c979872b6006 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -467,6 +467,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  {
>  	const struct xfrm_state_afinfo *afinfo;
>  	struct net *net = dev_net(skb->dev);
> +	struct net_device *dev = skb->dev;
>  	int err;
>  	__be32 seq;
>  	__be32 seq_hi;
> @@ -730,6 +731,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  	if (err)
>  		goto drop;
>  
> +	if (async && skb->dev != dev) {
> +		dev_put(dev);
> +		async = 0;
> +	}
>  	nf_reset_ct(skb);
>  
>  	if (decaps) {

Sashiko found issues with this patch:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260529092111.1089315-1-dongchenchen2%40huawei.com

Please review!

