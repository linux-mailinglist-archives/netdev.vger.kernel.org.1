Return-Path: <netdev+bounces-31150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BAB78BEC9
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 08:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D624E1C209C3
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 06:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72108A28;
	Tue, 29 Aug 2023 06:48:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B7AEC6
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 06:48:00 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB371AA;
	Mon, 28 Aug 2023 23:47:27 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RZdD12HlWzJrFZ;
	Tue, 29 Aug 2023 14:43:13 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 29 Aug 2023 14:46:49 +0800
Message-ID: <b33101ca-c5f8-be9e-7759-4d044c2fd340@huawei.com>
Date: Tue, 29 Aug 2023 14:46:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <mkubeck@suse.cz>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <shenjian15@huawei.com>,
	<wangjie125@huawei.com>, <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ethtool] hns3: add support dump registers for hns3 driver
To: Michal Kubecek <mkubecek@suse.cz>
References: <20230818085611.2483909-1-shaojijie@huawei.com>
 <20230827232008.tjcuolelsdhh7o44@lion.mk-sys.cz>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20230827232008.tjcuolelsdhh7o44@lion.mk-sys.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


on 2023/8/28 7:20, Michal Kubecek wrote:
>> +#pragma pack(4)
>> +struct hns3_reg_tlv {
>> +	u16 tag;
>> +	u16 len;
>> +};
>> +
>> +struct hns3_reg_header {
>> +	u64 magic_number;
>> +	u8 is_vf;
>> +	u8 rsv[7];
>> +};
>> +
>> +#pragma pack()
> Could we please avoid these #pragma directives? AFAIK this is a Microsoft
> extension, which, while implemented in gcc for compatibility reasons, is
> not very common in linux world. To be honest, I had to search the web to
> see what exactly does it do - and even after that, only checking the object
> file with gdb revealed that it does not really do anything except weakening
> the alignment of struct hns3_reg_header (as a whole). Given how the
> structure is used in this file, the only practical effect would be
> header_len in hns3_dump_regs() being 12 rather than 16 (on 64-bit
> architectures).
>
> Michal

okay， I will remove it in v2


Thanks,

Jijie Shao


