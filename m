Return-Path: <netdev+bounces-209774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB891B10BCE
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1585F170EE8
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD671386DA;
	Thu, 24 Jul 2025 13:46:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D52E36ED;
	Thu, 24 Jul 2025 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364777; cv=none; b=bf8XNfEfcOLHmIVfQIlGYKyzR4KS2Yk5x0pypr781Zei0a+wUvxHi4aZtHK5q1ym9JpSxCW3mYP1S4nhiRKxNjNLfQpS2gXV7XzbLeCqAwxh0XWA3asKwXT7fQ+3jIM49LDWmHLUVt9IEsEcnGbiNpTYm66HVY/3DPL0SooBhbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364777; c=relaxed/simple;
	bh=HBVLMcAC805Vc0bL+DlWEg/wfzjMVIf2kRhXBdlwe+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyTLSCsB8JsrUzjS6UtUA9BN+sTJ5eKwzYCGGR0IrgdgRsyshLncWMckwGmcK/3qu/mDvskZELvayIiGg0fDl+AEcQtvPCBQjn1kOT43RCehgikrW04lmVoDIIxXcSj5yWjmCKF6o25znv61eppIWphj2cf3wW2WspghTkrlYtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bnsfh6f4zz2FbQF;
	Thu, 24 Jul 2025 21:43:56 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BABE140109;
	Thu, 24 Jul 2025 21:46:11 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Jul 2025 21:46:09 +0800
From: Fan Gong <gongfan1@huawei.com>
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
Date: Thu, 24 Jul 2025 21:45:51 +0800
Message-ID: <20250724134551.30168-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250723081908.GW2459@horms.kernel.org>
References: <20250723081908.GW2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100013.china.huawei.com (7.202.181.12)

> > +
> > +/* Data provided to/by cmdq is arranged in structs with little endian fields but
> > + * every dword (32bits) should be swapped since HW swaps it again when it
> > + * copies it from/to host memory.
> > + */
>
> This scheme may work on little endian hosts.
> But if so it seems unlikely to work on big endian hosts.
>
> I expect you want be32_to_cpu_array() for data coming from hw,
> with a source buffer as an array of __be32 while
> the destination buffer is an array of u32.
>
> And cpu_to_be32_array() for data going to the hw,
> with the types of the source and destination buffers reversed.
>
> If those types don't match your data, then we have
> a framework to have that discussion.
>
>
> That said, it is more usual for drivers to keep structures in the byte
> order they are received. Stored in structures with members with types, in
> this case it seems that would be __be32, and accessed using a combination
> of BIT/GENMASK, FIELD_PREP/FIELD_GET, and cpu_to_be*/be*_to_cpu (in this
> case cpu_to_be32/be32_to_cpu).
> 
> An advantage of this approach is that the byte order of
> data is only changed when needed. Another is that it is clear
> what the byte order of data is.

There is a simplified example:

Here is a 64 bit little endian that may appear in cmdq:
__le64 x
After the swap it will become:
__be32 x_lo
__be32 x_hi
This is NOT __be64.
__be64 looks like this:
__be32 x_hi
__be32 x_lo

So the swapped data by HW is neither BE or LE. In this case, we should use
swab32 to obtain the correct LE data because our driver currently supports LE.
This is for compensating for bad HW decisions.

> > +void hinic3_cmdq_buf_swab32(void *data, int len)
> > +{
> > +	u32 *mem = data;
> > +	u32 i;
> > +
> > +	for (i = 0; i < len / sizeof(u32); i++)
> > +		mem[i] = swab32(mem[i]);
> > +}
>
> This seems to open code swab32_array().

We will use swab32_array in next patch.
Besides, we will use LE for cmdq structs to avoid confusion and enhance
readability.

