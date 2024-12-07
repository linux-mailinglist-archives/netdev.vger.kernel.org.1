Return-Path: <netdev+bounces-149918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAD69E8200
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 21:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934B71659F8
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 20:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68471153BC1;
	Sat,  7 Dec 2024 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Tb0xHJ86"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF2522C6FA;
	Sat,  7 Dec 2024 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733603946; cv=none; b=kPAGvbU+3ne/h7owaWwThUgiW6A3IngLHBPWTvz00EjzY3ZTlnO3ulR/zUnmygNvVQqP3Eq0T8JJXrFNUxb5uPpmE66+f0En1QernfQeBHEGqzaPLS30BA3McajIyxI1oLlNfOYogdApMk3uUswulpjp3qvCS7s9oN/T12ataoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733603946; c=relaxed/simple;
	bh=qL+9ChYPsqY4C77/Sy8OOVm/lI/zb17cDXk+ooYqc5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRnyUIL1cS5Llg/9pMcBf9eAF92vFIQAq8nGYUF/E67jU8sDUGRaXcG553U7hPpKKeL2pYEaghb0g0qhNysBynY1pU2sImvfXc2ziL5OAnLTqD09iVlNTN3WRIdh3ZqMBMx7TBh5Pn/vQQgcvsDW9W3ke0PZ6MNc+MRX2WLM2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Tb0xHJ86; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HS5+8cf/NT9XGki+xRoxATzUF6H4RE8i/SF969wIAc8=; b=Tb0xHJ8619TX2/pPW3q1qBNZW8
	NRpcElkBH2teVe3cUg3g73tMO4rn7PpO15lfgUmDbL7LD96kGh6EwYPf+KON/NiFFCzJlyaXvMnSU
	wcNwHCvlpAHW4Ycov7XDpsJi6OZvypnklVq2kvH/9eVF+88i6dA8FK0DLR2l47JwSwd0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tK1Zk-00FVKw-Ba; Sat, 07 Dec 2024 21:38:52 +0100
Date: Sat, 7 Dec 2024 21:38:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: Move callback comments from
 struct to kernel-doc section
Message-ID: <1b012a63-c644-4079-b590-34c5f54b207f@lunn.ch>
References: <20241206113952.406311-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206113952.406311-1-o.rempel@pengutronix.de>

> +#if 0 /* For kernel-doc purposes only. */
> +
> +/**
> + * soft_reset - Issue a PHY software reset.
> + * @phydev: The PHY device to reset.
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +int soft_reset(struct phy_device *phydev);

We should probably ask the kdoc maintainers about how to do this, or
if they can extend kdoc for this use case.

	Andrew

