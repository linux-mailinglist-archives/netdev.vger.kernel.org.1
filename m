Return-Path: <netdev+bounces-35938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2DA7ABF3E
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 11:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id A8A341F210C2
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 09:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD1FD512;
	Sat, 23 Sep 2023 09:25:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737632CA7
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 09:25:05 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A7E196;
	Sat, 23 Sep 2023 02:25:02 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VsfkbAw_1695461098;
Received: from 10.196.86.117(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsfkbAw_1695461098)
          by smtp.aliyun-inc.com;
          Sat, 23 Sep 2023 17:24:59 +0800
Message-ID: <a1b2e09e-070f-7f72-e631-835acf82d715@linux.alibaba.com>
Date: Sat, 23 Sep 2023 17:24:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 01/18] net/smc: decouple ism_dev from SMC-D
 device dump
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1695134522-126655-1-git-send-email-guwen@linux.alibaba.com>
 <1695134522-126655-2-git-send-email-guwen@linux.alibaba.com>
 <20230921204153.GQ224399@kernel.org>
 <2c9d570c-f780-0484-a26c-78b115e1a6a3@linux.alibaba.com>
 <b7dad8b72ec94d27378eca87fea4cb0c86b8c361.camel@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <b7dad8b72ec94d27378eca87fea4cb0c86b8c361.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/23 02:13, Gerd Bayer wrote:

> Hi Wen Gu,
> 
> seems like there is some email filter at work. Neither v2 nor v3 made
> it to the netdev mailing list - nor to patchwork.kernel.org.
> There's traces of Wenjia's replies and your replies to her - but not
> the original mail.
> 
> Could you please check? Thanks!
> Gerd

Yes, it is ture. v2 and v3 was refused by ver.kernel.org.

I will send the v4 based on Wenjia's comments as soon as possible,
and add CC of you, Sandy, Niklas and Halil in v4 in case the filter
happens again.

Thank you very much for your reminder!

Regards,
Wen Gu

