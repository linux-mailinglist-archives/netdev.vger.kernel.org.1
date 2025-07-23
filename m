Return-Path: <netdev+bounces-209338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAB8B0F473
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7261622EF
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A212E7F06;
	Wed, 23 Jul 2025 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqG+yF9v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F12E6114;
	Wed, 23 Jul 2025 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278543; cv=none; b=fl9tvnX7NHNWMHcsLb7KtVXI3a6hf3GjbuDNk/bAAj9uECarCbzVEHV2bluUFLlhb0s6HXSYsRCIp32S+JG43H9Gsd68T0rSnvuBbm1VZEq3GMKinZA/XoWi2nWRXcNa9lq0ml3q+6c5EjXa86b0yAlCJkBir6ULXp1vD9w1qVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278543; c=relaxed/simple;
	bh=gpofvUdCvafEi9/Yz7WQuqJNoF8dDZ2uzd6/+Lg4OuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tF0gTbrf8lbr41Ps6Zw4+lRRYkns+V8fMXdiaZVUXIroVS+kRCevXKIAFS/tNXLHFwuSuUkS2CoZUuO8wXGymxDXTXTgkuw0DoxBIJUJicU+3ICauZseMmsvfZ5zkQmxPx8ZFHc4fqsvjLU2uZEzJi58UlAhbXrC4AxO11G5Hks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqG+yF9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F177C4CEE7;
	Wed, 23 Jul 2025 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753278543;
	bh=gpofvUdCvafEi9/Yz7WQuqJNoF8dDZ2uzd6/+Lg4OuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eqG+yF9vGnyPwsKROpDhc4vfaUIwMNG9rE6vCOfRZVVpYeEE2bUgWTYDUlJOi99MA
	 +EBJt3gVHRkRBksLk+Lje0BQC5Ua1wtHXeKtWLK8LtqCvl55M9bBHXtu3TiYReajNa
	 f6RaOgTW6k3KEGmidaDlRwc7biL2cF94l/CbwSfQMo2dl7fbfEDIf/JzO41V3zHTg8
	 CCjmuzrn4jhTgA/QpGfQWCyjsJHo464cpB4tGF15NDc4b+K3kXcYDHDdshUfiUNWhw
	 dmBimZQ8TDdYTJH3h0DUzHOIem1prD3+ipds1isrmNp2ngbxhRaZe8bzdn60Gt7R2x
	 uxlaHyrY2zwlw==
Date: Wed, 23 Jul 2025 06:49:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>, Julia Lawall
 <Julia.Lawall@inria.fr>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Mengyuan Lou <mengyuanlou@net-swift.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Fan Gong <gongfan1@huawei.com>, Lee Trager <lee@trager.us>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, cocci@inria.fr, Nicolas Palix
 <nicolas.palix@imag.fr>
Subject: Re: [PATCH net-next 1/5] net: rpmsg-eth: Add Documentation for
 RPMSG-ETH Driver
Message-ID: <20250723064901.0b7ec997@kernel.org>
In-Reply-To: <20250723080322.3047826-2-danishanwar@ti.com>
References: <20250723080322.3047826-1-danishanwar@ti.com>
	<20250723080322.3047826-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 13:33:18 +0530 MD Danish Anwar wrote:
> +   - Vendors must ensure the magic number matches the value expected by the
> +     Linux driver (see the `RPMSG_ETH_SHM_MAGIC_NUM` macro in the driver
> +     source).

For some reason this trips up make coccicheck:

EXN: Failure("unexpected paren order") in /home/cocci/testing/Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst

If I replace the brackets with a comma it works:

   - Vendors must ensure the magic number matches the value expected by the
     Linux driver, see the `RPMSG_ETH_SHM_MAGIC_NUM` macro in the driver
     source.

Could you make that change in the next revision to avoid the problem?

Julia, is there an easy way to make coccinelle ignore files which
don't end with .c or .h when using --use-patch-diff ?
-- 
pw-bot: cr

