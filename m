Return-Path: <netdev+bounces-215473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D586B2EB9D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 05:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9665E633E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CED2D481D;
	Thu, 21 Aug 2025 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CS+Z681C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0D2E40E;
	Thu, 21 Aug 2025 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745291; cv=none; b=YUtVligGB+p/e586pysoTHz4QYeyTVq4Mc9mAXqUfkK0vsCkL1qu1A0Zwf1hd+5Kgo+d+AMZr6Vi+OkKa+eXoxMJcel2K7qFPwWOe12YNvfJ8IRpsVD0B2HmlBwVcTBFwLt6Q51uWt2UPOgnGbr9VSmGwS1H1boEqdjYYFUIPvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745291; c=relaxed/simple;
	bh=qYREvZ+LggU8fvv/4zmFhu42g7A+zKsUw6vrqFkd+Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCS2cKPKSJrvuNG2b2nnsXm9N7E3Rpszb0PLxqpiQNQqBqkjLQ6oukFiyI/sbMImWe/XTX1+xeaeAtsHykyipBpKF7jZlVyyzbamuVt13fmp6nropJq2Cfi8d3mlXnY+2aadoYwRYwzkeAgatELSrjcLW2Bxikn0i84ohVYwt6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CS+Z681C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NyO/Ccjg0V25K910aLrhbKBFCNAh9eQL0Kb1R0OHdJI=; b=CS+Z681CMFiCiL95IdoHxSLTLZ
	Jbelf9nGBE71qzTr9rVtQNiFrTYrvC4MAOHAIqcCcDFOgXGRfnAI4oY8jrB1vgy5kvVngAUa39G8i
	9o2Mb1cYuCHJmKNFhMcEEOiysfaus3i0SgPoWdJ9NrAEV7IrmYlO0y8UJrBVPHb64lAk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uovXo-005Ozx-T0; Thu, 21 Aug 2025 05:00:52 +0200
Date: Thu, 21 Aug 2025 05:00:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] net: rnpgbe: Add build support for rnpgbe
Message-ID: <7102c84e-711c-4380-8564-1f1fe65720f0@lunn.ch>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-2-dong100@mucse.com>
 <7696f764-7046-4967-813e-5a14557b9711@lunn.ch>
 <8DE9B7420E7CCA57+20250821012949.GA1742451@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8DE9B7420E7CCA57+20250821012949.GA1742451@nic-Precision-5820-Tower>

> Ok, I will improve it.
> By the way, if I want to add some functions(maybe workqueue to handle
> link status, or debugfs for the driver) in the future. The function is
> only one for driver, not each for every pci device, should I turn back to
> 'module_exit' and 'module_init'?
> Maybe workqueue can use 'system_power_efficient_wq' just like libwx
> does? 

Generally, you don't have per driver data, only per device data. It
makes the locking simpler, and handling bind/unbind etc.

	Andrew

