Return-Path: <netdev+bounces-203043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34200AF0650
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A84117E328
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 22:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E994230B983;
	Tue,  1 Jul 2025 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZMzjnVRp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B785302CC8;
	Tue,  1 Jul 2025 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751407644; cv=none; b=LgHF3Zl8Owe8HK9CnaouMzYlGittIWVKW3bg6tigec+tCHojjGCdPHn7LHRA/J5wK0mnSZYxeDphCeF7fXCosHX0iS7yxCQ2rqaQx0NtZj3lggol/BKzXpwudGlS/XxiUbF2zZ0vnwfvnLav7YGsYA43GHco0vIu8avMYKNhgQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751407644; c=relaxed/simple;
	bh=zi6v1l+4lRmDmBLWCGM97yPLoJhYg9pgI9j7qSGH1b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4KdJmv8MQ/MVH3S7jFfEXVqr6OUoKa7Ux47SAGgH+71TxsvFEu4RqSuyl6CaAbO4+MS9+oScQ7I1bLYZ1KdcsoWqM40GlfEzMAj0PJpL/nFLoWLsOCLA/I7KIa7DOzcgZXvkoyb/y5HjJzRqBzIUinlFKFK4WH7B1Z1AMII1jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZMzjnVRp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2LN8C9BH6bE7BEREzqc6mYXOs84jSO13kTlyKYPQJGE=; b=ZMzjnVRpkFMDWLzGRPMhru2Id1
	nAdWT7lOQ/U0RFcz92UFPX/dGt06hJxOtkZr/aPBAnjKUSV3SbKAtIhkUL8iNrIo3W77+tFJx/pq4
	IUopfqsGVSHWNerNmb1WCoQGTrjLmg1HeX3jaWhXEKv/3olTiAr8/bBEynibQ7gbYbt8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uWj88-00HVnX-4m; Wed, 02 Jul 2025 00:07:08 +0200
Date: Wed, 2 Jul 2025 00:07:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net-next 1/3] net: hibmcge: support scenario without
 PHY
Message-ID: <9b45bab6-dc6e-40b5-b37c-2b296213e8ed@lunn.ch>
References: <20250701125446.720176-1-shaojijie@huawei.com>
 <20250701125446.720176-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701125446.720176-2-shaojijie@huawei.com>

> +	phydev = fixed_phy_register(&hbg_fixed_phy_status, NULL);
> +	if (IS_ERR(phydev)) {
> +		dev_err_probe(dev, IS_ERR(phydev),

IS_ERR() returns a bool, where as dev_err_probe() expects an int.

> +			      "failed to register fixed PHY device\n");
> +		return IS_ERR(phydev);

This also looks wrong.

    Andrew

---
pw-bot: cr

