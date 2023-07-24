Return-Path: <netdev+bounces-20438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B237D75F970
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 16:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CB31C208F3
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D73C8ED;
	Mon, 24 Jul 2023 14:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A3E847B
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 14:10:22 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CA4E65
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 07:10:18 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="431247020"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="431247020"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 07:10:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="839463026"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839463026"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 07:10:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andy@kernel.org>)
	id 1qNwGK-00GKAo-0P;
	Mon, 24 Jul 2023 17:10:12 +0300
Date: Mon, 24 Jul 2023 17:10:11 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	wojciech.drewek@intel.com, michal.swiatkowski@linux.intel.com,
	aleksander.lobakin@intel.com, davem@davemloft.net, kuba@kernel.org,
	jiri@resnulli.us, pabeni@redhat.com, jesse.brandeburg@intel.com,
	simon.horman@corigine.com, idosch@nvidia.com
Subject: Re: [PATCH iwl-next v3 6/6] ice: Add support for PFCP hardware
 offload in switchdev
Message-ID: <ZL6GQyy2x56+K9si@smile.fi.intel.com>
References: <20230721071532.613888-1-marcin.szycik@linux.intel.com>
 <20230721071532.613888-7-marcin.szycik@linux.intel.com>
 <ZLqfJZi/14dyEzhH@smile.fi.intel.com>
 <24784f80-df7b-a666-a56b-9b4c288978a1@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24784f80-df7b-a666-a56b-9b4c288978a1@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 03:58:51PM +0200, Marcin Szycik wrote:
> On 21.07.2023 17:07, Andy Shevchenko wrote:
> > On Fri, Jul 21, 2023 at 09:15:32AM +0200, Marcin Szycik wrote:

...

> >> [1] https://lore.kernel.org/netdev/20230614091758.11180-1-marcin.szycik@linux.intel.com
> > 
> > We have Link: tag for such kind of stuff.
> 
> Are you sure this is a valid use of Link: tag?

Yes.

> Patch that is linked here is
> in another tree, and also I want to have [1] inline for context.

You can put it as
Link: $URI [1]

...

> >>  #define ICE_TC_FLOWER_MASK_32   0xFFFFFFFF
> > 
> > ...and (at least) this can utilize GENMASK().
> 
> It can, but it's unrelated to this patch.

Right. Just a side note.

-- 
With Best Regards,
Andy Shevchenko



