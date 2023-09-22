Return-Path: <netdev+bounces-35813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6EA7AB204
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 14:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D8EDB282285
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 12:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6874022F0A;
	Fri, 22 Sep 2023 12:18:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D6F168AA
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 12:18:49 +0000 (UTC)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E288E100;
	Fri, 22 Sep 2023 05:18:46 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VsdUGbw_1695385120;
Received: from 30.221.128.225(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsdUGbw_1695385120)
          by smtp.aliyun-inc.com;
          Fri, 22 Sep 2023 20:18:41 +0800
Message-ID: <714eadf7-1d4f-2379-bc2b-7b89d01987b3@linux.alibaba.com>
Date: Fri, 22 Sep 2023 20:18:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next v3 00/18] net/smc: implement virtual ISM
 extension and loopback-ism
To: Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
 jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1695302360-46691-1-git-send-email-guwen@linux.alibaba.com>
 <be68eac1-f22e-1ff6-dbaf-8cbd09315454@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <be68eac1-f22e-1ff6-dbaf-8cbd09315454@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/22 07:31, Wenjia Zhang wrote:

> 
> Hi Wen,
> 
> Thank you for the effort!

Thank you very much for review, Wenjia.

> You can find my comments in the respective patches. One general question from our team, could you please add a Kconfig 
> option to turn off/on loopback-ism?

Sure, I will add an option to turn off/on loopback-ism.

> 
> BTW, I'm in vacation next week, my colleagues will follow on the answer and update.

Thank you. Enjoy the vacation!

Regards,
Wen Gu

> 
> Thanks,
> Wenjia
> 


