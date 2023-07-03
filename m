Return-Path: <netdev+bounces-15123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B233A745C63
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 14:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E371C20982
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 12:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D814427;
	Mon,  3 Jul 2023 12:39:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F776DF4C
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 12:39:44 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C31E50;
	Mon,  3 Jul 2023 05:39:42 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qvlnf1zfBz6J7H0;
	Mon,  3 Jul 2023 20:37:58 +0800 (CST)
Received: from [10.123.123.126] (10.123.123.126) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 13:39:34 +0100
Message-ID: <f2754095-c0e8-7cd1-88f5-329696cdbee8@huawei.com>
Date: Mon, 3 Jul 2023 15:39:33 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v11 08/12] landlock: Add network rules and TCP hooks
 support
Content-Language: ru
To: =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
CC: <mic@digikod.net>, <willemdebruijn.kernel@gmail.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>
References: <20230515161339.631577-1-konstantin.meskhidze@huawei.com>
 <20230515161339.631577-9-konstantin.meskhidze@huawei.com>
 <20230627.82cde73b1efe@gnoack.org>
From: "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
In-Reply-To: <20230627.82cde73b1efe@gnoack.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.123.126]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



6/27/2023 10:48 PM, Günther Noack пишет:
> On Tue, May 16, 2023 at 12:13:35AM +0800, Konstantin Meskhidze wrote:
>> +static int add_rule_net_service(struct landlock_ruleset *ruleset,
>> +				const void __user *const rule_attr)
>> +{
>> +#if IS_ENABLED(CONFIG_INET)
>> +	struct landlock_net_service_attr net_service_attr;
>> +	int res;
>> +	access_mask_t mask;
>> +
>> +	/* Copies raw user space buffer, only one type for now. */
> 
> Nit, which I came across by accident: I believe the remark "only one
> type for now" referred to the fact that path_beneath_attr was the only
> rule type up until now - but that is not true any more.  Please adapt
> the wording also in add_rule_path_beneath, where the same comment
> exists.
> 
   Thanks. I will fix it.

> –Günther
> .

