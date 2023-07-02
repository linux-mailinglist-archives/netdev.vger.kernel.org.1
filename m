Return-Path: <netdev+bounces-14991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07677744DC0
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 15:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FFA1C20510
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 13:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7CC20FF;
	Sun,  2 Jul 2023 13:42:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D56820FE
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 13:42:54 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59854E55;
	Sun,  2 Jul 2023 06:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688305373; x=1719841373;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UK/nzE9dIxgjFsCrj7Qj4taBTpYmWjk/fOAoL8aT+a8=;
  b=HbG6wspr+sm+MlF1m56EfzLrkqojL3/iuEvoBaWW57OIX+Slgg0U5WLt
   oYLhf0XSvmLh2DzlfYRp2hhtltLT1FNmQNnDvKuFNL/hq21C6lvUwqJ8n
   miEehIXgj/SLO044vykPyxLXfnMW5O365MhwKZqZVtv2gCYtJGya1w1tJ
   Qxdo65qSgZajmYfLRtxQGWo82tWOb7ADhOdaawRG2Tjqj9noA2RIk3WT5
   eTUvKitrPcxy2HNDTT+/tpWmcs2mufc2fCJVrwwuAKWeucHzRzfqYss+U
   kHX6GpVgdQfHPX4Y0CzYsHaDKe4lbFtxwRlXzVO2JhjvGSynPgiWZdeOq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="393440818"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="393440818"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2023 06:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="964889090"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="964889090"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.249.95.54]) ([10.249.95.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2023 06:42:49 -0700
Message-ID: <ec3f0f2d-c8d4-3df7-7ff4-5c841a050be3@linux.intel.com>
Date: Sun, 2 Jul 2023 16:42:46 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Intel-wired-lan] [PATCH net v2 1/6] igc: Rename qbv_enable to
 taprio_offload_enable
Content-Language: en-US
To: Florian Kauer <florian.kauer@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tan Tee Min <tee.min.tan@linux.intel.com>,
 Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
 Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>,
 Malli C <mallikarjuna.chilakala@intel.com>
Cc: netdev@vger.kernel.org, kurt@linutronix.de,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20230619100858.116286-1-florian.kauer@linutronix.de>
 <20230619100858.116286-2-florian.kauer@linutronix.de>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20230619100858.116286-2-florian.kauer@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/19/2023 13:08, Florian Kauer wrote:
> In the current implementation the flags adapter->qbv_enable
> and IGC_FLAG_TSN_QBV_ENABLED have a similar name, but do not
> have the same meaning. The first one is used only to indicate
> taprio offload (i.e. when igc_save_qbv_schedule was called),
> while the second one corresponds to the Qbv mode of the hardware.
> However, the second one is also used to support the TX launchtime
> feature, i.e. ETF qdisc offload. This leads to situations where
> adapter->qbv_enable is false, but the flag IGC_FLAG_TSN_QBV_ENABLED
> is set. This is prone to confusion.
> 
> The rename should reduce this confusion. Since it is a pure
> rename, it has no impact on functionality.
> 
> Fixes: e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      | 2 +-
>   drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>   drivers/net/ethernet/intel/igc/igc_tsn.c  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

