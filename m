Return-Path: <netdev+bounces-289793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBq9LtpZDWpuwQUAu9opvQ
	(envelope-from <netdev+bounces-289793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:51:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 349EA588650
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D56EB3023DA6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE2D364935;
	Wed, 20 May 2026 06:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="YaHCtxr6"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06433630B9;
	Wed, 20 May 2026 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259807; cv=none; b=ss/6MLyHEipx30VuRqq/J2Uk8UZem+YnN8F24yZkxk5SxVf2HUM/uIhYXY3sN3JSzttxPOyweyzt/M7eeC7Kf1/b4ZbJwh/Ovobp9CpZ2+1zSajpZ1/u3WSRSCtwxTTPUPEV1sV20s9t/DiuknIpq6eK008K3FwEXBWMxW+gNbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259807; c=relaxed/simple;
	bh=Dw8JHXEVllQ9n7pZfoiDVu9fzd0smpGzRTc2eF2Ujgk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrszzBT1rpoTSP5hiJmDsQdhr9vWflpijCnw86un6gYN9212A2bWrbbSgUbTITnXVACWhlFuVKryER8eoaC6YAQH4Gnsr4p9vbi7ARNZeHnHZPG3D6Ooml1pBrOE0CmcMkZifelOBzcjZQRply0hWWBB1B2HSzq0gv6lzyAiR3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=YaHCtxr6; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id E937E207B0;
	Wed, 20 May 2026 08:50:02 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NcFQuUOI_VUh; Wed, 20 May 2026 08:50:02 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 551BC20184;
	Wed, 20 May 2026 08:50:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 551BC20184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779259802;
	bh=b0dUhk71na/5H1HuRBdGtqOC/Q+GWVi3wSXiWsgSpbY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=YaHCtxr6sd1kxYaOzrXAq/yTS560LoCHIyvYiH8GgroHkqYcW0LC0grKtdgbExENw
	 IaSG4Zokm5czItrV/EbRERFteaUZEpcj0tt4xTJ/4PeFEKZWBINq14xwB1KZxOINgH
	 5aE14/xS9BIasGBoAGo6PB9Ydve73l6YKjAbKXKMCSbiuUtFLiGySM1ZkJzcbPkzSA
	 /nPryhbiIXzog/daRELb3EvJIZFmpMF6Y0hmCFzctD7nyDkQFXrboGouM76tmEWJ1Y
	 JJB/MqmRynW544NM9ObYpscJz9C7fu7dnA8tRpYPv5El1Q0vjVx9JXSkbWIifLemX+
	 B5yF2z+0m82uA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 08:50:01 +0200
Received: (nullmailer pid 1139874 invoked by uid 1000);
	Wed, 20 May 2026 06:50:01 -0000
Date: Wed, 20 May 2026 08:50:01 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: =?iso-8859-1?Q?G=FCnther?= Muller <gunther.muller2008@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] xfrm: fix missing headroom check in
 xfrm_dev_direct_output
Message-ID: <ag1ZmRYxpWBkhba4@secunet.com>
References: <20260517111940.8987-1-gunther.muller2008@gmail.com>
 <20260518080410.11119-1-gunther.muller2008@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518080410.11119-1-gunther.muller2008@gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:mid,secunet.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_FROM(0.00)[bounces-289793-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 349EA588650
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 10:04:09AM +0200, Günther Muller wrote:
> Ensure the skb has enough headroom for the hardware offload device's
> hard_header_len. If the headroom is insufficient (e.g., when routing
> through certain virtual or tunnel devices), __skb_push() underflows
> skb->data below skb->head, causing silent memory corruption.
> 
> Fix this by using skb_cow_head() to dynamically expand headroom if
> needed, and switch to the checked skb_push() variant.
> 
> Fixes: 5eddd76ec2fd ("xfrm: fix tunnel mode TX datapath in packet offload mode")
> 
> Signed-off-by: Günther Muller <gunther.muller2008@gmail.com>
> ---
>  net/xfrm/xfrm_output.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index cc35c2fcbb..35f974d209 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -649,7 +649,10 @@ static int xfrm_dev_direct_output(struct sock *sk, struct xfrm_state *x,
>  	 * to netdevice.
>  	 */
>  	skb->dev = x->xso.dev;
> -	__skb_push(skb, skb->dev->hard_header_len);
> +	err = skb_cow_head(skb, skb->dev->hard_header_len);
> +	if (err)
> +		return err;

You leak skb here. Also, we should bump a statistic counter
when droping the packet.

