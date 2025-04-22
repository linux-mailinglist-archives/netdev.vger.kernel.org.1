Return-Path: <netdev+bounces-184503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD44FA95F17
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F2B3A7F1F
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 07:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F511D9A70;
	Tue, 22 Apr 2025 07:16:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72320FAA8
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306164; cv=none; b=Ar/KQz1LMCRWn+ms+AW3ttHoKNs+TXaXgN1RhtuJezHFDbSXbMu2EWo9ctnWlYXC9Z1t4GBVdDZ1qfHqYEAHiw/x8OVK3h4Tg1WpAvnN5EWaDT9USpLACE1BLRjeokm8kTCmSs7bf4ECbL1PdYgH+xg74Zm/acosenmyIiFQs+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306164; c=relaxed/simple;
	bh=m9dxc/BnTk6sxTQgaDLTn8CNGW0wMbc2u9p+iXgC/Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBJjVUifKlAzGSNPnggILox7hNOaKqF1qRGpbQiUGK26vZC9o60gnJIR32G3rMXDi9WboipxLx5D9/+upvFST1r/Ob57iGp1r5uenrXrxzDek4MocDH644OCOfER0Ega+8H9or4fVxHgNvmv+0eawNpP89TE3h6zq6WSn9XhyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from [10.31.1.120] (unknown [210.76.195.148])
	by APP-01 (Coremail) with SMTP id qwCowAA34gIlQgdoVj0LCw--.3245S2;
	Tue, 22 Apr 2025 15:15:50 +0800 (CST)
Message-ID: <90e40d18-ad31-4408-95e8-0cbe4fb12786@mails.ucas.ac.cn>
Date: Tue, 22 Apr 2025 15:15:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [?bug] Can't get switchdev mode work on ConnectX-4 Card
To: Mark Bloch <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: netdev@vger.kernel.org, Ivan Vecera <ivecera@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <8b96e37c-842b-4afb-9c61-f71674874be5@mails.ucas.ac.cn>
 <091ec8be-34f6-4324-9e79-d2fbc102fd6b@nvidia.com>
Content-Language: en-US
From: Qiyu Yan <yanqiyu17@mails.ucas.ac.cn>
In-Reply-To: <091ec8be-34f6-4324-9e79-d2fbc102fd6b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA34gIlQgdoVj0LCw--.3245S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWxCFyxXr15XF1rAr17trb_yoW8Xr1Dpa
	yY93WSvrykJF1vvw1xCwsruFWUuryDCa15trn3Gr9rCr1Yga4xKrZ7JFWYy3srurZxJ34j
	qan3XrWrua1DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUbkucDUUUU
X-CM-SenderInfo: 51dq1xl1xrlqxpdlz24oxft2wodfhubq/1tbiBwsAB2gHKCZpfQAAs+

Thank you for your reply!

在 2025/4/22 14:42, Mark Bloch 写道:
> It’s likely that the issue stems from cx4-lx not supporting metadata
> matching, which in turn prevents the driver from enabling bridge
> offloads.
>
> Could you please confirm this by checking the output of the following
> command?
> # devlink dev param show pci/0000:c1:00.0 name esw_port_metadata

$ sudo devlink dev param show pci/0000:c1:00.0 name esw_port_metadata
pci/0000:c1:00.0:
   name esw_port_metadata type driver-specific
     values:
       cmode runtime value false

I guess the "value false"  here means not supported.
> A better approach might be to check for metadata matching support
> ahead of time and avoid registering for bridge offloads if it's not
> supported.
Just wondering what is the penalty of not having such offload?

The reason I am trying to enable switchdev is that I wanted to tag 
multiple vlans for a single VF. I see there is something called VGT+ in 
the document of OFED driver but the same function don't seem to exist in 
the mainline driver, so I considered to use the switchdev. But if the 
performance penalty of switchdev can be high I might want to switch to 
OFED driver instead.

> This way the driver won't offload the bridge but
> it will also won't prevent users from adding the reps to bridge.
> Could you try the diff below and let me know if it resolves
> the issue for you?
Will try but this will take some time for me to do so.
Best,
Qiyu


