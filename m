Return-Path: <netdev+bounces-214886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399FCB2B9C5
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509955E1AEB
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B6B26E165;
	Tue, 19 Aug 2025 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KnIxvl/g"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22126B09F;
	Tue, 19 Aug 2025 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585861; cv=none; b=ofZiY/ZDZ9/fM4GQe0alqSAaIB4dHZWPiq8R6lwjoTmmlf2EKQkPT5U+yV80EpUGcZP7lI/MEi+ah7DfYXpgzGqnXEhC7qKFThCJQNqjy7zskumJmLoD0PdvZWsj5IRxKtRxlj/eEG8cJ6eWjHV/hs0pZNMS+2ja4K9QOYMYAYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585861; c=relaxed/simple;
	bh=cP8PEXAXqfpf3w0B8Uk32xdrJvRk5JyP2bU5Je7lfgw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvof6EtxGYnAv7UgZXaPHyHmdI78FGyUpWNlbp2SBXmQ5wfq9NRTVbPy5f0m1FmYNztA3Bn8h2GuS8JRSawOqvB0nyESYQ8wOpnRTiPg86HXB+O3TR6SS05PTuXFpg+BMrAKJiXdHsDotqOdjlzD7dRtPM1h6I4GtwGuMRfwTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KnIxvl/g; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755585859; x=1787121859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cP8PEXAXqfpf3w0B8Uk32xdrJvRk5JyP2bU5Je7lfgw=;
  b=KnIxvl/g1vvaETx+pHrF5rb2dtXiCibb5hsBFA1k8CwWAU8AUgXuAd8z
   +uWI6TI/p7Eh4bsr8CA/CTzosJilwQzLosGOIsIXi87rs7kjqcoT0J9DS
   23J+C3E+0/egM6jDURX1S4IpDYyXTrK7vIMBRADYZB066QL5T1wk1t8Os
   LHxwQVJ3NGwbd6q/MNi+4jmgbH6B5GqvvRZcNMD2x+rIZocYD06IfakQ+
   gpPMLUfek3B3lWTqQeuX8rOebssu8QFRlxkr/au4PIQf3hZcBepkaNEGh
   kEdC36/AiSwTmMoRBEK1+eoaMAGdVd2KnCUzYn16naGntkiY7eUkcLoM/
   w==;
X-CSE-ConnectionGUID: rZgPSQg4TSeIFZSdw/pssg==
X-CSE-MsgGUID: 83i4szVxTfWacn9WsKvBBg==
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="212782844"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Aug 2025 23:44:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 18 Aug 2025 23:43:34 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 18 Aug 2025 23:43:34 -0700
Date: Tue, 19 Aug 2025 08:40:11 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<rmk+kernel@armlinux.org.uk>, <rosenp@gmail.com>,
	<christophe.jaillet@wanadoo.fr>, <viro@zeniv.linux.org.uk>,
	<quentin.schulz@bootlin.com>, <atenart@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v4] phy: mscc: Fix timestamping for vsc8584
Message-ID: <20250819064011.zv3ybgvjx6cqkyhc@DEN-DL-M31836.microchip.com>
References: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
 <20250818132141.ezxmflzzg6kj5t7k@skbuf>
 <20250818135658.exs5mrtuio7rm3bf@DEN-DL-M31836.microchip.com>
 <20250818141306.qlytyq3cjryhqkas@skbuf>
 <20250818141925.l7rvjns26gda3bp7@DEN-DL-M31836.microchip.com>
 <20250818143732.q5eymo65iywz44ci@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250818143732.q5eymo65iywz44ci@skbuf>

The 08/18/2025 17:37, Vladimir Oltean wrote:
> 
> On Mon, Aug 18, 2025 at 04:19:25PM +0200, Horatiu Vultur wrote:
> > Nothing prevents me for looking at this issue. I just need to alocate
> > some time for this.
> >
> > > The two problems are introduced by the same commit, and fixes will be
> > > backported to all the same stable kernels. I don't exactly understand
> > > why you'd add some code to the PHY's remove() method, but not enough in
> > > order for it to work.
> >
> > Yes, I understand that but the fix for ptp_clock_unregister will fix a
> > different issue that this patch is trying to fix. That is the reason why
> > I prefer not to add that fix now, just to make things more clear.
> 
> Not sure "clear" for whom. One of the rules from Documentation/process/stable-kernel-rules.rst
> is "It must be obviously correct and tested.", which to me makes it confusing
> why you wouldn't fix that issue first (within the same patch set), and then
> test this patch during unbind/bind to confirm that it achieves what it intends.

I have tested the patch by inserting and removing the kernel module. And
I have check that remove function was called and see that it tries to
flush the queue.

> 
> I think the current state of the art is that unbinding a PHY that the
> MAC hasn't connected to will work, whereas unbinding a connected PHY,
> where the state machine is running, will crash the kernel. To be
> perfectly clear, the request is just for the case that is supposed to
> work given current phylib implementation, aka with the MAC unconnected
> (put administratively down or also unbound, depending on whether it
> connects to the PHY at probe time or ndo_open() time).
> 
> I don't see where the reluctance comes from - is it that there are going
> to be 2 patches instead of 1? My reluctance as a reviewer comes from the
> fact that I'm analyzing the change in the larger context and not seeing
> how the remove() method you introduced makes any practical difference.
> Not sure what I'm supposed to say.

I don't have anything against it, like I said before I thought those are
2 different issues. But if you think otherwise I can add a new patch in
this series, no problem.

Why do you say that the function remove() doesn't make any practical
difference?

-- 
/Horatiu

