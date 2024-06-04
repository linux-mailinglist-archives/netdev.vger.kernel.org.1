Return-Path: <netdev+bounces-100595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD078FB46B
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB101282C7E
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506A0D524;
	Tue,  4 Jun 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5cqBTk5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2436D63E;
	Tue,  4 Jun 2024 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509073; cv=none; b=R6uRDCrk1CIKyZoXe6ws58dDENfjj2L0w7ubRPa5PrmYUmGMdAg0ELe5PzaWl6xDzAr04iThJXTQjT6ZmC+/hzwy5d+9XUFecGoAEQJqlW6M2V+EAufJmfD9rGtxyPDtS1adog+DQvi9qWJBr8MaTadOeJMuMPYTMM8s7ADziM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509073; c=relaxed/simple;
	bh=6xWYDutldmMdcEkucQUkKgPmzAOHM4lh+zj5TzXtvmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EF/m/DmP9ImmNW2UdflPfi/mbyy8OFgraOJQM238YPfipX/mFH8qOnnpjvyuydRvjrMomcTZfVYNhNYX4VmBTa/CA1Ikyl2TUY2p9G9O1jcVljIDuQSHUIqLWphs/0mSiL47bUTKeqdEfnAjmgt7qX1//9eftoPNZGtRx9R1seQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5cqBTk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B2CC4AF09;
	Tue,  4 Jun 2024 13:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717509072;
	bh=6xWYDutldmMdcEkucQUkKgPmzAOHM4lh+zj5TzXtvmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a5cqBTk53wDuwp5jLOYMAT/95tu7fByNPys0vZYQCYJujVPoZwKQFBYy/MEJ/Eo43
	 InXyWgz0rLSRLNAEdKNy3oJL4EgJ4EZrqTSJff4vd6tflzndv0TMXmlRM3a1GfrH2I
	 DAA3ivw+YMIteKFMe7PuuLlmDBfgP4QiZLth5qXFyz3gXSfYg2y/84vfA11mr5L0zZ
	 lzNG91CbWM7D3ExQ1mXyNifoS//VJR9qHTju/N60bZlcl8sbbBzXANIJioO3/x27e9
	 eLfYOL9Bm2W8TneLUPHcFQ4/Kg3CYRjakLCdr2sc2OxPz3T12LUH7ywvcnutRls8DU
	 rVVwzB5HZrDJA==
Date: Tue, 4 Jun 2024 06:51:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christophe ROULLIER <christophe.roullier@foss.st.com>
Cc: Marek Vasut <marex@denx.de>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>,
 Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/11] ARM: dts: stm32: add ethernet1 and ethernet2
 support on stm32mp13
Message-ID: <20240604065110.462d01c0@kernel.org>
In-Reply-To: <c41e4379-d118-4182-8a7a-f6cf6c789be0@foss.st.com>
References: <20240603092757.71902-1-christophe.roullier@foss.st.com>
	<20240603092757.71902-9-christophe.roullier@foss.st.com>
	<e753d3fa-cdfd-426c-9e66-859a4897ec3b@denx.de>
	<c41e4379-d118-4182-8a7a-f6cf6c789be0@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 11:29:11 +0200 Christophe ROULLIER wrote:
> I prefer to push documentation YAML + glue + DT together, it goes 
> together, further more patch 11, it is also link to MP13 Ethernet, so 
> need to be in this serie.

Unfortunately what maintainers prefer is more important.

