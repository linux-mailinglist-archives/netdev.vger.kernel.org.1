Return-Path: <netdev+bounces-213355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89362B24B7E
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3637AB117
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE09C2EB5CD;
	Wed, 13 Aug 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="NCJWPtz3"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898422EAB90
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093899; cv=none; b=InCpvKnQA8plXctB/hbAnF2Q7twbj0RKn31rLJwvqZi1ERmv5BZxSXGy+K/4WBFZ8vWWOWSfWp74d8GdVay9CoqnZlJUW/Bi5fjtOdIMba6dHjPD70bgCa9P544ZI061kJzVCv79ikRfzS4Br9FhwJ9f31DkbypYXVwGyO3vDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093899; c=relaxed/simple;
	bh=ACUeZO4hEXy/Xvi2AUY0W66hUYnhOTLSnsztMV25Z64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S945kzqvwuESVfZuDsLEf++ZStK+eM+Oor7c+mQ7yOMQZM7GnYyc594PcNp4A9AozFP2i7YsH0QK3T4/ZZXYv1HJONoXD2BFYgXXL1rFol4e62OyUnrcPHjFbWDhdwQ+0L2p1QaNxnuxq7/r3Phzv7Yv7mKUQlq8NUr67J2g0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=NCJWPtz3; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8ED68FFF6C;
	Wed, 13 Aug 2025 15:54:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1755093295;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CY7Vfcwf0rZ/DD4O47SSJWAgt1gNE4pz0JCn/z2z9QQ=;
	b=NCJWPtz3uMVxxA9+Fho8TjHdbSzduxktnAk8EoyRijfrdXLbRV9NmjnM0ZGmQUXzwLE5yY
	uXt7+kl+18MpFovZrLU2FAvJh97MYGinaKqAZWh0zqU3R6HR4Z6rrFCl1fArHMqHMzLL/K
	2Wa0PKgLNpCoOMD9OVq3VaKgVyPY94AVyiuGlyRUeyV6HxFeelXcXxHVbqH/QfqcgL/9Qi
	G4TMeBt5tI325QmqcDeTdOQKZb16f9c6FxCYs5X0Nwb0f5V08WtREr3EHPeog7trooqzur
	R7is5U/pO+X2ejFI+vDiKdkvdBgVgD8km4veJt88nVdx/ESoNwBs5YGkhxQSQw==
Date: Wed, 13 Aug 2025 15:54:52 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Woojung.Huh@microchip.com, kuba@kernel.org, andrew@lunn.ch,
 netdev@vger.kernel.org, Tristram.Ha@microchip.com
Subject: Re: KSZ9477 HSR Offloading
Message-ID: <20250813155452.55c4eb81@wsk>
In-Reply-To: <8e761c31-728c-4ff7-925a-5e16a9ef1310@kontron.de>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
	<6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
	<1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
	<6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
	<20250129121733.1e99f29c@wsk>
	<0383e3d9-b229-4218-a931-73185d393177@kontron.de>
	<20250129145845.3988cf04@wsk>
	<42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
	<BL0PR11MB2913C7E1AE86A3A0EB12D0D7E7EE2@BL0PR11MB2913.namprd11.prod.outlook.com>
	<1400a748-0de7-4093-a549-f07617e6ac51@kontron.de>
	<BL0PR11MB29130BB177996C437F792106E7E92@BL0PR11MB2913.namprd11.prod.outlook.com>
	<20250203103113.27e3060a@wsk>
	<1edbe1e4-9491-4344-828d-4c3b73954e8a@kontron.de>
	<BL0PR11MB2913B949D05B9BB73108A5FFE7F52@BL0PR11MB2913.namprd11.prod.outlook.com>
	<20250203150418.7f244827@kernel.org>
	<BL0PR11MB2913ECAA6F0C97E342F7DE22E7F42@BL0PR11MB2913.namprd11.prod.outlook.com>
	<8e761c31-728c-4ff7-925a-5e16a9ef1310@kontron.de>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Frieder,

> Am 04.02.25 um 15:55 schrieb Woojung.Huh@microchip.com:
> > Hi Jakub,
> >   
> >> -----Original Message-----
> >> From: Jakub Kicinski <kuba@kernel.org>
> >> Sent: Monday, February 3, 2025 6:04 PM
> >> To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>
> >> Cc: frieder.schrempf@kontron.de; lukma@denx.de; andrew@lunn.ch;
> >> netdev@vger.kernel.org; Tristram Ha - C24268
> >> <Tristram.Ha@microchip.com> Subject: Re: KSZ9477 HSR Offloading
> >>
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you
> >> know the content is safe
> >>
> >> On Mon, 3 Feb 2025 14:58:12 +0000 Woojung.Huh@microchip.com wrote:
> >>  
> >>> Hi Lukasz & Frieder,
> >>>
> >>> Oops! My bad. I confused that Lukasz was filed a case originally.
> >>> Monday  
> >> brain-freeze. :(  
> >>>
> >>> Yes, it is not a public link and per-user case. So, only Frieder
> >>> can see  
> >> it.  
> >>> It may be able for you when Frieder adds you as a team. (Not
> >>> tested  
> >> personally though)
> >>
> >> Woojung Huh, please make sure the mailing list is informed about
> >> the outcomes. Taking discussion off list to a closed ticketing
> >> system is against community rules. See below, thanks.
> >>
> >> Quoting documentation:
> >>
> >>   Open development
> >>   ----------------
> >>
> >>   Discussions about user reported issues, and development of new
> >> code should be conducted in a manner typical for the larger
> >> subsystem. It is common for development within a single company to
> >> be conducted behind closed doors. However, development and
> >> discussions initiated by community members must not be redirected
> >> from public to closed forums or to private email conversations.
> >> Reasonable exceptions to this guidance include discussions about
> >> security related issues.
> >>
> >> See:
> >> https://www.kernel.org/doc/html/next/maintainer/feature-and-driver-maintainers.html#open-development
> >>  
> > 
> > Learn new thing today. Didn't know this. Definitely I will share it
> > when this work is done. My intention was for easier work for
> > request than having me as an middleman for the issue.  
> 
> Here is a follow-up for this thread. I was busy elsewhere, didn't have
> access to the hardware and failed to respond to the comments from
> Microchip support team provided in their internal ticket system.
> 
> As a summary, the Microchip support couldn't reproduce my issue on
> their side and asked for further information.
> 
> With the hardware now back on my table I was able to do some further
> investigations and found out that this is caused by a misconfiguration
> on my side, that doesn't get handled/prevented by the kernel.

If I remember correctly from the ticket - there was also an issue with
the size of MTU for HSR packets.

Am I correct?

> 
> The HW forwarding between HSR ports is configured in
> ksz9477_hsr_join() at the time of creating the HSR interface by
> calling ksz9477_cfg_port_member().
> 
> In my case I enabled the ports **after** that which caused the
> forwarding to be disabled again as ksz9477_cfg_port_member() gets
> called with the default configuration.
> 
> If I reorder my commands everything seems to work fine even with
> NETIF_F_HW_HSR_FWD enabled.
> 
> I wonder if the kernel should handle this case and prevent the
> forwarding configuration to be disabled if HSR is configured? I'll
> have a look if I can come up with a patch for this.
> 

Thanks  for looking for this issue. I'm looking forward for your
patches.

-- 
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic

