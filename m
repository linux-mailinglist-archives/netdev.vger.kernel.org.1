Return-Path: <netdev+bounces-137803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31739A9E4F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1911F22F5A
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510AB196C6C;
	Tue, 22 Oct 2024 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eN26kzNp"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883E912D75C;
	Tue, 22 Oct 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588781; cv=none; b=ijdxIFNSnod3t8sdDROymUcS/Y6Y5pOBuQzSDnaMN9bZWJjYKKXZcT9c6sdJrTpJ3dVewd+6nsuYD8yHZY2GRLKAfY467R/5R1nsGJFVyAflwLw/AyfKGWxBmO7AU8aaKMQIObJhT6p0nACqKMSkLzEKvavIUV5dsJ3wBF6wQOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588781; c=relaxed/simple;
	bh=1wQKnHb4F4y1RVrRIF7g0Pf31juqwfn3EgZdq2eOGc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4VuFF12L5MPiC2POh0zfGuhX0+2153ZjkxwrNlccmHQ/H9qCQqOXRYIh6feTnoA8iH65CEB+V0Ik3MdUOafDnhPa6ptrYy5D8IZpvruHAb9XAlMC5HCn0VqmS/EgDpT2Cbp4P4zWu41Z2xLJfNjaSCrLEdx2uX6mPis8CB0vWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eN26kzNp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729588771;
	bh=1wQKnHb4F4y1RVrRIF7g0Pf31juqwfn3EgZdq2eOGc0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eN26kzNpdfc25Jy/UzCLs4/5XKOePbwCcKMDBpWh9ssklSqmMzilnM/XtikdDqIBg
	 SEaVq8tWlAoE62RkvytYS3/F6gdUpiWagTqGflu5F8mHqF35BD3wQsY9hjOFca9n2f
	 PMBssXq16jFiLKbo1lAo6e02xZ3QVU3S9LWtu+Wh+Ev2Ag0/nEousOVgWqLC2J2h/t
	 alSJHyP+zWb36KTeMRV9mJ6qbe58Ro4DXcNCL335L+87BgrBQffci86dM/nrpNIYNb
	 i7QT4Ohu60po5tcestdayCijLBfHmxSwRQvJE8yHhdzw7xM6Ti3O8DoiCCDQdbgyrr
	 A0716m8jATsKA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0EB8217E120B;
	Tue, 22 Oct 2024 11:19:31 +0200 (CEST)
Message-ID: <99acb58d-a49a-4ad0-a4ec-f2b7c4f846fb@collabora.com>
Date: Tue, 22 Oct 2024 11:19:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Enable Ethernet on the Genio 700 EVK board
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Jianguo Zhang <jianguo.zhang@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Hsuan-Yu Lin <shane.lin@canonical.com>, Pablo Sun <pablo.sun@mediatek.com>,
 fanyi zhang <fanyi.zhang@mediatek.com>
References: <20241018-genio700-eth-v2-0-f3c73b85507b@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241018-genio700-eth-v2-0-f3c73b85507b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/10/24 17:19, Nícolas F. R. A. Prado ha scritto:
> The patches in this series add the ethernet node on mt8188 and enable it
> on the Genio 700 EVK board.
> 
> The changes were picked up from the downstream branch at
> https://git.launchpad.net/~canonical-kernel/ubuntu/+source/linux-mtk/+git/jammy,
> cleaned up and split into two commits.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Changes in v2:
> - Moved mdio bus to mt8188.dtsi
> - Changed phy-mode: rgmii-rxid -> rgmii-id
> - Removed mediatek,tx-delay-ps
> - style: Reordered vendor properties alphabetically
> - style: Used fewer lines for clock-names
> - Fixed typo in commit message: 1000 Gbps -> 1000 Mbps
> - Link to v1: https://lore.kernel.org/r/20241015-genio700-eth-v1-0-16a1c9738cf4@collabora.com
> 
> [...]
Applied to v6.12-next/dts64, thanks!

Cheers,
Angelo

