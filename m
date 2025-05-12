Return-Path: <netdev+bounces-189790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DDFAB3BED
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A53B189EA37
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC6C22A7EB;
	Mon, 12 May 2025 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY74upwZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110551DE8A6;
	Mon, 12 May 2025 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747063390; cv=none; b=IwyJusQq6DSd/FDkX7g7uXsKmQtK/czBnDlqdwye9Hh6SgwydwFuYq7u55bNi7YR+2MZBX/402uujl/FTd3hLbYs4NRxxnbEDuSjVYAHKonAbrZpjiUpnU7UZM+t3xQwuTYQv6OgbyzKmWF8nBggLBIaNqJcXsCKM/c5EE42IIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747063390; c=relaxed/simple;
	bh=bTluUh+XxqovVbRY+Sbpmqom/EmKfFvjwLJ8AnpA5YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lq7Iby1o5+w2yoBUzMu+PKKA4qsHUcg+YVA9YktlEndH1hdMmHx29r1UAnjUb0A6rwXMb3jGZWubi0N49NTYWT3FWep2I0h4sUyyHQAnHGiiCCHW580HjxTOLWXvVeh1xdT9RxpOQJVF2M6jkxStBxEA+8iSLxHjZKePSJxGYlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iY74upwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397C8C4CEE7;
	Mon, 12 May 2025 15:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747063389;
	bh=bTluUh+XxqovVbRY+Sbpmqom/EmKfFvjwLJ8AnpA5YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iY74upwZEVgnMWkd6DFuihA0PhEb03hzXLjWuL6d6mEXu5y2mDo8EZyjD2jy+9w+Q
	 2pb1yePe6EczYRs2HXQKPr9ElYKqReLG9dbeDJYfd0y8njYBizl3TOmHtEWya6v6MC
	 eM5hBveawqia8ow+DPKHr84/PfOvxFgMH/HI/BX/6bsECCREbU7YBgxsdtg1al7fZe
	 r08yz0Q8gq4i1bnie8vmGLBcbk4f9mzmnUxNk6kt/SPkxwqT0i0oGTRb5qR976Bhsb
	 iiIb/v7kck8BDKVDdQXc1fmYd4wkAC1SRRAR4y83o5GM58UQtzMwwrDgLL5l79mWIu
	 LiMVwdvCOqCGA==
Date: Mon, 12 May 2025 10:23:07 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: diogo.ivo@siemens.com, rogerq@ti.com, conor+dt@kernel.org,
	richardcochran@gmail.com, devicetree@vger.kernel.org, srk@ti.com,
	basharath@couthit.com, pabeni@redhat.com, horms@kernel.org,
	linux-arm-kernel@lists.infradead.org, m-karicheri2@ti.com,
	rogerq@kernel.org, s-anna@ti.com, tony@atomide.com, kuba@kernel.org,
	pratheesh@ti.com, jacob.e.keller@intel.com, danishanwar@ti.com,
	netdev@vger.kernel.org, glaroque@baylibre.com,
	s.hauer@pengutronix.de, schnelle@linux.ibm.com, krzk+dt@kernel.org,
	afd@ti.com, rdunlap@infradead.org, edumazet@google.com,
	pmohan@couthit.com, ssantosh@kernel.org, andrew+netdev@lunn.ch,
	javier.carrasco.cruz@gmail.com, vigneshr@ti.com,
	krishna@couthit.com, linux-kernel@vger.kernel.org, nm@ti.com,
	m-malladi@ti.com, davem@davemloft.net, mohan@couthit.com,
	prajith@ti.com, praneeth@ti.com
Subject: Re: [PATCH net-next v7 01/11] dt-bindings: net: ti: Adds DUAL-EMAC
 mode support on PRU-ICSS2 for AM57xx, AM43xx and AM33xx SOCs
Message-ID: <174706338693.3372878.17398563182195678411.robh@kernel.org>
References: <20250503121107.1973888-1-parvathi@couthit.com>
 <20250503121107.1973888-2-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503121107.1973888-2-parvathi@couthit.com>


On Sat, 03 May 2025 17:40:57 +0530, Parvathi Pudi wrote:
> Documentation update for the newly added "pruss2_eth" device tree
> node and its dependencies along with compatibility for PRU-ICSS
> Industrial Ethernet Peripheral (IEP), PRU-ICSS Enhanced Capture
> (eCAP) peripheral and using YAML binding document for AM57xx SoCs.
> 
> Co-developed-by: Basharath Hussain Khaja <basharath@couthit.com>
> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> ---
>  .../devicetree/bindings/net/ti,icss-iep.yaml  |  10 +-
>  .../bindings/net/ti,icssm-prueth.yaml         | 233 ++++++++++++++++++
>  .../bindings/net/ti,pruss-ecap.yaml           |  32 +++
>  .../devicetree/bindings/soc/ti/ti,pruss.yaml  |   9 +
>  4 files changed, 281 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


