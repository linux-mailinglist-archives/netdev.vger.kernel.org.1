Return-Path: <netdev+bounces-42346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B897CE615
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40435B20D87
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC963405C5;
	Wed, 18 Oct 2023 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nco4Zz3R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84CF3FE4F
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 18:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5926EC433C7;
	Wed, 18 Oct 2023 18:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697652968;
	bh=Ct9gR9nllChCdIfEvz/HYXItxKyJ157uTxTGorys+KY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nco4Zz3RCjMP2/4unO1zaVALBkrBBtB1bm2vkjdgz6OiCI5WdntbNLVDsSqfe3plb
	 uG1uKJPFqRSFpgT6hOC9UwwqGMHcueSf++oMDMp9WtdG+wB1rDdodLD/d3MCSdxwin
	 Up33Ui6lECUuOAntWYlX8uiTYeOJgycUZHJq2Lathd9OZiwFuELjedwOOQ5qaYf3pC
	 y4TytzyvBPFer72dXF7koBEl/zob4cRbYXOHPUrHg9B4oWhLctzWMrhTAqHF8/Viiy
	 fBXRquNpZsrGHLwOKuMHSAcdFh/HnUWlfcKkIAgIF+yu9tPgy9WbfPPJh1AMUR3s/R
	 XJwcB4Fs259uQ==
Date: Wed, 18 Oct 2023 11:16:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nishanth Menon <nm@ti.com>
Cc: Ravi Gunasekaran <r-gunasekaran@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <rogerq@ti.com>, <andrew@lunn.ch>,
 <f.fainelli@gmail.com>, <horms@kernel.org>, <linux-omap@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
 Thejasvi Konduru <t-konduru@ti.com>,
 <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: Fix the
 revision string for J721E
Message-ID: <20231018111606.4af0cdb3@kernel.org>
In-Reply-To: <20231018180035.saymfqwc2o3xpdf4@pretense>
References: <20231018140009.1725-1-r-gunasekaran@ti.com>
	<20231018154448.vlunpwbw67xeh4rj@unfasten>
	<20231018105236.347b2354@kernel.org>
	<20231018180035.saymfqwc2o3xpdf4@pretense>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 13:00:35 -0500 Nishanth Menon wrote:
> Thanks Jakub. SoC tree needs me to send based off rc1 for new features.
> I'd rather not mess with that.
> 
> Sure if we are doing an fixes pull, we can figure something out to
> sync. rc1 saves us the headache of conflict of me sending a PR merge
> while netdev maintainers aren't expecting it to be merged to master
> via soc tree.

Sounds good, I'll wait for Ravi to respond to you and once we have 
a green light we can plonk the patch on top of rc1.

