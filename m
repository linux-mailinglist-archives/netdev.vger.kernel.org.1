Return-Path: <netdev+bounces-154092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150779FB3F9
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634471884CEC
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83391C07DF;
	Mon, 23 Dec 2024 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axqfVWx7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4451BEF75;
	Mon, 23 Dec 2024 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734978275; cv=none; b=daL109ORYa+xK8HWDXwJK5TobKSFI3zf/jSd1yOu4y5Br8/3fm6eBKkx7VtjUzJHROE3A5Sp9tgBB7PPJ9VYFSf3AMq9Zz1Z4IsAKS/OPUea/ESL2efRy7jIixwG9ez7ikKu8Skcp3amFM9fn33wo5k1M+hioIr1v99PvdKu8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734978275; c=relaxed/simple;
	bh=wpw89dxvqNxWH2EevhSR949pHovPqQIpeWQjhdi7N88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDK8+ND7/vADGnSDGbOPaE5oASQypsTLVa3MahPHKtT40FzB1MU2yvE4DacpmE5JrV6SM6G/h0EabVDZjstJb+FQ6Vaj6iVchmFQd5GqEUCwDUoMPS4lE2yoHMntdS1CYIaPgXr3DJqboGYt+TiCRz7bQNBVS1m4hoMTS2+tczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axqfVWx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D1FC4CED3;
	Mon, 23 Dec 2024 18:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734978275;
	bh=wpw89dxvqNxWH2EevhSR949pHovPqQIpeWQjhdi7N88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=axqfVWx7TacMx1C15ufQAvcp85DMVzFoH0jmfl0pQmtAuoVpp1n+/MFd7EXqTwvzp
	 iKjSlW4qMVVUUCaA/J21Tk5zFIeaNEfK9uuCYlO1lwNSmNIKMBjBf1jF5x8Ax7r5rX
	 nGYwYalQkfLtQS48wedWNGj9XB8JQDmkPxwMrujNAC7KIUrdEjrX2ZuAmJv1YC9KbO
	 JMbvmXoiG4iOnR1Jw+7DxCFqoloZisX4QZgOEl6U+R84rRAQdKD52ULo8bG2DBqFIQ
	 kn/CdCPU5sqE7gJJ63lz913boELucaDHt0MiKhfsAKB+ISAZ2ys2of9DCVf9yusVyY
	 iTw9g3qLKOA6Q==
Date: Mon, 23 Dec 2024 10:24:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/8] Introduce unified and structured PHY
Message-ID: <20241223102433.55784fa1@kernel.org>
In-Reply-To: <20241221081530.3003900-1-o.rempel@pengutronix.de>
References: <20241221081530.3003900-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Dec 2024 09:15:22 +0100 Oleksij Rempel wrote:
> This patch set introduces a unified and well-structured interface for
> reporting PHY statistics. Instead of relying on arbitrary strings in PHY
> drivers, this interface provides a consistent and structured way to
> expose PHY statistics to userspace via ethtool.
> 
> The initial groundwork for this effort was laid by Jakub Kicinski, who
> contributed patches to plumb PHY statistics to drivers and added support
> for structured statistics in ethtool. Building on Jakub's work, I tested
> the implementation with several PHYs, addressed a few issues, and added
> support for statistics in two specific PHY drivers.

## Form letter - winter-break

Networking development is suspended for winter holidays, until Jan 2nd.
We are currently accepting bug fixes only, see the announcements at:

https://lore.kernel.org/20241211164022.6a075d3a@kernel.org
https://lore.kernel.org/20241220182851.7acb6416@kernel.org

RFC patches sent for review only are welcome at any time.
-- 
pw-bot: defer
pv-bot: closed

