Return-Path: <netdev+bounces-273515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJQ5C1WAy2kKIgYAu9opvQ
	(envelope-from <netdev+bounces-273515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:05:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85398365BFD
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC40A30607BA
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E23D34B7;
	Tue, 31 Mar 2026 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="g44x/o/5"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24423C73E3
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943956; cv=none; b=fN7NPFb+C6trkDe0jSxHcZGI7B76NqY2Z7MmqYRty2b9IeQ8K0CCJ0W0UdnqI8fx1gunYuCvLElIlrCiBkzTZo2UrZH7oikPIgyk7KrnIk0oukJfW31sBucXiZXMjANhD+EF33AabfM8BTY2rp35k1XYb6wGTVd2PK+VIA827Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943956; c=relaxed/simple;
	bh=t/Q1+mnp/qJGCro78fClJvIipnbgVdGdcPbbxtDQ9RA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e83ST4z7aWAbtf+Tfhf448DzGsj7wfN+BSL2fYJI08bBozlYuFaOEIvrcE+m79G0laz5gA9b+LO/B03jyKRm6UHOrpYLKlHlkWrvfofIRHEiDI9t77Syi7Nj2e+F87uT4MyrvbwnG+nZQr5IDPEONR32v2JVgL6EjYt6pFbhmWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=g44x/o/5; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 04BF520799;
	Tue, 31 Mar 2026 09:59:13 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WMDUWaZ62UE3; Tue, 31 Mar 2026 09:59:12 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5A222205E5;
	Tue, 31 Mar 2026 09:59:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5A222205E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774943952;
	bh=Q+Sitj+D07lqF9w2Xf/5e8TEz8Jatu7RV0qnURmFu1U=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=g44x/o/5hfl4eZaMNtheoXadEVUEyDoHdZQ/oXiwjdHVUcMA37xKzO9l9lI0IgISv
	 4MZw7VuP3fHDF8Q1gNpp6hv3hfW5WVL8LfzetNXWpROYeiaxtVCTyfgVgrar9IjTkh
	 KJ9r0I7CkjYz8fxYIB+C8bxdU5TTgq2Jv2f2mAJQXfCbdkyEecmdQNZriufSnQByTa
	 OvD2RQt6foycelFy+pn7ThI4tG1A9R64NKmqAEJJF/VN/LeFCvaoiOV1Ltyh34aSS4
	 3GJZRGkkaDo+m3nmuKgxThS4UxZdVfju+6tz46+5BUjGDOfjxGjUW9O4jJmemJcHXi
	 PzDZtTFTe4ALg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 09:59:11 +0200
Received: (nullmailer pid 1493628 invoked by uid 1000);
	Tue, 31 Mar 2026 07:59:10 -0000
Date: Tue, 31 Mar 2026 09:59:10 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Qi Tang <tpluszz77@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>,
	<herbert@gondor.apana.org.au>, <horms@kernel.org>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net] xfrm: hold skb->dev across async IPv6 transport
 reinject
Message-ID: <act-zn2s_59diwwO@secunet.com>
References: <abz65sB_1I9ImMx6@secunet.com>
 <20260326124131.193796-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260326124131.193796-1-tpluszz77@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273515-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 85398365BFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 08:41:31PM +0800, Qi Tang wrote:
> I reworked the fix direction to avoid taking another netdev reference.
> 
> The current idea is to reuse the existing dev_hold() in xfrm_input(),
> carry that reference across the async transport reinject path, and drop
> it only once the skb is either consumed earlier or the async reinject
> callback has completed.
> 
> Very roughly, the change would look like this:
> 
>   - in xfrm_input(), do not drop the existing dev reference immediately
>     on async resume
>   - add a dedicated queueing path for skbs that already carry that
>     input-side reference
>   - in transport_finish(), switch from NF_HOOK() to nf_hook() so the
>     ret != 1 path can drop the carried reference when the skb is consumed
>     before okfn runs
>   - in xfrm_trans_reinject(), drop the transferred reference after the
>     callback completes
> 
> Something along these lines:
> 
>   diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
>   @@
>         if (encap_type == -1) {
>                 async = 1;
>   -             dev_put(skb->dev);
>                 seq = XFRM_SKB_CB(skb)->seq.input.low;
>                 ...
>         }
> 
>   @@
>   +int xfrm_trans_queue_in(struct net *net, struct sk_buff *skb, ...)
>   +{
>   +       ...
>   +       XFRM_TRANS_SKB_CB(skb)->dev_ref_held = true;
>   +       ...
>   +}
> 
>   diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
>   @@
>   -     NF_HOOK(..., xfrm6_transport_finish2);
>   +     ret = nf_hook(..., async ? xfrm6_transport_finish2_async :
>   +                            xfrm6_transport_finish2);
>   +     if (ret != 1) {
>   +             if (async)
>   +                     dev_put(dev);
>   +             return 0;
>   +     }
>   +     (async ? xfrm6_transport_finish2_async :
>   +              xfrm6_transport_finish2)(net, NULL, skb);
> 
>   diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
>   @@
>         while ((skb = __skb_dequeue(&queue))) {
>   +             bool dev_ref_held = cb->dev_ref_held;
>   +             struct net_device *dev = dev_ref_held ? skb->dev : NULL;
>                 cb->finish(cb->net, NULL, skb);
>   +             if (dev_ref_held)
>   +                     dev_put(dev);
>         }
> 
> Does this sound like a reasonable direction for a v2?

Please send the actual patch for review. It is hard to
guess from such snippets if that's the correct way to
go.

Thanks!

