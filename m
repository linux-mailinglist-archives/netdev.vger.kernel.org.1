Return-Path: <netdev+bounces-15237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DCF746429
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 22:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A89F280ED3
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 20:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFB911C9B;
	Mon,  3 Jul 2023 20:33:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888ED11C84
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 20:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D274CC433CC;
	Mon,  3 Jul 2023 20:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688416437;
	bh=qg8LE55Eb5eQTL/7iZUZZnwLSbL18eGO83l+uTl/wTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nSt0gbtkjNVYR7WMHsuvkGTOLGmKAKUQk+paGFQsvXTryxi/NI6qMqVPxK2eh7LaW
	 HpNBxIW04g1n2iyU+K4ndVDmafmQaXNLWChN/SiaQJYDDx4QhySMSoA7TtQ4xase1I
	 fNd+0Gd919wHYzkyqmJAQTw+V5IDnoE/3E9ZOBY0Tzi7dzMojJScClKqfAa2yYrdbB
	 DRIG+flWrfBdxykMNDhhrb1pOWUd6ofO5VF3KMlnr5IdK8cHyjzPLuaR7AndNw7+dw
	 Z/p2v24gdYyoTvc43rY6sVemrq0u7qOf9HUwCDaZEghYAx40bCmA1qkpIDWPvkiQPk
	 fnVLFu/gNEG1g==
Date: Mon, 3 Jul 2023 13:33:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] Fix mangled link-local MAC DAs with SJA1105 DSA
Message-ID: <20230703133355.479c6651@kernel.org>
In-Reply-To: <20230629141453.1112919-1-vladimir.oltean@nxp.com>
References: <20230629141453.1112919-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jun 2023 17:14:51 +0300 Vladimir Oltean wrote:
> The SJA1105 hardware tagging protocol is weird and will put DSA
> information (source port, switch ID) in the MAC DA of the packets sent
> to the CPU, and then send some additional (meta) packets which contain
> the original bytes from the previous packet's MAC DA.
> 
> The tagging protocol driver contains logic to handle this, but the meta
> frames are optional functionality, and there are configurations when
> they aren't received (no PTP RX timestamping). Thus, the MAC DA from
> packets sent to the stack is not correct in all cases.
> 
> Also, during testing it was found that the MAC DA patching procedure was
> incorrect.
> 
> The investigation comes as a result of this discussion with Paolo:
> https://lore.kernel.org/netdev/f494387c8d55d9b1d5a3e88beedeeb448f2e6cc3.camel@redhat.com/

This series got eaten by vger, I think. Could you repost?

