Return-Path: <netdev+bounces-38052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4AE7B8C5F
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 26F6C1C20845
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 19:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBEE21A00;
	Wed,  4 Oct 2023 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+CFVr0v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3281B29D
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 19:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4041AC433C7;
	Wed,  4 Oct 2023 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696447217;
	bh=Z6f+ph1QyRpOMr1kPPcopjUoPxOl0nIiVIhrZ8RuMUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F+CFVr0vgd5vx17Trp5BZsr4W0E05tuw8MXQbIFJKMC/eYOwsExwe1aJMSGpItffo
	 ymd1V8eFZa1plyKPBblOYSuK7IrDNJn53rHRHxD6voYsauAOCz7SvIiBhpuH60hyCf
	 obsTqdBwhTfnMK9oAALcn1zWPuWkEkcQ8fxbkchWuabo4w/Rk2EKBidR0fP0hKzv+c
	 lUKAtery5Yp1Yhywv86wkt52UHyfO8ZjIQBnRmJY93TLlgG3gn6bDgYEey+X9R3PYx
	 dsVewleJRNNSX2F6+xt0V/i/0dcq37Ji9+oBIEitfFFzRAoVv4bEelNVBROe0lM68o
	 OZ5UQs/RK8/8g==
Date: Wed, 4 Oct 2023 12:20:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vishvambar Panth S <vishvambarpanth.s@microchip.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew@lunn.ch>
Subject: Re: [PATCH net] net: microchip: lan743x : bidirectional throughuput
 improvement
Message-ID: <20231004122016.76b403f0@kernel.org>
In-Reply-To: <20230927111623.9966-1-vishvambarpanth.s@microchip.com>
References: <20230927111623.9966-1-vishvambarpanth.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Sep 2023 16:46:23 +0530 Vishvambar Panth S wrote:
> The LAN743x/PCI11xxx DMA descriptors are always 4 dwords long, but the
> device supports placing the descriptors in memory back to back or
> reserving space in between them using its DMA_DESCRIPTOR_SPACE (DSPACE)
> configurable hardware setting. Currently DSPACE is unnecessarily set to
> match the host's L1 cache line size, resulting in space reserved in
> between descriptors in most platforms and causing a suboptimal behavior
> (single PCIe Mem transaction per descriptor). By changing the setting
> to DSPACE=16 many descriptors can be packed in a single PCIe Mem
> transaction resulting in a massive performance improvement in
> bidirectional tests without any negative effects.
> Tested and verified improvements on x64 PC and several ARM platforms
> (typical data below)

Nobody complained for 5 years, and it's not a regression.
Let's not treat this as a fix, please repost without the Fixes tag for
net-next.
-- 
pw-bot: cr

