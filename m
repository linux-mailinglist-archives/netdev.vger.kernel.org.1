Return-Path: <netdev+bounces-187503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C75C6AA78C2
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 19:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402A64E1A70
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 17:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC83264FB1;
	Fri,  2 May 2025 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MdQ2XScY"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415C264FA5
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746207714; cv=none; b=oSQC3j3bYbIg3RO87+BA5OrwYKyeZUpMIXEvfP/TQ5+dOBpX4BBjFVV2Zrg5f9r68dLLCc8nIEeFWS8E89gVGoMMEKTRz9DEWKDsojpKKKpWpcUmjZorLJ2z11nt4hc5+QEJZF/PiWmh1BvESxL0IKGgLE7tI1Z+iJCaWHKx2Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746207714; c=relaxed/simple;
	bh=eLz7obv35w/u/cKxEql/UTAbQvGopYBPWu2O23zJfFE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PxWUobkeHFq71SCUR1xGpKL7rp54LdtpMDhxyNaZ6B6qRybJD7ROppyIFqmuGbdrfN4NT7DPtHDhdIL+1+5CAeAGgo+pefhXWA7ThWyoqcjKRhzkCPxmyPyXyKGljcg8hbJhHSf6KCYIWfxHLl2yIMcXuwjuSKev6hPJhQ+GDFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MdQ2XScY; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7590d7af-e8c3-48cd-aba2-10af4d9d909d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746207700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xff4owWgDUIlVTdiJE9nAsinQN/NlojnRKLTslMQN8U=;
	b=MdQ2XScY0YuJgRON9Ye4a2dZ6lrHOCp7JQsLUQSjuXZectNoGme+AUXVBqAz/bLAUi84rn
	tYk3cMji0ERwL3QX6FL0n8Dtm2D4cGvlptE8Tm+HJDb0EKSUXLT3/UAE5lO/SrfbPWesYm
	LxlvBaN08D7jjeD+fd2fPTrHOxfw2sQ=
Date: Fri, 2 May 2025 13:41:32 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v3 00/11] Add PCS core support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, upstream@airoha.com,
 Christian Marangi <ansuelsmth@gmail.com>, linux-kernel@vger.kernel.org,
 Kory Maincent <kory.maincent@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
 Joyce Ooi <joyce.ooi@intel.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Madalin Bucur <madalin.bucur@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Robert Hancock <robert.hancock@calian.com>,
 Saravana Kannan <saravanak@google.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250415193323.2794214-1-sean.anderson@linux.dev>
 <aADzVrN1yb6UOcLh@shell.armlinux.org.uk>
 <13357f38-f27f-45b5-8c6a-9a7aca41156f@linux.dev>
 <aAEdQVd5Wn7EaxXp@shell.armlinux.org.uk>
 <8d6c8f72-a8bd-43a8-b1e6-a20cafddf804@linux.dev>
Content-Language: en-US
In-Reply-To: <8d6c8f72-a8bd-43a8-b1e6-a20cafddf804@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Russell,

On 4/17/25 11:29, Sean Anderson wrote:
> On 4/17/25 11:24, Russell King (Oracle) wrote:
>> On Thu, Apr 17, 2025 at 10:22:09AM -0400, Sean Anderson wrote:
>>> Hi Russell,
>>> 
>>> On 4/17/25 08:25, Russell King (Oracle) wrote:
>>> > On Tue, Apr 15, 2025 at 03:33:12PM -0400, Sean Anderson wrote:
>>> >> This series adds support for creating PCSs as devices on a bus with a
>>> >> driver (patch 3). As initial users,
>>> > 
>>> > As per previous, unless I respond (this response not included) then I
>>> > haven't had time to look at it - and today is total ratshit so, not
>>> > today.
>>> 
>>> Sorry if I resent this too soon. I had another look at the request for
>>> #pcs-cells [1], and determined that a simpler approach would be
>>> possible. So I wanted to resend with that change since it would let me
>>> drop the fwnode_property_get_reference_optional_args patches.
>> 
>> Please can you send them as RFC so I don't feel the pressure to say
>> something before they get merged (remember, non-RFC patches to netdev
>> get queued up in patchwork for merging.)
> 
> This series is marked "changes requested" in patchwork, so I don't think
> it should get merged automatically. I won't send a v4 until you've had a
> chance to review it.

Any chance you could review this series in the next week or so? I would
like to send v4 in time to be reviewed before net-next closes later this
month.

--Sean

