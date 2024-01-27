Return-Path: <netdev+bounces-66377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9DE83EB44
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 06:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA871F24C04
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 05:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8CC13AE3;
	Sat, 27 Jan 2024 05:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laqQed0h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6AD134C3
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 05:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706332842; cv=none; b=QeIDfOu5NSNeXdtbkljR7s0UCN2R9FFB1NxpME1MZc9/2N2WYIZqa5gbYSnuVc+SFaPest+F9wnlDsbF39QcWlYaaue70KfEQwItPcNUpzuguWAAdRhAjE8W+0vx4/5dZ7MDArEeWVL/PJ4pOukLkPhhyY24x+J08qCBEDtUbEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706332842; c=relaxed/simple;
	bh=CGAdET7oUlfB8UFR06GHBXA7yrbknHNf/uWxRbl3NVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USQZkbW7WXF4wcZLOaIrstWeADpPpwzSQ/RytVbvW+/Zal8eGC70rBftcuf+H9WrN4qKfiJBD+tg46vPVdvfZSg69mGUPIfqgctgfxMxP472Dk1kSXYT5WnzwH13kdRKauVCDgFkktzVFC+9Y5QBrImqkGEpvlI1UWz3yrYYvfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laqQed0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D940C433C7;
	Sat, 27 Jan 2024 05:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706332841;
	bh=CGAdET7oUlfB8UFR06GHBXA7yrbknHNf/uWxRbl3NVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=laqQed0hYh2LG6iYNtH1n2dt37iOcdov+Mm9kzUyQ/M1fzATG+yk4v/Lx7lT9wflm
	 nqJYxf2E8d3StzcsbF8uB1nCH7NcfQK7s4V6K/Ja5IClrTciHYil44tWOSuHANxOAD
	 IsbPB9V+TWIMYfnrUbfjEgljuEnzZlQSiYSjkpQhVtNdDhopuRYBCyKOYxdWf/uj8s
	 7daihpGzd6OZxdkEni9gdNKydkZVspbvKIyIZWJT4QJpqcOFpRuzZ5CyW8OBcQCO/E
	 bO0fWNaIsaWaLztoSOltW2C412oiHn1ajOK/iMt3aS9x/K9nhENrlfbpvv0SmKiMyW
	 VatCHw+tJYRHQ==
Date: Fri, 26 Jan 2024 21:20:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux
 <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 4/6] ethtool: add suffix _u32 to legacy
 bitmap members of struct ethtool_keee
Message-ID: <20240126212040.0fe28d88@kernel.org>
In-Reply-To: <e6ec45ea-0bfe-48f5-8169-a34e070732cb@gmail.com>
References: <c28077f6-74e2-42fc-b57e-9545816cc813@gmail.com>
	<e6ec45ea-0bfe-48f5-8169-a34e070732cb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 23:15:33 +0100 Heiner Kallweit wrote:
> This is in preparation of using the existing names for linkmode
> bitmaps.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

missed some?

drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c:719:30: error: no member named 'supported' in 'struct ethtool_keee'
  719 |                 eee->advertised_u32 = eee->supported;
      |                                       ~~~  ^
-- 
pw-bot: cr

