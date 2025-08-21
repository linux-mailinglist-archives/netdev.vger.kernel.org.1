Return-Path: <netdev+bounces-215645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB770B2FC53
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD741794A9
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D8026D4F1;
	Thu, 21 Aug 2025 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT2dFNMT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF926B761;
	Thu, 21 Aug 2025 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785861; cv=none; b=TXu1jqbDKbuA3EILCizOHmAMwJPl6YJvMXgZWTHkrdUIIccjEMFK0z+2oozPrIcjZOcUMLOvbl6ldRgNMsMUwyQNcPeYuUh1g2ojldB9cLIeZE8LP9j0WHtObGoeGqo3LEVZXTQVyIVTCoC8AAvs27o84cYJOvpA+YOkVRpMkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785861; c=relaxed/simple;
	bh=gW7zqHt7cuAakYbLK9BQKAYcDbTeaMYBUi5199VFuWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lr108co+fp5b1AkA15R8+Kfoe8NZTat2nyRpuoKTI1TbPWABwKuE8bBo7ABz9H9TWsEWu+OMv0I6uR0u1mu/KvwfHCHCrmuTcoVVMeTZ9fw3lCkUs9HqPb/bE4MImFTKmBaZPgqi+LFhk3cehuNfUwvCac71FBkuaXrqiooawuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT2dFNMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186A6C4CEEB;
	Thu, 21 Aug 2025 14:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755785860;
	bh=gW7zqHt7cuAakYbLK9BQKAYcDbTeaMYBUi5199VFuWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nT2dFNMTdJafnR8SCtfTZ4mri3Lbf6Uobpr9VzI6B7WWWTWueKS2GpZsfOM4W5Nul
	 jI3GCEU11vPSdLCtvy/MjJMPT8dny8Rwe4zbyNeKnHr7WHKP5mK5SdOIcYajHvymgT
	 tW3YMrkNocdSeWpD4xypEwihTB9ldMoEaAKjOtBBSXxoRYrr1lsfkzqut+JG3kNJ4D
	 YLmM0mIA/lEam7fPLNtPjInCYoGmaIxE7K7Lgdf4UT4vwjb81vIbXKKc9u7722DLm5
	 x80sH/px/HKkEYCDcx1FDetplKayERaM+BZoFgVpNE8rFtH8FqIst1UYrvSwV0d0Bo
	 H/fk60AGBEorQ==
Date: Thu, 21 Aug 2025 07:17:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: Rohan G Thomas via B4 Relay
 <devnull+rohan.g.thomas.altera.com@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Serge Semin <fancer.lancer@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>, Jose Abreu
 <Jose.Abreu@synopsys.com>, Ong Boon Leong <boon.leong.ong@intel.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew
 Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: Set CIC bit only for TX
 queues with COE
Message-ID: <20250821071739.2e05316a@kernel.org>
In-Reply-To: <feb15456-2a16-4323-9d69-16aa842603f2@altera.com>
References: <20250816-xgmac-minor-fixes-v2-0-699552cf8a7f@altera.com>
	<20250816-xgmac-minor-fixes-v2-3-699552cf8a7f@altera.com>
	<20250819182207.5d7b2faa@kernel.org>
	<22947f6b-03f3-4ee5-974b-aa4912ea37a3@altera.com>
	<20250820085446.61c50069@kernel.org>
	<20250820085652.5e4aa8cf@kernel.org>
	<feb15456-2a16-4323-9d69-16aa842603f2@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 19:20:02 +0530 G Thomas, Rohan wrote:
> > To be clear -- this is just for context. I don't understand the details
> > of what the CIC bit controls, so the final decision is up to you.  
> 
> Currently, in the stmmac driver, even though tmo_request_checksum is not
> implemented, checksum offloading is still effectively enabled for AF_XDP
> frames, as CIC bit for tx desc are set, which implies checksum
> calculation and insertion by hardware for IP packets. So, I'm thinking
> it is better to keep it as false only for queues that do not support
> COE.

Oh, so the device parses the packet and inserts the checksum whether
user asked for it or not? Damn, I guess it may indeed be too late
to fix, but that certainly _not_ how AF_XDP is supposed to work.
The frame should not be modified without user asking for it..

