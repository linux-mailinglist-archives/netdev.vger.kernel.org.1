Return-Path: <netdev+bounces-39911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A157C4DCF
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 10:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C28B28206B
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A25A1A29D;
	Wed, 11 Oct 2023 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5C1199D4
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 08:57:23 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAE1A7;
	Wed, 11 Oct 2023 01:57:20 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VtwA3AS_1697014637;
Received: from 30.221.146.138(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VtwA3AS_1697014637)
          by smtp.aliyun-inc.com;
          Wed, 11 Oct 2023 16:57:18 +0800
Message-ID: <1d02aac4-e67c-f457-61a8-187b0d9f3a3e@linux.alibaba.com>
Date: Wed, 11 Oct 2023 16:57:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net 2/5] net/smc: fix incorrect barrier usage
Content-Language: en-US
To: Heiko Carstens <hca@linux.ibm.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-3-git-send-email-alibuda@linux.alibaba.com>
 <20231011084416.6942-A-hca@linux.ibm.com>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20231011084416.6942-A-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/11/23 4:44 PM, Heiko Carstens wrote:
> I did not Co-develop this, nor did I provide an explicit Signed-off-by.
> Please don't add Signed-off-by statements which have not been explicitly
> agreed on.

Sorry for that, I have used the wrong tag, Reported by might be more 
appropriate .
I will remove this in the next version, sorry to bother you again.

Best wishes,
D. Wythe

