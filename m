Return-Path: <netdev+bounces-46656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1067E59DE
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 16:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D89B1C2088D
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76CE30333;
	Wed,  8 Nov 2023 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ADFjITpM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0530322
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 15:17:26 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EF0199
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 07:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0tOA4xl7tjgD0t44VxCU9/KD7nYM3/Cw/0M7IYajhuA=; b=ADFjITpMwY9PI1lEgQCt2DfXJw
	0plQC4SkwiApsyP0rD/O4IBAGUEkDNUC3UiKeOZJT4O+BwRSf/KrQmLijojSkO38n2naFlOBzAa+Z
	tu53iQ2+sOrP/UiL35aKxQDhMbeeR3OH41B8aaX7uCJYxYrcGb6lIJtmXojLekzJMFEA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r0kJ1-0018Gt-Jw; Wed, 08 Nov 2023 16:17:23 +0100
Date: Wed, 8 Nov 2023 16:17:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiko Gerstung <heiko.gerstung@meinberg.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: PRP with VLAN support - or how to contribute to a Linux network
 driver
Message-ID: <6ab3289a-2ede-41a3-8c57-b01df37bab7f@lunn.ch>
References: <75E355CF-3621-40D7-A31C-BA829804DFA2@meinberg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75E355CF-3621-40D7-A31C-BA829804DFA2@meinberg.de>

> I would like to discuss if it makes sense to remove the PRP
> functionality from the HSR driver (which is based on the bridge
> kernel module AFAICS) and instead implement PRP as a separate module
> (based on the Bonding driver, which would make more sense for PRP).

Seems like nobody replied. I don't know PRP or HSR, so i can only make
general remarks.

The general policy is that we don't rip something out and replace it
with new code. We try to improve what already exists to meet the
demands. This is partially because of backwards compatibility. There
could be users using the code as is. You cannot break that. Can you
step by step modify the current code to make use of bonding, and in
the process show you don't break the current use cases? You also need
to consider offloading to hardware. The bridge code has infrastructure
to offload. Does the bond driver? I've no idea about that.

> Hoping for advise what the next steps could be. Happy to discuss
> this off-list as it may not be of interest for most people.

You probably want to get together with others who are interested in
PRP and HSR. linutronix, ti, microchip, etc.

	Andrew

