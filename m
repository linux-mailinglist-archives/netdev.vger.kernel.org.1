Return-Path: <netdev+bounces-211210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4792B172CA
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 16:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04882171889
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DA02C3276;
	Thu, 31 Jul 2025 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vB6TryRb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0231474DA;
	Thu, 31 Jul 2025 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970651; cv=none; b=lY6hdQZwnD5tqIcKwtDi83GShb8FFa828geZe+mIGZtRdk9+Bfqq7uvyWAv66eoXtVynIaCMt5Eerz8BBDlPf8e5skG+KjCEjZV4gS41YhC+zX53SkswdvTo0rj16bAp+zbES+pooS5NaJed7bavF1UA4RzRsjN3O4mYIa1Xyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970651; c=relaxed/simple;
	bh=SN9WLKxqUU91wfpdWi+S97+8/wY9bgFqbbVnqRerV6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F351o1mssIvs7yTsNOdQ+AFXWtJDJKvkEb+yWKCEVWyBOVDYREkGpxB/cKk0t7XDWTAwbhhqScp3WusqfHA3oxrCnz8gK3fBjlOolj+Pr9go0UHK+OY1kVxEenSO3vRMfIMXUYW6VgvvbsTM/Ho4J5N21bDgsk72klVeRtLkUHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vB6TryRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CCCC4CEEF;
	Thu, 31 Jul 2025 14:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753970651;
	bh=SN9WLKxqUU91wfpdWi+S97+8/wY9bgFqbbVnqRerV6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vB6TryRbHC2ejIlxVHgCkNZYpBO4+oew+futJCVIWwhQyrXyx8+VsCH+j2P6ACC3j
	 5inhcCMcU1qbhYm74NGdJPeEdsTUBaboqOrGdmbuuIhnv51KPmDKEtZhfQDO17GyFP
	 GgX53hrC/Vnz4ClfpPIP3jxi4GUiUpS/4HxH3o3klTYWEoMXzNNjDVlYurrfn5o0Cv
	 VeS7ZhDyFXnLa4xnqAu7d2vNuft9ooeUOhTgzt74Xh7fDfUaOHKCrX+qvObIX6M89X
	 t8nEfRvmZXVqbmyHug4pUmNRvcxkhma8jqQ9lzgE8S5Slhee38WXckx84J9kINoreH
	 NJGD0p7DHvmXw==
Date: Thu, 31 Jul 2025 15:04:04 +0100
From: Simon Horman <horms@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: andrew+netdev@lunn.ch, christophe.jaillet@wanadoo.fr, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, fuguiming@h-partners.com,
	gongfan1@huawei.com, guoxin09@huawei.com, helgaas@kernel.org,
	jdamato@fastly.com, kuba@kernel.org, lee@trager.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	luosifu@huawei.com, meny.yossefi@huawei.com, mpe@ellerman.id.au,
	netdev@vger.kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com, shenchenyang1@hisilicon.com,
	shijing34@huawei.com, sumang@marvell.com, vadim.fedorenko@linux.dev,
	wulike1@huawei.com, zhoushuai28@huawei.com,
	zhuyikai1@h-partners.com
Subject: Re: [PATCH net-next v10 1/8] hinic3: Async Event Queue interfaces
Message-ID: <20250731140404.GD8494@horms.kernel.org>
References: <20250725152709.GE1367887@horms.kernel.org>
 <20250731125839.1137083-1-gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731125839.1137083-1-gur.stavi@huawei.com>

On Thu, Jul 31, 2025 at 03:58:39PM +0300, Gur Stavi wrote:
> > On Thu, Jul 24, 2025 at 09:45:51PM +0800, Fan Gong wrote:
> > > > > +
> > > > > +/* Data provided to/by cmdq is arranged in structs with little endian fields but
> > > > > + * every dword (32bits) should be swapped since HW swaps it again when it
> > > > > + * copies it from/to host memory.
> > > > > + */
> > > >
> > > > This scheme may work on little endian hosts.
> > > > But if so it seems unlikely to work on big endian hosts.
> > > >
> > > > I expect you want be32_to_cpu_array() for data coming from hw,
> > > > with a source buffer as an array of __be32 while
> > > > the destination buffer is an array of u32.
> > > >
> > > > And cpu_to_be32_array() for data going to the hw,
> > > > with the types of the source and destination buffers reversed.
> > > >
> > > > If those types don't match your data, then we have
> > > > a framework to have that discussion.
> > > >
> > > >
> > > > That said, it is more usual for drivers to keep structures in the byte
> > > > order they are received. Stored in structures with members with types, in
> > > > this case it seems that would be __be32, and accessed using a combination
> > > > of BIT/GENMASK, FIELD_PREP/FIELD_GET, and cpu_to_be*/be*_to_cpu (in this
> > > > case cpu_to_be32/be32_to_cpu).
> > > >
> > > > An advantage of this approach is that the byte order of
> > > > data is only changed when needed. Another is that it is clear
> > > > what the byte order of data is.
> > >
> > > There is a simplified example:
> > >
> > > Here is a 64 bit little endian that may appear in cmdq:
> > > __le64 x
> > > After the swap it will become:
> > > __be32 x_lo
> > > __be32 x_hi
> > > This is NOT __be64.
> > > __be64 looks like this:
> > > __be32 x_hi
> > > __be32 x_lo
> >
> > Sure, byte swapping 64 bit entities is different to byte swapping two
> > consecutive 32 bit entities. I completely agree.
> >
> > >
> > > So the swapped data by HW is neither BE or LE. In this case, we should use
> > > swab32 to obtain the correct LE data because our driver currently supports LE.
> > > This is for compensating for bad HW decisions.
> >
> > Let us assume that the host is reading data provided by HW.
> >
> > If the swab32 approach works on a little endian host
> > to allow the host to access 32-bit values in host byte order.
> > Then this is because it outputs a 32-bit little endian values
> 
> Values can be any size. 32 bit is arbitrary.
> .
> >
> > But, given the same input, it will not work on a big endian host.
> > This is because the same little endian output will be produced,
> > while the host byte order is big endian.
> >
> > I think you need something based on be32_to_cpu()/cpu_to_be32().
> > This will effectively be swab32 on little endian hosts (no change!).
> > And a no-op on big endian hosts (addressing my point above).
> >
> > More specifically, I think you should use be32_to_cpu_array() and
> > cpu_to_be32_array() instead of swab32_array().
> >
> 
> Lets define a "coherent struct" as a structure made of fields that makes sense
> to human beings. Every field endianity is defined and fields are arranged in
> order that "makes sense". Fields can be of any integer size 8,16,32,64 and not
> necessarily naturally aligned.
> 
> swab32_array transforms a coherent struct into "byte jumble". Small fields are
> reordered and larger (misaligned) fields may be split into 2 (or even 3) parts.
> swab32_array is reversible so a 2nd call with byte jumble as input will produce
> the original coherent struct.
> 
> hinic3 dma has "swab32_array" built in.
> On send-to-device it expects a byte jubmle so the DMA engine will transform it
> into a coherent struct.
> On receive-from-device it provides a byte jumble so the driver needs
> to call swab32_array to transform it into a coherent struct.
> 
> The hinic3_cmdq_buf_swab32 function will work correctly, producing byte jumble,
> on little endian and big endian hosts.
> 
> The code that runs prior to hinic3_cmdq_buf_swab32 that initializes a coherent
> struct is endianity sensitive. It needs to initialize fields based on their
> coherent endianity with or without byte swap. Practically use cpu_to_le or
> cpu_to_be based on the coherent definition.
> 
> Specifically, cmdq "coherent structs" in hinic3 use little endian and since
> Kconfig currently declares that big endian hosts are not supported then
> coherent structs are initialized without explicit cpu_to_le macros.
> 
> And this is what the comment says:
> 
> /* Data provided to/by cmdq is arranged in structs with little endian fields but
>  * every dword (32bits) should be swapped since HW swaps it again when it
>  * copies it from/to host memory.
>  */
> 

Thanks, I think I am closer to understanding things now.

Let me try and express things in my own words:

1. On the hardware side, things are stored in a way that may be represented
   as structures with little-endian values. The members of the structures may
   have different sizes: 8-bit, 16-bit, 32-bit, ...

2. The hardware runs the equivalent of swab32_array() over this data
   when writing it to (or reading it from) the host. So we get a
   "byte jumble".

3. In this patch, the hinic3_cmdq_buf_swab32 reverses this jumbling
   by running he equivalent of swab32_array() over this data again.

   As 3 exactly reverses 2, what is left are structures exactly as in 1.

If so, I agree this makes sense and I am sorry for missing this before.

And if so, is the intention for the cmdq "coherent structs" in the driver
to look something like this.

   struct {
	u8 a;
	u8 b;
	__le16 c;
	__le32 d;
   };

If so, this seems sensible to me.

But I think it would be best so include some code in this patchset
that makes use of such structures - sorry if it is there, I couldn't find
it just now.

And, although there is no intention for the driver to run on big endian
systems, the __le* fields should be accessed using cpu_to_le*/le*_to_cpu
helpers.

