Return-Path: <netdev+bounces-17602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2DD7524DC
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F991C21370
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6028F18010;
	Thu, 13 Jul 2023 14:15:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54737182A3
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 14:15:38 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221043A85;
	Thu, 13 Jul 2023 07:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689257720; x=1720793720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t6/CWbos/88643w3iuRqAiJYN+TLmHJLjYSn3gBi4eg=;
  b=a8pqdw3JDPJMlhyK6l0Igr8Aos006Cq7giuu52WnY2ZGi/V94SooImKM
   1fCFUBH1YMWa7A9D8Bc4aoQ80lvkYKI7JzclVoZyEY0XMjWkBL+4pIcKJ
   x4zvociAeqEPFd5Xx5rVitjoMnDeQNYYDJADj/y3LC1pN7nHZL3/P+LP5
   goP/GvT5B6WlrTtk3V0HTZolRry9HAkyBgn9BqPUqT0jX7u8s7s3xB2qS
   9qyG1BOSZpkfN2S9HfZjhh2MyCJ+c2l+jYOL48TZVKm02rxMU3uTditTF
   fei1sHixozj2oUC2j8G1v6M5Uyj1J/u2R/Zv2307wO5vRhEQgVtSsa0vJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345513060"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="345513060"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 07:15:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="725315229"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="725315229"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jul 2023 07:15:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1qJx6B-002PjM-3C;
	Thu, 13 Jul 2023 17:15:15 +0300
Date: Thu, 13 Jul 2023 17:15:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>
Subject: Re: Closing down the wireless trees for a summer break?
Message-ID: <ZLAG85HEMH0MeW1G@smile.fi.intel.com>
References: <87y1kncuh4.fsf@kernel.org>
 <ZK7Yzd0VvblA3ONU@smile.fi.intel.com>
 <87wmz43xy4.fsf@kernel.org>
 <d1f9ca04bb055dc07f2a7f9f07f774e08913cf00.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1f9ca04bb055dc07f2a7f9f07f774e08913cf00.camel@sipsolutions.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 01:05:45PM +0200, Johannes Berg wrote:
> On Thu, 2023-07-13 at 13:30 +0300, Kalle Valo wrote:
> > Andy Shevchenko <andriy.shevchenko@intel.com> writes:
> > > On Tue, Jun 13, 2023 at 05:22:47PM +0300, Kalle Valo wrote:

...

> > > > [1] https://phb-crystal-ball.sipsolutions.net/
> > > 
> > > How could one use the shut down site?
> > 
> > What do you mean? At least from Finland it Works for me:
> 
> That did in fact not work yesterday for some time as I was doing some
> maintenance :)

Good to know!

-- 
With Best Regards,
Andy Shevchenko



