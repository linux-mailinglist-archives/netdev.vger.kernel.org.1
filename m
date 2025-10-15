Return-Path: <netdev+bounces-229656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2943BDF7DD
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 17:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A363AE998
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D7C323406;
	Wed, 15 Oct 2025 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaDWqTDS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51DB2D3755;
	Wed, 15 Oct 2025 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543687; cv=none; b=qVkzH3+ZED7v9yqSRTBlh93AuUjPQY2VtBIADXKoVXtVVaxBfnEwKCgUHNZNkckjLVV+tFIPBFSY10uP7+g8RPqNT8cphzz8XWRRC4kewizjeFO6JaDQGIUv9QndOFYmTgviFBjJkI100JF1KX/mzVvBNey3s+zts7zQU6Ccm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543687; c=relaxed/simple;
	bh=3Gm4tGlsOa8Zx34REOY2GFsAOIWAL2jmXbC0xdevdvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efKPwVV42/eRxH3FrJoQxjRFCMYtseDbRQemPSndo1TXeEZkz13iVekRflJlwf0wV/RXstQ6BDvOmb/VK8HuguLjxyN/0KnX7Ov3aVEovIRkkHLngCLKpmT5UmIcXk2Xl4j1PwZIpNOHRZJIx80NwJYBZcRoRnV5Qh5W4yvA6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaDWqTDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF501C4CEF8;
	Wed, 15 Oct 2025 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760543687;
	bh=3Gm4tGlsOa8Zx34REOY2GFsAOIWAL2jmXbC0xdevdvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KaDWqTDSd7SUVWENYTiRxcIxnRzoZ2bTFmLk4YnY3qGkm/yw+3tIP90tP55fqRoil
	 1CJYiJmAF5Ub5AhPuSlXvHIWKctoqfrpUsk7MFBBCM3AvUGNGKVZRL875EWu+XogG8
	 ojtCGeAqRe4vO+HPSCqRub3vJfVEvO6gGcyhBdqM2+gF+PYsG2HjEXIbvTmuVGFi4Q
	 WeDMuiquYDkT6xE1EsRoW3N84Azy1Yy8aC3TEbt1822FJXkI66MkuJrNrwzWlwgNdt
	 FNIjjK8CihdGs5VP1RT8ca6qnC/Y7fEwsaCH1BgqlQZ8qdol4LRLEIM2cP9nVGGUtH
	 UMCYLdm5Vr0cw==
Date: Wed, 15 Oct 2025 16:54:42 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] net: airoha: Select default ppe cpu port
 in airoha_dev_init()
Message-ID: <aO_Dwn9r_32-U72N@horms.kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
 <20251015-an7583-eth-support-v1-10-064855f05923@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-an7583-eth-support-v1-10-064855f05923@kernel.org>

On Wed, Oct 15, 2025 at 09:15:10AM +0200, Lorenzo Bianconi wrote:
> Select PPE default cpu port in airoha_dev_init routine.
> For PPE2 always use secondary cpu port. For PPE1 select cpu port
> according to the running QDMA.

Hi Lorenzo,

I think this could benefit from a few words around 'why?'.

> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

...

