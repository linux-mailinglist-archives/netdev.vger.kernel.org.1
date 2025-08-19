Return-Path: <netdev+bounces-214829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F90DB2B6A4
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 04:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E771897456
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F880286412;
	Tue, 19 Aug 2025 02:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ti/3Zh77"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179C21FF3E;
	Tue, 19 Aug 2025 02:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568999; cv=none; b=FI1COMvolPSxcv21iFkoYaeWKQwI5+lDxrj+yoihq/MXkFXn14cUB0BdGop/jScjk5CtfogA/+f9Ywlmuda+yMuirftzUA1RhqcZBOt9Uy4nqLZfPv6kvujleVPCaNbl5CU1G95gdE+8BHhiDNYSIwRP/JuRMgKsTqlOopuVZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568999; c=relaxed/simple;
	bh=25ifC56kUlkKG18BYWJYBsBe4Rs7A4OYFDR8dl4reqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6PV6Zh/bHSQ08D4oXf/w1MhEXRsxOiJfKOrljsMXnmVdd5oJsqqhmFdoLdicWEbzikgcZk5o43fA/b04Wj+r4euS0llz3uD8mhEQ+Xu+uE77w5DBrwc09sSWcfPINTHH9MTZAkOe9cgk/l9YDfeMs7lecOqlL++OqR6qMEPgug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ti/3Zh77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F3DC4CEEB;
	Tue, 19 Aug 2025 02:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755568997;
	bh=25ifC56kUlkKG18BYWJYBsBe4Rs7A4OYFDR8dl4reqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ti/3Zh77da/Y4/jR0dJVLEZoWxNIFsCQw3+bTD/y4GaxwGeUc8makT02pbE4DFdLx
	 Oh/0KUxUoaKSRZiZOu7WfWY2E9eLpfr6udFbPkFXdq0r5puSP/swP/vQ4epqeBPwGX
	 qLO5kWQ4P/0NK/4TnP1O6xJv6UcKAlfnJWKr0NX8YGlXRx6upbmrXXyI5L2sI+jQ12
	 qiN1Jgw3PSwhBbhL1F5aFlQSsd25P2b7N34gLovKbK7VEARsHVtNJU09zG/d07EXT9
	 nm8/CnZxCiWTLfJ4n3t5BQt4T//mzvX00zejuZd3xJQE7Ce2jac/erWfrtawfzySJQ
	 G2goZhaj1J2Aw==
Date: Mon, 18 Aug 2025 19:03:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Florian
 Fainelli <f.fainelli@gmail.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Divya.Koppera@microchip.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] Documentation: networking: add detailed
 guide on Ethernet flow control configuration
Message-ID: <20250818190316.0bfdc719@kernel.org>
In-Reply-To: <20250814075342.212732-1-o.rempel@pengutronix.de>
References: <20250814075342.212732-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 09:53:42 +0200 Oleksij Rempel wrote:
> Introduce a new document, flow_control.rst, providing a comprehensive
> overview of Ethernet Flow Control in Linux. It explains how flow control
> works in full- and half-duplex modes, how autonegotiation resolves pause
> capabilities, and how users can inspect and configure flow control using
> ethtool and Netlink interfaces.
> 
> The document also covers typical MAC implementations, PHY behavior,
> ethtool driver operations, and provides a test plan for verifying driver
> behavior across various scenarios.
> 
> The legacy flow control section in phy.rst is replaced with a reference
> to this new document.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

This conflicts again, FWIW, another rebase will be needed.

> diff --git a/Documentation/networking/flow_control.rst b/Documentation/networking/flow_control.rst
> new file mode 100644
> index 000000000000..5585434178e7
> --- /dev/null
> +++ b/Documentation/networking/flow_control.rst
> @@ -0,0 +1,383 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +Ethernet Flow Control
> +=====================
> +
> +This document is a practical guide to Ethernet Flow Control in Linux, covering
> +what it is, how it works, and how to configure it.
> +
> +What is Flow Control?
> +=====================
> +
> +Flow control is a mechanism to prevent a fast sender from overwhelming a
> +slow receiver with data, which would cause buffer overruns and dropped packets.
> +The receiver can signal the sender to temporarily stop transmitting, giving it
> +time to process its backlog.

You haven't covered PFC. Is PFC not used in TSN?

> +How It Works: The Two Mechanisms
> +================================
> +
> +The method used for flow control depends on the link's duplex mode.
> +
> +1. Full-Duplex: PAUSE Frames (IEEE 802.3 Annex 31B)
> +---------------------------------------------------
> +On full-duplex links, devices can send and receive at the same time. Flow
> +control is achieved by sending a special **PAUSE frame**.
> +
> +* **What it is**: A standard Ethernet frame with a globally reserved
> +    destination MAC address (``01-80-C2-00-00-01``). This address is in a range
> +    that standard IEEE 802.1D-compliant bridges do not forward. However, some
> +    unmanaged or misconfigured bridges have been reported to forward these
> +    frames, which can disrupt flow control across a network.
> +
> +* **How it works**: The frame contains a `pause_time` value, telling the

What's the logic behind using single backticks? 
I'm a bit unclear on the expectations, AFAIU the single
backtick are supposed to be mostly references?
Unless you intend that it's safer to use double ticks everywhere
(ccL linux-doc to keep me honest).

> +Many MACs also implement automatic PAUSE frame transmission based on the fill
> +level of their internal RX FIFO. This is typically configured with two
> +thresholds:
> +
> +* **FLOW_ON (High Water Mark)**: When the RX FIFO usage reaches this
> +    threshold, the MAC automatically transmits a PAUSE frame to stop the sender.
> +
> +* **FLOW_OFF (Low Water Mark)**: When the RX FIFO usage drops below this
> +    threshold, the MAC transmits a PAUSE frame with a quanta of zero to tell
> +    the sender it can resume transmission.
> +
> +The optimal values for these thresholds often depend on the bandwidth of the
> +bus between the MAC and the system's CPU or RAM. Like the pause quanta, there
> +is currently no generic kernel interface for tuning these thresholds.

I'm not sure if this is true. In the "fast devices" I'm familiar
with, at least, the pause threshold is only covering latency of
stopping the internal device pipeline, and the *wire side*.
Basically you need to be able to cover RTT/2 * link speed
with internal MAP IP buffering. I thought there were even
some formulas in the spec on how much latency the far end
is allowed before it processes the ctrl frame.

Long story short the thresholds generally have little to do with
"CPU or RAM" and much more with cable length. It should be worth
calling out that the driver is responsible for configuring sensible
defaults per IEEE spec. The only reason user should have to tweak 
these thresholds, really, is on long fiber connections. Or I guess
if the user knows that the peer is buggy.

> +User Space Interface
> +--------------------
> +The primary user space tool for flow control configuration is `ethtool`. It
> +communicates with the kernel via netlink messages, specifically
> +`ETHTOOL_MSG_PAUSE_GET` and `ETHTOOL_MSG_PAUSE_SET`.

Linking to the ethtool_netlink section would be great, instead of
repeating her.e

> +These messages use a simple set of attributes that map to the members of the
> +`struct ethtool_pauseparam`:
> +
> +* `ETHTOOL_A_PAUSE_AUTONEG` -> `autoneg`
> +* `ETHTOOL_A_PAUSE_RX` -> `rx_pause`
> +* `ETHTOOL_A_PAUSE_TX` -> `tx_pause`
> +
> +The driver's implementation of the `.get_pauseparam` and `.set_pauseparam`
> +ethtool operations must correctly interpret these fields.
> +
> +* **On `get_pauseparam`**, the driver must report the user's configured flow
> +    control policy.
> +
> +    * The `autoneg` flag indicates the driver's behavior: if `on`, the driver
> +      will respect the negotiated outcome; if `off`, the driver will use a
> +      forced configuration.
> +
> +    * The `rx_pause` and `tx_pause` flags reflect the currently preferred
> +      configuration state, which depends on multiple factors.
> +
> +* **On `set_pauseparam`**, the driver must interpret the user's request:
> +
> +    * The `autoneg` flag acts as a mode selector. If `on`, the driver
> +      configures the PHY's advertisement based on `rx_pause` and `tx_pause`.
> +
> +    * If `off`, the driver forces the MAC into the state defined by
> +      `rx_pause` and `tx_pause`.

This belongs in the code. Please render this into the kdoc of correct
structs and use the power of kdoc to refer to those structs here.
Worst case you can use a DOC: section, if kdoc is too hard, but please
try to move description of the internal kernel APIs into code comments
which are included/referred to in the Documentation output.
And some kind of "See Documentation/networking/flow_control.rst" in
relevant places in the kernel code would be nice, too

> +Test Plan
> +=========

Obvious question.. could you make this into a python test?
put it under ..selftests/drivers/net/hw/, the SW emulation 
of the features is not required.

> +This section outlines test cases for verifying flow control configuration. The
> +`ethtool -s` command is used to set the base link state (autoneg on/off), and
> +`ethtool -A` is used to configure the pause parameters within that state.
> +
> +Case 1: Base Link is Autonegotiating
> +------------------------------------
> +*Prerequisite*: `ethtool -s eth0 autoneg on`
-- 
pw-bot: cr

