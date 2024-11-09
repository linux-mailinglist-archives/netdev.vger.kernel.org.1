Return-Path: <netdev+bounces-143549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0622A9C2EFE
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 19:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36EDD1C20AE7
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 18:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DCC13BACB;
	Sat,  9 Nov 2024 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4NqLLIPz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7009233D7D;
	Sat,  9 Nov 2024 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731175252; cv=none; b=kvzIceFVvWm2UeyEKGc9eHrSJvhqZI87rabS0b6VO1Bf36msnua1GDjHc53JtTic9FkgMC+6TtX7vGZLLSGp/qu+7l3N2v0CLKlRNUnWQxvnAVKVpyw7F5bmKE1gipWE4lyEzzNrIAxfYQAMm2p/NCu9tueUbCCE/1j4fbGzVXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731175252; c=relaxed/simple;
	bh=jG+TcbF+YScf3QauecEwLkm1T1rd2Ak4bd+ycrp1DsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+oJDHUdWaqEDlgijOekTJXc2cVpRe7HRIVJEPdGi4lfpAVC6Ge1/3FKUrDuGENee2Q3gHNr5gEBE8u+douQhv+xLmRZnY1534Js32ot6nl9H/2u7jtV5mo4ZzHh3m1NG7cB7bgkfuHmF0/bMHptUZL45AWx8jArXjefHMCzYck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4NqLLIPz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Af08O8QQU9lovRofFEIAnROpNHG8FgeW3SE4K68deRo=; b=4NqLLIPzkMmK1O7OuDLm3WPg4v
	C02k4xvKJF6hFhKmZhV66slK9Te3olkkVu9q5sKVROA/JNalQI2P00RbnZuCkh/N+j9qM5gbaaKJa
	qm+/79eKOjFQvQa98IDMrnWQexS1eXUkNzaBEVPAW7zY6VhLCZHpOdUiVanxLipyuAbI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t9plG-00CiwN-4T; Sat, 09 Nov 2024 19:00:38 +0100
Date: Sat, 9 Nov 2024 19:00:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	mohsin.bashr@gmail.com, sanmanpradhan@meta.com,
	andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev,
	jdamato@fastly.com, sdf@fomichev.me, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] eth: fbnic: Add PCIe hardware statistics
Message-ID: <e80299f8-5fc4-41ba-8e48-37029078825e@lunn.ch>
References: <20241109025905.1531196-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109025905.1531196-1-sanman.p211993@gmail.com>

> +void fbnic_dbg_init(void)
> +{
> +	fbnic_dbg_root = debugfs_create_dir(fbnic_driver_name, NULL);
> +	debugfs_create_file("pcie_stats", 0400, fbnic_dbg_root, NULL,
> +			    &fbnic_dbg_pcie_stats_fops);

Have you tested this on a machine with two NICs?

	Andrew

