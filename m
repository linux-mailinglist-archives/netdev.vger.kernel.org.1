Return-Path: <netdev+bounces-114441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2AD9429B2
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B781F21F37
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 08:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF04F1A8BF6;
	Wed, 31 Jul 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQol9oX3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94AD1A7F87
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416086; cv=none; b=W6+6Ug/MAnD1CjgtYZQjG2V8p7CJfLw6CHPY4ojwOfi6qllgxnIjRMMiETTgwkI/3pXMQLfiSizbamvwOK+XqeROfuEF68WQy+XGjs032xLPWAWLmolXBXFM6pE05beM3X8m87+q+kcjLNwL2BbrMgUXGPuAY7qgITErHd9lo2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416086; c=relaxed/simple;
	bh=qmbJvr1Uuy1tS5AnKk7/a4dNC6RsQBMVIpnBMNp6TJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIu2K3xfHq2koshjApuutxyDn+QyzqH4GBijcGBwEjOHRecTAh+2PvZct0HIuyw/ggZDWwUpBc+R6J2UbWWUv31HIAp7NnjYueNM+MTwnnslLTFE3RraFcey3Q9S3z8CLIdLX8mT5vSFI3eb5dvTNlydV8JwDsFBCFwPmil+CxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQol9oX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9769C116B1;
	Wed, 31 Jul 2024 08:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722416086;
	bh=qmbJvr1Uuy1tS5AnKk7/a4dNC6RsQBMVIpnBMNp6TJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQol9oX3QO1yPMil8dpygVEjJx/zbPmkgQB+uGOgfYzaTfPxs+q7YvBaonwj55y0c
	 ArQClHRNK8XCjrjaHCiMWvxjWSNbdmnoNsif8KSk3AosVtY8fXeEXBYYi2VsggGSeZ
	 Ds5rN32IW6ix3luj2lD9fnPrbbbUcEC8Si5wh+B0OTUxK0+rV/1VPG6EWYu1c13pV5
	 kFIlbRcbIpX8ZvwK0rQVMRQKKbuboSyTI3K7QFhnNCve2B+HnY9j+IQxKckiFmgYxM
	 RCa9f3WDYiEx45uzxFSTu0ebMc7t9iB7EcBAunQa4gBNLk2ua8UJtdGgoJgSl8shyj
	 JBDifU2bZuRwA==
Date: Wed, 31 Jul 2024 09:54:42 +0100
From: Simon Horman <horms@kernel.org>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
	"Simek, Michal" <michal.simek@amd.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: Re: net: xilinx: axienet: Query about checksum partial implementation
Message-ID: <20240731085442.GN1967603@kernel.org>
References: <20240726120700.GA1694627@kernel.org>
 <MN0PR12MB59534F7030FB73002F1223F4B7B02@MN0PR12MB5953.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB59534F7030FB73002F1223F4B7B02@MN0PR12MB5953.namprd12.prod.outlook.com>

On Tue, Jul 30, 2024 at 07:15:13PM +0000, Pandey, Radhey Shyam wrote:
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Friday, July 26, 2024 5:37 PM
> > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>; Ariane Keller
> > <ariane.keller@tik.ee.ethz.ch>; Simek, Michal <michal.simek@amd.com>;
> > netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: net: xilinx: axienet: Query about checksum partial implementation
> > 
> > Hi Radhey, all,
> > 
> > I am wondering if you could shed some light on the following checksum
> > partial handling in the axienet_rx_poll():
> > 
> >                         /* if we're doing Rx csum offload, set it up */
> >                         if (lp->features & XAE_FEATURE_FULL_RX_CSUM) {
> > 				...
> >                         } else if ((lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) != 0
> > &&
> >                                    skb->protocol == htons(ETH_P_IP) &&
> >                                    skb->len > 64) {
> >                                 skb->csum = be32_to_cpu(cur_p->app3 & 0xFFFF);
> >                                 ...
> >                         }
> > 
> > In particluar the "skb->csum =" line.
> > 
> > The type of cur_p->app3 is u32, and 0xFFFF is also host byte order.
> > So far so good. But after the bitwise operation it is treated as a big-endian
> > value by passing it to be32_to_cpu.
> > 
> > Perhaps I am missing something obvious, but my question is how does that
> > work?
> > 
> > * Was it only tested on big endian sysgtems where be32_to_cpu() is a no-op
> > 
> > * Was it only tested on little endian systems where be32_to_cpu()
> >   is a byteswap and somehow that works (how?).
> > 
> > * Is the code unecessised because the XAE_FEATURE_FULL_RX_CSUM branch
> > is
> >   always taken?
> > 
> >   A grep of dts files shows up arch/microblaze/boot/dts/system.dts which
> >   sets sets xlnx,rxcsum to 0, which corresponds to XAE_NO_CSUM_OFFLOAD.
> 
> + Harini
> 
> Yes, IIRC default AXI Ethernet IP RX checksum is set to "No checksum offload"
> so, it is default case and being set in most designs. Have added Harini to this
> thread to confirm on partial checksum verification results.
> 
> Assuming partial implementation is functional then likely DMA IP updates
> application field in big endian format and that is the reason we have this
> be32 to CPU conversion in place. will dig a bit more and get back on it.

Thanks, much appreciated.

FWIIW, I do agree that the scenario you describe would mostly explain
things, although the mask with 0xFFFF still seems off.

