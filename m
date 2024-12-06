Return-Path: <netdev+bounces-149554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFF79E6356
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2B3167887
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EF680BF8;
	Fri,  6 Dec 2024 01:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojbXKCV4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE13A10957;
	Fri,  6 Dec 2024 01:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447951; cv=none; b=tLzX3zi8QbBRvl0PJUPuZt3707OYMa/A9fgPJUh4Pa9mMiW40jHTQr/0YIWZcRTcyWw/JHZLmFxMY8WpNL1fIY4DclAFB96DnH/gUo5Rdkehgjr7Qp0FOGUr7pI8RHR6wYvjc66+suRjlbMkHEbuBKQ12HxuTCzis/tU/CVHJXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447951; c=relaxed/simple;
	bh=vN2Ax7TtmFtE+uoNCQ51l+8i9KFfMSsF2dzC9yrXkwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQgbnEbV9lrl9J0pbBX2NPdEszuzTx1BUMWHGUEgaiIjfWYopq7D76JSAcItKiv68MjqC94dOtmvn7l4zy9RE251LwdS4fFQveyEU4/8sC5zTuvOl6u6T0LrW49wv33wwHTraYlSyYPU23oJU+6FnQWiiPxXqsi/IsBsYTrBymU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojbXKCV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E268EC4CED1;
	Fri,  6 Dec 2024 01:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733447951;
	bh=vN2Ax7TtmFtE+uoNCQ51l+8i9KFfMSsF2dzC9yrXkwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ojbXKCV4ZE+fktAnzHNlZuEVeFNqD8YDZ/4IPFLcEyBYos8xfrLDiVnvk3vdkNPEI
	 IgzJwiLXf/QTjYO/4gyF5h+NvgjSiaHFbLMTzzZD9Gcx8/Y2BNTMnNOayevfv/4w19
	 qeXt/VfluJZhOGeTjseXrIwOH0rlgDNluNkuzYZY9p+CFFeMegDsUSi6PxJ1dzAfvh
	 LSHgOgysBfsfpZfgibaAbUIYLnizLkQU2tfbWwVxCdsd3/uVwz7dzSWYazXNsHKpYy
	 aZsi365fdHT//CY+WILMQ4JJgE5nCUlV6jVrb4/L6HmLGaTqK2KaQt9EQ9zdx3kKMe
	 xhbD3zfs0ZpBw==
Date: Thu, 5 Dec 2024 17:19:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/7] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <20241205171909.274715c2@kernel.org>
In-Reply-To: <Z1GVLf0RaYCP060b@shell.armlinux.org.uk>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
	<20241203075622.2452169-2-o.rempel@pengutronix.de>
	<Z1GVLf0RaYCP060b@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Dec 2024 11:57:33 +0000 Russell King (Oracle) wrote:
> > +	 * The input structure is not zero-initialized and the implementation
> > +	 * must only set statistics which are actually collected by the device.  
> 
> Eh what? This states to me that the structure is not initialised, but
> drivers should not write to all members unless they support the
> statistic.
> 
> Doesn't this mean we end up returning uninitialised data to userspace?
> If the structure is not initialised, how does core code know which
> statistics the driver has set to avoid returning uninitialised data?

It's not zero-initialized. Meaning it's initialized to a special magic
value that the core then checks for to decide if the driver actually
reported something.

Maybe this:

 * Drivers must not zero out statistics which they don't report.
 * Core will initialize members to ETHTOOL_STAT_NOT_SET and check
 * for this value to report to user space only the stats actually
 * supported by the device.

IDK how to phrase this better..

