Return-Path: <netdev+bounces-144089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5455C9C58C9
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFAD1F20F33
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF2140E5F;
	Tue, 12 Nov 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3WkTUVYZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D009D433CB;
	Tue, 12 Nov 2024 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417455; cv=none; b=eGkNleATW83wRjgHdSlOVa4A296Qcopf8ARL5d+u0pZf/PTryoIltRYcS4HuFXWCQbKEITsfCrirmC6HL2BBGb+iyu21MnLY5WmX/j0gjmIpLEvaF8s/6CmKEqEhmi+46z9j/7a8qUIND6sKWy5vOhFUxa9J5GqLeOfwArPuPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417455; c=relaxed/simple;
	bh=6K3GSc0x/j9A8YcooX+eY4MolLdzUjUEnuk3WVYw3FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtn/xzP8vPN+5IzUQhcxt+xHjsWH2Z3g9weHzyDXKXuuHIDII5lh71Ltt5a8tKEY4UbnulJmebOJ1ooxHVkVkUVGcBXSWnZdfphG1aozvppSg0WIJpywtYnk+k5LMU0zFA0qZ1IaJz7Mj6PmG5WnhTn/Lbl45q6ohGp2WNimi6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3WkTUVYZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VUXGbgZtZ4lHTogpAsxPzrwuPigwQsowYfuNsRuPONg=; b=3WkTUVYZcasH+PX6DnxFkHsN2Y
	/yQSdjic11nspISkJDJJ0pvEDnaP4x83aK4FcF4QaR4QB7MgFveQY8P7LbY7LlGalDABsPYsVeDyL
	4sRpuOOvO/vURmnsu5NiKsewiOUXQwX1HlNbOqzRgqNGsJKo4LJopokqT9vDKfqwnCQ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tAqlu-00D1qn-S1; Tue, 12 Nov 2024 14:17:30 +0100
Date: Tue, 12 Nov 2024 14:17:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alistair Francis <alistair@alistair23.me>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com, alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 1/2] include: mdio: Remove mdio45_ethtool_gset()
Message-ID: <939ceeee-ce7b-47cf-80e4-873a0816f26a@lunn.ch>
References: <20241112105430.438491-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112105430.438491-1-alistair@alistair23.me>

On Tue, Nov 12, 2024 at 08:54:29PM +1000, Alistair Francis wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> mdio45_ethtool_gset() is never called, so let's remove it.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

With a pathchset, it would be normal to include a cover node, patch
0/X, which explains the big picture. There you could mention that you
are primarily doing this for Rust since it gives linker errors.

The patches themselves look O.K. Lets leave them for a couple of days
so 0-day can build test them and see if there are some users hiding
away which we both missed.

	Andrew

