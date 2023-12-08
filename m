Return-Path: <netdev+bounces-55158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A58809A58
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 04:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15E5281E96
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 03:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C183FDB;
	Fri,  8 Dec 2023 03:30:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C129C1716;
	Thu,  7 Dec 2023 19:30:23 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vy1gZbD_1702006219;
Received: from 30.221.129.118(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy1gZbD_1702006219)
          by smtp.aliyun-inc.com;
          Fri, 08 Dec 2023 11:30:21 +0800
Message-ID: <872ce21c-bd6b-e58c-43bb-56f13a0a4e7c@linux.alibaba.com>
Date: Fri, 8 Dec 2023 11:30:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 0/9] net/smc: implement SMCv2.1 virtual ISM
 device support
To: Jakub Kicinski <kuba@kernel.org>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kgraul@linux.ibm.com,
 jaka@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, raspl@linux.ibm.com,
 schnelle@linux.ibm.com, guangguan.wang@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1701920994-73705-1-git-send-email-guwen@linux.alibaba.com>
 <20231207164947.3b338de4@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20231207164947.3b338de4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/8 08:49, Jakub Kicinski wrote:
> On Thu,  7 Dec 2023 11:49:45 +0800 Wen Gu wrote:
>> (Note that this patch set depends on an under-reviewing bugfix patch:
>> Link: https://lore.kernel.org/netdev/1701882157-87956-1-git-send-email-guwen@linux.alibaba.com/)
> 
> Post as an RFC, please, until the dependencies have converged.

Understand, thank you.

And I found that the dependency fix has been converged. This patch set will be reposted as a v5.

