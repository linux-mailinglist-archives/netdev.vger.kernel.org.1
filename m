Return-Path: <netdev+bounces-238892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E66C60BB4
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 22:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDDA84E14AB
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 21:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CA022FE11;
	Sat, 15 Nov 2025 21:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OCM3iKo6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4313594F;
	Sat, 15 Nov 2025 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763241363; cv=none; b=DDwIw1HsvI2TGUGZAsauz2RntBjBsRsYg3KGCKcwKuzqM1q20kWXBDbbhoXyeTc86ouWW1Wd2N19+2hJrclEJsC6/Q5FjQgHE9b1KBe2WT37VyDgTwhbY1J3RnjwqFJDhNzU7TnA6MjSFtQt5KxluwXwOry5xkERUxtZrTk2O1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763241363; c=relaxed/simple;
	bh=9Z733u5Ow5KX/0wGU+juH/ehU3LkKn/YGRAFyBH4t3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3Sgro7aaOIWdoau7AY4cAqG0UmEuSt54Muyo4nG+EeUAyem4sR1vVDpjGZKWIQ58fUjDe4tzAt7U+oOoPhgLGUtNawiioX+VHX2cnUi4TNgKttrai363QNB7BkFQaOTPS5S5NfknFWIs/RBpdK1UGSrNAnvMtA8sIhgm+MoTWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OCM3iKo6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=khPgDsVJrdOTw5XRZdidZ350ZJ9XgdNzhpLeT83/DIo=; b=OCM3iKo6z5eLZeUF3b5Se3eu4P
	24OzwFf8tBoieqvXawQWCnUvnlCLLaRt+B/Xl6VgVyrIZ2XQGkfOQ2Uy+HoFw8vGXRThD6t3HO3Rt
	IorisFz7KnK+q0cUGfL3yh45+u7v4gSZLySpaGFJpRjpJG0xZOffYM42fvUCLAa0lqUg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKNca-00E78A-Nh; Sat, 15 Nov 2025 22:15:48 +0100
Date: Sat, 15 Nov 2025 22:15:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Wei Fang <wei.fang@nxp.com>, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	eric@nelint.com, maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phylink: add missing supported link modes for
 the fixed-link
Message-ID: <a3886abf-5ed5-436a-8f92-7c010beced13@lunn.ch>
References: <20251114052808.1129942-1-wei.fang@nxp.com>
 <fc57fba2-26c2-4b8a-b0f5-1b3c4d1b9bef@lunn.ch>
 <aRjqLN8eQDIQfBjS@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRjqLN8eQDIQfBjS@shell.armlinux.org.uk>

> No, not for fixed links. (I have a patch which enables this, but we
> mutually agreed not to push it into mainline - I think you've forgotten
> that discussion.)

Not too surprising, given the number of discussions...

> So, the patch is the correct approach. The only thing that is missing
> is the detailed explanation about the problem the regression is
> causing. We have too many patches that fix regressions without
> explaining what the effect of the regression was... which is bad when
> we look back at the history.

Agreed.

I often like Vladimirs patches. Two pages of commit message for a one
line change.

    Andrew

---
pw-bot: cr

