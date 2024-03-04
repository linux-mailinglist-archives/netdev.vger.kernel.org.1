Return-Path: <netdev+bounces-77089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE58D87028A
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 14:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1917C1C2084C
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 13:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166BA3D560;
	Mon,  4 Mar 2024 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rC1nG9Eh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E23C3D547
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558512; cv=none; b=sSFX4yV6k6KclO722xoTBIQw4X163U5WcqeoU3rXCwGAji0sS56q4vnESX8wQDDvBiXRRvTN2kF/AxknIY7Pvu459ayUE5j15IkPPL4MluUfJoN9lvdOwZsLS2yCFbH6n6+KvKjGSTOHiap/tjtX9V5uLXLOvwNucSgGB9ookuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558512; c=relaxed/simple;
	bh=C49sg2Dp2mTLaAhznGffYsE/pKtC305wcs7Y7Pacrhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJPfhG0olGJj6rS6j7rmoEqWCK6aun8UQhP0/VOO7YV8eV4Z3ns4GWZYN1dkwYBFI5Vzn15Z6Ezz7nm104nWZJ1cxm9n2WThka+O+6UvCN6JsV/eZQEsr3yYAEJmaI/sPw3eG/DS432aVIR3vm5ZrnNHFojhM0xZ3xZOW7Cm/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rC1nG9Eh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5qP8R9oX0cwwLAQPw0Wfq5jIiyCJnfOqtdNI4lCv7xA=; b=rC1nG9Ehf8H5B17d8/U9C6JdBc
	5SyTuFrp5MN7RynXVOTO9wWcSm0z/OxR6hRoElnNRZOKi66JwMT3N3OgLVYz702dHKq2EPFdQ2ude
	tZ54zwaViRrmujOxbvJ5h7rpUeo/2TXoJWj2mCq57VfUVkwjTDh+78mjokideyjs6gnc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rh8Gc-009KCw-Gm; Mon, 04 Mar 2024 14:22:06 +0100
Date: Mon, 4 Mar 2024 14:22:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Steen.Hegelund@microchip.com,
	netdev@vger.kernel.org, Horatiu.Vultur@microchip.com,
	Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
	Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com
Subject: Re: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Message-ID: <0dd74757-33e3-4872-85e1-8276ea6f1f22@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <1e6c9bf1-2c36-4574-bd52-5b88c48eb959@lunn.ch>
 <5e85c427-2f36-44cc-b022-a55ec8c2d1bd@microchip.com>
 <e819bb00-f046-4f19-af83-2529f2141fa6@lunn.ch>
 <04a2e78e-aac4-4638-b096-a2f0a8d3950b@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04a2e78e-aac4-4638-b096-a2f0a8d3950b@microchip.com>

> Hi Andrew,
> 
> Good day...!
> 
> Finally we have completed the v3 patch series preparation and planning 
> to post it in the mainline in the next days. FYI, next week (from 11th 
> to 15th March) I will be out of office and will not have access to 
> emails. Again will be back to work on 18th March. Would it be ok for you 
> to post the patch series this week or shall I post it on March 18th? as 
> I will not be able to reply to the comments immediately. Could you 
> please provide your suggestion on this?

Onsemi are waiting for the new version. So i would suggest you post
them sooner, not later. If need be, get one of the other Microchip
developers to post them. If they are posted RFC, the signed-off-by can
be missing the actual submitter.

       Andrew

