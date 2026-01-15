Return-Path: <netdev+bounces-250306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EE7D28456
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 21:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E03BA300F721
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8C6313E0E;
	Thu, 15 Jan 2026 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9YS3PqZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C825776;
	Thu, 15 Jan 2026 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507233; cv=none; b=LNvMBbwXUxBIa9AD21eRu+3nBEO5Cj80zxqzs4qSr5vEXMN9wsJ8r5O9fqDVQc9rZx23u8xreGDOjGO/jHPBfnIJqw383Kb+nifOmis6KYpp2o4oomm3fdRAwn9BVhWtnJXi36m0m5E6xghWCbTiO5YMvDSG0oF+WWXfuGEgdYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507233; c=relaxed/simple;
	bh=+5QyhYDr0HXPpFvLxc24uAPqv7v9VJpdTBcn1dPobhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cePTwaQv71D4GCWF87n55iAG8DIZ6Kty0gqEjjNmQxRorIU59HU+eHypvNTJI4DcZmzCpuTn58NUtAIcVqRkd1erOJa31OK/iKShfLCdBklZYoYn4Xb2bmfoGCbciHiWsBpEuaQ7376LOiur/iGUfQM1wa+x9SGsQt7/PU/KrKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9YS3PqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB083C116D0;
	Thu, 15 Jan 2026 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768507232;
	bh=+5QyhYDr0HXPpFvLxc24uAPqv7v9VJpdTBcn1dPobhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9YS3PqZiPs9t7x+rZuxzUXw3v+Ckct1TrmZBBXOEuY2HsYTlssmPUvArPa5inwiD
	 grwjYvy3t4ARvJc9GMmWihrmHauubHoD7LkrhRvy4tiyyM9sOu/UbRLrMrtCOvd26S
	 N+P959oKrPmdDNVlY/yK72otIItG1Wm0Y3qdyJmj35R7Sq3XD0PN3V1BBQpOE2+1Xa
	 CLFuoVVQ0cA2sUB35K4HAhOOFJNiKX9eSfS6oRlRH2v65pc6q7OLuQFFk4xIjTf32b
	 eNBGxWYBUOIZ3wplU5R7U7TGSoLf1ZBFNT9M8lzPSZlzZFbTd9WfMBV6INe5DMvfjX
	 j4kTDV6p9v/8g==
Date: Thu, 15 Jan 2026 14:00:31 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Chen Minqiang <ptpt52@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: Re: [PATCH net-next v2 2/6] dt-bindings: net: dsa: lantiq,gswip: add
 Intel GSW150
Message-ID: <176850723116.1091718.16729542270759892264.robh@kernel.org>
References: <cover.1768438019.git.daniel@makrotopia.org>
 <10fdede364239ac04ef768983e5a18dbb37b4c55.1768438019.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10fdede364239ac04ef768983e5a18dbb37b4c55.1768438019.git.daniel@makrotopia.org>


On Thu, 15 Jan 2026 00:56:53 +0000, Daniel Golle wrote:
> Add compatible strings for the Intel GSW150 which is apparently
> identical or at least compatible with the Lantiq PEB7084 Ethernet
> switch IC.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: no changes
> 
>  Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


