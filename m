Return-Path: <netdev+bounces-207756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E806B08741
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644CD174B00
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0D2265637;
	Thu, 17 Jul 2025 07:44:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EEB2652A4;
	Thu, 17 Jul 2025 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738275; cv=none; b=QnciFdzLPC/CfTJmNb9P45RT/fa8oIe+NMTQkboBwGRVA9W6NpzMMBiahT7tKGvuMP3G15kPCRQ0aVGvX/NpURBOuwXOuTGl5V+60YoVUpJsK1retUYOJRy7P49KrfG7aOGPzL4OMKgGXEM5TXOeyRInKTUuE118r97Sc/DFO8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738275; c=relaxed/simple;
	bh=FJLPW+xkiOM0Q/3rwnBQCTizQkRpW2AF55c+O40YFD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTaE9bvijFaBBMdr1OAkoqr4Zvsg63PGS9/8hLrnKKEsYHeuDNHcQQZ3ODtZDHengBRTs85D3NZqAjImXTXAXW9AHBZOgX6oG1s3/lekZIb/x/321ejwSEy1y5A/hOLQXQpBS9Ta381VoQ8otG50dm0nBvp54ieq6QOnmvmMk/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bjPzm6693z6L5H4;
	Thu, 17 Jul 2025 15:43:16 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 41D99140257;
	Thu, 17 Jul 2025 15:44:30 +0800 (CST)
Received: from china (10.220.118.114) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Jul
 2025 09:44:16 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<fuguiming@h-partners.com>, <gongfan1@huawei.com>, <guoxin09@huawei.com>,
	<gur.stavi@huawei.com>, <helgaas@kernel.org>, <horms@kernel.org>,
	<jdamato@fastly.com>, <lee@trager.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <mpe@ellerman.id.au>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>,
	<shenchenyang1@hisilicon.com>, <shijing34@huawei.com>, <sumang@marvell.com>,
	<vadim.fedorenko@linux.dev>, <wulike1@huawei.com>, <zhoushuai28@huawei.com>,
	<zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v09 1/8] hinic3: Async Event Queue interfaces
Date: Thu, 17 Jul 2025 11:02:29 +0300
Message-ID: <20250717080229.1054761-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250716183208.26b87aa8@kernel.org>
References: <20250716183208.26b87aa8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 frapeml500005.china.huawei.com (7.182.85.13)

On Tue, 15 Jul 2025 08:28:36 +0800 Fan Gong wrote:
> +/* Data provided to/by cmdq is arranged in structs with little endian fields but
> + * every dword (32bits) should be swapped since HW swaps it again when it
> + * copies it from/to host memory. This is a mandatory swap regardless of the
> + * CPU endianness.

> This comment makes no sense, FWIW. The device writes a byte steam
> to host memory. For what you're saying to make sense the device would
> have to intentionally switch the endian based on the host CPU.
> And if it could do that why wouldn't it do it in the opposite
> direction, avoiding the swap ? :/
>
> I suppose the device is always writing in be32 words, and you should
> be converting from be32.
>

Lets assume the following is a simplified PACKED cmdq struct:

struct some_cmdq {
	__le16 a;
	__le32 b;
	__le16 c;
};

Lets denote x0 as lsb of field x. x3 as msb of 32 bits field.

Byte stream in CPU memory is:
a0, a1, b0, b1, b2, b3, c0, c1

The HW expects the following byte stream:
b1, b0, a1, a0, c1, c0, b3 ,b2

A native struct would be:

struct some_cmdq {
	__be16 b_lo;
	__be16 a;
	__be16 c;
	__be16 b_hi;
}

It does not make sense from code readability perspective.
While this is a simplified example, there are similar problems in real cmdq
structs.
Also group of fields that makes sense (based on their names) for being
logically near each other become separated in "native" big endian arrangements.

This is a case where driver need to compensate for bad HW decisions.

