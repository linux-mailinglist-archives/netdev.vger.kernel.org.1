Return-Path: <netdev+bounces-23146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1544176B26F
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4678F1C20380
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EBF20F82;
	Tue,  1 Aug 2023 10:57:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88F46A0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:57:05 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A75A49F1
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 03:56:36 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RFX6n728pzrS6v;
	Tue,  1 Aug 2023 18:54:25 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 18:55:26 +0800
Message-ID: <ee16e9c9-ac08-3400-c092-6a0983855ff9@huawei.com>
Date: Tue, 1 Aug 2023 18:55:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] bnx2x: Remove unnecessary ternary operators
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <aelior@marvell.com>, <skalluru@marvell.com>, <manishc@marvell.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20230801020240.3342014-1-ruanjinjie@huawei.com>
 <ZMjas31vx/uiZzLV@kernel.org>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <ZMjas31vx/uiZzLV@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/1 18:13, Simon Horman wrote:
> On Tue, Aug 01, 2023 at 10:02:40AM +0800, Ruan Jinjie wrote:
>> Ther are a little ternary operators, the true or false judgement
>> of which is unnecessary in C language semantics.
>>
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> 
> For non-bugfix Networking patches, it is appropriate to
> designate the target tree as 'net-next' rather than '-next'.
> (For bug fixes 'net' is appropriate).
Thank you! I'll fix it in v2.
> 
> Link: https://docs.kernel.org/process/maintainer-netdev.html
> 
> Otherwise, this looks fine to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 

