Return-Path: <netdev+bounces-216041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4C1B31AC5
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5587F18852AA
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEB43126D7;
	Fri, 22 Aug 2025 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkOPw/WH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030E23126C3;
	Fri, 22 Aug 2025 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871220; cv=none; b=KBjlqEfX9PSDN5MUH18b5dlKCVpACPeHDFIGy7qhPCXTO53QMqEK9LuEw6lmPv9HY8cU0LsTK7W9YHwD1ope0MRtl93WiF2sDi5HMXagOQ5uOtD2mmK07f+b4swRg9ClBFwBiexgs8qguy9r4nW56kPXo2fYpLB2ugpxNRRpecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871220; c=relaxed/simple;
	bh=NhcqNJcEWkTWGz8ovLpQi/hjQY3as5SmrOYUySgeg2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tssaeIDQcU/6ZrYYcKiRgxKs2gKhWuEwhmPsP6/jX7tpqrY4VhCGkIDLqrb//XNlrXvmtzvfevbDzcqv5ow0LhSr4PM7JQDcDkWQlPLJoPkPFNbecJgWpRbOtAzFoImfzFKSaRgnmfN+EKxqwXUUVFH9GfgR6sSmq6CYeg2lCRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkOPw/WH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A0DC4CEED;
	Fri, 22 Aug 2025 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871219;
	bh=NhcqNJcEWkTWGz8ovLpQi/hjQY3as5SmrOYUySgeg2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pkOPw/WHe5B9a4j3FhXTTUyx/m4orDiZW+owegOeFJg3JhJTsM/i/35kfS2vO1ujh
	 i6vIKqxsz4hm02PfMUhJK6hKGbg4TBRldoCfDxzZJjZSoP1pbeGshY+mwMbolz612G
	 W3jH/tu707bGd5eT0GLly11JcMATjFRVYt7U2FT5MW21iGAIulz+piRLK10Hb6+Dje
	 zma9YLw9ntGnz/zU6iWzEp3CVo1MvOttpOV4jDw0rlUzKeeWihIr2aG42kyBc8QEuG
	 Bq73EDU+U0BxDy9V8+uW+4eboZ+DnYkj/XYoPQepHoH1NOXVpc2yjAKo2M1FhyWsjA
	 4rA4pDSw/WfBg==
Date: Fri, 22 Aug 2025 07:00:18 -0700
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
Message-ID: <20250822070018.35692c26@kernel.org>
In-Reply-To: <0f391b0a-6e9d-4581-9f3a-48e67ea90b31@altera.com>
References: <20250816-xgmac-minor-fixes-v2-0-699552cf8a7f@altera.com>
	<20250816-xgmac-minor-fixes-v2-3-699552cf8a7f@altera.com>
	<20250819182207.5d7b2faa@kernel.org>
	<22947f6b-03f3-4ee5-974b-aa4912ea37a3@altera.com>
	<20250820085446.61c50069@kernel.org>
	<20250820085652.5e4aa8cf@kernel.org>
	<feb15456-2a16-4323-9d69-16aa842603f2@altera.com>
	<20250821071739.2e05316a@kernel.org>
	<0f391b0a-6e9d-4581-9f3a-48e67ea90b31@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 18:19:01 +0530 G Thomas, Rohan wrote:
> On 8/21/2025 7:47 PM, Jakub Kicinski wrote:
> >> Currently, in the stmmac driver, even though tmo_request_checksum is not
> >> implemented, checksum offloading is still effectively enabled for AF_XDP
> >> frames, as CIC bit for tx desc are set, which implies checksum
> >> calculation and insertion by hardware for IP packets. So, I'm thinking
> >> it is better to keep it as false only for queues that do not support
> >> COE.  
> > Oh, so the device parses the packet and inserts the checksum whether
> > user asked for it or not? Damn, I guess it may indeed be too late
> > to fix, but that certainly_not_ how AF_XDP is supposed to work.
> > The frame should not be modified without user asking for it..  
> 
> Yes, I also agreed. But since not sure, currently any XDP applications
> are benefiting from hw checksum, I think it's more reasonable to keep
> csum flag as false only for queues that do not support COE, while
> maintaining current behavior for queues that do support it. Please let
> me know if you think otherwise.

Agreed.

