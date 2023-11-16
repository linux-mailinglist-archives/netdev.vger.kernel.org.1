Return-Path: <netdev+bounces-48259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BAB7EDCD6
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 09:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C675280F52
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 08:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB3ACA7A;
	Thu, 16 Nov 2023 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00311101;
	Thu, 16 Nov 2023 00:26:43 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VwVhCey_1700123200;
Received: from 30.221.129.201(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VwVhCey_1700123200)
          by smtp.aliyun-inc.com;
          Thu, 16 Nov 2023 16:26:41 +0800
Message-ID: <88bd9c9d-572b-deb7-5d05-9d9432b2c071@linux.alibaba.com>
Date: Thu, 16 Nov 2023 16:26:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] s390/ism: ism driver implies smc protocol
To: Gerd Bayer <gbayer@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, dust.li@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <b152ec7c0e690027da1086b777a3ec512001ba1f.camel@linux.ibm.com>
 <20231114091718.3482624-1-gbayer@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20231114091718.3482624-1-gbayer@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/11/14 17:17, Gerd Bayer wrote:
> Since commit a72178cfe855 ("net/smc: Fix dependency of SMC on ISM")
> you can build the ism code without selecting the SMC network protocol.
> That leaves some ism functions be reported as unused. Move these
> functions under the conditional compile with CONFIG_SMC.
> 
> Also codify the suggestion to also configure the SMC protocol in ism's
> Kconfig - but with an "imply" rather than a "select" as SMC depends on
> other config options and allow for a deliberate decision not to build
> SMC. Also, mention that in ISM's help.
> 
> Fixes: a72178cfe855 ("net/smc: Fix dependency of SMC on ISM")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/netdev/afd142a2-1fa0-46b9-8b2d-7652d41d3ab8@infradead.org/
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> ---
> 
> Hi Randy,
> 
> sorry for the long wait. We had some internal discussions about how to
> tackle this and decided to send out the short-term solution first and
> work on better isolating the ISM device and SMC protocol together
> with the work to extend ISM,
> e.g. at https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
> 

Hi, Gerd

I like the idea of better isolating ISM and SMC, both from a compilation perspective
and a code perspective. If I come up with any ideas during extending ISM, I will give
a feedback.

Thanks and Regards,
Wen Gu

> Cheers, Gerd
> 

