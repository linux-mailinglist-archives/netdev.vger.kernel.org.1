Return-Path: <netdev+bounces-215083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BBEB2D14F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A744D2A3A51
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 01:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CFC19F111;
	Wed, 20 Aug 2025 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG2aM9mg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B5B19E7D1;
	Wed, 20 Aug 2025 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755652833; cv=none; b=ksZMYd4O1GmsT+o8uhpg0TY8awknPAtmqUPjHMgjjOyAP3hoizWdrjHE2wPxi0o5VdV0nj+eABpd6zbiHjeb9wMDLjhraX7zNX7sFKJY5lvI3Qa9AYa3FtRNSRhWGQHHVjD0LwzTfX8gWTLbDWqt8T8pPJTc9xsuN4xLVirdhws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755652833; c=relaxed/simple;
	bh=Mt3tseJjycqq+91W06SzoBlKRR5su31bUW3zAc7vzWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTCQZxW25Idsz6SCsZEJKLSu0Em3/7v7LMeD/XTTPK+XoVPhHhOa/cNqMpkNOU2+pEcVGOqFiewAw6onko/2PmY7hvtVZI1ILdZ6T8UMgTLGVJPcYBGh/mJsVWuqVs2wYB+S5H1LQZGSgB4/54BUz+lA09xPfz+6K5s1q34IBkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG2aM9mg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A1DC4CEF1;
	Wed, 20 Aug 2025 01:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755652833;
	bh=Mt3tseJjycqq+91W06SzoBlKRR5su31bUW3zAc7vzWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HG2aM9mgicAGjOvLZDbZfHKUAi9cNYbGj4HLb/kIR4spjkfhmeEqbz8R5OZecCN40
	 DQj+zgYEHuZMtlJo4dppMQgsQDopEZ0gZvoY5ha5HCZuezwR24gZVf9hWSV7FUWWW2
	 oXRjm8WIx3SLQ6n1/lRMu3hM+V+yyqa4eVbyRxPzXL8gHbrotIfQT8pv6Je7oKSbmV
	 JlUjPY8QvkAyYc4LPmKWtD2qNT1NmPUD17fiP5QMU1d+WBqZVFN5ApgHZ4Cyh482R+
	 y6B5SE1c9S2tzDQvqgBkfMzi+WxdLA5vuf98vmQad0kbTz6MduOgEcuZCuGFwkrfkY
	 5PeJ/4J1hM9Wg==
Date: Tue, 19 Aug 2025 18:20:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rohan G Thomas via B4 Relay
 <devnull+rohan.g.thomas.altera.com@kernel.org>
Cc: rohan.g.thomas@altera.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Serge Semin
 <fancer.lancer@gmail.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, Ong Boon Leong
 <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew
 Gerlach <matthew.gerlach@altera.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 0/3] net: stmmac: xgmac: Minor fixes
Message-ID: <20250819182031.58becfe7@kernel.org>
In-Reply-To: <20250816-xgmac-minor-fixes-v2-0-699552cf8a7f@altera.com>
References: <20250816-xgmac-minor-fixes-v2-0-699552cf8a7f@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Aug 2025 00:55:22 +0800 Rohan G Thomas via B4 Relay wrote:
> Subject: [PATCH net-next v2 0/3] net: stmmac: xgmac: Minor fixes

I left one nit, when you repost please use [PATCH net] rather than
net-next as these will go to the net tree, and 6.17-rc3. Rather
than net-next and therefore 6.18.

