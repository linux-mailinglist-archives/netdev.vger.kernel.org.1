Return-Path: <netdev+bounces-33501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09F679E445
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA871C20B6E
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCE31DDE5;
	Wed, 13 Sep 2023 09:54:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF3910F5
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 09:54:07 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E0919B6;
	Wed, 13 Sep 2023 02:54:05 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vs-HUH._1694598841;
Received: from 30.221.129.156(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vs-HUH._1694598841)
          by smtp.aliyun-inc.com;
          Wed, 13 Sep 2023 17:54:02 +0800
Message-ID: <a0a4567e-07f1-91db-50cb-bbfc803f5969@linux.alibaba.com>
Date: Wed, 13 Sep 2023 17:53:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next] net/smc: Introduce SMC-related proc files
To: Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
 jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1694416820-60340-1-git-send-email-guwen@linux.alibaba.com>
 <2b1d129c-06e2-0161-7c8a-1e930150d797@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <2b1d129c-06e2-0161-7c8a-1e930150d797@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/9/11 19:54, Wenjia Zhang wrote:
> 
> 
> 
> Hi Wen,
> 
> I can understand your problem and frustration. However, there are two reasons I'm not really convinced by the proc file 
> method:
> 1) AFAI, the proc method could consume many CPU time especially in case with a log of sockets to read the pseudo files.
> 2) We have already implemented the complex netlink method on the same purpose. I see the double expense to main the code.
> 
> Then the question is if the lack of dependency issue can be handle somehow, or the proc method is the only way to 
> achieve this purpose?
> 
> Any opinion is welcome!
> 
> Thanks,
> Wenjia

Hi, Wenjia. I agree with your concerns.

My initial intention is to make these proc files serve as a supplement to netlink to conveniently
check smc connections in an environment where smc-tools cannot be easily obtained.

Yes, proc files won't be the first choice for diagnosis, but can be a convenient backup.

Thanks,
Wen Gu


