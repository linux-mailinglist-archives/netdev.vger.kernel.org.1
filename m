Return-Path: <netdev+bounces-14140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ADF73F30F
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 05:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3AA280F6F
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 03:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF7BEBF;
	Tue, 27 Jun 2023 03:57:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB26EA1
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 03:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62906C433C8;
	Tue, 27 Jun 2023 03:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687838221;
	bh=lbqCvYJZh8SNnzJHRVkGMjw86NGTJnfT4uBpXp3TsMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UJRyf34z65RZchlmGj5kDLX8/xIFZBl4JuqPoaOeWL3HrkrpHeHhzo2SM0uFY8819
	 GIz1SX8wvhzxCsMcDeVkxIiYg22Ey/z/cMXAaxgdldvW/JyWu64/GS1IYm+v3M1fsn
	 IQSB9aQjQyHzkCZa80cvDJ99znfCPmYcnrxj+dj/tuQ9ofL4jpaZbcotTfvyRIe9BZ
	 r2hpe5rpcJeqxDYyd5Wt5dc9OBaSMQYwQLXJljmEfBqY1jXv3ebhPZ/K4XN2t/FXal
	 WCE9hmCEAPs8OlQXGtXeA9DUE3a/p4mROkRBEehc0CKC+wzL0/ML++5E4Y7Q/Wgpj/
	 063J82HUmM7hQ==
Date: Mon, 26 Jun 2023 20:57:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <Tristram.Ha@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
 <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v4 net-next] net: phy: smsc: add WoL support to
 LAN8740/LAN8742 PHYs
Message-ID: <20230626205700.2ec4acc0@kernel.org>
In-Reply-To: <1687832250-2867-1-git-send-email-Tristram.Ha@microchip.com>
References: <1687832250-2867-1-git-send-email-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jun 2023 19:17:30 -0700 Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <Tristram.Ha@microchip.com>
> 
> Microchip LAN8740/LAN8742 PHYs support basic unicast, broadcast, and
> Magic Packet WoL.  They have one pattern filter matching up to 128 bytes
> of frame data, which can be used to implement ARP or multicast WoL.
> 
> ARP WoL matches any ARP frame with broadcast address.
> 
> Multicast WoL matches any multicast frame.
> 
> Signed-off-by: Tristram Ha <Tristram.Ha@microchip.com>

## Form letter - net-next-closed

The merge window for v6.5 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after July 10th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


