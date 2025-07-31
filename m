Return-Path: <netdev+bounces-211253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 828B5B1760E
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 20:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C584718C3A4C
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 18:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA5723E33D;
	Thu, 31 Jul 2025 18:16:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829251E0DB0;
	Thu, 31 Jul 2025 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985815; cv=none; b=ngnUc7uQfizxorl9AxM89AlgJ4JXWqUFz59x8qlXfl6N6bwwh8GCxeSGJRQUVIAbsQ4SVQ/5894R+RuLDnd5m6cP9LBeaH9/GIim8pHtTMP+C9bDcKdTV2D9SYCImmmUVYd/6cKkpjGD00B7kkidy0WzrmMK2A1syT79LccqVw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985815; c=relaxed/simple;
	bh=S+eAHkUQmIxOmh9BhUcuLHRn/WSy/97Ut9MbCGS8kfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amFc/s9TrMc1A8YU7LmA9Pd5EeBEEiVyNx67KT0ILsS+expiJkK77oPqtMoBoWJlZ/fsWP7fBHQwMGseVC9AmnbzOIquPOv9u+SoMnk1Q9l0rlYZReKL/mkfngss5XT7Cs0Y+2fcEA/pUbb5RymcULDGle1IDWKMu7Mw3UThnHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4btHHN2xzjz6L4t7;
	Fri,  1 Aug 2025 02:12:32 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id CB0D51404C6;
	Fri,  1 Aug 2025 02:16:48 +0800 (CST)
Received: from china (10.220.118.114) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 20:16:34 +0200
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
Date: Thu, 31 Jul 2025 21:34:20 +0300
Message-ID: <20250731183420.1138336-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250731140404.GD8494@horms.kernel.org>
References: <20250731140404.GD8494@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 frapeml500005.china.huawei.com (7.182.85.13)

> On Thu, Jul 31, 2025 at 03:58:39PM +0300, Gur Stavi wrote:
> >
> > Lets define a "coherent struct" as a structure made of fields that makes sense
> > to human beings. Every field endianity is defined and fields are arranged in
> > order that "makes sense". Fields can be of any integer size 8,16,32,64 and not
> > necessarily naturally aligned.
> >
> > swab32_array transforms a coherent struct into "byte jumble". Small fields are
> > reordered and larger (misaligned) fields may be split into 2 (or even 3) parts.
> > swab32_array is reversible so a 2nd call with byte jumble as input will produce
> > the original coherent struct.
> >
> > hinic3 dma has "swab32_array" built in.
> > On send-to-device it expects a byte jubmle so the DMA engine will transform it
> > into a coherent struct.
> > On receive-from-device it provides a byte jumble so the driver needs
> > to call swab32_array to transform it into a coherent struct.
> >
> > The hinic3_cmdq_buf_swab32 function will work correctly, producing byte jumble,
> > on little endian and big endian hosts.
> >
> > The code that runs prior to hinic3_cmdq_buf_swab32 that initializes a coherent
> > struct is endianity sensitive. It needs to initialize fields based on their
> > coherent endianity with or without byte swap. Practically use cpu_to_le or
> > cpu_to_be based on the coherent definition.
> >
> > Specifically, cmdq "coherent structs" in hinic3 use little endian and since
> > Kconfig currently declares that big endian hosts are not supported then
> > coherent structs are initialized without explicit cpu_to_le macros.
> >
> > And this is what the comment says:
> >
> > /* Data provided to/by cmdq is arranged in structs with little endian fields but
> >  * every dword (32bits) should be swapped since HW swaps it again when it
> >  * copies it from/to host memory.
> >  */
> >
>
> Thanks, I think I am closer to understanding things now.
>
> Let me try and express things in my own words:
>
> 1. On the hardware side, things are stored in a way that may be represented
>    as structures with little-endian values. The members of the structures may
>    have different sizes: 8-bit, 16-bit, 32-bit, ...
>
> 2. The hardware runs the equivalent of swab32_array() over this data
>    when writing it to (or reading it from) the host. So we get a
>    "byte jumble".
>
> 3. In this patch, the hinic3_cmdq_buf_swab32 reverses this jumbling
>    by running he equivalent of swab32_array() over this data again.
>
>    As 3 exactly reverses 2, what is left are structures exactly as in 1.
>

Yes. Your understanding matches mine.

> If so, I agree this makes sense and I am sorry for missing this before.
>
> And if so, is the intention for the cmdq "coherent structs" in the driver
> to look something like this.
>
>    struct {
> 	u8 a;
> 	u8 b;
> 	__le16 c;
> 	__le32 d;
>    };
>
> If so, this seems sensible to me.
>
> But I think it would be best so include some code in this patchset
> that makes use of such structures - sorry if it is there, I couldn't find
> it just now.
>
> And, although there is no intention for the driver to run on big endian
> systems, the __le* fields should be accessed using cpu_to_le*/le*_to_cpu
> helpers.

There was a long and somewhat heated debate about this issue.
https://lore.kernel.org/netdev/20241230192326.384fd21d@kernel.org/
I agree that having __le in the code is better coding practice.
But flooding the code with cpu_to_le and le_to_cpu does hurt readability.
And there are precedences of drivers that avoid it.

However, our dev team (I am mostly an advisor) decided to give it a try anyway.
I hope they manage to survive it.

