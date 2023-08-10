Return-Path: <netdev+bounces-26397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865E0777B3C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70AD1C21617
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 14:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB161FB42;
	Thu, 10 Aug 2023 14:48:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400D01F95D
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 14:48:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B38A2106;
	Thu, 10 Aug 2023 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691678921; x=1723214921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XK5sa90zsGSSN9wGkHZ/mNjWAnNcdml9adYZrQUo6a0=;
  b=QpdCoJlEyE9pMh+gS9BWYcVQn/gqjZVrNBGkp6PmP/zBy5pkIogej8A6
   Kw8gG1u+3iG1ULcqR0EptK1Qf9cgt14DW+FcTPLgr7D0OmzfvIdCxAWt2
   5IiqiQGkyGJ2iZJmGvp4DDZDipX1GImaPoBJMv2XQFaeo7ktC9AlTTEqc
   bVTzNqdhX/a8z1mLal27nC2Mfqps5l/kfmKg3NA4hT212iT4yo8OVk/qL
   YLXVMusCEesbXt8yO1Zu/GtAQ420NvOZMH0/xwJdjQtiLaIq51gB+J4y9
   paTXzjydmNJRJvupGJ8tOMZwXZFjisqdbgPnfG2E2dXlQcC2m4DItWbnF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="374191982"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="374191982"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 07:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="682146600"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="682146600"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 10 Aug 2023 07:48:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qU6xp-005VjK-19;
	Thu, 10 Aug 2023 17:48:37 +0300
Date: Thu, 10 Aug 2023 17:48:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH RFC] Introduce uniptr_t as a generic "universal" pointer
Message-ID: <ZNT4xQ40gt+Vg4hs@smile.fi.intel.com>
References: <87edkce118.wl-tiwai@suse.de>
 <20230809143801.GA693@lst.de>
 <CAHk-=wiyWOaPtOJ1PTdERswXV9m7W_UkPV-HE0kbpr48mbnrEA@mail.gmail.com>
 <87wmy4ciap.wl-tiwai@suse.de>
 <CAHk-=wh-mUL6mp4chAc6E_UjwpPLyCPRCJK+iB4ZMD2BqjwGHA@mail.gmail.com>
 <87o7jgccm9.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7jgccm9.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 08:08:30PM +0200, Takashi Iwai wrote:
> On Wed, 09 Aug 2023 19:01:50 +0200,
> Linus Torvalds wrote:
> > On Wed, 9 Aug 2023 at 09:05, Takashi Iwai <tiwai@suse.de> wrote:

...

> > Please? At least look into it.
> 
> All sounds convincing, I'll take a look tomorrow.  Thanks!

Nice discussion happened while I was sleeping / busy with some personal stuff.
Thank you, Linus, for all insights, it's educational.

-- 
With Best Regards,
Andy Shevchenko



