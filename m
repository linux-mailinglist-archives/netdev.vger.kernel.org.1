Return-Path: <netdev+bounces-245162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 384E9CC7FC6
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 14:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F28F4300EA3B
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C29D382581;
	Wed, 17 Dec 2025 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qhOrnQOd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6444434FF7A;
	Wed, 17 Dec 2025 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979638; cv=none; b=neaeAlE30k9RjUAxX8syFJYXAa5nIOP3/7/+oY/nPgm4xrvps7Wlsq54605bKR1dEZB8iuwElDCHSlOlSV+5M9NDWQvHCYm37864VmkSAy+gt2/dkzOTXzLoMIn00yl2LNEQfKfgyQvz0cQGwBW6V0Zec/l3bi71telQOWYLS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979638; c=relaxed/simple;
	bh=1UpAV83OpKNjjc4ByCa2HOBtLC9gCAtyfjTfRDKh2vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyX++CrB0X23mS8HVw3HS8OxHx5YRRilVSkRFq7mdI6TKoUd7icVTGSy7js0lkMGV00Ig9M3nS6GiGDavohHHA3dOOfI9rQ+TEVvzrX9yOLURNIO2f41G+zKCU7d0TP3492R8n7JQiR4w8R9pUilfbXbRhNhvi2pZXYu6RvIK2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qhOrnQOd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yfpuFUIIdzDvqAVnHULPTZrjOHsB1IDrDwe7OdEgiT0=; b=qhOrnQOdSGklUExbLgo+E2wqU2
	G2XxSwC7uHjFCcCfKooalEfsNF+4p1W0bc3FALEBpq1Brmni5+6mZ1qpMQuag8V4qcYSL2LJShXSl
	HQ2kqFnjlhFkO8OJwl3Zc0zMZq9SzEgp/FrHbXzpCR4Si8gU+7HoyKt8DbWqqbZVRIB0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vVryN-00HDTt-1u; Wed, 17 Dec 2025 14:53:47 +0100
Date: Wed, 17 Dec 2025 14:53:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, salil.mehta@huawei.com,
	shiyongbang@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/6] net: phy: add support to set default
 rules
Message-ID: <4e884fc2-9f64-48dd-b0be-e9bb6ec0582d@lunn.ch>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-3-shaojijie@huawei.com>
 <fe22ae64-2a09-45ce-8dbf-a4683745e21c@lunn.ch>
 <647f91c7-72c2-4e9d-a26d-3f1b5ee42b21@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <647f91c7-72c2-4e9d-a26d-3f1b5ee42b21@huawei.com>

> Some of our boards have only one LED, and we want to indicate both
> link and active(TX and RX) status simultaneously.

Configuration is generally policy, which is normally done in
userspace. I would suggest a udev rule.

	Andrew


