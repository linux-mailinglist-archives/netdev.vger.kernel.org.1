Return-Path: <netdev+bounces-23147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B3176B270
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73AA280E1C
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A1D20F84;
	Tue,  1 Aug 2023 10:57:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D626846A0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:57:20 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F96565AF
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 03:56:53 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RFX7K0frxz1GDGR;
	Tue,  1 Aug 2023 18:54:53 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 18:55:53 +0800
Message-ID: <a4217579-da50-0669-b1bb-d4df13ae8f59@huawei.com>
Date: Tue, 1 Aug 2023 18:55:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] octeontx2: Remove unnecessary ternary operators
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
	<jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <netdev@vger.kernel.org>
References: <20230801024413.3371379-1-ruanjinjie@huawei.com>
 <ZMjbJW+VmNE891iN@kernel.org>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <ZMjbJW+VmNE891iN@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/1 18:15, Simon Horman wrote:
> On Tue, Aug 01, 2023 at 10:44:13AM +0800, Ruan Jinjie wrote:
>> Ther are a little ternary operators, the true or false judgement
> 
> nit: Ther -> There
> 
>> of which is unnecessary in C language semantics. So remove it
>> to clean Code.
> 
> The target tree of this patch should be 'net-next'.
> 
> 	Subject: [PATCH net-next] ...

Thank you! I'll fix it in v2.

> 
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> 
> Otherwise this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 

