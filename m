Return-Path: <netdev+bounces-117855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CB294F8F6
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A20E283386
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 21:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAB4194A49;
	Mon, 12 Aug 2024 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FnJav7uR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C1187553;
	Mon, 12 Aug 2024 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723498090; cv=none; b=PJHl4wK4th26fkpAONvfBcdqAvJJgakSAX6DuL9bKXdEx64FYfK14RqeEeSdlyaJkrnFB3C/sUTJKSI/mMzLRw6iwZkG8WDeR4ehehpNe+eMc/9ktriTnOEidyuS1B0lPJxAYRgb9oMwpbTEO3tlvP+oMsooktrFNoTPFNr4FSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723498090; c=relaxed/simple;
	bh=2anLmvgLygGK2sB+arUEGgY58D4B5bZI7k9IAL1zuCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gr2BNPpdwGDoFzuvjRYYvFsjlJ/va32dil/Ufuxqp0HitHV2zMwrtG5KOgzadfbonL0QGWB5Rrq4HOW1qZbeqyivGt5xF42gVV0cR2JwBhMZQPfUdjAolqw8uKyVGW7jm3G2XDyZtvUHGsO6qsfsrBCBsVDxPgWzkPHDvA7wmFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FnJav7uR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a5dWnVcDL2y4UgdW2kUaINeQrbP4oE/rFx2jeLTa9Ao=; b=FnJav7uRWxxcGxJsxLHACfuSad
	mhfreWbPHaNYsf8DDF0np7YKUKMJ+aUTKYmqH3aFvCowXKs1ZEt3ZESf5EBdsU9ikr4Dc9imUppEL
	EIKYisYfpovkSa3pzzUIG6fY/6xdyGxN7y/IIENEzw8nzjTYaGY4SkHu4d2lhgB3b7lc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdca7-004ceV-UR; Mon, 12 Aug 2024 23:27:59 +0200
Date: Mon, 12 Aug 2024 23:27:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de
Subject: Re: [PATCH net-next 2/3] net: ag71xx: use devm for
 of_mdiobus_register
Message-ID: <ae818694-e697-41cc-a731-73cd50dd7d99@lunn.ch>
References: <20240812190700.14270-1-rosenp@gmail.com>
 <20240812190700.14270-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812190700.14270-3-rosenp@gmail.com>

On Mon, Aug 12, 2024 at 12:06:52PM -0700, Rosen Penev wrote:
> Allows removing ag71xx_mdio_remove.
> 
> Removed local mii_bus variable and assign struct members directly.
> Easier to reason about.

This mixes up two different things, making the patch harder to
review. Ideally you want lots of little patches, each doing one thing,
and being obviously correct. 

Is ag->mii_bus actually used anywhere, outside of ag71xx_mdio_probe()?
Often swapping to devm_ means the driver does not need to keep hold of
the resources. So i actually think you can remove ag->mii_bus. This
might of been more obvious if you had first swapped to
devm_of_mdiobus_register() without the other changes mixed in.

    Andrew

---
pw-bot: cr

