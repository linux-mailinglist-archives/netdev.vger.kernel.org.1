Return-Path: <netdev+bounces-224197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F80B822B3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 00:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7A01C80F91
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 22:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAE930E85C;
	Wed, 17 Sep 2025 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLbGShqM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B102FB991;
	Wed, 17 Sep 2025 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148428; cv=none; b=b56jUnAUQWZWLVSSqvp6NsqOx1hf1P4mdXwMM5xLIxZHcoOnqFRkpP6xxKgzWie+RTwPlaV3lsDkCUy1c/c2Z2y7zdUScFMRx4T7MVUSfCI312BBqYxj0NmiwdEzSY05b0rQ5PwWYF9JGNp7yh/tMObIssdKzNnHb2hIpYbJXqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148428; c=relaxed/simple;
	bh=AeEOjTrTrYWvH72UFkbwWuavt/5qgvpD1SHmR09SsvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFx3OGbKkhK8/HLTDbPhBxSh9OxGrTyrbnTSfczprHFFwI6beA5/f09aSszR2Tu6hzbi8zAdP1G3l4+zr7UzcGvqNcCJ4xusNukZ7vuHCFCfIcBbtYz24yUHQXKbmEuPV6A5mcFwEHojghiP2eGwOVemkL4OKK1pJEtGqcxQAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLbGShqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7A8C4CEE7;
	Wed, 17 Sep 2025 22:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758148426;
	bh=AeEOjTrTrYWvH72UFkbwWuavt/5qgvpD1SHmR09SsvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gLbGShqM98jOqHm37oS4ubwyuBbGytiQBlkfN3FynWD6yumF43D+pnm2kKZ7pCclt
	 L3+yryrCXLitIEL+LQQzQXcg0zncYegJFkrruDRnkAm56i6RUvUxq3OX2OdjMCQP1q
	 /TIU3srcNNwYP0vjJL8m4KMlX2ZhavisMnYA0jfP/Gg8UxSO88nGulQ1K+f+2N0Ilf
	 6rYYWhRTBPb5vaauZvJj4yyxrKUuzoYsdBIHlCbiPcCnebtEyLgELq2ZSQ7KxsO81j
	 4Qlesy9hz/aaOiRKnTJqsm2ZCw/v1xB6klS1LNPXYQKW2rzoa1Zz2oby/gXP4ZSo2I
	 JQBJizKO/7Ssg==
Date: Wed, 17 Sep 2025 15:33:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rohan G Thomas via B4 Relay
 <devnull+rohan.g.thomas.altera.com@kernel.org>
Cc: rohan.g.thomas@altera.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew
 Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next v2] net: stmmac: est: Drop frames causing HLBS
 error
Message-ID: <20250917153345.27598d55@kernel.org>
In-Reply-To: <20250915-hlbs_2-v2-1-27266b2afdd9@altera.com>
References: <20250915-hlbs_2-v2-1-27266b2afdd9@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 16:22:14 +0800 Rohan G Thomas via B4 Relay wrote:
> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> Drop those frames causing HLBS error to avoid HLBS interrupt
> flooding and netdev watchdog timeouts due to blocked packets.
> Also add HLBS frame drops to taprio stats.

I think these should be two separate commits.

Also are the HLBS and DFBS acronyms obvious to everyone who works 
on TSN? 
-- 
pw-bot: cr

