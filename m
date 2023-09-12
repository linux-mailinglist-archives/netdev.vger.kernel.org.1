Return-Path: <netdev+bounces-33055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAF679C95D
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1332819E5
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 08:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0707B1773C;
	Tue, 12 Sep 2023 08:10:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7742E54B
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 08:10:43 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3082EE78
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 01:10:43 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RlGSF06z7zrSmN;
	Tue, 12 Sep 2023 16:08:44 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 12 Sep 2023 16:10:40 +0800
Message-ID: <07dbd880-1b3f-eff3-511d-ad116d1181de@huawei.com>
Date: Tue, 12 Sep 2023 16:10:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net v2 4/5] net: microchip: sparx5: Fix possible memory
 leaks in test_vcap_xn_rule_creator()
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <lars.povlsen@microchip.com>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
References: <20230909080207.1174597-1-ruanjinjie@huawei.com>
 <20230909080207.1174597-5-ruanjinjie@huawei.com>
 <253e481e308f73cf9ae3b55b62bc00412047c02b.camel@redhat.com>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <253e481e308f73cf9ae3b55b62bc00412047c02b.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected



On 2023/9/12 15:41, Paolo Abeni wrote:
> On Sat, 2023-09-09 at 16:02 +0800, Jinjie Ruan wrote:
>> Inject fault while probing kunit-example-test.ko, the duprule which
>> is allocated by kzalloc in vcap_dup_rule(), 
> 
> Small typo above, I think it should be 'vcap_alloc_rule' instead of
> 'vcap_dup_rule'. I think it's relevant, otherwise looking only at the
> changelog, the next patch would be a not-needed/duplicated of this one.
> 
> Please fix the above, thanks!

Thank you! I'll fix it sooner.

> 
> Paolo
> 

