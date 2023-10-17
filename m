Return-Path: <netdev+bounces-41649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50C77CB828
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2D82814C3
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA35F4402;
	Tue, 17 Oct 2023 01:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ED31FD5
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:57:10 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0613B4;
	Mon, 16 Oct 2023 18:57:05 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VuL.UJ1_1697507816;
Received: from 30.221.149.45(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VuL.UJ1_1697507816)
          by smtp.aliyun-inc.com;
          Tue, 17 Oct 2023 09:57:02 +0800
Message-ID: <eecd0cbe-1dc5-c3e8-c047-6a3d9382ac58@linux.alibaba.com>
Date: Tue, 17 Oct 2023 09:56:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net 0/5] net/smc: bugfixs for smc-r
Content-Language: en-US
To: Alexandra Winter <wintera@linux.ibm.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <4a1b965e-b026-45d7-bd09-7b23b797ee90@linux.ibm.com>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <4a1b965e-b026-45d7-bd09-7b23b797ee90@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/23 9:43 PM, Alexandra Winter wrote:
> The subject of the thread says 'smc-r', but some of the changes affect smc-d alike,
> don't they?

Yes, sorry for this mistake, it should be bugfix for smc.
>
>
> On 11.10.23 09:33, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> This patches contains bugfix following:
>>
>> 1. hung state
>> 2. sock leak
>> 3. potential panic
>>
> I may be helpful for the reviewers, when you point out, which patch fixes which problem.
>
> Were they all found by code reviews?
> Or did some occur in real life? If so, then what were the symptoms?
> A description of the symptoms is helpful for somebody who is debugging and wants to check
> whether the issue was already fixed upstream.

Hi Alexandra,

Except for the issue with the barrier, which was feedback from the 
review, all other issues have actually occurred in our environment
and have been verified through internal testing. However, most of these 
issues are caused by reference leakage rather than panic, so it is 
difficult to provide a
representative phenomenon. But what you said is do necessary, so I will 
post some phenomena in the next version, such as

lsmod | grep smc
or
smcss - a

In that case, we can found  the issues of reference residue or the 
connection residue. Hope it can be helpful to you.

Thanks,
D. Wythe



