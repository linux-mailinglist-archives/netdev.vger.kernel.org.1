Return-Path: <netdev+bounces-32753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6720D79A306
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 07:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9812C1C204AB
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 05:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9AC23C0;
	Mon, 11 Sep 2023 05:55:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD86820EB
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 05:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13085C433C8;
	Mon, 11 Sep 2023 05:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694411725;
	bh=9bchAL96F/QOep8WZYj8nalWoQJmgRfO9qDf4knqnwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tI3fVLomlrTQUPsoENLVjnbiITA2CEAcBmVi9mCtktLzAGohq6eDHEtOX/L3jNgTO
	 43rvA+cWO5+iYe/DqReH9VylhVPsAoxzQHw7IN9mC759EpiD+IspNCMy11ndB5ugDU
	 C3NB1Vdz2xrzsobTBxfwjGrVSIXoDUgS1KPT8xE/18mEGNpyKAZtYh8Ba5RxA9Yv7D
	 8KsXp8JBgPWY5zJlFTENKoTjV2h+JepGqLua4cMiI47MTy2jCjrYZHpMKm9vtk8l2s
	 k6PL3UbiZi5ExIBbdKYS2WEsYwxmPp/PIkRTDIW3jCVKyAApxwkrFvZkbLkNVzRLXj
	 jcYrlpowCxY5A==
Date: Mon, 11 Sep 2023 07:55:20 +0200
From: Simon Horman <horms@kernel.org>
To: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc: "intel-wired-lan@osuosl.org" <intel-wired-lan@osuosl.org>,
	"Neftin, Sasha" <sasha.neftin@intel.com>,
	"bcreeley@amd.com" <bcreeley@amd.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"naamax.meir@linux.intel.com" <naamax.meir@linux.intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"husainizulkifli@gmail.com" <husainizulkifli@gmail.com>
Subject: Re: [PATCH iwl-net v5] igc: Expose tx-usecs coalesce setting to user
Message-ID: <20230911055520.GM775887@kernel.org>
References: <20230908081734.28205-1-muhammad.husaini.zulkifli@intel.com>
 <20230910142416.GD775887@kernel.org>
 <SJ1PR11MB6180C920CED9ABECC9FD022EB8F3A@SJ1PR11MB6180.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6180C920CED9ABECC9FD022EB8F3A@SJ1PR11MB6180.namprd11.prod.outlook.com>

On Sun, Sep 10, 2023 at 02:41:50PM +0000, Zulkifli, Muhammad Husaini wrote:
> Dear Simon,
> 
> Thanks for reviewing. Replied inline
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Sunday, 10 September, 2023 10:24 PM
> > To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
> > Cc: intel-wired-lan@osuosl.org; Neftin, Sasha <sasha.neftin@intel.com>;
> > bcreeley@amd.com; davem@davemloft.net; kuba@kernel.org;
> > pabeni@redhat.com; edumazet@google.com; netdev@vger.kernel.org;
> > naamax.meir@linux.intel.com; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; husainizulkifli@gmail.com
> > Subject: Re: [PATCH iwl-net v5] igc: Expose tx-usecs coalesce setting to user
> > 
> > On Fri, Sep 08, 2023 at 04:17:34PM +0800, Muhammad Husaini Zulkifli wrote:
> > > When users attempt to obtain the coalesce setting using the ethtool
> > > command, current code always returns 0 for tx-usecs.
> > > This is because I225/6 always uses a queue pair setting, hence
> > > tx_coalesce_usecs does not return a value during the
> > > igc_ethtool_get_coalesce() callback process. The pair queue condition
> > > checking in igc_ethtool_get_coalesce() is removed by this patch so
> > > that the user gets information of the value of tx-usecs.
> > >
> > > Even if i225/6 is using queue pair setting, there is no harm in
> > > notifying the user of the tx-usecs. The implementation of the current
> > > code may have previously been a copy of the legacy code i210.
> > > Since I225 has the queue pair setting enabled, tx-usecs will always
> > > adhere to the user-set rx-usecs value. An error message will appear
> > > when the user attempts to set the tx-usecs value for the input
> > > parameters because, by default, they should only set the rx-usecs value.
> > 
> > Hi Muhammad,
> > 
> > Most likely I'm misunderstanding things. And even if that is not the case
> > perhaps this is as good as it gets. But my reading is that an error will not be
> > raised if a user provides an input value for tx-usecs that matches the current
> > value of tx-usecs, even if a different value is provided for rx-usecs (which will
> > also be applied to tx-usecs).
> 
> Yes you are right. This is what I mentioned in previous version discussion.
> https://lore.kernel.org/netdev/20230905101504.4a9da6b8@kernel.org/
> But at least IMHO, better than current or my previous design submission.
> 
> Previously, I had considered changing the ".supported_coalesce_params"
> during ethtool set ops to only set ETHTOOL_COALESCE_RX_USECS with a new
> define of ETHTOOL_QUEUE_PAIR_COALESCE_USECS. But, if we change the
> queue/cpu during runtime setting, I believe this
> ".supported_coalesce_params" need to change as well...

Thanks Muhammad, and sorry for missing that thread.

With that discussion in mind, I think that what this patch does is as good
as it gets with the current uAPI, and changes to the uAPI is a follow-up
topic.

So, FWIIW, I am happy with this patch as it is.

Reviewed-by: Simon Horman <horms@kernel.org>


