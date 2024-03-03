Return-Path: <netdev+bounces-76864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A57CC86F386
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 04:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CFF281DD1
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 03:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2780E566D;
	Sun,  3 Mar 2024 03:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNBqmXuZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D2469D;
	Sun,  3 Mar 2024 03:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709437244; cv=none; b=onhtSezuOPuZ0rJvqLUK9EvS4Uw+h2VyjDGJ3RtWEDYauG/SJNAFTfXBfOX8ESo+OX91F2D3JME9RakTMKrMpvrPw/1jsiW7jzH6e2BDNAZpGiItrSYhf8gmP1eYm+efKBQzXxscCrsR6qzXlFH0/4dN68BdGfQ5s9N3qepHcOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709437244; c=relaxed/simple;
	bh=EwA6Ug4Nsd81EG7L93AG11bGqeuzSxQPGgSUPSBM6yU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQ4ex49JDa1XuAvmuDh8yDf+5orq+cHvFCITOhNOAiDS8B9bSLphdSP5NmETLexeHQngqpnBN7oy4jxxp2xhhgi1uktqUM7s4eoCFqOdDdo1iq55twXZcO1Q2WNQNqVxOhxxpHr7aTZGPyJip23l7MSwVv2EarBVvZ8twguHX5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNBqmXuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82ADC433F1;
	Sun,  3 Mar 2024 03:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709437243;
	bh=EwA6Ug4Nsd81EG7L93AG11bGqeuzSxQPGgSUPSBM6yU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lNBqmXuZikyV+iLVF1sg/Ph1Quylm1fn95CzoDzhCspdInXE4t4WdW18CENmYiURL
	 Vf/Oxgug8nbuef+ri8d5wjGYB6kfNtcuDBa+xmKUy4+Kkb4WH4vX7kuoasmRjWYJyK
	 hUjS7hnIb6Q7mLIjyCVbN5KStLSAOKpEQTvSSu+rrpg0PaNgr60AmrZ5iu84jlYU0X
	 dzjAaT+Au3vAaw0v3Y3UmDOmETCQ+88SqEhAnaiIkPwSWRos8MT0b9XZfXCe9rMGuI
	 ZNZ8Gr40laBhDIwPQVev+FK9KOVsJW4mYPwMDJsRzkssjI8UYTqHEthIZhDdJcbSWu
	 HP79DD3M08sRw==
Date: Sat, 2 Mar 2024 19:40:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Horatiu Vultur - M31836 <Horatiu.Vultur@microchip.com>
Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>, "andrew@lunn.ch"
 <andrew@lunn.ch>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "wojciech.drewek@intel.com"
 <wojciech.drewek@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
 <edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 UNGLinuxDriver <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v2 2/2] net: phy: micrel: lan8814 cable
 improvement errata
Message-ID: <20240302194041.5d8f8fad@kernel.org>
In-Reply-To: <20240301072757.t36qqf47erk4jygr@DEN-DL-M31836.microchip.com>
References: <20240229195220.2673049-1-horatiu.vultur@microchip.com>
	<20240229195220.2673049-3-horatiu.vultur@microchip.com>
	<80bea3ec2ec86d2e75002f849da174f50e0b846b.camel@microchip.com>
	<20240301072757.t36qqf47erk4jygr@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 08:27:57 +0100 Horatiu Vultur - M31836 wrote:
> > > +#define LAN8814_PD_CONTROLS			0x9d
> > > +#define LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK_	GENMASK(3, 0)
> > > +#define LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL_	0xb  
> > 
> > nitpick: TIME_VAL macro is very generic if it can end with specific
> > like TIME_VAL_100M or something similar will gives more readability.  
> 
> Actually I prefer to keep it like this the name if it is possible..
> Because the VAL_ represents the value and MASK_ represents the mask
> value. Therefore the actual bits name of the register is
> LAN8814_PD_CONTROLS_PD_MEAS_TIME.
> 
> I am trying to have a naming convetion about how to define names in this
> file:
> <TARGET>_<REG_NAME>_<REG_BITS_NAME>

Why the trailing underscores, tho?

