Return-Path: <netdev+bounces-198422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4628BADC18E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 07:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCD3172F39
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 05:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7A1213E9C;
	Tue, 17 Jun 2025 05:25:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8223A14E2E2
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 05:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750137948; cv=none; b=GimgGH2Bu+vZjccTiQvOPLPUcKFFBalsWNaKJZ8YnrpgF/8YMzep/YWxV/o4eEPoXDRYq0yXsoq1gO4nQ7DCU5NDks6XB1AxsExZfZE7b/y/sUAhiWWMQAFk8uAC0MrqdjKQyE4iRO0zH+1mbnRIRX2hv2bHbsUbHbCh3qjH6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750137948; c=relaxed/simple;
	bh=LXXtqBAWTsou/FRkr5jyMnDlvR3Y6hdToKrF+Sp20d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxITt8ydZDOtIul9HgM57ukaQN7haxP9ABKxCuZqhwtfWnP3H/IYtglaDWslIBxvDfOODQOhLvgbzBbyMDmjHQlSFUgdrAaSmqUdDFt1Fl6gXV/J+LlAo3EkyvG30e3Ms1AMSalMZJ1cLmbt+vUlWEPgBz4dvdRfebA88q6Ljpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uROpJ-000397-TK; Tue, 17 Jun 2025 07:25:41 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uROpI-003vEi-2y;
	Tue, 17 Jun 2025 07:25:40 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uROpI-001LWp-2W;
	Tue, 17 Jun 2025 07:25:40 +0200
Date: Tue, 17 Jun 2025 07:25:40 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: netdev@vger.kernel.org, Arun Ramadoss <arun.ramadoss@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
	Richard Cochran <richardcochran@gmail.com>,
	Christian Eggers <ceggers@arri.de>
Subject: Re: [PTP][KSZ9477][p2p1step] Questions for PTP support on KSZ9477
 device
Message-ID: <aFD8VDUgRaZ3OZZd@pengutronix.de>
References: <20250616172501.00ea80c4@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250616172501.00ea80c4@wsk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Jun 16, 2025 at 05:25:01PM +0200, Lukasz Majewski wrote:
> Dear Community,
> 
> As of [1] KSZ drivers support HW timestamping HWTSTAMP_TX_ONESTEP_P2P.
> When used with ptp4l (config [2]) I'm able to see that two boards with
> KSZ9477 can communicate and one of them is a grandmaster device.
> 
> This is OK (/dev/ptp0 is created and works properly).
> 
> From what I have understood - the device which supports p2p1step also
> supports "older" approaches, so communication with other HW shall be
> possible.

This is not fully correct. "One step" and "two step" need different things from
hardware and driver.

In "one step" mode, the switch modifies the PTP frame directly and inserts the
timestamp during sending (start of frame). This works without host help.

But for "two step" mode, the hardware only timestamps after the frame is sent.
The host must then read this timestamp. For that, the switch must trigger an
interrupt to the host. This requires:
- board to wire the IRQ line from switch to host,
- and driver to handle that interrupt and read the timestamp (like in
ksz_ptp_msg_thread_fn()).

So it's not only about switch HW. It also depends on board design and driver
support.

> Hence the questions:
> 
> 1. Would it be possible to communicate with beaglebone black (BBB)
> connected to the same network?

No, this will not work correctly. Both sides must use the same timestamping
mode: either both "one step" or both "two step".
 
> root@BeagleBone:~# ethtool -T eth0
> Hardware Transmit Timestamp Modes:
>         off
>         on
> Hardware Receive Filter Modes:
>         none
>         ptpv2-event

BBB supports only "two step" (mode "on").
 
> My board:
> # ethtool -T lan3
> Hardware Transmit Timestamp Modes:
>         off
>         onestep-p2p
> Hardware Receive Filter Modes:
>         none
>         ptpv2-l4-event
>         ptpv2-l2-event
>         ptpv2-event

Your board supports only "one step". So they cannot sync correctly.

> (other fields are the same)
> 
> As I've stated above - onestep-p2p shall also support the "on" mode
> from BBB.

No, onestep-p2p cannot talk to "on" mode. They use different timestamping
logic. ptp4l cannot mix one-step and two-step.

> The documentation of KSZ9477 states that:
> - IEEE 1588v2 PTP and Clock Synchronization
> - Transparent Clock (TC) with auto correction update
> - Master and slave Ordinary Clock (OC) support
> - End-to-end (E2E) or peer-to-peer (P2P)
> - PTP multicast and unicast message support
> - PTP message transport over IPv4/v6 and IEEE 802.3
> - IEEE 1588v2 PTP packet filtering
> - Synchronous Ethernet support via recovered clock
> 
> which looks like all PTP use cases (and other boards) for HW shall be
> supported.
> 
> Is this a matter of not (yet) available in-driver support or do I need
> to configure linuxptp in different way to have such support?

Be careful - this list shows what the hardware could support, but not what
actually works in all setups. Many features need specific driver or board
support.

For example, KSZ9477 has an erratum for 2-step mode:
When 2-step is enabled, some PTP messages (like Sync, Follow-up, Announce) can
get dropped if normal traffic is present. This makes 2-step mode unreliable.

End-user impact: Protocols like gPTP or AVB, which require 2-step mode, will
not work correctly. The device cannot keep time sync in 2-step mode with other
devices.
 
> 2. The master clock synchronization and calibration
> 
> On one board (grandmaster) (connected to lan3):
> [1943.558]: port 0: INITIALIZING to LISTENING on INIT_COMPLETE
> [1951.091]: port 1: LISTENING to MASTER on
> ANNOUNCE_RECEIPT_TIMEOUT_EXPIRES
> [1951.091]: selected local clock 824f12.fffe.110022 as best master
> [1951.091]: port 1: assuming the grand master role
> 
> The other board:
> [890.003]: port 1 (lan3): new foreign master 824f12.fffe.110022-1
> [894.003]: selected best master clock 824f12.fffe.110022
> [894.005]: port 1 (lan3): LISTENING to UNCALIBRATED on RS_SLAVE

At this point, I would expect to see output like:

master offset ... path delay ...
port 1: UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED

If these are missing, sync is not working. In this case, the likely reason is
that the two devices use different timestamping modes — one-step vs two-step —
which are not compatible. Because of that, delay and offset cannot be
calculated, and the state stays UNCALIBRATED.
 
> The phc2sys -m -s lan3 shows some calibration...
> 
> CLOCK_REALTIME phc offset        65 s2 freq  -45509 delay 351557
> CLOCK_REALTIME phc offset       591 s2 freq  -44964 delay 350475
> CLOCK_REALTIME phc offset      -892 s2 freq  -46270 delay 350516
> CLOCK_REALTIME phc offset    137456 s2 freq  +91811 delay 733784
> CLOCK_REALTIME phc offset   -136987 s2 freq -141395 delay 350676
> CLOCK_REALTIME phc offset    -41327 s2 freq  -86831 delay 350216
> CLOCK_REALTIME phc offset        66 s2 freq  -57837 delay 350489
> CLOCK_REALTIME phc offset     12037 s2 freq  -45846 delay 351854
> CLOCK_REALTIME phc offset     12213 s2 freq  -42059 delay 350474
> CLOCK_REALTIME phc offset      8984 s2 freq  -41624 delay 349682
> 
> 
> but the "fluctuation" is too large to regard it as a "stable" and
> precise source.

This is not the right tool to check the current sync problem. The timestamp
readings on KSZ are done over several SPI transactions, which adds jitter and
delay.

For better accuracy, the driver should support gettimex64(), but this is not
implemented in the KSZ driver. So the phc2sys output is not reliable here.

> And probably hence it is "UNCALIBRATED" master clock.
> 
> Even more strange - the tshark -i lan3 -Y "ptp" -V
> 
> .... 1011 = messageId: Announce Message (0xb)
> correction: 0.000000 nanoseconds                     
>     correction: Ns: 0 nanoseconds                   
>     correctionSubNs: 0 nanoseconds             
> 
> .... 0010 = messageId: Peer_Delay_Req Message (0x2)
>     correction: 0.000000 nanoseconds
>     correction: Ns: 0 nanoseconds
>     correctionSubNs: 0 nanoseconds
> 
> shows always the correction value of 0 ns.
> I do guess that it shall have some (different) values.
> 
> Any hints on fixing this problem?

The correctionField is only set when Transparent Clock (TC) is active. But with
KSZ switches, TC is disabled as soon as any port uses DSA CPU tagging.

So in your setup, TC is not active — that’s why correctionField stays 0. This
is expected behavior with current driver and DSA integration
 
> 3. Just to mention - I've found rather old conversation regarding PTP
> support [3] on KSZ devices (but for KSZ9563)
> 
> And it looks like it has already been adopted to minline Linux. 
> Am I correct? Or is anything still missing (and hence I do see the two
> described above issues)?

Some support is in mainline, but what works depends on several things:

- the exact KSZ switch variant (some have quirks, e.g. broken 2-step mode),
- the required feature (OC, TC, 1-step or 2-step),
- the board implementation (e.g. IRQ lines connected or not),
- and driver support (e.g. timestamp reading, gettimex64).

For example:
- If your KSZ chip has broken 2-step mode (known issue), you can only use
  1-step.
- If the switch is used with DSA and CPU tagging is enabled, Transparent
Clock cannot work.

So yes, it’s upstream - but real support depends on your exact use case.

Best Regards,
Oleksij Rempel
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

