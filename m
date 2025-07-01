Return-Path: <netdev+bounces-202774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1079AEEF40
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46BE7A6059
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 06:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7B71F4285;
	Tue,  1 Jul 2025 06:51:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1572538B;
	Tue,  1 Jul 2025 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352705; cv=none; b=Azbr5I56jY80JZBeuhsACWygi5UeI6Vnvm1iU/32ddocomsMzdMfJz/GUeBg8cbwq/zLpkcfZmMz51SX5qAqGrx7z5W4Fp2YEJOU/w3nknQ5wvvJQRBi0D+aac0CFA+WhtrxkyvYXbTVN7vORwwOujZ6o7dfN1oGdwhECQfn3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352705; c=relaxed/simple;
	bh=bk9XEM4QGki6UTP9OfPqIKQU8e82uGZABUr0WbPGwDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E79WHPKT0HVqx9cwQfw90nLMfKc/CK3V1ZXztDEi4du8kS48VzmdDWMOHSPb0JrWh2vufx+OWk1dOwEUe3rZCZWboM5cMflVOD2bgTGvy83nn+XF9N+WQaUO7H6s7Bks9qzexmgiyclq9OYKhCYoJ2lDJ5dZzybdeIAjcuwRvZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bWYVC40Hzz14LsS;
	Tue,  1 Jul 2025 14:46:59 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 821BE1800EC;
	Tue,  1 Jul 2025 14:51:39 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Jul 2025 14:51:38 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <vadim.fedorenko@linux.dev>
CC: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <gur.stavi@huawei.com>,
	<helgaas@kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
	<kuba@kernel.org>, <lee@trager.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <mpe@ellerman.id.au>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>,
	<shenchenyang1@hisilicon.com>, <shijing34@huawei.com>, <sumang@marvell.com>,
	<wulike1@huawei.com>, <zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v06 6/8] hinic3: Mailbox framework
Date: Tue, 1 Jul 2025 14:51:26 +0800
Message-ID: <20250701065126.8668-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <7c2ab3be-3b7b-49a5-82d2-99c8001ef635@linux.dev>
References: <7c2ab3be-3b7b-49a5-82d2-99c8001ef635@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)

> > +void hinic3_mbox_func_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header,
> > +				   u8 size)
> > +{
> > +	u64 mbox_header = *((u64 *)header);
>
> The question here is how will it work with different endianess? AFAIU,
> u8 *header is a buffer filled in by FW with device's endianess, which
> you directly  convert into host's endianess into u64 value. If the 
> endianess doesn't match, this conversion will fail.

The mbox data filled by HW is little-endian and our driver is currently supported
on little endian. So they work with the same endianess and header's conversion
will success.

> I cannot find any code which calls hinic3_mbox_func_aeqe_handler(),
> neither in this patch, nor further in the patchset. What is the reason
> to have it in this series?

Besides hinic3_mbox_func_aeqe_handler, hinic3_init_mbox and hinic3_free_mbox
are not called in this patchset because of LoC limit. They will be called in
next patchset which includes HW capabilities probing and initialization.
The reason why we place them in this patch is that these three functions are
basic funcions of mbox framework, representing initialization, release and
firmware-triggered callbacks. A complete mbox framework requires these three
parts of code logic.

