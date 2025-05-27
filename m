Return-Path: <netdev+bounces-193742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B0AC5AA9
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 21:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A5A4A248F
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 19:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6085A2882CB;
	Tue, 27 May 2025 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C18Q4wxA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454812B93;
	Tue, 27 May 2025 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374106; cv=none; b=Qft1S7arPGsaCIvj1iG+MtDmwRNnehT+LPXc6GIkzLnjKckaEZi+9vgGSRneWL/Y4B80j3TiTBqCAkC6QqzbBDDJ8V/277BnJF4Z40KgLrPZkeJGyIgkXR5NV/fzVJPgglqOd8hT/YxUIKoOWzWcqJ9Kz6p1ifhU1Dq5Ji2RtcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374106; c=relaxed/simple;
	bh=ZcppwkkBkGHzfL/HojYzLOl4RCeHBYYQUV63DqSRucM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHR/nY6w51qeEoIx35R3p5hH5ejKBt76JaT16VubDwlK4DR5vtpY2J5pRnbR9JSsMiYHuLZ53/i0Zk9v6ZTbhOndWt2WBh7Y+9ofmlQCd8D/EvLJYHCrW22Z9RfDwxAry/asJisCPeVJrLJHxCP+vMWzysq8hL/bvWe3SOI8428=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C18Q4wxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EB3C4CEE9;
	Tue, 27 May 2025 19:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748374106;
	bh=ZcppwkkBkGHzfL/HojYzLOl4RCeHBYYQUV63DqSRucM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C18Q4wxAIMAZ+UbWrE1lFvCpoZhpt/PBhWqEwgXbut9htZnxVTyZ4DBPOvmqZ6YNQ
	 lJJ55e7ZRfL/bKDdOK4pOlYBu4SyQktp7wfoCYBdTYeQfUz3ogXafmvGCaT3662unh
	 495cJTJLzsiFQ3oAnLez/2yCuqs2WN6gMWfJNLcE0mtBhFv8pd1GwL5/Dk6+dvoVs5
	 JsvzkbFFzmk3HyeCtRK4HGry4Y8HX1IfiJtazdMxhSsuLe2UU4X9eeB8PRs02okcwG
	 SmXCzdZ9yluDgM9b/BU73hkMHJuoSmWGN6Qo0FhwytFRi8d1kEsev0ZUQU75NQdUx5
	 AH6eL3zDyhaag==
Date: Tue, 27 May 2025 14:28:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>, devicetree@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Felix Fietkau <nbd@nbd.name>,
	linux-kernel@vger.kernel.org,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	DENG Qingfang <dqfext@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH v2 01/14] dt-bindings: net: mediatek,net: update for
 mt7988
Message-ID: <174837410385.1090056.12670391327460010323.robh@kernel.org>
References: <20250516180147.10416-1-linux@fw-web.de>
 <20250516180147.10416-2-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516180147.10416-2-linux@fw-web.de>


On Fri, 16 May 2025 20:01:31 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Update binding for mt7988 which has 3 gmac and 2 reg items.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v2:
> - change reg to list of items
> ---
>  .../devicetree/bindings/net/mediatek,net.yaml          | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


