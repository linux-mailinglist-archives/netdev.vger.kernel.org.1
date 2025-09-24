Return-Path: <netdev+bounces-225749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22648B97F09
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B867B75B6
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 00:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C039D1DE4C9;
	Wed, 24 Sep 2025 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTyJmgcj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9453A4A35;
	Wed, 24 Sep 2025 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674859; cv=none; b=po1mqSrypg+nBMgXQy3WXQJ1WQOYBMVKBx145KYQjMnvN6Zp99B5MC4tfKBznwxE22OvmvJcttFbmZ/wpUStNmmcLn3y18Uq384nUHjYY+GPU3FSQ5NdaJ/gDaxfv8Rrh0pTNCqVQxS7QrrTwInv19vE3LiH2EB77tDmS+2AtMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674859; c=relaxed/simple;
	bh=Bp3tHq3pjenL9flU3HYwhJiFub3m45DDOYq8H1LjgqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+br2lgxglYHRGdBlS8/ndfm9ympuUygFwzaCNNX0OAMpcE74Hn5Dp4DKRSFdr7ei1XESSSiwDIGbR62M0ruH9Q2NQ6n5W2ahfonG3wfU5mD8gk/xVF5z0gGXg2LScS6bSto0xH8VvZsdA3QX4WNteID+dstuCQ6JpdL7Ee3/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTyJmgcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF41AC4CEF5;
	Wed, 24 Sep 2025 00:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758674859;
	bh=Bp3tHq3pjenL9flU3HYwhJiFub3m45DDOYq8H1LjgqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GTyJmgcjbSrgSGOai94m6h6uQ9mw+Dv2Bd8lWkApWlKlh3ifmD734L3iEeU+/Afk7
	 +oEg/aliW3zbWOm7DEzPrUqfhD90ZKQc/672R95LhYzK7LWwN3++MNr/LKxLhQu/lU
	 RtE4Ll6hzOvKfFPpUfriFN8Ur96vcuOyEfjBz3bVdLg4w491Qx+oYR1AfEyNiRyW+t
	 D5y8HpRVBuiHdkYjZHnapGKkpoSpAZnbzYVJZ/S6g6+JGsxnfBFN+bV6ozoTDrOacx
	 rK1uZnfEK11WJF4gyieB5mv+IBYaTMi2Z0AeN6m+ljSASZ67DjyKnElemHhHAo6/qs
	 aq5BT8Zw2bJFQ==
Date: Tue, 23 Sep 2025 17:47:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 5/5] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <20250923174737.4759aaf4@kernel.org>
In-Reply-To: <20250922131148.1917856-6-mmyangfl@gmail.com>
References: <20250922131148.1917856-1-mmyangfl@gmail.com>
	<20250922131148.1917856-6-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 21:11:43 +0800 David Yang wrote:
> +	MIB_DESC(1, 0x00, "RxBroadcast", false),	/* rx broadcast pkts */
> +	MIB_DESC(1, 0x04, "RxPause", false),		/* rx pause pkts */
> +	MIB_DESC(1, 0x08, "RxMulticast", false),	/* rx multicast pkts, excluding pause and OAM */
> +	MIB_DESC(1, 0x0c, "RxCrcErr", false),		/* rx crc err pkts, len >= 64B */

Keeping the string names for every stat, and the boolean seems like 
an overkill when there is grand total of 3 stats that set "true".
The comments for IEEE stats can also go, there's no extra information
here.

> +static void yt921x_mdio_remove(struct mdio_device *mdiodev)
> +{

> +		cancel_delayed_work_sync(&pp->mib_read);
> +	}
> +
> +	dsa_unregister_switch(&priv->ds);

The work canceling looks racy, the port can come up in between
cancel_work and dsa_unregister ? disable_delayed_work.. will likely 
do the job.
-- 
pw-bot: cr

