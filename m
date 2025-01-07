Return-Path: <netdev+bounces-155896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1595A043BD
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563D01885C5A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAE31F1921;
	Tue,  7 Jan 2025 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFgkX8vz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8C51AD3E0
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262484; cv=none; b=NFyb4XL0/YB1ekoG1++t8Mej35qMZ5iFz+w5bGwbCiSV+Yrz5YH/9fYwdXvx/WIim7KGTmzVHEce1lyKBJKOOSPj15ilqbp2svcY36n+01ftRxICubPlF5+UJynpA3fTNPeOHC+ERTcsdfbseBkP+cWMCXZwI+FFpHOWSw+xEHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262484; c=relaxed/simple;
	bh=zGOMgWciIr/pBmb3fIksdi8vslvxL+ARAfpEC/eug/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8OC8q/2O6JFP7wv7IEByMMtICbrYQEOkI+Wa1x1Ii9pC96VZLyAla5egJzrj5q/duZek6lZH7wqDPnBoFFaaLQIKdF5LLzwqE6xuoIEwsI/PKcM0TSdHayw9FfzkqjwtTDNdEsSK6MSil7fm4fUq1tncEU5YFn5WOe8DA74vGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFgkX8vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BA5C4CED6;
	Tue,  7 Jan 2025 15:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736262483;
	bh=zGOMgWciIr/pBmb3fIksdi8vslvxL+ARAfpEC/eug/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QFgkX8vzo88Pe9VHbS9153Gh9Uw8S51n9auUk+L3xplNt4FeLfOfeI1FXlK4QC7pA
	 RJsiWfki251JBchm45L5qa5FT+fsHBHnarvXk2iV50y/TgulIGULMBmNjIhic8+pAM
	 +RBFPLTP0CjvGFOfNBtEvqRX4/CTaQwKwpILLxBpECl318aWKJAe9uDpc4A/OxDimR
	 rOsJsReSOZ1TVsPJlopqQf8R5S0J8kmlmYRZTTdgi3eyl9w6Ja5wkkQ2sShRSsqqCT
	 lN6AmxjGiEOpNI7C+9kWtUBf8cZWP6YvrPFYsSUTGy1w7G7VdtRc5WKB3Fm/pooZ3/
	 zoKu2sTN8Ob9A==
Date: Tue, 7 Jan 2025 07:08:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <Woojung.Huh@microchip.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <Thangaraj.S@microchip.com>,
 <Rengarajan.S@microchip.com>
Subject: Re: [PATCH net 2/8] MAINTAINERS: mark Microchip LAN78xx as Orphan
Message-ID: <20250107070802.1326e74a@kernel.org>
In-Reply-To: <BL0PR11MB29136D1F91BBC69E985BFBD6E7112@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20250106165404.1832481-1-kuba@kernel.org>
	<20250106165404.1832481-3-kuba@kernel.org>
	<BL0PR11MB29136D1F91BBC69E985BFBD6E7112@BL0PR11MB2913.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 14:14:56 +0000 Woojung.Huh@microchip.com wrote:
> Surely, they should involve more on patches and earn credits, but
> Thangaraj Samynathan <Thangaraj.S@microchip.com> and 
> Rengarajan S <Rengarajan.S@microchip.com> are going to take care LAN78xx
> from Microchip.

I can add them, I need to respin the series, anyway.

