Return-Path: <netdev+bounces-180331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00273A80FC1
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06A0171FA8
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A0E226520;
	Tue,  8 Apr 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qYN9elIQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F2F2236FC
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125489; cv=none; b=VJsVwix9IQMkkIq4i2vyU84m7e9i/KsIg0mXxJeDKNsDzSnXYte1mi3GQ4/TigL4gwhXa+nnHpKFONhrcFA4WZ0DcKTO+eIH2l5x3lsK1357g1x40TxIsAP6H7PscLJ1qadDALsADXN07VfRIDd1CawyLV1eDsjkFaZtLlOpces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125489; c=relaxed/simple;
	bh=R7gt85kpHUgOXrzFifbXZ9lqyoRD668hCe7Kpfratak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcVsVDIHI6nuTmlIpDV2PP6MdM2Q6lji9GeJWFcZ6Z97pazSOosimt3rsQ69yiLPGEpIvvI5RklpSg0SfGUX3GGQxcCC/8EJ1fnixHjKocHnPDhbCuOVZVy6I4SboESFtNBHJD8agpNDJdqsX5w9DVEc8Z6bv5RjWwnRP5LsE8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qYN9elIQ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e7720741-93c5-450b-99a0-3434a5d535f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744125482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6A0hK4GqrFidtzfUsz5pZ3otqeWdeUksBm3Ffeph64Q=;
	b=qYN9elIQgFBvOhzsXh3Ym4aLFX9ciaThNCjNQYCkgf6ZQB63IU9qXvViaXtNZ3HsvQ90R2
	bXwC/4E6c8pVQoaCzqtHCDvwW1Y9QVSXLmO7XXnkXVMao7Ct/yZv1K1u/knJG7IlU0EOxa
	VCPfs97vLfLKyJjO9Ti4Badxnbc5Kjk=
Date: Tue, 8 Apr 2025 11:17:52 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC net-next PATCH 00/13] Add PCS core support
To: Daniel Golle <daniel@makrotopia.org>,
 "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
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
 <Z_QKl-4563l05WB3@makrotopia.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <Z_QKl-4563l05WB3@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/7/25 13:25, Daniel Golle wrote:
> On Mon, Apr 07, 2025 at 07:21:38PM +0200, Christian Marangi (Ansuel) wrote:
>> Il giorno lun 7 apr 2025 alle ore 19:00 Sean Anderson
>> > I agree that a "cells" approach would require this, but
>> >
>> > - There are no in-tree examples of where this is necessary
>> > - I think this would be easy to add when necessary
>> >
>> 
>> There are no in-tree cause only now we are starting to support
>> complex configuration with multiple PCS placed outside the MAC.
>> 
>> I feel it's better to define a standard API for them now before
>> we permit even more MAC driver to implement custom property
>> and have to address tons of workaround for compatibility.
> 
> Qualcomm's PCS driver will require offering multiple phylink_pcs by a
> single device/of_node. So while it's true that there is currently no
> in-tree user for that, that very user is already knocking on our doors.
> 
> See
> https://patchwork.kernel.org/project/netdevbpf/list/?series=931658&state=*

OK, but you have separate nodes for each PCS? So maybe the best thing is to
allow customizing the fwnode? E.g. something like

pcs_register_fwnode(struct device *dev, struct phylink_pcs *pcs, struct fwnode_handle *fwnode)

--Sean

