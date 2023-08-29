Return-Path: <netdev+bounces-31191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5555B78C285
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB432810AC
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1500E14F96;
	Tue, 29 Aug 2023 10:43:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924514F93
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:43:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448671AA
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 03:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693305791; x=1724841791;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MsxR7QKpIt5CsxpWBb9Z6qvDwri7o9tBTG/pV/U9iuo=;
  b=KwZV0svxzHcxG0wQAbgxJf6xJukn83dCRpHKPDKzGQFQ3o4b7bNpFvE0
   cWUQMMkFgAzlXMOcD4Z1kH/OuLS9/t9joWB05h8Qc7ZI2/9DeP4D2Md02
   +/oBmweKJW7ProGUvoggJODjt5Zl2dSQD84xJKVVgTOcjbvlIPJEvxMuo
   fP9OrlY190I/ZwWi0cC88G+UefcaGEkjVfEsnMry/KFhP4Pt8+3lUyLu/
   SZ6Jl9GVpuLykJA5KUFqos3W3Km32f+hpNSc1z20e5pJ0HXXUEf5Q0Mks
   voXMPwscmLe6gFZnUquhDf67y7egGXlh14dbHV1CydVvKLQd4jRrzTGfX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="372748305"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="372748305"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 03:43:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="715484791"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="715484791"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.249.132.148]) ([10.249.132.148])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 03:43:04 -0700
Message-ID: <ebb004ea-bd9e-aa42-530e-ccfdb086ec9f@linux.intel.com>
Date: Tue, 29 Aug 2023 12:42:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: hardware filter for matching GTP-U TEID
Content-Language: en-US
To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Naveen Mamindlapalli <naveenm@marvell.com>, Suman Ghosh
 <sumang@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>,
 Geethasowjanya Akula <gakula@marvell.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>
References: <CO1PR18MB46668B13A44DD677B6A241F0A1E7A@CO1PR18MB4666.namprd18.prod.outlook.com>
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <CO1PR18MB46668B13A44DD677B6A241F0A1E7A@CO1PR18MB4666.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 29.08.2023 08:18, Subbaraya Sundeep Bhatta wrote:
> Hi Marcin Szycik,
> 
> Below commit demonstrates that we need to create a GTP tunnel netdev and
> create a tc filter on top of it. I am unable to understand how the tc filter on top of
> tunnel netdev $GTP0 propagates to the interface $PF0 for hardware offload?

It propagates via a notification from tunnel netdev to PF, and then to driver.
 
> commit 97aeb877de7f14f819fc2cf8388d7a2d8090489d
> Merge: 4d17d43 9a225f8
> Author: David S. Miller <davem@davemloft.net>
> Date:   Sat Mar 12 11:54:29 2022 +0000
> 
>     Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
> 
>     Tony Nguyen says:
> 
>     ====================
>     ice: GTP support in switchdev
> 
>     Marcin Szycik says:
> 
>     Add support for adding GTP-C and GTP-U filters in switchdev mode.
> 
>     To create a filter for GTP, create a GTP-type netdev with ip tool, enable
>     hardware offload, add qdisc and add a filter in tc:
> 
>     ip link add $GTP0 type gtp role <sgsn/ggsn> hsize <hsize>
>     ethtool -K $PF0 hw-tc-offload on
>     tc qdisc add dev $GTP0 ingress
>     tc filter add dev $GTP0 ingress prio 1 flower enc_key_id 1337 \
>     action mirred egress redirect dev $VF1_PR
> 
> 
> I have to redirect GTP-U packets with a TEID to a VF which may be in guest using hardware tc filter on PF.
>>From my understanding current TC and ethtool cannot specify match filters beyond L4 header fields.
> Can I add new command something like gtp-teid to tc filter?
> Please help me understand this.

You can specify TEID field with the enc_key_id option in tc (like in above
example). Meaning of that option changes depending on tunnel used, in case of
GTP it's TEID.

> 
> Thanks,
> Sundeep
> 
> 

I hope that answers your questions,
Marcin

