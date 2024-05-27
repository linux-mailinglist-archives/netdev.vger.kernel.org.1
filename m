Return-Path: <netdev+bounces-98247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B2D8D0521
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 17:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3255F28E940
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 15:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7537016D30F;
	Mon, 27 May 2024 14:37:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E416C872
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716820658; cv=none; b=Vs61p4DCvqEZRR7RB04KZM4aPUuZLe/v6KOEnqAK/uAHIGbuXyP0adk3MgMLcMXpGzvk6Vctqw8r9H+j95Z9cQt6tCU43oBQ2eGxj9Ue4UEVyOk7HPFjf7un2PE9C8hfMyyY3EXTW/+OJtf2I1tRvxqD0TFMpc9/WzjTTvrw228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716820658; c=relaxed/simple;
	bh=1ploEBYJ7WBfvP4vhIV1KUlO8thNKiAS5Q5PBPZZbAo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEdr9wHAMvbWT5zrBNQ+jia1qd58ItVoV4q4PZomRjnQqEgg3w4dMur3LRmO6dggqMUOKqhwc3K005bpTmr+TJpoynUBdq9YmHR8pzWXoXOiVsYuQdMzF2+C4koRVYLE+t+cpGBS9AhRmHEaVT7ZO41OJLGGXC+OOWEglOX31Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id a799409f-1c36-11ef-80bb-005056bdfda7;
	Mon, 27 May 2024 17:37:33 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 27 May 2024 17:37:33 +0300
To: "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"jstultz@google.com" <jstultz@google.com>,
	"giometti@enneenne.com" <giometti@enneenne.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Dong, Eddie" <eddie.dong@intel.com>,
	"Hall, Christopher S" <christopher.s.hall@intel.com>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"peter.hilber@opensynergy.com" <peter.hilber@opensynergy.com>,
	"N, Pandith" <pandith.n@intel.com>,
	"Mohan, Subramanian" <subramanian.mohan@intel.com>,
	"T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Subject: Re: [PATCH v8 12/12] ABI: pps: Add ABI documentation for Intel TIO
Message-ID: <ZlSarRwF1vEbfzlP@surfacebook.localdomain>
References: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
 <20240513103813.5666-13-lakshmi.sowjanya.d@intel.com>
 <ZkH37Sc9LU4zmcGB@smile.fi.intel.com>
 <CY8PR11MB7364A367739AA57107DBBE6AC4F02@CY8PR11MB7364.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB7364A367739AA57107DBBE6AC4F02@CY8PR11MB7364.namprd11.prod.outlook.com>

Mon, May 27, 2024 at 11:53:07AM +0000, D, Lakshmi Sowjanya kirjoitti:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Monday, May 13, 2024 4:52 PM
> > On Mon, May 13, 2024 at 04:08:13PM +0530, lakshmi.sowjanya.d@intel.com
> > wrote:

...

> > > +Date:		June 2024
> > 
> > Is this checked by phb?
> > 
> > "the v6.11 kernel predictions: merge window closes on Sunday, 2024-08-04
> > and  release on Sunday, 2024-09-29"
> 
> I have taken from phb but my understanding is that any probable month before
> merge window should be added.

I didn't get this. You meant the merge window for the next cycle after your
changes are expected to land?

> I want to know if it should be the month when the merge window closes? (i.e
> in this case August)?

My common sense tells me that there will be no real users (except developers)
for any kernel that's marked as vX.Y-rcZ. Assuming that we announce the ABI in
the release, we should use date of the estimated relase. In this case I would
use September 2024.

> > > +KernelVersion:	6.11

-- 
With Best Regards,
Andy Shevchenko



