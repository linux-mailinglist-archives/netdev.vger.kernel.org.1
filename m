Return-Path: <netdev+bounces-32108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEFB7926AB
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 18:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDB3281350
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7546DD507;
	Tue,  5 Sep 2023 16:31:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6A378
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 16:31:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F1E61AA;
	Tue,  5 Sep 2023 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693931435; x=1725467435;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Wsj83dMuB0IsLZ+OQSDNV5lLeqy1G/b0RknIK8INS+M=;
  b=n3h8G3aPd+SlgsRH3zGqmW7I+3lrQZHDbP/owfe6TdoxTfHvtv4NiANa
   PJYKMWe5SqgCsTeu8d3LyrvDs5PHrhhARhDr9/1iva7k35NU1bACGujYZ
   gUbJpyn0Ycv7/r8ycCBph0ZljFExMTp3PjqCSC+j0MUXHo3FeSeCeLEZH
   2LQVkbajnz5+oshq3Aqk3T3rQUN95bmY7BSbHFHH9sQW4GaUlmBK1t4M4
   MgrcxQ30XinjyYWSrfTgjbI28w2Da6AjKm26K9Sw15hzSvv/MgJMh1kAI
   YnqrUdeNOVa5SNnifoCzopuFXCu+UiZb+jSqbpxojzQlfRpDD3B8zbjor
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="374228903"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="374228903"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 09:21:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="806665737"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="806665737"
Received: from hha-mobl1.amr.corp.intel.com (HELO [10.209.14.88]) ([10.209.14.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 09:21:45 -0700
Message-ID: <c3b0a87e-b680-3141-93df-911b00211ceb@intel.com>
Date: Tue, 5 Sep 2023 09:21:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: Fwd: RCU indicates stalls with iwlwifi, causing boot failures
To: Hugh Dickins <hughd@google.com>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Lai Jiangshan
 <laijs@linux.alibaba.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Gregory Greenman <gregory.greenman@intel.com>,
 Ben Greear <greearb@candelatech.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>,
 Linux Wireless <linux-wireless@vger.kernel.org>,
 Linux RCU <rcu@vger.kernel.org>
References: <c1caa7c1-b2c6-aac5-54ab-8bcc6e139ca8@gmail.com>
 <c3f9b35c-087d-0e34-c251-e249f2c058d3@candelatech.com>
 <f0f6a6ec-e968-a91c-dc46-357566d8811@google.com>
Content-Language: en-US
In-Reply-To: <f0f6a6ec-e968-a91c-dc46-357566d8811@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/1/23 23:59, Hugh Dickins wrote:
> I just took a look at your dmesg in bugzilla: I see lots of page tables
> dumped, including "ESPfix Area", and think you're hitting my screwup: see
> 
> https://lore.kernel.org/linux-mm/CABXGCsNi8Tiv5zUPNXr6UJw6qV1VdaBEfGqEAMkkXE3QPvZuAQ@mail.gmail.com/
> 
> Please give the patch from the end of that thread a try:

Thanks, Hugh.

I tried a random commit from Linus's tree that didn't boot for me
earlier.  Applying your fix allowed me to boot!

I still can't boot Linus's _current_ tree with your patch in it, but
that looks like another failure mode altogether.

