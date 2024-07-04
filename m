Return-Path: <netdev+bounces-109247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B5D927908
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627A11F21A42
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D69D1AED35;
	Thu,  4 Jul 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBktxjLn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12524182D8;
	Thu,  4 Jul 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104182; cv=none; b=H2AgIlw8qwoIFDU1T448uefSKC3sQOI0G1cYUYXusFaVGV1oPTmrpTG+Yv7EJKzpeG0bnFpv7Muvf+zlBC+Fo1HT6x1N+BVTyqNjcm4JcTDxX9g3oQLcWB+2LOPzTw5EGU3Qga47BVqEFxCMh8PrIIx4mZlKAJiPnTjORGokPOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104182; c=relaxed/simple;
	bh=zQpK9OBXROjgLoRLG7JDGGHdoYhGisETPta8xT2Jufk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBUgo1oqUMV7vN2MUCMSfJgc92b291sEJ/qpxUsrKtEspkWnQzrMjQYNt1kz5kfFOB37RPmOa/9/DoOIyGeqSo7qXlDm+FQr8JlcFbeaz0yfKjtS6wLK38RpkR1e1PNGeT01KJJ2AXc2kXRucHcQdOgD4g8hhRg5dOi5uBIGEgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBktxjLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453E1C3277B;
	Thu,  4 Jul 2024 14:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720104181;
	bh=zQpK9OBXROjgLoRLG7JDGGHdoYhGisETPta8xT2Jufk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XBktxjLncOLxCIa52EafJmxJX3nU3Cyg3moVRgHXsI/llE0Vzmgndr6NT5iokdVPb
	 NbTqGJhRbqpLr+9+LS2XpOQB63FoASjc3TXTKoAsnHc0MAhukfXIB3e48Td/Gquzkc
	 yRxbjLYjqYA7K2BcCCOX4/ezgUZDNhVArNWecn/79mjUGsFKWUKLqxAm9JeDNYBhxc
	 0y+7EaT9TECmLhK2uSx/efnyzuSZ50uRNqM9HgfHxNmDXzKJmyIwvT2oraEpKBk/xZ
	 VAc+sIVGUy+gEXJxE7lR1IoIYG/ofqbkM08g3t5bP4uWaaI95bt+cUfY5VP409VoNQ
	 KuDhFDfVQVMOg==
Message-ID: <ae1447c3-6e91-410f-9a3b-142e4da5f6d8@kernel.org>
Date: Thu, 4 Jul 2024 17:42:56 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] net: ti: icss-iep: constify struct regmap_config
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 MD Danish Anwar <danishanwar@ti.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240703-net-const-regmap-v1-0-ff4aeceda02c@gmail.com>
 <20240703-net-const-regmap-v1-2-ff4aeceda02c@gmail.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240703-net-const-regmap-v1-2-ff4aeceda02c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/07/2024 00:46, Javier Carrasco wrote:
> `am654_icss_iep_regmap_config` is only assigned to a pointer that passes
> the data as read-only.
> 
> Add the const modifier to the struct and pointer to move the data to a
> read-only section.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

