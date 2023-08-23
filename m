Return-Path: <netdev+bounces-29851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 988CB784F25
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8A61C20C05
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 03:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094B520F09;
	Wed, 23 Aug 2023 03:15:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F239B15BC
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 03:15:45 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5AACE8;
	Tue, 22 Aug 2023 20:15:44 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVrq15kHGztS8T;
	Wed, 23 Aug 2023 11:11:57 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 11:15:41 +0800
Message-ID: <1b87e5c8-ceed-9b7a-4137-89d085e6c959@huawei.com>
Date: Wed, 23 Aug 2023 11:15:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ethtool] hns3: add support dump registers for hns3 driver
To: <mkubecek@suse.cz>
References: <20230818085611.2483909-1-shaojijie@huawei.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20230818085611.2483909-1-shaojijie@huawei.com>
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


on 2023/8/18 16:56, Jijie Shao wrote:
> Add support pretty printer for the registers of hns3 driver.
> This printer supports PF and VF, and is compatible with hns3
> drivers of earlier versions.
>
> Sample output:
>
> $ ethtool -d eth1
> [cmdq_regs]
>    comm_nic_csq_baseaddr_l : 0x48168000
>    comm_nic_csq_baseaddr_h : 0x00000000
>    comm_nic_csq_depth      : 0x00000080
>    comm_nic_csq_tail       : 0x00000050
>    comm_nic_csq_head       : 0x00000050
>    comm_nic_crq_baseaddr_l : 0x48170000
>    comm_nic_crq_baseaddr_h : 0x00000000
>    comm_nic_crq_depth      : 0x00000080
>    comm_nic_crq_tail       : 0x00000000
>    comm_nic_crq_head       : 0x00000000
>    comm_vector0_cmdq_src   : 0x00000000
>    comm_cmdq_intr_sts      : 0x00000000
>    comm_cmdq_intr_en       : 0x00000002
>    comm_cmdq_intr_gen      : 0x00000000
> [common_regs]
>    misc_vector_base    : 0x00000001
>    pf_other_int        : 0x00000040
>    misc_reset_sts      : 0x00000000
>    misc_vector_int_sts : 0x00000000
>    global_reset        : 0x00000000
>    fun_rst_ing         : 0x00000000
>    gro_en              : 0x00000001
> ...

Hi，

We noticed that this patch had been stuck for several days.

Is there any problem with this patch?

Jijie Shao


