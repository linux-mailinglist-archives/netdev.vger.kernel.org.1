Return-Path: <netdev+bounces-46585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEA47E52C8
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 10:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3951B20CE5
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A28FC17;
	Wed,  8 Nov 2023 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC6101C1
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 09:43:01 +0000 (UTC)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB24199;
	Wed,  8 Nov 2023 01:42:59 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VvxlGB8_1699436575;
Received: from 30.221.147.99(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VvxlGB8_1699436575)
          by smtp.aliyun-inc.com;
          Wed, 08 Nov 2023 17:42:56 +0800
Message-ID: <2bc5d6b3-e349-1fc6-e354-9bad955eab20@linux.alibaba.com>
Date: Wed, 8 Nov 2023 17:42:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] net/smc: avoid data corruption caused by decline
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1699329376-17596-1-git-send-email-alibuda@linux.alibaba.com>
 <20231107183809.58859c8f@kernel.org>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20231107183809.58859c8f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/8/23 10:38 AM, Jakub Kicinski wrote:
> On Tue,  7 Nov 2023 11:56:16 +0800 D. Wythe wrote:
>> This issue requires an immediate solution, since the protocol updates
>> involve a more long-term solution.
> Please provide an appropriate Fixes tag.

Thanks for reminder.

D. Wythe

