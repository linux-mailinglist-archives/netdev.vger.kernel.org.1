Return-Path: <netdev+bounces-35154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 708947A75D8
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 10:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100D02819B5
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7411097C;
	Wed, 20 Sep 2023 08:27:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DE1FBE6
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 08:27:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8EC90
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 01:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695198456; x=1726734456;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mugEMfEi1I77BlKEzCqJcYcb+pIhWsiKW9tX8FiEGkA=;
  b=GjBFlg60e22fP6fKg3i8A7Wtl4+6TeNhgVnrM75PJ3uFt0Jf+hMTqsj8
   fgw35/9oUpxZIMAPSlSfFttDxIbThTA+wmFFSvazD1eWuTwcPtXy+Au8v
   Vm7415OMnIKhxZtpGvdH50HUbj5IzVPg9rZ5wQUdhwkWcu43APgiz4lpY
   6IcRDBh7LrvvdRnUWzhWwe5lUQxHJWM46v7PjNrK20w8361dsJXwVG0zu
   BWilKfwOFWoDjwbsg95eGAL/je1rdUoyemb2qtLBEJwD6v6ebchleQpXs
   1HEBA90e/EdjV1XvSN4CjdXOHUiB/lM0iVzYNtTaFBJd08YDCrUlL2SCO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="370476830"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="370476830"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 01:27:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="775902663"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="775902663"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.214.192.216]) ([10.214.192.216])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 01:27:32 -0700
Message-ID: <6da7388a-45f2-b705-af74-f493dc301b52@linux.intel.com>
Date: Wed, 20 Sep 2023 11:27:24 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH iwl-net v5] igc: Expose tx-usecs coalesce setting to user
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
 intel-wired-lan@osuosl.org
Cc: sasha.neftin@intel.com, bcreeley@amd.com, horms@kernel.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 husainizulkifli@gmail.com
References: <20230908081734.28205-1-muhammad.husaini.zulkifli@intel.com>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20230908081734.28205-1-muhammad.husaini.zulkifli@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/8/2023 11:17, Muhammad Husaini Zulkifli wrote:
> When users attempt to obtain the coalesce setting using the
> ethtool command, current code always returns 0 for tx-usecs.
> This is because I225/6 always uses a queue pair setting, hence
> tx_coalesce_usecs does not return a value during the
> igc_ethtool_get_coalesce() callback process. The pair queue
> condition checking in igc_ethtool_get_coalesce() is removed by
> this patch so that the user gets information of the value of tx-usecs.
> 
> Even if i225/6 is using queue pair setting, there is no harm in
> notifying the user of the tx-usecs. The implementation of the current
> code may have previously been a copy of the legacy code i210.
> Since I225 has the queue pair setting enabled, tx-usecs will always adhere
> to the user-set rx-usecs value. An error message will appear when the user
> attempts to set the tx-usecs value for the input parameters because,
> by default, they should only set the rx-usecs value.
> 
> This patch also adds the helper function to get the
> previous rx coalesce value similar to tx coalesce.
> 
> How to test:
> User can get the coalesce value using ethtool command.
> 
> Example command:
> Get: ethtool -c <interface>
> 
> Previous output:
> 
> rx-usecs: 3
> rx-frames: n/a
> rx-usecs-irq: n/a
> rx-frames-irq: n/a
> 
> tx-usecs: 0
> tx-frames: n/a
> tx-usecs-irq: n/a
> tx-frames-irq: n/a
> 
> New output:
> 
> rx-usecs: 3
> rx-frames: n/a
> rx-usecs-irq: n/a
> rx-frames-irq: n/a
> 
> tx-usecs: 3
> tx-frames: n/a
> tx-usecs-irq: n/a
> tx-frames-irq: n/a
> 
> Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> ---
> V4 -> V5:
> - Squash patch for set/get together as recommended by Jakub.
> - Fix unstabilize value when user insert both tx and rx params
> together.
> - Add error message for unsupported config.
> 
> V3 -> V4:
> - Implement the helper function, as recommended by Brett Creely.
> - Fix typo in cover letter.
> 
> V2 -> V3:
> - Refactor the code, as Simon suggested, to make it more readable.
> 
> V1 -> V2:
> - Split the patch file into two, like Anthony suggested.
> ---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 31 ++++++++++++--------
>   1 file changed, 19 insertions(+), 12 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

