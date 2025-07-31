Return-Path: <netdev+bounces-211189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF229B17167
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E014E3E3B
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 12:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3092823A563;
	Thu, 31 Jul 2025 12:41:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00591C84C5;
	Thu, 31 Jul 2025 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965676; cv=none; b=EkoX1SpLDJSNPgFuMg6wL4UqPEk8NOdh8XP66YF2fchpNPipkzM7ZmJJlHrBml6AXXBur3kXWm7TuzGNKtDROnfp30fIfhuafreR0vv+jlryC5zcBC7f6Rjk87Oc8XPGCxRj6ITOE4AiqXrIpRWiWQYgwkcT8yUhjQpYxKMiGvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965676; c=relaxed/simple;
	bh=A8SPR7x7U/Pf/eDeqxWiI48HRFqavciMy1UGMfaZW60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUxh2P56hiAHu8OjD8p4sDfmJaKcb5qW1N0YlMkgcmSHY8GkQ4K58p88nvi6k1PxheUtw50bpKb+v19PGIsoEkKTHUSolDUJDM7sPaR7qI3h/ZkxPLPCHXFu+oTsXW+GPIO9p9KAKHk+L2VZbChzAWiSpaJhypkHpbsCobHQy+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt7v64Rk8z6D9Th;
	Thu, 31 Jul 2025 20:39:30 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A8A91402F4;
	Thu, 31 Jul 2025 20:41:08 +0800 (CST)
Received: from china (10.220.118.114) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 14:40:53 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<fuguiming@h-partners.com>, <gongfan1@huawei.com>, <guoxin09@huawei.com>,
	<gur.stavi@huawei.com>, <helgaas@kernel.org>, <jdamato@fastly.com>,
	<kuba@kernel.org>, <lee@trager.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <mpe@ellerman.id.au>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>,
	<shenchenyang1@hisilicon.com>, <shijing34@huawei.com>, <sumang@marvell.com>,
	<vadim.fedorenko@linux.dev>, <wulike1@huawei.com>, <zhoushuai28@huawei.com>,
	<zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v10 1/8] hinic3: Async Event Queue interfaces
Date: Thu, 31 Jul 2025 15:58:39 +0300
Message-ID: <20250731125839.1137083-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250725152709.GE1367887@horms.kernel.org>
References: <20250725152709.GE1367887@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 frapeml500005.china.huawei.com (7.182.85.13)

> On Thu, Jul 24, 2025 at 09:45:51PM +0800, Fan Gong wrote:
> > > > +
> > > > +/* Data provided to/by cmdq is arranged in structs with little endian fields but
> > > > + * every dword (32bits) should be swapped since HW swaps it again when it
> > > > + * copies it from/to host memory.
> > > > + */
> > >
> > > This scheme may work on little endian hosts.
> > > But if so it seems unlikely to work on big endian hosts.
> > >
> > > I expect you want be32_to_cpu_array() for data coming from hw,
> > > with a source buffer as an array of __be32 while
> > > the destination buffer is an array of u32.
> > >
> > > And cpu_to_be32_array() for data going to the hw,
> > > with the types of the source and destination buffers reversed.
> > >
> > > If those types don't match your data, then we have
> > > a framework to have that discussion.
> > >
> > >
> > > That said, it is more usual for drivers to keep structures in the byte
> > > order they are received. Stored in structures with members with types, in
> > > this case it seems that would be __be32, and accessed using a combination
> > > of BIT/GENMASK, FIELD_PREP/FIELD_GET, and cpu_to_be*/be*_to_cpu (in this
> > > case cpu_to_be32/be32_to_cpu).
> > >
> > > An advantage of this approach is that the byte order of
> > > data is only changed when needed. Another is that it is clear
> > > what the byte order of data is.
> >
> > There is a simplified example:
> >
> > Here is a 64 bit little endian that may appear in cmdq:
> > __le64 x
> > After the swap it will become:
> > __be32 x_lo
> > __be32 x_hi
> > This is NOT __be64.
> > __be64 looks like this:
> > __be32 x_hi
> > __be32 x_lo
>
> Sure, byte swapping 64 bit entities is different to byte swapping two
> consecutive 32 bit entities. I completely agree.
>
> >
> > So the swapped data by HW is neither BE or LE. In this case, we should use
> > swab32 to obtain the correct LE data because our driver currently supports LE.
> > This is for compensating for bad HW decisions.
>
> Let us assume that the host is reading data provided by HW.
>
> If the swab32 approach works on a little endian host
> to allow the host to access 32-bit values in host byte order.
> Then this is because it outputs a 32-bit little endian values

Values can be any size. 32 bit is arbitrary.
.
>
> But, given the same input, it will not work on a big endian host.
> This is because the same little endian output will be produced,
> while the host byte order is big endian.
>
> I think you need something based on be32_to_cpu()/cpu_to_be32().
> This will effectively be swab32 on little endian hosts (no change!).
> And a no-op on big endian hosts (addressing my point above).
>
> More specifically, I think you should use be32_to_cpu_array() and
> cpu_to_be32_array() instead of swab32_array().
>

Lets define a "coherent struct" as a structure made of fields that makes sense
to human beings. Every field endianity is defined and fields are arranged in
order that "makes sense". Fields can be of any integer size 8,16,32,64 and not
necessarily naturally aligned.

swab32_array transforms a coherent struct into "byte jumble". Small fields are
reordered and larger (misaligned) fields may be split into 2 (or even 3) parts.
swab32_array is reversible so a 2nd call with byte jumble as input will produce
the original coherent struct.

hinic3 dma has "swab32_array" built in.
On send-to-device it expects a byte jubmle so the DMA engine will transform it
into a coherent struct.
On receive-from-device it provides a byte jumble so the driver needs
to call swab32_array to transform it into a coherent struct.

The hinic3_cmdq_buf_swab32 function will work correctly, producing byte jumble,
on little endian and big endian hosts.

The code that runs prior to hinic3_cmdq_buf_swab32 that initializes a coherent
struct is endianity sensitive. It needs to initialize fields based on their
coherent endianity with or without byte swap. Practically use cpu_to_le or
cpu_to_be based on the coherent definition.

Specifically, cmdq "coherent structs" in hinic3 use little endian and since
Kconfig currently declares that big endian hosts are not supported then
coherent structs are initialized without explicit cpu_to_le macros.

And this is what the comment says:

/* Data provided to/by cmdq is arranged in structs with little endian fields but
 * every dword (32bits) should be swapped since HW swaps it again when it
 * copies it from/to host memory.
 */

