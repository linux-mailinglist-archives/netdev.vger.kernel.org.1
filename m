Return-Path: <netdev+bounces-161493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D578A21DAB
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77ACC1882BDF
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0D633997;
	Wed, 29 Jan 2025 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xH3tLDAy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F07CEEC5
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156499; cv=none; b=hw/Apk4ljdoVHFnEJOfpqSDPzCUfyqnkCFXyimzsLqFZ/IEtKhtN/B70pwlDvkjbPmd2lgq/afDWYBTCKRw7G8WpAvak1s04tmuBC3Vh/LO8u1kbNt/IQQM67RZ8Xo/Mhghs2n/08cHilKvf6E/AumE5YqnMLNgmBCSlz02k/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156499; c=relaxed/simple;
	bh=h31Qbs8XjC1eT1tHcjH9wX3v7Ur0+cuMi/Kku4iDMuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw2i4YFHnuPnU/3X3OiQo3du/pJgXMurpLhl+qkdNrgjbUlcEQ5X6t43QXNX4IxvB2/XiCwf2f+nbVp1dYJqgU57TYZgAK8dY56jp9D9oBiAo6hI5Ox156WALX48PdI0ppFFDLkP5j/DYAsLsmziPZTjci5nMA1u8NUpiJJgwFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xH3tLDAy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=96xQKXbW88WSfMfKlu8LMdocq/6Ub/czkB0Et5xaEZY=; b=xH3tLDAyvQo4SrHTVIoBpKp5V4
	Hb0CHfJRn/swPKfyrKadgiXtr+Xdh3CKmHe9NIiJssv4rXaP99A8EcJNdhVBYYPKKRGSMDQNWPC/N
	aKQ+bl+SDT8DNR2ZDelG67De9UE1aM9t6AVmaL1OBSyPmew6UP57blCIrugez4HmewFs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1td7uC-0098JF-AD; Wed, 29 Jan 2025 14:14:56 +0100
Date: Wed, 29 Jan 2025 14:14:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Lukasz Majewski <lukma@denx.de>
Subject: Re: KSZ9477 HSR Offloading
Message-ID: <82dd2368-561f-49d2-a52a-911c045b4873@lunn.ch>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
 <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
 <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>

> >> How are IP addresses configured? I assume you have a bridge, LAN1 and
> >> LAN2 are members of the bridge, and the IP address is on the bridge
> >> interface?
> > 
> > I have a HSR interface on each node that covers LAN1 and LAN2 as slaves
> > and the IP addresses are on those HSR interfaces. For node A:
> > 
> > ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision 45
> > version 1
> > ip addr add 172.20.1.1/24 dev hsr
> > 
> > The other nodes have the addresses 172.20.1.2/24, 172.20.1.3/24 and
> > 172.20.1.4/24 respectively.
> > 
> > Then on node A, I'm doing:
> > 
> > ping 172.20.1.2 # neighboring node B works
> > ping 172.20.1.4 # neighboring node D works
> > ping 172.20.1.3 # remote node C works only if I disable offloading
> 
> BTW, it's enough to disable the offloading of the forwarding for HSR
> frames to make it work.

HSR is not my area of expertise, but that makes sense, HSR is a L2
concept, so you need something like a bridge, which the hsr device is,
and it is where you put the IP address.

Hopefully Lukasz can help you.

	Andrew

