Return-Path: <netdev+bounces-190546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DCFAB77BD
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 23:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40309E3835
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 21:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1E2777F7;
	Wed, 14 May 2025 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8XT4RXF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B90418DB2F;
	Wed, 14 May 2025 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747257421; cv=none; b=Y2lGCJUqEdATarUhQ8b2EoIV7BClWAzomfZXnOr2cCGu8PgBHyePXcb/6cjB9MoTM6lnGgVOY1/dhqlfzyr4FSUqQQWNi9EgpqpdtueSPhkr4bWkI/j/zlD3vT6TaKAMcvZfWIoC5absLJCXNtWpA768ROIeOtie0Bwh1WTG41M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747257421; c=relaxed/simple;
	bh=XqD9mQcmolD6PXXgJ20Lz/AYkecGTq+N8Hzsb17sSuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jph9vN4wc8JqISriJosp1KngsZ7ah8VAFBJ3qsHLko8weyUurF3+s4NGZdwGPqanQFdI2ZS8vCvTfNrFBGgZcOs+BSxx+EXW4PB3Hq+ACt2NyoOXb5F+HTvpJCpaPAbpzJGVzvU1z1vAOXVjkRcHIzpjWq98dcs+UWkLbMwJToo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8XT4RXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9DDC4CEE3;
	Wed, 14 May 2025 21:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747257420;
	bh=XqD9mQcmolD6PXXgJ20Lz/AYkecGTq+N8Hzsb17sSuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8XT4RXFeMXxkFHhN3G5e7D+3lR2DVv7JoPlyoJ0CDr/gZSQsN4veiaikN/aQXCUk
	 R5PdppjlHSo0+Tn10FEYSUrcIZugSoP+ge/6AUju3208V4eJlxt8c4pdXJhblvvnPB
	 A5CV6eTdz14sxq+tHjMSI6CK/rk1dKpdiW3g4PFECTlpX37rn53iU7mqRb+pLWpA1K
	 giJr4dPDJpL6JU7f3CUuByPCGFzhII/CYeL7t+VQ5oT4tFgZSkWIcVw9lLzpRs3Ko7
	 ekXrit+GrBtevtHy8Sllrbow88oCXVQHubtKMH3fSznRWXXDMeg+FvxWco6vEcvGRV
	 C2INWW2po70pg==
Date: Wed, 14 May 2025 16:16:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	DENG Qingfang <dqfext@gmail.com>, Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	linux-kernel@vger.kernel.org,
	Landen Chao <Landen.Chao@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Frank Wunderlich <frank-w@public-files.de>,
	linux-mediatek@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v1 02/14] dt-bindings: net: dsa: mediatek,mt7530: add
 dsa-port definition for mt7988
Message-ID: <174725741810.3051350.2895104132991545164.robh@kernel.org>
References: <20250511141942.10284-1-linux@fw-web.de>
 <20250511141942.10284-3-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511141942.10284-3-linux@fw-web.de>


On Sun, 11 May 2025 16:19:18 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add own dsa-port binding for SoC with internal switch where only phy-mode
> 'internal' is valid.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  .../bindings/net/dsa/mediatek,mt7530.yaml          | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


