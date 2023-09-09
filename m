Return-Path: <netdev+bounces-32686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571BB79954D
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 03:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E9C281B71
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 01:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A99F1101;
	Sat,  9 Sep 2023 01:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62457E5
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 01:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE70CC433C7;
	Sat,  9 Sep 2023 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694221827;
	bh=kML9hZ7IDaG4XktJeZe7x8+x5w4mrLeBCCe8e1QV/lA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aEY6pwn2Yeo9yuQW7sBAUzeurEYWQEbrf1TSbgln+HHTWG2SjmzWtPJWHaHU99PfG
	 1BLtxCba3iXLP+xbQMnKCeyxTW3DGV38psO0doZlALLot6WZQrHgVjPr0A/nX2aSar
	 4rgXfcrn0IGyPPCM4E04o9hO62JO06oAISyEMBma7xcryXYfRcNsX+nmtQ26/Gw+fe
	 AMmzV+Wh/Ld+j2+sJKSPVkaHZ26G1h+CSZgJI0tADDe+HUuxk9/LWAy6Kzw9zNjhKP
	 NMvEbS3Qz1JqlBcTo9LtxPyeffaLqkoYq3X3XFif28aWLJXAxL1Pg8bPGDEyKJjBoJ
	 s4JnLD6DaGwqg==
Date: Fri, 8 Sep 2023 18:10:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Maxim Mikityanskiy <maxtram95@gmail.com>, <netdev@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <kernel@axis.com>
Subject: Re: [PATCH net v2] net: stmmac: fix handling of zero coalescing
 tx-usecs
Message-ID: <20230908181025.5a38c4f5@kernel.org>
In-Reply-To: <20230907-stmmac-coaloff-v2-1-38ccfac548b9@axis.com>
References: <20230907-stmmac-coaloff-v2-1-38ccfac548b9@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Sep 2023 12:46:31 +0200 Vincent Whitchurch wrote:
> Setting ethtool -C eth0 tx-usecs 0 is supposed to disable the use of the
> coalescing timer but currently it gets programmed with zero delay
> instead.
> 
> Disable the use of the coalescing timer if tx-usecs is zero by
> preventing it from being restarted.  Note that to keep things simple we
> don't start/stop the timer when the coalescing settings are changed, but
> just let that happen on the next transmit or timer expiry.
> 
> Fixes: 8fce33317023 ("net: stmmac: Rework coalesce timer and fix multi-queue races")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Felix, good enough?

