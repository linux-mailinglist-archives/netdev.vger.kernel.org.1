Return-Path: <netdev+bounces-28372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D85677F32B
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07998281D61
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCE0125B9;
	Thu, 17 Aug 2023 09:26:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118163C10
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:25:59 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F73119A1;
	Thu, 17 Aug 2023 02:25:58 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VpzQniW_1692264353;
Received: from 30.221.109.120(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VpzQniW_1692264353)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 17:25:54 +0800
Message-ID: <efe04c4f-7733-bcd4-e371-d51cbcd54511@linux.alibaba.com>
Date: Thu, 17 Aug 2023 17:25:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 3/6] net/smc: support smc v2.x features validate
Content-Language: en-US
To: Jan Karcher <jaka@linux.ibm.com>, wenjia@linux.ibm.com,
 kgraul@linux.ibm.com, tonylu@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230816083328.95746-1-guangguan.wang@linux.alibaba.com>
 <20230816083328.95746-4-guangguan.wang@linux.alibaba.com>
 <08e116ea-e907-0141-4766-c4c84cbd87d2@linux.ibm.com>
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <08e116ea-e907-0141-4766-c4c84cbd87d2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/17 14:42, Jan Karcher wrote:
> Hi Guangguan Wang,
> 
> minor renaming.
> 
> On 16/08/2023 10:33, Guangguan Wang wrote:
>> Support SMC v2.x features validate for SMC v2.1. This is the frame
>> code for SMC v2.x features validate, and will take effects only when
>> the negotiated release version is v2.1 or later.
>>
>> For Server, v2.x features' validation should be done in smc_clc_srv_
>> v2x_features_validate when receiving v2.1 or later CLC Proposal Message,
>> such as max conns, max links negotiation, the decision of the final
>> value of max conns and max links should be made in this function.
>> And final check for server when receiving v2.1 or later CLC Confirm
>> Message should be done in smc_clc_v2x_features_confirm_check.
>>
>> For client, v2.x features' validation should be done in smc_clc_cli_
>> v2x_features_validate when receiving v2.1 or later CLC Accept Message,
> 
> please use either clnt or client for the function. I know we have some functions with cli in them but they need to be cleaned up down the road.
> 
> Thank you.
> - Jan
> 

Get it, Thanks.

