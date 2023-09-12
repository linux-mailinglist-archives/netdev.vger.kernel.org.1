Return-Path: <netdev+bounces-33054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CA579C95C
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77BED1C20B1A
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 08:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C6B1773B;
	Tue, 12 Sep 2023 08:10:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEE8171B5
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 08:10:29 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E3D10C3
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 01:10:28 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RlGPv3RjPzJrxn;
	Tue, 12 Sep 2023 16:06:43 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 12 Sep 2023 16:10:25 +0800
Message-ID: <f15f3ff8-da04-ab87-a8ee-a23f5f3293c4@huawei.com>
Date: Tue, 12 Sep 2023 16:10:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net v2 3/5] net: microchip: sparx5: Fix possible memory
 leak in vcap_api_encode_rule_test()
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <lars.povlsen@microchip.com>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
References: <20230909080207.1174597-1-ruanjinjie@huawei.com>
 <20230909080207.1174597-4-ruanjinjie@huawei.com>
 <5eefb04c2e9028337ade88b50de3f8db3ffc5185.camel@redhat.com>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <5eefb04c2e9028337ade88b50de3f8db3ffc5185.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected



On 2023/9/12 15:38, Paolo Abeni wrote:
> On Sat, 2023-09-09 at 16:02 +0800, Jinjie Ruan wrote:
>> Inject fault while probing kunit-example-test.ko, the duprule which
>> is allocated in vcap_dup_rule() and the export which is allocated in
> 
> Small typo above: 'export' should be 'eport' or 'vcap enabled port'. 
> Please fix that, as it makes the changelog a bit confusing.

Thank you! I'll fix it sooner.

> 
> Thanks!
> 
> Paolo
> 

