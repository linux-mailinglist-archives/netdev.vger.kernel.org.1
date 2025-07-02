Return-Path: <netdev+bounces-203509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF53AF638E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DFB1C422C7
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 20:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF73C2D6415;
	Wed,  2 Jul 2025 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL2hXc4A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C32DE6E2;
	Wed,  2 Jul 2025 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751489611; cv=none; b=D3Gd1RQQmcBYvg482xOQ/dnmCU/oxyegPHkN+nblbZzlMjcTuOLRBPVpkuwpjEraYumk67A3aqBDQFO8XFdHnATDd3ig/GoF5jxA4H+8chdrxG7yxypCTElNxFJKrZqNQBBfq9XUCeOBn3yrbfw7p4e35jfh2IEuqVqV4GFos3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751489611; c=relaxed/simple;
	bh=rl3zKx7F20QaIupDu9ZefM9xSY3d7yuEuQmie46w34A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbcPJsqKIkKuHmkF1KdDt0ruXbXXYNLoKbDYIwttHId5v6//cf8UtiPkI65trpa0PfOYUN6SCerCn+ptu5oq1VUzucFLkaMQv2S5PtkFz0850QbJPB2LDHmaDS0AgDDVehiZPHeVyszFhBdVtUigI+di8nnTGs08pOWtB9rU1JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL2hXc4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EAEC4CEE7;
	Wed,  2 Jul 2025 20:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751489611;
	bh=rl3zKx7F20QaIupDu9ZefM9xSY3d7yuEuQmie46w34A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eL2hXc4AxGmCBEN04ff4QAxFRxgEKV3jAXyQrSrUqVLZIDVVc5Nky3xnzpu2fmDf+
	 82H0gW5DioNaITyeZcZWlcIsM3o9ls5EQ4dGA1aJhWuZzc6q5y7sJhlOZaAYMaiGKn
	 2i3bLVm+iZCo+s2pfT/KTqH2RRfJ1lBIrIYZcwsPJ3ceIgmGB8FkG5Q2F5CxFoThHB
	 jW1084vx9OyDJ0ihZBhNYNHrp/wFlWomwy8bo62hpU8LHgJYTsiFklAnBr8srl3fVw
	 h5Ht05579CM6sAPsfyYxP8jeXro1gM9EUvWMOSsHuyLrDbgFJVXi4/29I/P7P+pLvt
	 dHQO7tqMrDZvw==
Date: Wed, 2 Jul 2025 13:53:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: almasrymina@google.com, asml.silence@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 tariqt@nvidia.com, cratiu@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
Message-ID: <20250702135329.76dbd878@kernel.org>
In-Reply-To: <c5pxc7ppuizhvgasy57llo2domksote5uvo54q65shch3sqmkm@bgcnojnxt4hh>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
	<20250702172433.1738947-2-dtatulea@nvidia.com>
	<20250702113208.5adafe79@kernel.org>
	<c5pxc7ppuizhvgasy57llo2domksote5uvo54q65shch3sqmkm@bgcnojnxt4hh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Jul 2025 20:01:48 +0000 Dragos Tatulea wrote:
> On Wed, Jul 02, 2025 at 11:32:08AM -0700, Jakub Kicinski wrote:
> > On Wed, 2 Jul 2025 20:24:23 +0300 Dragos Tatulea wrote:  
> > > For zerocopy (io_uring, devmem), there is an assumption that the
> > > parent device can do DMA. However that is not always the case:
> > > for example mlx5 SF devices have an auxiliary device as a parent.  
> > 
> > Noob question -- I thought that the point of SFs was that you can pass
> > them thru to a VM. How do they not have DMA support? Is it added on
> > demand by the mediated driver or some such?  
> They do have DMA support. Maybe didn't state it properly in the commit
> message. It is just that the the parent device
> (sf_netdev->dev.parent.device) is not a DMA device. The grandparent
> device is a DMA device though (PCI dev of parent PFs). But I wanted to
> keep it generic. Maybe it doesn't need to be so generic?
> 
> Regarding SFs and VM passtrhough: my understanding is that SFs are more
> for passing them to a container.

Mm. We had macvlan offload for over a decade, there's no need for
a fake struct device, auxbus and all them layers to delegate a
"subdevice" to a container in netdev world.
In my head subfunctions are a way of configuring a PCIe PASID ergo
they _only_ make sense in context of DMA.
Maybe someone with closer understanding can chime in. If the kind
of subfunctions you describe are expected, and there's a generic 
way of recognizing them -- automatically going to parent of parent
would indeed be cleaner and less error prone, as you suggest.

