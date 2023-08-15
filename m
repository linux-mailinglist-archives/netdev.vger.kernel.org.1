Return-Path: <netdev+bounces-27561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E9F77C690
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 05:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD4E1C20B59
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 03:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BA41FA0;
	Tue, 15 Aug 2023 03:59:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56151C13
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 03:59:51 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319911BF2;
	Mon, 14 Aug 2023 20:59:50 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vpq8-GN_1692071986;
Received: from 30.221.106.14(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Vpq8-GN_1692071986)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 11:59:47 +0800
Message-ID: <01c03f48-3210-ff51-7e46-e4903c15e854@linux.alibaba.com>
Date: Tue, 15 Aug 2023 11:59:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 net-next 3/6] net/smc: support smc v2.x features
 validate
Content-Language: en-US
To: Wenjia Zhang <wenjia@linux.ibm.com>, jaka@linux.ibm.com,
 kgraul@linux.ibm.com, tonylu@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230807062720.20555-1-guangguan.wang@linux.alibaba.com>
 <20230807062720.20555-4-guangguan.wang@linux.alibaba.com>
 <1f162370-5878-80fc-25b9-0de22ba2efe1@linux.ibm.com>
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <1f162370-5878-80fc-25b9-0de22ba2efe1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/10 00:03, Wenjia Zhang wrote:
> 
> 
> On 07.08.23 08:27, Guangguan Wang wrote:
>> Support smc v2.x features validate for smc v2.1.
>>
> a bit more description?
> 

OK, more descriptions will be added in the next version.

>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>


