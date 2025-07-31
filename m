Return-Path: <netdev+bounces-211222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0ECB17375
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 16:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2567B1C247C7
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747C01A76D4;
	Thu, 31 Jul 2025 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Bzp5E1cU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC591AC88B
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973584; cv=none; b=iLcz183gD2uwJGxS9DUMECnW8lcHgWNS8b57oVYuKM9Nd8CXf9ZIb0xH6I48+EHuZRAdH5TExJQDyL7kSM8JemYJfDibJ7f8ATgIst9dPx5h4XVAGYvHz5CQRCm9ZZQi2xbz9JU75YeXOdUsvQu8ub7Vul+3MMwjXxL/aJCPryc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973584; c=relaxed/simple;
	bh=ZlUTEskPGG/kUfy3h3Vq31WGFInsyu/NaBo9Rb5ct3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3K7MCF+Yk148f2IlozVTZYc/dFZsVQ1LYdQlEDAjqa6sTlFWK6ARkuaE178RABC8LJPrvdZr95WSvBsUTJCAqWlVpEIjAC6p5A/yS05SpGcrKnNkXHFD1LTt2lSmLjg844KolZlEcNFla2ON2JnwCmBx2sMXw7Nf/0eu8DDvzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bzp5E1cU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hlM0dB8yb47JDk4czdoq1u0oRL4Jkv/Jn+2f+Y6ruiI=; b=Bzp5E1cU/nr0wPC2eMkkv5w8Sp
	pgz5XPolNMm5xooZ2YagM0JIlWVkbxXJ6bdY1xu3FN22RZH53VozQ4nB0kCxj9tjZvpRdfN05eVE/
	j/crKIMf+C0ifBYL56xkO7phRQpy7FvfeHoXcfLP215J8zi4GDZJhqkEEnaJkLLn/Gww=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uhUeH-003NdM-BO; Thu, 31 Jul 2025 16:52:49 +0200
Date: Thu, 31 Jul 2025 16:52:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: npu: Add missing MODULE_FIRMWARE macros
Message-ID: <1ef51e54-9ad1-4e98-aaba-63d493e22959@lunn.ch>
References: <20250731-airoha-npu-missing-module-firmware-v1-1-450c6cc50ce6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-airoha-npu-missing-module-firmware-v1-1-450c6cc50ce6@kernel.org>

On Thu, Jul 31, 2025 at 12:25:21PM +0200, Lorenzo Bianconi wrote:
> Introduce missing MODULE_FIRMWARE definitions for firmware autoload.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

If this is for net it needs a Fixes: tag.

    Andrew

---
pw-bot: cr

