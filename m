Return-Path: <netdev+bounces-15098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B3F745A77
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 12:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDED280CEC
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1131FAC;
	Mon,  3 Jul 2023 10:42:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2253D72
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 10:42:49 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2D9C1;
	Mon,  3 Jul 2023 03:42:48 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qvj9M1mmHz67fjF;
	Mon,  3 Jul 2023 18:39:51 +0800 (CST)
Received: from [10.123.123.126] (10.123.123.126) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 11:42:45 +0100
Message-ID: <b40ceb8e-8cba-6a8e-e499-b1f225c0901a@huawei.com>
Date: Mon, 3 Jul 2023 13:42:44 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v11 12/12] landlock: Document Landlock's network support
Content-Language: ru
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
CC: <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>
References: <20230515161339.631577-1-konstantin.meskhidze@huawei.com>
 <20230515161339.631577-13-konstantin.meskhidze@huawei.com>
 <524f3c11-f228-1519-451f-c992bff8be79@digikod.net>
From: "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
In-Reply-To: <524f3c11-f228-1519-451f-c992bff8be79@digikod.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.123.126]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



6/26/2023 9:59 PM, Mickaël Salaün пишет:
> 
> On 15/05/2023 18:13, Konstantin Meskhidze wrote:
>> Describe network access rules for TCP sockets. Add network access
>> example in the tutorial. Add kernel configuration support for network.
>> 
>> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
>> ---
>> 
>> Changes since v10:
>> * Fixes documentaion as Mickaёl suggested:
>> https://lore.kernel.org/linux-security-module/ec23be77-566e-c8fd-179e-f50e025ac2cf@digikod.net/
>> 
>> Changes since v9:
>> * Minor refactoring.
>> 
>> Changes since v8:
>> * Minor refactoring.
>> 
>> Changes since v7:
>> * Fixes documentaion logic errors and typos as Mickaёl suggested:
>> https://lore.kernel.org/netdev/9f354862-2bc3-39ea-92fd-53803d9bbc21@digikod.net/
>> 
>> Changes since v6:
>> * Adds network support documentaion.
>> 
>> ---
>>   Documentation/userspace-api/landlock.rst | 83 ++++++++++++++++++------
>>   1 file changed, 62 insertions(+), 21 deletions(-)
>> 
> 
> [...]
> 
>> @@ -143,10 +159,23 @@ for the ruleset creation, by filtering access rights according to the Landlock
>>   ABI version.  In this example, this is not required because all of the requested
>>   ``allowed_access`` rights are already available in ABI 1.
>> 
>> -We now have a ruleset with one rule allowing read access to ``/usr`` while
>> -denying all other handled accesses for the filesystem.  The next step is to
>> -restrict the current thread from gaining more privileges (e.g. thanks to a SUID
>> -binary).
>> +For network access-control, we can add a set of rules that allow to use a port
>> +number for a specific action: HTTPS connections.
>> +
>> +.. code-block:: c
>> +
>> +    struct landlock_net_service_attr net_service = {
>> +        .allowed_access = NET_CONNECT_TCP,
> 
> LANDLOCK_ACCESS_NET_CONNECT_TCP

   Yep. Thanks.
> 
> 
>> +        .port = 443,
>> +    };
>> +
>> +    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_SERVICE,
>> +                            &net_service, 0);
>> +
> .

