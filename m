Return-Path: <netdev+bounces-190478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773CDAB6E9A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3173A7B71
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9E91B3930;
	Wed, 14 May 2025 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KhzNny9Y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234AD1C2335
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234484; cv=none; b=Mn1SefThOTaOQ4yzRuqVBJekzOJHD6rE76UypxxrUQwag6ecCnT/wiK+ljd7F5SSh053o9K0+H3+LYkpJ2zpvc9g9F+GBQYOJFiYmjm1hcd6cr0KUEHB6IvmkPBq5MLQKY7cWwGMJLBj/VESjsTCXZU2ddodvIoCVaDadm2P1bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234484; c=relaxed/simple;
	bh=LH8bJjec9qI5aQ9LqT9/sies7sP6lfbVkCXONMu07rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShQMq+slZS0dmQ2widLHhOi2PqBAgg9GqFTMA817MeW2qSRQr/9/6oA0rJwXtKMsnlY6ZtIoSNQsYeGk4rT0eW1uLDizCXTY5WIWsHPAGi1rpWZzgpFMYbtPwEhGPEXuuNESPzUy6+znZ3fQkpsMruHONoLRgTq5VF1UxwYawdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KhzNny9Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cSjOc/YqxdAvIPTyhEF+WHHps5jpSm0lgy6z8D3ZndY=; b=KhzNny9YWuL1gnrwofJMHpy8Pe
	kyhSLlIOSgAYIJnXqQI7HQXcF6Tnm8kett3SK/3jVu4oZPRD8r4cFTZKuc0CRvpIEcT/R14cDsi8Q
	Kqk5NvNoiqHwMBB9WJUgCyjr7ZL3LdJWsc6wIDn6OfFMEhxZgbjiCCl9AoP2cpsppUZE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uFDVE-00CZoZ-2I; Wed, 14 May 2025 16:54:36 +0200
Date: Wed, 14 May 2025 16:54:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wojtek Wasko <wwasko@nvidia.com>
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH] ptp: Add sysfs attribute to show clock is safe to open RO
Message-ID: <64de5996-1120-4c06-9782-a172e83f9eb3@lunn.ch>
References: <20250514143622.4104588-1-wwasko@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514143622.4104588-1-wwasko@nvidia.com>

On Wed, May 14, 2025 at 05:36:21PM +0300, Wojtek Wasko wrote:
> Recent patches introduced in 6.15 implement permissions checks for PTP
> clocks. Prior to those, a process with readonly access could modify the
> state of PTP devices, in particular the generation and consumption of
> PPS signals.
> 
> Userspace (e.g. udev) managing the ownership and permissions of device
> nodes lacks information as to whether kernel implements the necessary
> security checks and whether it is safe to expose readonly access to
> PTP devices to unprivileged users. Kernel version checks are cumbersome
> and prone to failure, especially if backports are considered [1].
> 
> Add a readonly sysfs attribute to PTP clocks, "ro_safe", backed by a
> static string.

~/linux$ grep -r "ro_safe"
~/linux$ 

At minimum, this needs documentation.

But is this really the first time an issue like this has come up?

Also, what was the argument for adding permission checks, and how was
it argued it was not an ABI change?

   Andrew

