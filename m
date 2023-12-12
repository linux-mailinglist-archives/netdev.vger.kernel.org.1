Return-Path: <netdev+bounces-56577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A0880F787
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C060CB20E6A
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F387B81E59;
	Tue, 12 Dec 2023 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DD6xBI3f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C8963576
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 20:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E340AC433C7;
	Tue, 12 Dec 2023 20:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702411770;
	bh=0eVTZkHlIsk4aS6bhAk3MNH78cknRO/FG2cL4SHw4nI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DD6xBI3fMi8m8hMqyxAqM36NRBTMjYg931z25Qts7t2uYQAK00GDdDBiyoi/FZU58
	 T9SoUwMxKnA0cz46BjKba5m4VqYqOTygLmVIs3sEdYuPg2P2ASocvDEPXR3wC/uJE9
	 qEe24c7y5ScQsZx/2ONaVEeGAFcO9ftV+ckdevj9JrD3fis2cq6fShopa8V0O95wZM
	 aKFwUfAe3+3iMj5KxNCUAELeS6V6diijN3EkX7+vLAMkWsBKXOBP6/RP7mcSg+1E8/
	 VE8WRBkUH64YHcc3gYeYdaT8WvphmfQCBlKozwafOyXWENgvyoVL1JmNRxKlQWJxPt
	 PjGzwsL/bIOtg==
Date: Tue, 12 Dec 2023 12:09:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir
 Oltean <olteanv@gmail.com>, David Epping
 <david.epping@missinglinkelectronics.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Harini Katakam <harini.katakam@amd.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v5 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <20231212120928.4b558d68@kernel.org>
In-Reply-To: <20231212123743.29829-3-ansuelsmth@gmail.com>
References: <20231212123743.29829-1-ansuelsmth@gmail.com>
	<20231212123743.29829-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 13:37:43 +0100 Christian Marangi wrote:
> + * __phy_package_write_mmd - write MMD reg relative to PHY package base addr

kdoc test says phy_package_write_mmd

> + * @phydev: The phy_device struct
> + * @addr_offset: The offset to be added to PHY package base_addr
> + * @devad: The MMD to write to
> + * @regnum: The register on the MMD to write
> + * @val: value to write to @regnum
> + *
> + * Convenience helper for writing a register of an MMD on a given PHY
> + * using the PHY package base address. The base address is added to
> + * the addr_offset value.
> + *
> + * Same calling rules as for phy_write();
> + *
> + * NOTE: It's assumed that the entire PHY package is either C22 or C45.
> + */
> +int phy_package_write_mmd(struct phy_device *phydev,
-- 
pw-bot: cr

