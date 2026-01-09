Return-Path: <netdev+bounces-248307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC09D06BD6
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 02:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAE99301C900
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 01:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB192264C7;
	Fri,  9 Jan 2026 01:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rY8K/7DV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481881DE885
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 01:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767922096; cv=none; b=g4th/Ps0mY6sAfgXWwC9L7+6FoPhJKjcYTU6RFfSvlez/EwptyUMhCxSbHHw6unW6H83ElCMLniUYCx6E54A9la/KAYG2/hs6jA+ERNGBn+CHSHRdhh7dtcKlrYfzRSeZa7kVWLC2tmrNxWyg4AKJd3Y4Fd2yROpuBv4sDxuOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767922096; c=relaxed/simple;
	bh=x4lzX7i7MOIuLGNby2gBNzNNvA3ShmWSsptOdIlwZ/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkwAlIpmHJwdCI0EiAdCt1eNjZDIMV0f8SELbSg5mCEKi7Vr+pCdgQ9KPPAFIBo0FKTaeROgLNtLWz0NXBzPTF+Fp01lu4zXZ8SnWDvx2AWLzeQqhchtJDBTPrI98pw3fppiAG6fNgwAQ1XJucdekSVVUuUj9xkRL/U9RO67L6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rY8K/7DV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106BFC116C6;
	Fri,  9 Jan 2026 01:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767922095;
	bh=x4lzX7i7MOIuLGNby2gBNzNNvA3ShmWSsptOdIlwZ/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rY8K/7DV7VfhlnAV2ilw0J7Erm7ceBfYeAud1xBT/et61PexRtPcw7/sXOTXccrj6
	 c1mkYMzsdPoup1TBe8J5iRqihsmbDq5KY/3BZ+Z3DCqtbeAFoVzTD9NF0AkJ+2rUIs
	 1AQKtIQcYWUZaDS4f0QS463R5Le66XGSiWynDPA8lG1AjahxTZ0Nj+EImXdJ+WdAAy
	 W/R/k6lhiUfagkQHfzF45Z2HcGy9nTKZ0pqiybnvjM0IeLR6fsa03VpsEUCRwUnkKW
	 ob6R4D8pih09S9GxMBkzFiTnMWBEvM63QytS9LrSKExxtvAm90RSDLM1z52YHRe3vx
	 Xd4z2m9LhPv4A==
Date: Thu, 8 Jan 2026 17:28:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, David Miller
 <davem@davemloft.net>, Vladimir Oltean <vladimir.oltean@nxp.com>, Michael
 Klein <michael@fossekall.de>, Daniel Golle <daniel@makrotopia.org>, Realtek
 linux nic maintainers <nic_swsd@realtek.com>, Aleksander Jan Bajkowski
 <olek2@wp.pl>, Fabio Baltieri <fabio.baltieri@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: phy: realtek: add PHY driver for
 RTL8127ATF
Message-ID: <20260108172814.5d98954f@kernel.org>
In-Reply-To: <492763d9-9ece-41a1-a542-d09d9b77ab4a@gmail.com>
References: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
	<492763d9-9ece-41a1-a542-d09d9b77ab4a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jan 2026 21:27:06 +0100 Heiner Kallweit wrote:
> --- /dev/null
> +++ b/include/linux/realtek_phy.h

How would you feel about putting this in include/net ?
Easy to miss things in linux/, harder to grep, not to
mention that some of our automation (patchwork etc) has
its own delegation rules, not using MAINTAINERS.

