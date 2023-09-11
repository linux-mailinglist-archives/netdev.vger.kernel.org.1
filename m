Return-Path: <netdev+bounces-32746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A153B79A17B
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 04:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE662810B7
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 02:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A027517F3;
	Mon, 11 Sep 2023 02:46:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D6B630
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 02:46:40 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9C1B0;
	Sun, 10 Sep 2023 19:46:38 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RkWGj60jyzNnHc;
	Mon, 11 Sep 2023 10:42:53 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 11 Sep 2023 10:46:35 +0800
Message-ID: <110c02bf-3133-971c-750b-4a2d18bc9bf9@huawei.com>
Date: Mon, 11 Sep 2023 10:46:35 +0800
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
Subject: Re: [PATCH V2 ethtool] hns3: add support dump registers for hns3
 driver
To: <mkubecek@suse.cz>
References: <20230829065656.2725081-1-shaojijie@huawei.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20230829065656.2725081-1-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


on 2023/8/29 14:56, Jijie Shao wrote:
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
>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> changeLog:
>    v2: remove #pragma suggested by Michal
>    v1: https://lore.kernel.org/all/20230818085611.2483909-1-shaojijie@huawei.com/
> ---

Hi Michal:

   This patch has been uploaded for more than 10 days and has not been merged.
   Please review this patch. and if you have any problems, please inform me in time.

  Thanks！
  Jijie Shao


