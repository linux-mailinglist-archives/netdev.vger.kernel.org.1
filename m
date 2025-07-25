Return-Path: <netdev+bounces-210245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D96B127AD
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 01:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687E91C82F01
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 23:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F703261581;
	Fri, 25 Jul 2025 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5ViWjLs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38328126C1E;
	Fri, 25 Jul 2025 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753487601; cv=none; b=icSuKfKvJ71z578i6GHMkzEAeK5ZNJ4GpnmPer7Q5shiccjO58zWq8rGps6bIrJ/HMSCz8clhgK7DSm7T1fdAqVFIWiy7uIySwtqLdfxpXSP+GFHyPZZwIRiIgMLOvJTOS7Hz7wawr0orXm4AR2n7Sw8Bdol+etTxJqVCNjIoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753487601; c=relaxed/simple;
	bh=NqoXLUuAf82ud3Ct2ZNxUllxw0cjOfg6jGytZWQZ+Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbsnUwu7VU1ndnZMGoZHhzpyLAIJfMkjeU1xZ83IrxGQ4p/F/50jaCvY5eAAaKEd87m3Nstdr9l1soArt5HrK0tC/6WTpmZ7l++H4Civm1tN1FEJnGxwuMxHVBecKs45CTows0YivHPyMXwiE8grTX3vtlsAlZd1qW+PK9w0x/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5ViWjLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509F6C4CEE7;
	Fri, 25 Jul 2025 23:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753487600;
	bh=NqoXLUuAf82ud3Ct2ZNxUllxw0cjOfg6jGytZWQZ+Uc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R5ViWjLs08ZlW5Z8q/n7rxmu/69aWewHkfIWDHrFFyFcVuZudgRZkfZv6kZemM3o5
	 CVCCvKK7bUL05N5yu8qq7BTITUn94QRx99GbzTUk4e3ehOZ0d8GfBw/Vy5mBxAMnGO
	 rp8wol1biiYcn5/WNFaePkDz6YrGJvbjjIbgSIB7StaU5+0zhXbK18uiPdn4fHFwIg
	 jOSrz9rqz5xPqR4PYQ8HwD78ZwLscb3gBNrfpcjEBVblP4KOFEhGd8CK7vaL8ZycxG
	 TTWEdyl2sateqRQ8d5noRH28eYp9j+Hpph6eTiz+LpJRq+H3fmy/KWNn8cmjr1uQn5
	 64pT7cqevwnfw==
Date: Fri, 25 Jul 2025 16:53:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sunil Goutham
 <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, "Subbaraya
 Sundeep" <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [net-next PatchV3] Octeontx2-pf: ethtool: Display "Autoneg" and
 "Port" fields
Message-ID: <20250725165319.5d01da34@kernel.org>
In-Reply-To: <20250724101057.2419425-1-hkelam@marvell.com>
References: <20250724101057.2419425-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 15:40:57 +0530 Hariprasad Kelam wrote:
>     Supported link modes:  10000baseCR/Full
> 	                   10000baseSR/Full
>                            10000baseLR/Full

>     Speed: 10000Mb/s
>     Duplex: Full
>     Port: Twisted Pair

How can you have twisted pair with those link modes.
Twisted pair is 10000baseT/Full.
If the link mode is CR the correct port type is PORT_DA.
-- 
pw-bot: cr

