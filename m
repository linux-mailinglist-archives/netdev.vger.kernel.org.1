Return-Path: <netdev+bounces-56358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A239780E97D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FBF1F218FE
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4D75C91C;
	Tue, 12 Dec 2023 10:54:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521B0A0;
	Tue, 12 Dec 2023 02:54:54 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VyMBMsm_1702378490;
Received: from 30.221.129.163(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyMBMsm_1702378490)
          by smtp.aliyun-inc.com;
          Tue, 12 Dec 2023 18:54:52 +0800
Message-ID: <d9e55a9e-c956-544b-74d5-a7f95774f2a8@linux.alibaba.com>
Date: Tue, 12 Dec 2023 18:54:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
From: Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 00/10] net/smc: implement SMCv2.1 virtual ISM
 device support
To: wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, raspl@linux.ibm.com,
 schnelle@linux.ibm.com, guangguan.wang@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
In-Reply-To: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/12 16:52, Wen Gu wrote:

> The fourth edition of SMCv2 adds the SMC version 2.1 feature updates for
> SMC-Dv2 with virtual ISM. Virtual ISM are created and supported mainly by
> OS or hypervisor software, comparable to IBM ISM which is based on platform
> firmware or hardware.
> 
> With the introduction of virtual ISM, SMCv2.1 makes some updates:
> 
> - Introduce feature bitmask to indicate supplemental features.
> - Reserve a range of CHIDs for virtual ISM.
> - Support extended GIDs (128 bits) in CLC handshake.
> 
> So this patch set aims to implement these updates in Linux kernel. And it
> acts as the first part of SMC-D virtual ISM extension & loopback-ism [1].
> 
> [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
> 
> v6->v5:
> - Add 'Reviewed-by' label given in the previous versions:
>    * Patch #4, #6, #9, #10 have nothing changed since v3;
> - Patch #2:
>    * fix the format issue (Alignment should match open parenthesis) compared to v5;
>    * remove useless clc->hdr.length assignment in smcr_clc_prep_confirm_accept()
>      compared to v5;
> - Patch #3: new added compared to v5.
> - Patch #7: some minor changes like aclc_v2->aclc or clc_v2->clc compared to v5
>    due to the introduction of Patch #3. Since there were no major changes, I kept
>    the 'Reviewed-by' label.
> 
> Other changes in previous versions but not yet acked:
> - Patch #1: Some minor changes in subject and fix the format issue
>    (length exceeds 80 columns) compared to v3.
> - Patch #5: removes useless ini->feature_mask assignment in __smc_connect()
>    and smc_listen_v2_check() compared to v4.
> - Patch #8: new added, compared to v3.
> 

Looks like I accidentally modified my send-email script..

There is a typo in the CC-ed mail address list:
lzinux-kernel@vger.kernel.org -> linux-kernel@vger.kernel.org



