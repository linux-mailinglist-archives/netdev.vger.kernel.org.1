Return-Path: <netdev+bounces-35260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3547A82EE
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 15:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA791C20F88
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7DC36AF2;
	Wed, 20 Sep 2023 13:05:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4463347CF
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:05:43 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3125E12B;
	Wed, 20 Sep 2023 06:05:37 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VsVIPo7_1695215133;
Received: from 30.221.128.235(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsVIPo7_1695215133)
          by smtp.aliyun-inc.com;
          Wed, 20 Sep 2023 21:05:34 +0800
Message-ID: <447f1d11-38de-e896-dead-6b27502e1886@linux.alibaba.com>
Date: Wed, 20 Sep 2023 21:05:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 06/18] net/smc: extend GID to 128bits for virtual
 ISM device
To: Niklas Schnelle <schnelle@linux.ibm.com>,
 kernel test robot <lkp@intel.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695134522-126655-7-git-send-email-guwen@linux.alibaba.com>
 <202309201408.95QRxHEl-lkp@intel.com>
 <50feb145-c658-b9a1-7261-b67bb82767dc@linux.alibaba.com>
 <09ef007793b27e2ba5cc75a33c99cf8ead62c7f3.camel@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <09ef007793b27e2ba5cc75a33c99cf8ead62c7f3.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/20 17:00, Niklas Schnelle wrote:

>>
>> I do not have a local compilation environment for s390 (IBM Z) architecture. But I think
>> it can be fixed by the following patch.
> 
> With these kernel test robot mails the bot provides
> instructions for reproducing with a cross toolchain from the 0day
> project. See the line starting with "reproduce (this is a W=1 build):"
> i.e. in this particular case it links the URL:
> https://download.01.org/0day-ci/archive/20230920/202309201408.95QRxHEl-lkp@intel.com/reproduce


Ah, I see. Thank you Niklas for the explanation. :)

