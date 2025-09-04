Return-Path: <netdev+bounces-219763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2849CB42E41
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43C21897183
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D1C1465B4;
	Thu,  4 Sep 2025 00:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSDO2SU4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E03A15D3
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 00:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945926; cv=none; b=Yth1wtBe9Ew+iLdymuC3mqHcsIYhnNCIVv+6GB4edNm1+d81Rya/twSEL6CpkQBJxfF+sRdVeMZyQuU5QqHvP1HmEk62pVV2ueAhiLmfsNrQN9E83B2aiI4jQac2ZBn/Ac3VxMp/VNI65WyT7vn2nMKVmDLZlA7S6hu4m1SFBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945926; c=relaxed/simple;
	bh=vNBrxYioIH6NH17+QE2EEh0a9ZdygTBpYzjwNaFeqHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7qFcqlGTu2DDxUvgaiAXg6qjMfTAmJHclBVTbeoY5pDmqp3w5riycS9fszOUEV7k0Xeu9eD2fS/cUMQk1yeAw6sbJeYdux3d7LvXG5cnrxx+ycc8ZOXoW0FPIHb+7JQmmu3Z6N1n8RpkTL/mv5NZhEbrmdl9JefilJI8MBYl7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSDO2SU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A708BC4CEE7;
	Thu,  4 Sep 2025 00:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756945926;
	bh=vNBrxYioIH6NH17+QE2EEh0a9ZdygTBpYzjwNaFeqHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rSDO2SU4+ZpZbvGYR2aTv5eOQrZZWMFALXfy5lPQO9M2axxWapKD8FbtcdaSrSwOI
	 /96W7fpkegWYepvtmbhzuPNaTLe49tc49F/5s+drN0pJcd0x7Df+wX37t/JByhxnCx
	 9e1LEALJjENlNSJTpW1Z+NOjiqpphZpH2FkF3OyVyLA/2NLidT1yjDVWobssOXCUEA
	 OjMOg73xzujfaw/e2G2byf4aupvejlEo2UIutNU51RwM/Rj7kO2uZzOSzCfUiq6+25
	 JKC1FZrNlmIrYH0C3QpJ431MalK6a5jI3ZiNecOrevGLgMqORY67NggG1Zxyn+IKTp
	 /IAn9d6f9JGEw==
Date: Wed, 3 Sep 2025 17:32:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, David Miller
 <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 net-next] net: phy: fixed_phy: remove link gpio
 support
Message-ID: <20250903173204.3ca4969e@kernel.org>
In-Reply-To: <230c1f83-6dac-484a-bc80-e62260e56e74@gmail.com>
References: <230c1f83-6dac-484a-bc80-e62260e56e74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Sep 2025 20:37:02 +0200 Heiner Kallweit wrote:
> The only user of fixed_phy gpio functionality was here:
> arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts
> Support for the switch on this board was migrated to phylink
> (DSA - mv88e6xxx) years ago, so the functionality is unused now.
> Therefore remove it.

Sorry if I'm mixing things up and misunderstanding.
There was a recent conversation regarding backward compat
with device trees. Was it related to this patch? Is the policy 
that we only care about in-tree device trees?
Would it make sense to document in the commit message?


