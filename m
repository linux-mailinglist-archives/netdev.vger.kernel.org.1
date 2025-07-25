Return-Path: <netdev+bounces-210069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BBEB120EF
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5846B4E554D
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 15:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1E62EE960;
	Fri, 25 Jul 2025 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sF0ie5wu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C2218592;
	Fri, 25 Jul 2025 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457238; cv=none; b=VTGdK0E1UpeL1kEYyA7SJd+E2InXRQw6AObyHbkow4Ry7SEXcekLL+rDYhIJdK4dNQU7KrHGCuYZjLV2S4/xKQnkvvIkELI18VHVvD3HIox8Qt3nn0vqBsKGP35boxTyC6rUlKZ8a1GYcmvBg5G4r1h1nQBQWs2DQFQZKnycbDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457238; c=relaxed/simple;
	bh=qM7/+BGGB9SCqAKipIZlD4cUu7CfIL7Ub9snrawtBfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4Od85LEOCOw/7I74XvbpRvHCl2Sj+o6Kyz57+BOcTOLuVyY1DhYEi9j98Rx+M6EOrVzPc3vQadXAPzCl6nBLBc8D/aWdNpyY/jTZbkYDAtlesxkqCnZg2Mrk8ePYI6XH0DH113SCsqPdZgzaM9MDqKF7iuStjY1LNi4imqu/S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sF0ie5wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6734CC4CEE7;
	Fri, 25 Jul 2025 15:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753457236;
	bh=qM7/+BGGB9SCqAKipIZlD4cUu7CfIL7Ub9snrawtBfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sF0ie5wu+jQQHM1BRQJY+y6wOsUrpIAQe1zpmGv40Rvuw45bNgRpcgEE9MiGoxjnt
	 Ngr4VQhJZu6xOj2djqOZlGMkAamkmSv28Ztl4qCRbodlMP+73yXTtkYJNLcIKrdiDQ
	 jHpmFyG3wFBxrMN5AhG1epRTu0pTL32MDj0guejboQj5zS8fF/TZxhst50w1PA/M+Z
	 pncNGoY2NlVr47YcnvxutyQcc7pRPBO3tZpf9Bj8zusKLtrBJkQIlPwclj2kFULBv3
	 QkSbna/Em5RttySBz/QBmTcBaCVlVhG7CTipRdTV3/qr/XxEaXBTxylMY+jSPRGALb
	 4EBs+MoZjDJBw==
Date: Fri, 25 Jul 2025 16:27:09 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: andrew+netdev@lunn.ch, christophe.jaillet@wanadoo.fr, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, fuguiming@h-partners.com,
	guoxin09@huawei.com, gur.stavi@huawei.com, helgaas@kernel.org,
	jdamato@fastly.com, kuba@kernel.org, lee@trager.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	luosifu@huawei.com, meny.yossefi@huawei.com, mpe@ellerman.id.au,
	netdev@vger.kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com, shenchenyang1@hisilicon.com,
	shijing34@huawei.com, sumang@marvell.com, vadim.fedorenko@linux.dev,
	wulike1@huawei.com, zhoushuai28@huawei.com,
	zhuyikai1@h-partners.com
Subject: Re: [PATCH net-next v10 1/8] hinic3: Async Event Queue interfaces
Message-ID: <20250725152709.GE1367887@horms.kernel.org>
References: <20250723081908.GW2459@horms.kernel.org>
 <20250724134551.30168-1-gongfan1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724134551.30168-1-gongfan1@huawei.com>

On Thu, Jul 24, 2025 at 09:45:51PM +0800, Fan Gong wrote:
> > > +
> > > +/* Data provided to/by cmdq is arranged in structs with little endian fields but
> > > + * every dword (32bits) should be swapped since HW swaps it again when it
> > > + * copies it from/to host memory.
> > > + */
> >
> > This scheme may work on little endian hosts.
> > But if so it seems unlikely to work on big endian hosts.
> >
> > I expect you want be32_to_cpu_array() for data coming from hw,
> > with a source buffer as an array of __be32 while
> > the destination buffer is an array of u32.
> >
> > And cpu_to_be32_array() for data going to the hw,
> > with the types of the source and destination buffers reversed.
> >
> > If those types don't match your data, then we have
> > a framework to have that discussion.
> >
> >
> > That said, it is more usual for drivers to keep structures in the byte
> > order they are received. Stored in structures with members with types, in
> > this case it seems that would be __be32, and accessed using a combination
> > of BIT/GENMASK, FIELD_PREP/FIELD_GET, and cpu_to_be*/be*_to_cpu (in this
> > case cpu_to_be32/be32_to_cpu).
> > 
> > An advantage of this approach is that the byte order of
> > data is only changed when needed. Another is that it is clear
> > what the byte order of data is.
> 
> There is a simplified example:
> 
> Here is a 64 bit little endian that may appear in cmdq:
> __le64 x
> After the swap it will become:
> __be32 x_lo
> __be32 x_hi
> This is NOT __be64.
> __be64 looks like this:
> __be32 x_hi
> __be32 x_lo

Sure, byte swapping 64 bit entities is different to byte swapping two
consecutive 32 bit entities. I completely agree.

> 
> So the swapped data by HW is neither BE or LE. In this case, we should use
> swab32 to obtain the correct LE data because our driver currently supports LE.
> This is for compensating for bad HW decisions.

Let us assume that the host is reading data provided by HW.

If the swab32 approach works on a little endian host
to allow the host to access 32-bit values in host byte order.
Then this is because it outputs a 32-bit little endian values.

But, given the same input, it will not work on a big endian host.
This is because the same little endian output will be produced,
while the host byte order is big endian.

I think you need something based on be32_to_cpu()/cpu_to_be32().
This will effectively be swab32 on little endian hosts (no change!).
And a no-op on big endian hosts (addressing my point above).

More specifically, I think you should use be32_to_cpu_array() and
cpu_to_be32_array() instead of swab32_array().

> 
> > > +void hinic3_cmdq_buf_swab32(void *data, int len)
> > > +{
> > > +	u32 *mem = data;
> > > +	u32 i;
> > > +
> > > +	for (i = 0; i < len / sizeof(u32); i++)
> > > +		mem[i] = swab32(mem[i]);
> > > +}
> >
> > This seems to open code swab32_array().
> 
> We will use swab32_array in next patch.
> Besides, we will use LE for cmdq structs to avoid confusion and enhance
> readability.

Thanks.

