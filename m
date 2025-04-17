Return-Path: <netdev+bounces-183808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA93A9219B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12BD819E848C
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4755C253347;
	Thu, 17 Apr 2025 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tINTPSUk"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B86253B74
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903809; cv=none; b=cLLkp4FjhstrDDhn3AY/Q9gl98Wfmoiz4VsA95WNz46dx9B0/e3MtLqYjp/TGMAU9Mas8yjYIf7n2cflFtYErdY7RLcwZ1axy40lty6FN0Zf6pA3Hqoi+EtzGkEn2GIvc/8+zb/rsNaR8tO4bweJJxAg5keVZdrBDejBm8ZDfm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903809; c=relaxed/simple;
	bh=7yHU2zMjXO7YHcDIN5XLl9irHpMX2LD+Z4RtW8tNBNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COUDeJa5cvFyeqsVsUyp1LXIASaVW79mfCwGdlQodLGD+apLrNghZyVAf3m8ywk1JkzagM6ectdE7LNezSvL1DDeuEkdB1ES0k2fqgeLapcSB8mURhGXTTyl/rFVf38EXORcrKmaG7qbf8RdECX5xuAPssP136om5dktwHl3VEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tINTPSUk; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8d6c8f72-a8bd-43a8-b1e6-a20cafddf804@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744903792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkOBPoUk+xFY5ZKRx/7lO+ZCCZvZu8C4v3s/LGW1qvM=;
	b=tINTPSUkz+lDh2u0qbUCc7IvYTHB0jtNBVFJ9GpvC7Xs047gwS9jy1iPUq6aP0+0OMpGTQ
	tDohhgUbbIgxhRG1BUFLBUe7j3DUUn7RwmiDGwOgZZ3tjEdqYt3iISZp4y0PSgaEgSxpjz
	LfFic1XsdEQ7osExW7l1Z8p7PX0VEsU=
Date: Thu, 17 Apr 2025 11:29:38 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v3 00/11] Add PCS core support
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aAEdQVd5Wn7EaxXp@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/17/25 11:24, Russell King (Oracle) wrote:
> On Thu, Apr 17, 2025 at 10:22:09AM -0400, Sean Anderson wrote:
>> Hi Russell,
>> 
>> On 4/17/25 08:25, Russell King (Oracle) wrote:
>> > On Tue, Apr 15, 2025 at 03:33:12PM -0400, Sean Anderson wrote:
>> >> This series adds support for creating PCSs as devices on a bus with a
>> >> driver (patch 3). As initial users,
>> > 
>> > As per previous, unless I respond (this response not included) then I
>> > haven't had time to look at it - and today is total ratshit so, not
>> > today.
>> 
>> Sorry if I resent this too soon. I had another look at the request for
>> #pcs-cells [1], and determined that a simpler approach would be
>> possible. So I wanted to resend with that change since it would let me
>> drop the fwnode_property_get_reference_optional_args patches.
> 
> Please can you send them as RFC so I don't feel the pressure to say
> something before they get merged (remember, non-RFC patches to netdev
> get queued up in patchwork for merging.)

This series is marked "changes requested" in patchwork, so I don't think
it should get merged automatically. I won't send a v4 until you've had a
chance to review it.

--Sean


