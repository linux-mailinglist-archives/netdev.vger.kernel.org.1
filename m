Return-Path: <netdev+bounces-179825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 623E2A7E958
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3D83AAB55
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B200219302;
	Mon,  7 Apr 2025 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kybWyAZ0"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3946201270
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049196; cv=none; b=T6j4II1hw6/OWpx9TjEa9PuG7oAXAAr11wlWxmNF9SrzeI42elHn2B0k2beEZOe6iAK0VWM/hFubMYkMYEzJVR1vTaeN7Zzjz8w/tQzIvkC4cupmfk9KkEl8SclepGhDybUW1vetwLSbedCsrU5y+3fasKUlE9U5Y+yD+kSRc9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049196; c=relaxed/simple;
	bh=aPHlSmphASyw/e6OtF5BrnhEcXrJ3Tl5hTVdsy/Yibc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7yRY5pGR+1UxZQRWyt9ElWaydlB4jmNJIcNeWCm1fYecvVqGI1vy/rMj7X+EeknMG7vk25WJSsMUuxZwIx1hV01LqZX8iUzTSk6kYbEjwIyomc+Xkye3HiW7Q/UM7razS6BpRMph6dYeGnEJByDussBHKnPvGhlZeNSob6pKoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kybWyAZ0; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3203955d-b0fa-4ef6-bcec-6d23a5b6441d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744049190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFU4PCOFCF2t2dPmfjFQsFfH3+loT9oNKaTNo2jAsrw=;
	b=kybWyAZ0LNPljlzODiID9MCxmPkOsj3+XZ3NOBA1SJ+GUkEwxi2q4YG6Tqzxu5OztwOoy2
	4FWNfu+DxWPsP6v4QiY6skK5eZddzEVCNMMTHOBHgUXOXHrueBs+hUmpIpZBJYNh/tQl0M
	sPWqXv7raQ0Wc9svTCLcg7RV8xLYw7E=
Date: Mon, 7 Apr 2025 14:06:21 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC net-next PATCH 00/13] Add PCS core support
To: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 upstream@airoha.com, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
 Joyce Ooi <joyce.ooi@intel.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Li Yang <leoyang.li@nxp.com>, Madalin Bucur <madalin.bucur@nxp.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <michal.simek@amd.com>,
 Naveen N Rao <naveen@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Robert Hancock <robert.hancock@calian.com>,
 Saravana Kannan <saravanak@google.com>, Shawn Guo <shawnguo@kernel.org>,
 UNGLinuxDriver@microchip.com, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Wei Fang <wei.fang@nxp.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linuxppc-dev@lists.ozlabs.org
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
 <20250407182738.498d96b0@kmaincent-XPS-13-7390>
 <720b6db8-49c5-47e7-98da-f044fc38fc1a@linux.dev>
 <CA+_ehUyAo7fMTe_P0ws_9zrcbLEWVwBXDKbezcKVkvDUUNg0rg@mail.gmail.com>
 <1aec6dab-ed03-4ca3-8cd1-9cfbb807be10@linux.dev>
 <CA+_ehUzeMBFrDEb7Abn3UO3S7VVjMiKc+2o=p5RGjPDkfLPVtQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <CA+_ehUzeMBFrDEb7Abn3UO3S7VVjMiKc+2o=p5RGjPDkfLPVtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/7/25 13:21, Christian Marangi (Ansuel) wrote:
> Il giorno lun 7 apr 2025 alle ore 19:00 Sean Anderson
> <sean.anderson@linux.dev> ha scritto:
>>
>> On 4/7/25 12:46, Christian Marangi (Ansuel) wrote:
>> > Il giorno lun 7 apr 2025 alle ore 18:33 Sean Anderson
>> > <sean.anderson@linux.dev> ha scritto:
>> >>
>> >> On 4/7/25 12:27, Kory Maincent wrote:
>> >> > On Thu,  3 Apr 2025 14:18:54 -0400
>> >> > Sean Anderson <sean.anderson@linux.dev> wrote:
>> >> >
>> >> >> This series adds support for creating PCSs as devices on a bus with a
>> >> >> driver (patch 3). As initial users,
>> >> >>
>> >> >> - The Lynx PCS (and all of its users) is converted to this system (patch 5)
>> >> >> - The Xilinx PCS is broken out from the AXI Ethernet driver (patches 6-8)
>> >> >> - The Cadence MACB driver is converted to support external PCSs (namely
>> >> >>   the Xilinx PCS) (patches 9-10).
>> >> >>
>> >> >> The last few patches add device links for pcs-handle to improve boot times,
>> >> >> and add compatibles for all Lynx PCSs.
>> >> >>
>> >> >> Care has been taken to ensure backwards-compatibility. The main source
>> >> >> of this is that many PCS devices lack compatibles and get detected as
>> >> >> PHYs. To address this, pcs_get_by_fwnode_compat allows drivers to edit
>> >> >> the devicetree to add appropriate compatibles.
>> >> >
>> >> > I don't dive into your patch series and I don't know if you have heard about it
>> >> > but Christian Marangi is currently working on fwnode for PCS:
>> >> > https://lore.kernel.org/netdev/20250406221423.9723-1-ansuelsmth@gmail.com
>> >> >
>> >> > Maybe you should sync with him!
>> >>
>> >> I saw that series and made some comments. He is CC'd on this one.
>> >>
>> >> I think this approach has two advantages:
>> >>
>> >> - It completely solves the problem of the PCS being unregistered while the netdev
>> >>   (or whatever) is up
>> >> - I have designed the interface to make it easy to convert existing
>> >>   drivers that may not be able to use the "standard" probing process
>> >>   (because they have to support other devicetree structures for
>> >>   backwards-compatibility).
>> >>
>> >
>> > I notice this and it's my fault for taking too long to post v2 of the PCS patch.
>> > There was also this idea of entering the wrapper hell but I scrapped that early
>> > as I really feel it's a workaround to the current problem present for
>> > PCS handling.
>>
>> It's no workaround. The fundamental problem is that drivers can become
>> unbound at any time, and we cannot make consumers drop their references.
>> Every subsystem must deal with this reality, or suffer from
>> user-after-free bugs. See [1-3] for discussion of this problem in
>> relation to PCSs and PHYs, and [4] for more discussion of my approach.
>>
>> [1] https://lore.kernel.org/netdev/YV7Kp2k8VvN7J0fY@shell.armlinux.org.uk/
>> [2] https://lore.kernel.org/netdev/20220816163701.1578850-1-sean.anderson@seco.com/
>> [3] https://lore.kernel.org/netdev/9747f8ef-66b3-0870-cbc0-c1783896b30d@seco.com/
>> [3] https://lpc.events/event/17/contributions/1627/
>>
>> > And the real problem IMHO is that currently PCS handling is fragile and with too
>> > many assumptions. With Daniel we also discussed backwards-compatibility.
>> > (mainly needed for mt7621 and mt7986 (for mediatek side those are the 2
>> > that slipped in before it was correctly complained that things were
>> > taking a bad path)
>> >
>> > We feel v2 permits correct support of old implementations.
>> > The ""legacy"" implementation pose the assumption that PCS is never removed
>> > (unless the MAC driver is removed)
>> > That fits v2 where a MAC has to initially provide a list of PCS to
>> > phylink instance.
>>
>> And what happens when the driver is unbound from the device and suddenly
>> a PCS on that list is free'd memory but is in active use by a netdev?
>>
> 
> driver bug for not correctly implementing the removal task.
> 
> The approach is remove as provider and call phylink removal phase
> under rtnl lock.
> We tested this with unbind, that is actually the main problem we are
> trying to address
> and works correctly.

OK, so this is a different approach since your last submission. Please
CC me on your series.

- Fundamentally this is going to make backwards compatibility very
  difficult, since your approach cannot work with mac_select_pcs. How
  are you going to handle the case of MAC-internal PCSs? Are you going
  to make them create a swnode and bind to it just to create a PCS for
  e.g. MMIO registers? And how is the MAC supposed to know how to select
  the PCS? From what I can tell you don't even notify the MAC about
  which PCS it's using.

  I considered an approach like this, where the phylink would be in the
  driver's seat (so to speak), but I decided not to persue it due to
  the problems listed above. A lot of PCSs are tightly-integrated with
  their MACs, so it does not make sense to introduce this little
  coupling. I think it is better to let the MAC select the PCS e.g.
  based on the phy interface. This tends to be a few lines of code for
  the MAC and saves so much complexity in phylink.

  I think you should try doing the macb and lynx conversions for your
  approach. It will make the above problems obvious.

- Your approach is very intrusive. There are lots of changes all over
  phylink across several patches and it is hard to verify all the
  assumptions. Whereas a wrapper keeps everything contained to one file,
  and most of the functions can be evaluated independently.

--Sean

