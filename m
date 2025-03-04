Return-Path: <netdev+bounces-171747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7C5A4E674
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0D87A1378
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5A028F94F;
	Tue,  4 Mar 2025 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ombHZ+VK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6760B28F945
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105292; cv=none; b=YVBmufAOpLS63/vT+TnsD/JzBhKHpNskW8WSKQVnrHK5HTbiu+IIfHjPoa3NsYMHDGdnD6m2b6gme1e/XbOtkdxrOvKh4BFaidHpQfvd4XvO2aawyjoTJv8IgnFR8xliQ+s+loUtE5LN3onIeRWW94xOyFZnN1dzCWNHymUfcKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105292; c=relaxed/simple;
	bh=pZe9Bki6ygAZpdRXEySS+N871FnXyiKf6+FqujnhI6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaLDWv6QOtmDMZowMhrmJsO2eFhOYR0WdalXc+MXwPfYHEJZftyqDhRpJ8P8LBfiRlwZnNMHqyo/L/biiBHuIenn1WNK8v75D5zCYFwDx2kmJ+Dq4yK+FfQ0W5fAj3DYcpJCApCOJBlNM7IJF+OXGvHFoHVKI/IhrC3C/8litI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ombHZ+VK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LPkLiCNr4920SnP/H54afqG920rIJOKnmmpv4wSH3Ic=; b=ombHZ+VK7YlZy5RPFUFnfCqkai
	u0XAbpShn5huYu9IPHtIPilAsM8kntXetr90NaTyPYUsQki+e+0MOwZKw+FHK7fNJEq3Sh6yCWYV3
	k7tp/t5tKk8CGO0SfTM6NAkOADlQarFykfIWfHG3JXNSNfMKOesF4APbrliE6HlRbvdE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpV1E-002C0j-To; Tue, 04 Mar 2025 17:21:20 +0100
Date: Tue, 4 Mar 2025 17:21:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: max.schulze@online.de, hfdevel@gmx.net, netdev@vger.kernel.org
Subject: Re: tn40xx / qt2025: cannot load firmware, error -2
Message-ID: <89515e61-6aeb-4063-bc47-52a9ea982a26@lunn.ch>
References: <5f649558-b6a0-4562-b8e5-713cb8138d9a@online.de>
 <20250304.214223.562994455289524982.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304.214223.562994455289524982.fujita.tomonori@gmail.com>

> You hit the error during boot? In that case, the firmware file might
> not be included in the initramfs.

With a C driver, you would add a MODULE_FIRMWARE() macro indicating
the firmware filename. The tools building the initramfs should then be
able to pull the firmware in. I see you have:

kernel::module_phy_driver! {
    drivers: [PhyQT2025],
    ...
    firmware: ["qt2025-2.0.3.3.fw"],
}

Does this last line do the equivalent of MODULE_FIRMWARE()?

	Andrew

