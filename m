Return-Path: <netdev+bounces-189548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7375AB296E
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 17:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F401709E9
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 15:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD342580F0;
	Sun, 11 May 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r+J4U9rW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89B0433A0
	for <netdev@vger.kernel.org>; Sun, 11 May 2025 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746978835; cv=none; b=NK+fBs6mp/K/IlsZ4ObxevX1y4VC/bDcaDpT9V44g1Scn8zxpyr3GnWdAmRwALyUaXKVNa3QmpSQFH3gRSagrPqTxHJBAHnpbf9gUFcwSj8jBZQQG6kJQcdWxJjf6+lgVT3Gq4asaE7KL+jFIPBO9WJMq9ovJOauGuqA8YI4FsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746978835; c=relaxed/simple;
	bh=u2R7N6LxbkFfqCg7VgP4+tLrdiJ18ve98MRPbx/b9Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxgKLYqe7FGhwCk6ckLEyhhsVlHtcllnzKd356Ge5FjTS1XS+/dvuRMVes7fhOfs3gVtUthzn8vl2sm6QElAcdkklwMkuMLhWBSWKdB7ISsG7loyFhKZcSXeZal8nXo2DG0Gu/CNh4QHKU5NM8brKzPIWD4S9aTrG87OrLGrGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r+J4U9rW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FudL8wW38yLUAKfCCvZQoCwQ9Q6z7DFk59SrgsfBOQY=; b=r+J4U9rWgzjJoNwEkP1kvVR+Uq
	yf2K7FHUsQqJDFefLmovPvyzb+dU15YZpYXZEylFDf0YFtvvQoNzzo8uFsrK5Fj63WDhPdVM+aSK6
	SykTx9BhKbnEm7pgX4qYpxeotQh3EdhT5Z782eTlpVRg5TyLQPTGF9UMja0UNrBh7KNI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uE8zg-00CG90-OF; Sun, 11 May 2025 17:53:36 +0200
Date: Sun, 11 May 2025 17:53:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next 1/4] net: bonding: add broadcast_neighbor option
 for 802.3ad
Message-ID: <ea87b2d2-9b17-4f16-9e40-fe7212f2788d@lunn.ch>
References: <20250510044504.52618-1-tonghao@bamaicloud.com>
 <20250510044504.52618-2-tonghao@bamaicloud.com>
 <1133230.1746881077@vermin>
 <CE4DB782-91EB-4DBD-9C26-CA4C4612D58C@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CE4DB782-91EB-4DBD-9C26-CA4C4612D58C@bamaicloud.com>

> static inline bool bond_should_broadcast_neighbor(struct bonding *bond,
>                                                   struct sk_buff *skb)
> {
>         if (!bond->params.broadcast_neighbor ||
>             BOND_MODE(bond) != BOND_MODE_8023AD)
>                 return false;

I think you missed the point. You have added these two tests to every
packet on the fast path. And it is very likely to return false. Is
bond.params.broadcast_neighbor likely to be in the cache? A cache miss
is expensive. Is bond.params.mode also likely to be in cache? You
placed broadcast_neighbor at the end of params, so it is unlikely to
be in the same cache line as bond.params.mode. So two cache misses.

What Jay would like is that the cost on the fast path is ~0 for when
this feature is not in use. Jump labels can achieve this. It inserts
either a NOP or a jump instruction, which costs nearly nothing, and
then uses self modifying code to swap between a NOP or a jump. You can
keep a global view of is any bond is using this new mode? If no, this
test is eliminated. If yes, you do the test.

	Andrew

