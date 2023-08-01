Return-Path: <netdev+bounces-23226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C1476B5D8
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA471C20CC4
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201B421D38;
	Tue,  1 Aug 2023 13:30:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCF0200A3
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3F9C433C8;
	Tue,  1 Aug 2023 13:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690896600;
	bh=d9psugM3kdjDEK4P7pIMibyVGTo8lFybTwVf6CPdblw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XXwpszJCEPVqiP8v9CysPgOgPPrvsW6uoKwE2JwGB/HtJ7zQY0R6Ii7FdJbhkO41/
	 Y39OYvChkyMWaKTL5Th6blCeP2El+pI1DvIDViK/hsZ0kI7ybDKO+5JoXsCKxeICF2
	 bpT5PWDrcuCmwPXAW/9sx2KVRwK/J9beyMpc3+b4k3NzbyWXPzoaV13qgSzgpr56Qf
	 MAubHObB7hH+3o615gylObQcDkj/653Yk1iaOCRK2AYZd/0i3RgcXi+UMN/l95AQcn
	 IhSYvR2JDMdKkD1JBNpeqPnA/rP/0XG6FzAYLaZautehPBXtXAzi/39RnBodHdTrln
	 opxdELDfov4vw==
Message-ID: <5cab2f28-b0e5-b6ab-d981-28436fb3e742@kernel.org>
Date: Tue, 1 Aug 2023 16:29:55 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] net: ethernet: ti: am65-cpsw-qos: Add Frame
 Preemption MAC Merge support
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, s-vadapalli@ti.com, srk@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230725072338.20789-1-rogerq@kernel.org>
 <20230801131418.bhcjtflj3iu77mmc@skbuf>
 <0f18cf9e-9c5b-02dd-b396-729b9fecdfe7@kernel.org>
 <20230801132844.o56h3bsx7zfwbeu6@skbuf>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230801132844.o56h3bsx7zfwbeu6@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 01/08/2023 16:28, Vladimir Oltean wrote:
> On Tue, Aug 01, 2023 at 04:19:30PM +0300, Roger Quadros wrote:
>>> Also:
>>>
>>> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:173:6: warning: no previous prototype for function 'am65_cpsw_iet_change_preemptible_tcs' [-Wmissing-prototypes]
>>> void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
>>>      ^
>>> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:173:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>>> void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
>>> ^
>>> static
>>> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:179:6: warning: no previous prototype for function 'am65_cpsw_iet_link_state_update' [-Wmissing-prototypes]
>>> void am65_cpsw_iet_link_state_update(struct net_device *ndev)
>>>      ^
>>> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:179:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>>> void am65_cpsw_iet_link_state_update(struct net_device *ndev)
>>> ^
>>> static
>>> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:699:33: error: redefinition of 'taprio'
>>>         struct tc_taprio_qopt_offload *taprio = type_data;
>>>                                        ^
>>> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:697:33: note: previous definition is here
>>>         struct tc_taprio_qopt_offload *taprio = type_data;
>>>                                        ^
>>> 2 warnings and 1 error generated.
>>> make[7]: *** [../scripts/Makefile.build:243: drivers/net/ethernet/ti/am65-cpsw-qos.o] Error 1
>>> make[7]: *** Waiting for unfinished jobs....
>>
>> I'm pretty sure there weren't any build errors for me.
>> Did you have and resolve conflicts when applying this patch?
> 
> Yup, part of it (the error) is to blame due to an auto-merge (conflict
> with 2d800bc500fb ("net/sched: taprio: replace tc_taprio_qopt_offload ::
> enable with a "cmd" enum")) which failed to do the right thing in
> am65_cpsw_setup_taprio():
> 
> $ git b4 0f18cf9e-9c5b-02dd-b396-729b9fecdfe7@kernel.org
> Looking up https://lore.kernel.org/r/0f18cf9e-9c5b-02dd-b396-729b9fecdfe7%40kernel.org
> Grabbing thread from lore.kernel.org/all/0f18cf9e-9c5b-02dd-b396-729b9fecdfe7%40kernel.org/t.mbox.gz
> Analyzing 5 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   ✓ [PATCH RFC] net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge support
>   ---
>   ✓ Signed: DKIM/kernel.org
> ---
> Total patches: 1
> ---
>  Link: https://lore.kernel.org/r/20230725072338.20789-1-rogerq@kernel.org
>  Base: not specified
> Applying: net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge support
> Using index info to reconstruct a base tree...
> M       drivers/net/ethernet/ti/am65-cpsw-nuss.c
> M       drivers/net/ethernet/ti/am65-cpsw-qos.c
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/ethernet/ti/am65-cpsw-qos.c
> Auto-merging drivers/net/ethernet/ti/am65-cpsw-nuss.c
> 
> But part of it is legit, and I saw it with a W=1 C=1 build.
> am65_cpsw_iet_link_state_update() and am65_cpsw_iet_change_preemptible_tcs()
> should be static.

Got it. I'll resolve the warnings. Thanks!

-- 
cheers,
-roger

