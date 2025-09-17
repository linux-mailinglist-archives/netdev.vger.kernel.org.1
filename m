Return-Path: <netdev+bounces-224006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B40B0B7DF67
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7BE2A3D2C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 12:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613F53233FD;
	Wed, 17 Sep 2025 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4ueDrypv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21DC1EF38E;
	Wed, 17 Sep 2025 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112681; cv=none; b=JKz9U06XZpKfGXMQ24xWRbsY9N/COnpQogmqjRi+GYqRLqQt8QWLPXder++qhRLWRFIGA6U0DVYJNmILddm8wdGBGLimq5pBCNFRkQKesyCr00N8j7gEkRmSlqTYlgjBiAA3U9aOdtGPfk7cbOc4NtNS2hf31ltjmRJGIxDANUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112681; c=relaxed/simple;
	bh=V2ZPWJHV9jW0DR04zuEk3OE/ujMijnKfpmKtkP4xCME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCnbnt3cGjKpmqjxtDE+VS2Sm44lMrsijKhWR+DMcYysIcNS764IcvRo7lIiIClPbzs8Xxstp9er58VRSaNueGIfBmer8wNr+Iou160lrwcG+GYKMW7k/PO9PRWdgmgCxjnXW1AmootKeFHdWY38Xj8asW4jX0FuFdRKu8b82iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4ueDrypv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=e2ZMXo1Gxkk2gy72Jq8lMDtCEkvQOtMbArjyfiUYt4Q=; b=4ueDrypvy4EXJXttDp9V1oXmUr
	rO10IvneSDBEbwMy+mhX/3SIrGmP97e0fNRzWg8RcskCDUYHP2klt6bKvvMuWsUicm/OXFe7+1AUX
	qujZh0PTXXT7ET25zSZq+STMEKnTIKo2ijXyBdi7iA4vpRALof1De68XppAgogqFWcfY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyrPr-008gHb-4f; Wed, 17 Sep 2025 14:37:43 +0200
Date: Wed, 17 Sep 2025 14:37:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <482f27de-f660-4e7a-a1a9-3000b7119567@lunn.ch>
References: <20250913044404.63641-1-mmyangfl@gmail.com>
 <20250913044404.63641-4-mmyangfl@gmail.com>
 <20250916231714.7cg5zgpnxj6qmg3d@skbuf>
 <b0fc2de5-bccc-4ef8-a04d-0c3b13cde914@lunn.ch>
 <20250917100243.s55irruj4bzg343v@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917100243.s55irruj4bzg343v@skbuf>

> I'm not sure that a "driver lock" is something that drivers need.
> In this case it creates a lot of red tape. Function yt921x_dsa_X() takes
> the driver lock and calls function yt921x_X() which does the work.
> IMO that's part of what gives "vendor crap" drivers their name, when
> there's no reason behind it.

As you said, some methods are protected by RTNL. But not all. And it
is hard to know which are not. A driver lock is KISS, and easy to get
right, easy to see is right, and easy to prove is right. Locking can
be hard, so KISS is good.

	Andrew

