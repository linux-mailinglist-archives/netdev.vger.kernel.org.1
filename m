Return-Path: <netdev+bounces-84109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF9A8959BE
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 18:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC611F211CB
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD7314B062;
	Tue,  2 Apr 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesaguri.club header.i=@tesaguri.club header.b="G42II7Sa";
	dkim=permerror (0-bit key) header.d=tesaguri.club header.i=@tesaguri.club header.b="wY9qo6Xg"
X-Original-To: netdev@vger.kernel.org
Received: from gagc1.tesaguri.club (gagc1.tesaguri.club [172.93.166.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE314AD1D
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.93.166.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075371; cv=none; b=QZKe/i0kphMrsGbrJHqBj4bx44tVsgeZ9xfZwljlnFtiXiFmdy/SW7dYO1S2fbgB8T1MFFwYx0MjbO2Xe/Bv9CbFqMXw/qMx9rf1X5z1NmxE1OLi9BGcjCAV9Xw/F2bKO7amn8ax8g1K8yR9arMrEHbNt50/RWBnqcfYWfHbMII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075371; c=relaxed/simple;
	bh=VpgP+hyGwAxZcziLqXe7+WLvln5wEMdSmiqWe0vv6Ag=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=e4ynsPWiIIXDMyLJ0LlzbU7+Y98XWy3zNsG0HLs0eQ8SY70DzjoxWky/y91EMR4W642JFpiZBif+/u9qR1kLG7Tyig5nEPbZxB7ZkJmx6WsNOnt3PHsa2jgfwgI5q31epl95jPuhGlBloNJIlMMxOgZFmnM8XSpRpU+0ORtWwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesaguri.club; spf=pass smtp.mailfrom=tesaguri.club; dkim=pass (2048-bit key) header.d=tesaguri.club header.i=@tesaguri.club header.b=G42II7Sa; dkim=permerror (0-bit key) header.d=tesaguri.club header.i=@tesaguri.club header.b=wY9qo6Xg; arc=none smtp.client-ip=172.93.166.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesaguri.club
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesaguri.club
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesaguri.club;
	s=rsa; t=1712075368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3piAEGtv//7XDobk/H1lp9yy/QQCsTxricNtUhMa94w=;
	b=G42II7SaEjzb1a2zbQnJigJi1pChte49QufusR8SqK75L9SewqHuUkOue+n1Z96l0GeKGS
	uwb4LXmzZ30+w7asDSuVMAxhcCH0etRaDSNFHpdI2iZR4ZLWU91FIWhb9WesoMRmBd7ILT
	sFsVSKRCoCfZp1ZAZllxyeKu1XOt13QcsgU/ofTy1Y7HRkiI0jwYhRfiFulqpkQBYmRrOD
	fI8+pzeZn9RD7XaHVCqr2wWKVaMEAG+uHycg/Yc2n2GNbdx4Cecgu6uts7FUJeM28deSJC
	hNMx7olo4Mi9VyT4S4rd2Bbc+HzBom9thEPEPNYa4w6ldTYzeMv5R4zCYRdNUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tesaguri.club;
	s=ed25519; t=1712075368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3piAEGtv//7XDobk/H1lp9yy/QQCsTxricNtUhMa94w=;
	b=wY9qo6Xg1ls1BIaNr5W9gXZkA28XeKv30FYbBC0qQjHO5lFfAm+TdPCDBpQUfWYqPSs8SI
	ZI7gfR66/6Q3YgAw==
Date: Tue, 02 Apr 2024 12:29:28 -0400
From: shironeko@tesaguri.club
To: Eric Dumazet <edumazet@google.com>
Cc: Jose Alonso <joalonsof@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Soheil Hassas Yeganeh
 <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, Yuchung Cheng
 <ycheng@google.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
In-Reply-To: <CANn89iKm5X8V7fMD=oLwBBdX2=JuBv3VNQ5_7-G7yFaENYJrjg@mail.gmail.com>
References: <20230717152917.751987-1-edumazet@google.com>
 <c110f41a0d2776b525930f213ca9715c@tesaguri.club>
 <CANn89iKMS2cvgca7qOrVMhWQOoJMuZ-tJ99WTtkXng1O69rOdQ@mail.gmail.com>
 <CANn89iKm5X8V7fMD=oLwBBdX2=JuBv3VNQ5_7-G7yFaENYJrjg@mail.gmail.com>
Message-ID: <f6a198ec2d3c4bb5dc16ebd6c073588b@tesaguri.club>
X-Sender: shironeko@tesaguri.club
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-04-02 12:23, Eric Dumazet wrote:
> 
> Could you try this patch ?
> 
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 88e084534853dd50505fd730e7ccd07c70f2d8ee..ca33365e49cc3993a974ddbdbf68189ce4df2e82
> 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -1452,21 +1452,16 @@ static int ax88179_rx_fixup(struct usbnet
> *dev, struct sk_buff *skb)
>                         /* Skip IP alignment pseudo header */
>                         skb_pull(skb, 2);
> 
> -                       skb->truesize = SKB_TRUESIZE(pkt_len_plus_padd);
>                         ax88179_rx_checksum(skb, pkt_hdr);
>                         return 1;
>                 }
> 
> -               ax_skb = skb_clone(skb, GFP_ATOMIC);
> +               ax_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len);
>                 if (!ax_skb)
>                         return 0;
> -               skb_trim(ax_skb, pkt_len);
> +               skb_put(ax_skb, pkt_len);
> +               memcpy(ax_skb->data, skb->data + 2, pkt_len);
> 
> -               /* Skip IP alignment pseudo header */
> -               skb_pull(ax_skb, 2);
> -
> -               skb->truesize = pkt_len_plus_padd +
> -                               SKB_DATA_ALIGN(sizeof(struct sk_buff));
>                 ax88179_rx_checksum(ax_skb, pkt_hdr);
>                 usbnet_skb_return(dev, ax_skb);

will report back next week :)

