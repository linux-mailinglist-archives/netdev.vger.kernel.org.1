Return-Path: <netdev+bounces-239167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 098DDC64D7F
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 16:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 19FCE35F17F
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B65339B43;
	Mon, 17 Nov 2025 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wqWVApOf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A125486D;
	Mon, 17 Nov 2025 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392596; cv=none; b=s17x4RmlGOKiJo2Xf92v847uJ8PhZ8Jxq78KI9ZgrRE5wMmWtP/hjVNJ3unzfoIekitewEgN6lMHi+2+eQs7fsKuMK+wT2NENb1bWSDlo2dO0Yp4pOKu8v4iMo55tiAwC1cKhelWTDMVeS/NFI3ApnY1Ryna+XtJheG3dCzKcbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392596; c=relaxed/simple;
	bh=XEvEWMteZPfye3qixtrCv2y8U7IJBzphP6dKiKxBf5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYeV/bwFmihUUncKmFTSBkBBG8nBMvC78gn25as+4Y9iza74dzbWG7N5Dfi0NL9qIGzxvWYhjHiDZ8tzoiKnLE1r5VqdLTcgS2cVivFUQjbUSqcPkiQBLw3AfUZHh944+f/uOVGNu3YnQDoOwVQWOKBQc+ZkIARSphkbmjzn6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wqWVApOf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0iPLRHgS6teleSKYRRbynIml90CWfijVv5vx60t7mdE=; b=wqWVApOflz6/2YeFRZijMKpFC3
	kxr0LeMyGxuDRXdKNadAFH5Ep2wcA2SWmB7SHTaHsYuArBNuEFfK6j9XFLD53AsbmsQKcsv2EZoye
	p9JI01lg5vvcwvxmX+cVlaxQnNzUEhlt+dAFSEVlc0W7lgwsC7Ftv9Sraov86hm+px1g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vL0xm-00EFoa-Pa; Mon, 17 Nov 2025 16:16:18 +0100
Date: Mon, 17 Nov 2025 16:16:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Peter Enderborg <peterend@axis.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for net-next] if_ether.h: Clarify ethertype validity for
 gsw1xx dsa
Message-ID: <b072d237-2bc0-4930-a8f0-2adb7eb81043@lunn.ch>
References: <20251114135935.2710873-1-peterend@axis.com>
 <3feaff7a-fcec-49d9-a738-fa2e00439b28@lunn.ch>
 <5a7f0105-801d-41d9-850c-03783d76f3e1@axis.com>
 <7000f777-d082-4b06-88dd-67f947c85d2a@lunn.ch>
 <5b0bd2a0-c1cb-40f0-9226-3038ea9eb294@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0bd2a0-c1cb-40f0-9226-3038ea9eb294@axis.com>

On Mon, Nov 17, 2025 at 03:59:13PM +0100, Peter Enderborg wrote:
> You have to pay us$4000 to get a ethertype.
> 
> On 11/17/25 14:28, Andrew Lunn wrote:
> > On Mon, Nov 17, 2025 at 10:02:05AM +0100, Peter Enderborg wrote:
> > > (resend due to html bounce)
> > > On 11/15/25 21:41, Andrew Lunn wrote:
> > > > On Fri, Nov 14, 2025 at 02:59:36PM +0100, Peter Enderborg wrote:
> > > > > Ref https://standards-oui.ieee.org/ethertype/eth.txt
> > > > > 
> > > > > 
> > > > Is this actually registered with IANA?
> > > No.
> > > 
> > > > https://www.iana.org/assignments/ieee-802-numbers/ieee-802-numbers.xhtml
> > > > 
> > > > Does not list it. Please keep the "NOT AN OFFICIALLY REGISTERED ID" if
> > > > it is not.
> > > IEEE is the official source to use for ethertype number assignment.
> > What i want to make clear is, if IEEE officially allocate this to
> > something else, this is an unofficial allocation, and the official use
> > can replace it. We have a few ID like this, and never had a collision
> > yet, but it could happen.
> 
> This is the public list from IEEE. It wont get more official. Yes, official
> allocation can be changed in non backward compatible way. It happen
> in 1983 so it can happen again. If the standard changes we need to adopt.
> 
> "NOT AN OFFICIALLY REGISTERED ID" is wrong, it is "Infineon Technologies Corporate Research ST".

Ah. Let me see if i have this correct.....

Infineon made a spin off called Lantiq.

Lantiq was acquired by Intel

MaxLinear acquired Intels Connected Home division.

Assuming the rights to this ID transferred along the way, it is
O.K. for MaxLinear to use this ID. But, IANAL...

Please expand the commit message with this history, which is then a
justification for removing the NOT AN OFFICIALLY REGISTERED ID, and
why it is O.K. for MaxLinear to use it.

	Andrew

