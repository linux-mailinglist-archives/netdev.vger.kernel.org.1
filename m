Return-Path: <netdev+bounces-57722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E1F813FCC
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DBF1F22D90
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 02:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A7D62F;
	Fri, 15 Dec 2023 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkpiwemH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6421807;
	Fri, 15 Dec 2023 02:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013BDC433C8;
	Fri, 15 Dec 2023 02:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702607485;
	bh=ciWixoj9UkQ4OM79q9TQTfVlptETwuOYFH/B/dkuCYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dkpiwemHB5IMIhKteD/xK6e0viUDrWEqWFVcI0OIq8t2qRzen7Yn697y4UbkdBGL6
	 xlcfQaaJHL1he+q2VGdCvb2pnPTd633FVCGpx6uBskcZwX3ILKa4izDxfxlWy2pqQK
	 4AxNERUbcPqJKPxBKaMzNCst7+qjiNkOpCP1iv/JZIwd81sCOU66/chUzzrb6R3cMB
	 rUSPHqAvW6kHZCdNDA1XqhOBpbp9MYj7xUL/VA6WVu5mJD+9xa0/Nyx694kJ5HpqcL
	 2UWbidQZP0YmOFmPGWkFaCQ7kGuoCIWku5jUYMQtMSWjcVH2aYgGbmVtRRshTBJvZx
	 53ewpzVLxTtag==
Date: Thu, 14 Dec 2023 18:31:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <20231214183123.0f0af377@kernel.org>
In-Reply-To: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 00:05:35 +0000 Daniel Golle wrote:
> Calling led_trigger_register() when attaching a PHY located on an SFP
> module potentially (and practically) leads into a deadlock.
> Fix this by not calling led_trigger_register() for PHYs localted on SFP
> modules as such modules actually never got any LEDs.

Any suggestion of a Fixes tag?
Looks like the triggers were added a while back, are we only seeing it
now because we started exercising the code more?

