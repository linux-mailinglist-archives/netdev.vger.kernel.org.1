Return-Path: <netdev+bounces-283743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIl0LYNT+GlUtAIAu9opvQ
	(envelope-from <netdev+bounces-283743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:06:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BEB4B9DF9
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B71F3003360
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 08:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB22314B95;
	Mon,  4 May 2026 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="UOxunXI1"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD362D8DA8;
	Mon,  4 May 2026 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881984; cv=none; b=slNhYBeR6wOzO7rD7Y+McRx8XwrjLNrQVLztYZUTGrvD6OHeZHM2kaLH9eqKd8MRw2bqcPfcEPGYa8tSbsG/7mruSD7Nzn3foSpwhe3k3jJKhfCjaxxwMJ6fk5YXS82o7p6QCIwKZRqd+Hk9VKzlBxHz3UyzhKvoxvp6v6djYqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881984; c=relaxed/simple;
	bh=0Dk8dv/ejG2pu7Eg3GOJvlP8Azj1caLvEPyv/jtgKi0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce3cRW/8PDhLiRexwl8NfbvSiedrOy7fpD0SlP+g2OZrWAJHTNNtnuEwZa/5aCD3tfuMCFNYzFdaVnzMUjq7WLKRGJ7THs0ieM3fnBdnE1G2ugG3msOLBBJGIAlLmZYLOAo/NC4TGleSMTaG0S+WrWelvVGQ11R2kDj6THog14Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=UOxunXI1; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8C335206B0;
	Mon,  4 May 2026 10:06:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PetyLHE_rKxA; Mon,  4 May 2026 10:06:20 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E6D9D206D0;
	Mon,  4 May 2026 10:06:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E6D9D206D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777881979;
	bh=WXdqCoi9aWLyheQblKJiDvFdefNy42wYFTlQ3Srmrs0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=UOxunXI1hXu9nalhg7cgJSq5Lrvdsym2X6OIBsLxjJWLbgtbA4b9sFsQ++8sGvM5W
	 YKW32QJfR8fL/VrEFTzqspxUH6HMsnn6pOOZuBC83q6fTIWmY0kg5zm30T9uL9+6FJ
	 eklLoRfd00k8MOyKAjGhklkGfWC5CLJ+bktvimSYM39S92OApyS4y8eJKmeLdOJjMu
	 9JogFof5c1V06OO7km00Tefs5F54VdH4ayGKZo7LCrhDEMhHMa6N/20HFKeB5CL3Fj
	 gLHQbBDeCdOHktXDw296SaT9/BfRPGvHLsgxr2BAyMztTq+XQYvX3o9+WEYP3S/kxM
	 GBKuX8rKsN2+g==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 10:06:19 +0200
Received: (nullmailer pid 2945512 invoked by uid 1000);
	Mon, 04 May 2026 08:06:18 -0000
Date: Mon, 4 May 2026 10:06:18 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eric Dumazet <edumazet@google.com>
CC: HexRabbit <h3xrabbit@gmail.com>, <netdev@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, "David S .
 Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>, <linux-kernel@vger.kernel.org>, Hyunwoo Kim
	<imv4bel@gmail.com>
Subject: Re: [PATCH net] xfrm: esp: avoid in-place decrypt on shared skb frags
Message-ID: <afhTekPcnIak0IcI@secunet.com>
References: <20260504073403.38854-1-h3xrabbit@gmail.com>
 <afhQjlpmt2agPcRE@secunet.com>
 <CANn89iLeX5eZuH6c=_HcADzgejYzE36HhFxmvg+2U3gqsOqHkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLeX5eZuH6c=_HcADzgejYzE36HhFxmvg+2U3gqsOqHkg@mail.gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 49BEB4B9DF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linuxfoundation.org,gondor.apana.org.au,kernel.org,davemloft.net,redhat.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-283743-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,secunet.com:dkim,secunet.com:mid];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Mon, May 04, 2026 at 12:56:50AM -0700, Eric Dumazet wrote:
> On Mon, May 4, 2026 at 12:53 AM Steffen Klassert
> <steffen.klassert@secunet.com> wrote:
> >
> > We have antoher patch that addresses this issue in a different way,
> > so Cc the author of the other patch.
> >
> > On Mon, May 04, 2026 at 03:34:03PM +0800, HexRabbit wrote:
> > > From: Kuan-Ting Chen <h3xrabbit@gmail.com>
> > >
> > > MSG_SPLICE_PAGES can attach pages from a pipe directly to an skb. TCP
> > > marks such skbs with SKBFL_SHARED_FRAG after skb_splice_from_iter(),
> > > so later paths that may modify packet data can first make a private
> > > copy. The IPv4/IPv6 datagram append paths did not set this flag when
> > > splicing pages into UDP skbs.
> > >
> > > That leaves an ESP-in-UDP packet made from shared pipe pages looking
> > > like an ordinary uncloned nonlinear skb. ESP input then takes the no-COW
> > > fast path for uncloned skbs without a frag_list and decrypts in place
> > > over data that is not owned privately by the skb.
> > >
> > > Mark IPv4/IPv6 datagram splice frags with SKBFL_SHARED_FRAG, matching
> > > TCP. Also make ESP input fall back to skb_cow_data() when the flag is
> > > present, so ESP does not decrypt externally backed frags in place.
> > > Private nonlinear skb frags still use the existing fast path.
> > >
> > > This intentionally does not change ESP output. In esp_output_head(),
> > > the path that appends the ESP trailer to existing skb tailroom without
> > > calling skb_cow_data() is not reachable for nonlinear skbs:
> > > skb_tailroom() returns zero when skb->data_len is nonzero, while ESP
> > > tailen is positive. Thus ESP output will either use the separate
> > > destination-frag path or fall back to skb_cow_data().
> > >
> > > Signed-off-by: Kuan-Ting Chen <h3xrabbit@gmail.com>
> > > ---
> > >  net/ipv4/esp4.c       | 3 ++-
> > >  net/ipv4/ip_output.c  | 2 ++
> > >  net/ipv6/esp6.c       | 3 ++-
> > >  net/ipv6/ip6_output.c | 2 ++
> > >  4 files changed, 8 insertions(+), 2 deletions(-)
> >
> > This looks ok to me. From the IPsec point of view, I'm
> > fine with this patch, but it also touches generic
> > networking code. So I'd like to hear an opinion of one
> > of the networking maintainers before proceeding.
> 
> I have not seen a Fixes: tag.

Right, we need a v2 with a Fixes tag, and maybe also
'Cc: stable@vger.kernel.org'

> Do we need to split this patch into two parts?

I don't think we need to spilt it, we can merge it
either to the net or the ipsec tree. Both should
be OK.

