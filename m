Return-Path: <netdev+bounces-14637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A60742C82
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7F31C20918
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605B413AD4;
	Thu, 29 Jun 2023 18:55:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7CB14267
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 18:55:57 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112F3A2;
	Thu, 29 Jun 2023 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688064956; x=1719600956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ifQ/TmMyoecGcMpnDZy5wdi7VnMZ4/AI4CN4sS2srqs=;
  b=AegY92zhpJQ8iKlmxt8TD88i8kATvkiBs3tuttQVeEd2IJjK54/HX+MG
   QDHQpQLWmmKJOXfSe8dfbSfX0hLRY64RQSMPTcSeuXGiuXdrUi1JkDa3b
   pTAeZT7R1LqAaxExbSW4HNM3zjKgH42qYZPP1LDaBntfx45iONxTOaAyA
   yimanl0Y+LcXRtXPljY654fef11168xRJ1V+ukd3a6+jbtrBvqvuL3K3r
   0OhCeD9WRlFGXm5ob3IDfaJ9jJMij61H9yDPyC/BiHlvL4986Z/WVgRT+
   BpXMNDOGaNWNqWX4sQqbtR8IiVkgspqOu8d+wtbJ9DcwFyWNvPF1BDeTt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="392924889"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="392924889"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 11:55:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="891494657"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="891494657"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 29 Jun 2023 11:55:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qEwo3-000vLS-1T;
	Thu, 29 Jun 2023 21:55:51 +0300
Date: Thu, 29 Jun 2023 21:55:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Horman <simon.horman@corigine.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v1 1/1] netlink: Don't use int as bool in
 netlink_update_socket_mc()
Message-ID: <ZJ3Ttq/zRRKSVyDp@smile.fi.intel.com>
References: <20230629133131.83284-1-andriy.shevchenko@linux.intel.com>
 <ZJ2fG/2AzJ5O0IFr@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJ2fG/2AzJ5O0IFr@corigine.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 05:11:23PM +0200, Simon Horman wrote:
> On Thu, Jun 29, 2023 at 04:31:31PM +0300, Andy Shevchenko wrote:

> > -	int old, new = !!is_new, subscriptions;
> > +	int subscriptions;
> > +	bool old;
> >  
> >  	old = test_bit(group - 1, nlk->groups);
> >  	subscriptions = nlk->subscriptions - old + new;
> 
> Hi Andy,
> 
> Doing arithmetic with boolean values doesn't seem right to me.

In any case it does not change the status quo, the same still applies to
the existing code (that's implied in the commit message). And obfuscating
it for the sake of purity seems wrong to me. Hence this patch.

> In any case, net-next is closed.
> Please consider reposting once it re-opens, after 10th July.

Sure.

Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



