Return-Path: <netdev+bounces-146290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7772C9D2993
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 16:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F631F22DAA
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4B91CF2A3;
	Tue, 19 Nov 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NE0GPwwT"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D3199240
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030027; cv=none; b=aln5/HGdt2zfYxRdgZnnoret+oyUyGrTjt98g9UOPGnT+gnNjkOtQnSd1Fal7flANwK3Yb/LqOxiuDiM7eFrtXaniv5MRdE0Cv0ONTbzunMM5ePBBDKr/+LrmNknf8MDkRxelUnDX6CoCuWKWJR9KKVgJQ+B9z6vm9M/+onIKFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030027; c=relaxed/simple;
	bh=ER7cOBRIWGX7yohlx6AJ+2dZ0QuWbhsrufosCohFYYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CG6n1n5jqp6ukLMe16u1aXnvnvMc/m5BfjwgU382L8aLlsO9UTaIaubTNOhJMbYQ7/V+nXvDKcBJJ04XGvXZyW+yNpD0rv83FOwB8ZgEsmAwoCAW4/HbaVeKJHd0EcM9o7Fef1Pt7mepNcgb368jowm19ColhOJ8IW6TBkCRKAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NE0GPwwT; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <72ded972-cd16-4124-84af-8d8ddad049f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732030022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWSbFUx2xGk80b42aBRdXXKoJH6db6ZMOCOwwIwKZXc=;
	b=NE0GPwwTEBuMqj0fiOfOLYCHp464B1uP7TmgAZ8Fem4JrdRsJmM1XhJ/sFOkZXkDsg05FE
	N0gSw1hiUqF76rqmEbREn0/u7Y2ILOzOokQ1PHn2RJiz51YcqWdOzuzR3wtwfXrQsjYWiI
	iwUQoACvsJfoEflxgC8FRHlEGNS9fSQ=
Date: Tue, 19 Nov 2024 10:26:52 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Suraj Gupta <suraj.gupta2@amd.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michal.simek@amd.com, radhey.shyam.pandey@amd.com,
 horms@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@amd.com, harini.katakam@amd.com
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-3-suraj.gupta2@amd.com>
 <ZztjvkxbCiLER-PJ@shell.armlinux.org.uk>
 <657764fd-68a1-4826-b832-3bda91a0c13b@linux.dev>
 <9d26a588-d9ac-43c5-bedc-22cb1f0923dd@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <9d26a588-d9ac-43c5-bedc-22cb1f0923dd@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/18/24 20:35, Andrew Lunn wrote:
> On Mon, Nov 18, 2024 at 11:00:22AM -0500, Sean Anderson wrote:
>> On 11/18/24 10:56, Russell King (Oracle) wrote:
>> > On Mon, Nov 18, 2024 at 01:48:22PM +0530, Suraj Gupta wrote:
>> >> Add AXI 2.5G MAC support, which is an incremental speed upgrade
>> >> of AXI 1G MAC and supports 2.5G speed only. "max-speed" DT property
>> >> is used in driver to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
>> >> If max-speed property is missing, 1G is assumed to support backward
>> >> compatibility.
>> >> 
>> >> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
>> >> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
>> >> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
>> >> ---
>> > 
>> > ...
>> > 
>> >> -	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
>> >> -		MAC_10FD | MAC_100FD | MAC_1000FD;
>> >> +	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
>> >> +
>> >> +	/* Set MAC capabilities based on MAC type */
>> >> +	if (lp->max_speed == SPEED_1000)
>> >> +		lp->phylink_config.mac_capabilities |= MAC_10FD | MAC_100FD | MAC_1000FD;
>> >> +	else
>> >> +		lp->phylink_config.mac_capabilities |= MAC_2500FD;
>> > 
>> > The MAC can only operate at (10M, 100M, 1G) _or_ 2.5G ?
>> 
>> It's a PCS limitation. It either does (1000Base-X and/or SGMII) OR
>> (2500Base-X). The MAC itself doesn't have this limitation AFAIK.
> 
> 
> And can the PCS change between these modes? It is pretty typical to
> use SGMII for 10/100/1G and then swap to 2500BaseX for 2.5G.

Not AFAIK. There's only a bit for switching between 1000Base-X and
SGMII. 2500Base-X is selected at synthesis time, and AIUI the serdes
settings are different.

--Sean

