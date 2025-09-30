Return-Path: <netdev+bounces-227280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8242BABBFC
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 09:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D163201F6
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 07:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741B12C0281;
	Tue, 30 Sep 2025 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pBiRx12f"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AFE2BE029;
	Tue, 30 Sep 2025 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215924; cv=none; b=EHQoGFEZgO4jZf0JkNRvdkEM1rjjUS8aE/jYiz728SwH+gthE4Zs0UOsu/wXKyF4GbVwSNhJI6UPM4Vdz+wFE2l2UXTK+XUT2vW1+P23Qym/eSIuSYIR3zW++LxlbaX2ojE/kAVkVmTI7NdFh9l6PBj0K6P/q4jl9OvkV4B0qeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215924; c=relaxed/simple;
	bh=RVWIeUkqMhG5Kuuus/6/Lb4aIRpKpAT0yru+IaDq92o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX/ls/C+qwenQLaLFwKLZCxkIDk2crODayWnJhH/0ZkVgt5mXR846R1Ak0jdxQUR9rRSs7lVBcRakLzhPITtzmkGnmzXADgopqUuUrUapsup7UwQGqyvKjyCDFA8OV0Jb70YHYEUEz1phS+iccTp4nnbM5SFoVX1WDfe2fGmhYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pBiRx12f; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1759215922; x=1790751922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RVWIeUkqMhG5Kuuus/6/Lb4aIRpKpAT0yru+IaDq92o=;
  b=pBiRx12f33Vvsr1N3HEwfEaXnCfNBARF+j+9NOexpsxa3swBNrLtLgOp
   4UxFnS3UpbrjW6ln4HFIzmR52MAUZA+5pXKmwFYSz3P94XBzaEhOzMBec
   UvAZswwwpupdKZiMpRWwSTjGZ2PFWBvLh0lYsi68HG+6yc3vp4Xxtymoo
   UsLCn9VHKqclupGZa/UwvMj2chyEMxDBaVnWi/8y3n7j4qwDA/FOa9TFQ
   W3lmx44iAPsUE23YuJ9AEBfvxC8c5MTGxHobmnj1sohFcyaV1moZf+pkL
   doPIQd4OoEey0mwis/97x9svfNI6/Ze6D+UKjHwHgHxR3EuV/OANj+HhY
   w==;
X-CSE-ConnectionGUID: 5WG/H9VdR6ySuaTWDfYMLA==
X-CSE-MsgGUID: nnjcQvgfSz2wbCL28bXkBg==
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="47665541"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2025 00:05:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 30 Sep 2025 00:04:40 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 30 Sep 2025 00:04:40 -0700
Date: Tue, 30 Sep 2025 09:03:59 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<vadim.fedorenko@linux.dev>, <rosenp@gmail.com>,
	<christophe.jaillet@wanadoo.fr>, <steen.hegelund@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 2/2] phy: mscc: Fix PTP for VSC8574 and VSC8572
Message-ID: <20250930070359.sjeqsgluwyt23ry2@DEN-DL-M31836.microchip.com>
References: <20250929091302.106116-1-horatiu.vultur@microchip.com>
 <20250929091302.106116-3-horatiu.vultur@microchip.com>
 <aNqKuzlxWwcANiK7@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aNqKuzlxWwcANiK7@shell.armlinux.org.uk>

The 09/29/2025 14:33, Russell King (Oracle) wrote:

Hi Russell,

> 
> On Mon, Sep 29, 2025 at 11:13:02AM +0200, Horatiu Vultur wrote:
> > The PTP initialization is two-step. First part are the function
> > vsc8584_ptp_probe_once() and vsc8584_ptp_probe() at probe time which
> > initialize the locks, queues, creates the PTP device. The second part is
> > the function vsc8584_ptp_init() at config_init() time which initialize
> > PTP in the HW.
> 
> So, to summarise, you register the PTP clock at probe time? At that
> point, you get a /dev/ptp* device. Is that device functional without
> the config_init() initialisation?

That is correct. I register the PTP clock at probe time.
It is not fully functional, for example calling "phc_ctl /dev/ptp0 get", I
always get "clock time is 0.000000000 or Thu Jan  1 00:00:00 1970"

# phc_ctl /dev/ptp0 get
phc_ctl[414.412]: clock time is 0.000000000 or Thu Jan  1 00:00:00 1970

# phc_ctl /dev/ptp0 get
phc_ctl[418.453]: clock time is 0.000000000 or Thu Jan  1 00:00:00 1970

Then after setting up, I can see the time increasing:

# phc_ctl /dev/ptp0 get
phc_ctl[511.841]: clock time is 2.232610928 or Thu Jan  1 00:00:02 1970

# phc_ctl /dev/ptp0 get
phc_ctl[515.113]: clock time is 5.504853240 or Thu Jan  1 00:00:05 1970

> 
> I would hope it is, because one of the fundamental concepts in kernel
> programming is... don't publish devices to userspace that are not
> completely ready for operation.
> 
> Conversely, don't tear down a published device without first
> unpublishing it from userspace.

Thanks for reminding me about this. Unfortunately, the same behaviour is for
all the devices that this driver is covering. So, then maybe I would
need to create a patch in the future to change this to have the correct
behaviour.

> 
> Thanks.
> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
/Horatiu

