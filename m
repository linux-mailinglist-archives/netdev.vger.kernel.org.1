Return-Path: <netdev+bounces-55525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB05780B2A1
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 08:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624D31F21079
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 07:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555121C3E;
	Sat,  9 Dec 2023 07:07:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from anchovy2.45ru.net.au (anchovy2.45ru.net.au [203.30.46.146])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479F810D9
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 23:07:15 -0800 (PST)
Received: (qmail 2597 invoked by uid 5089); 9 Dec 2023 07:07:11 -0000
Received: by simscan 1.2.0 ppid: 2486, pid: 2487, t: 0.3965s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-Spam-Level: 
Received: from unknown (HELO ?192.168.1.24?) (rtresidd@electromag.com.au@202.90.244.20)
  by anchovy3.45ru.net.au with ESMTPA; 9 Dec 2023 07:07:10 -0000
Message-ID: <8a0850d8-a2e4-4eb0-81e1-d067f18c2263@electromag.com.au>
Date: Sat, 9 Dec 2023 15:06:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: STMMAC Ethernet Driver support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
References: <e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au>
 <20231208101216.3fca85b1@kernel.org>
Content-Language: en-US
From: Richard Tresidder <rtresidd@electromag.com.au>
In-Reply-To: <20231208101216.3fca85b1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/12/2023 2:12 am, Jakub Kicinski wrote:
> On Fri, 8 Dec 2023 14:03:25 +0800 Richard Tresidder wrote:
>> I've looked through the diffset 6.3.3 >>> 6.6.3 on the driver
>> drivers\net\ethernet\stmicro\stmmac
>> But nothing is jumping out at me.
>>
>> I could use a pointer as to where to look to start tracing this.
> Bisection is good way to zero in on the bad change if you don't
> have much hard to rebase code in your tree.
>
> Otherwise you can dump the relevant registers and the descriptors
> (descriptors_status file in debugfs) and see if driver is doing
> anything differently on the newer kernel?
>
Thanks Jakub
   Yep I think I'll have to start bisecting things on Monday.
Luckily to work through this I shouldn't have to merge very much.
Have a great weekend

Cheers
   Richard Tresidder

