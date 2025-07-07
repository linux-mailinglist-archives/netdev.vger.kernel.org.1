Return-Path: <netdev+bounces-204687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68457AFBBEE
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4170B7B2A41
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A75B2673B7;
	Mon,  7 Jul 2025 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uu2LUz5g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A060194094;
	Mon,  7 Jul 2025 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918017; cv=none; b=npUFU5fU5toii9gVtAvPWM7jDfnPgfVxFims38aJbpTN/udp0RjJNuPQWlHCtMY5SCEOwJLjWv14O3I1HzgPMGcRvEONngRrzTuEMIeK81OPNWqymeANGK5fJX9LPG5/JKlzWR48Dt1y2G8aSzVJlEl2HBTI+RAKJo/PYohwPJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918017; c=relaxed/simple;
	bh=gYG6DTBWMK46GKc/R8YrHZbxB8McYHlJaxPaoMQWFJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sft/UuNpALiydPCMwKwI1cNmpXJAM5E96PEEjVrtVam6+cRNJF4k726f0Ot1edRUyJ6Q8vtVW0iEHv+tc/yXdZzZPS9hq5z4ib+vJZM4yGrOZUBoLUEVMYMCO73aVPlMLZLU3HNOKpRcc5qlywDyhv5CVFO8FHKB0P/ezPsAWfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uu2LUz5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ED6C4CEEF;
	Mon,  7 Jul 2025 19:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751918016;
	bh=gYG6DTBWMK46GKc/R8YrHZbxB8McYHlJaxPaoMQWFJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uu2LUz5gv2fyvuaFKZiLimQvQT5SUAlqcCNcZ+P7WmzI70VmZ+6UlylHV971wm401
	 QYVFwc5p7wMbj/E6AalC35K1v5vIFeyDU+JUxNrQFmG4RoK45NYE8a66UjyNEGFMWc
	 F7XTFuB308bejaoJdXCfXpnKG6dvX7gq5G43n6+2i7ESI9oZIjoXayhmU2xbjCh7KD
	 p/wB170emV+PYUO40rceUnrziVrjcHheJeUNoYO/SGBlIONkwj7T0s6Mo0UXebMHxX
	 2dX5TeSHUT11RkTOxOUVOZC3ObNiNAzH5VO4j1L6t7pI/OisnsjShP39jhd8GHg4/R
	 PFOQowSlfVEeg==
Date: Mon, 7 Jul 2025 12:53:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kamil =?UTF-8?B?SG9yw6Fr?= - 2N <kamilh@axis.com>
Cc: <florian.fainelli@broadcom.com>,
 <bcm-kernel-feedback-list@broadcom.com>, <andrew@lunn.ch>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <f.fainelli@gmail.com>, <robh@kernel.org>, <andrew+netdev@lunn.ch>,
 <horms@kernel.org>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net v6 0/4] net: phy: bcm54811: Fix the PHY
 initialization
Message-ID: <20250707125335.213ed1d7@kernel.org>
In-Reply-To: <20250704083512.853748-1-kamilh@axis.com>
References: <20250704083512.853748-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Jul 2025 10:35:08 +0200 Kamil Hor=C3=A1k - 2N wrote:
> Fix the bcm54811 PHY driver initialization for MII-Lite.

Sorry for the delay, I went AFK for the long weekend shortly after
responding to v5. IIUC bcm54811 basically never worked, so I think
net-next is appropriate for the whole series. Please rebase and strip
the Fixes tags.
--=20
pw-bot: cr

