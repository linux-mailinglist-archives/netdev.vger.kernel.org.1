Return-Path: <netdev+bounces-100012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCA88D7744
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 19:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D45B1C20AD6
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 17:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47C555880;
	Sun,  2 Jun 2024 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jSbStml4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604E482FA;
	Sun,  2 Jun 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717347915; cv=none; b=jybMKjtP02RTDglWCXRzQCciPZUP/Vnf8WQAj8P8wg1/h4pEBRf3+nyZIl3bVd9RROZzN8LbHpt/87wEIqWo+x5XmNnopB6qTVqvVxsW5eoE9kT5XoTZpyHoAbsDUohMtNpltPD2Dy8r0CnKKNAj9KSEXhQAZ8IqAHi92LuJJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717347915; c=relaxed/simple;
	bh=ft1WFhqfEDuAOEfdUsxrdnOhE+mAw0j0NCjbdvAdVYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gp0IwnnWBNp+6X99uXmYG+YwJ06+o2J0QZxNnJPvpFp/mRyLAHDxwklPPRkNrPk+pE06XJKWC1mXZ1Hu01N1JN408bvy2v4gBtlz0mZpbmwhUbDLpvfmo9t9XGnoMHRhEj5aEDgypsIKcruZIpq/YC73NnD5jzrQx/F9fxaRSGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jSbStml4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XrnfCFVA692poKyGKvkjY/UIQpDOqNdBiQZ2G92IKbY=; b=jSbStml4jJu/FcVZfeQeWHVefN
	gRtv9iDMkk7KfKHemRdkbNmPyX+MYfKguFiZmjTs4xniW7pSFjA+Z80xQYCu5PYanMgPt8nSd6Zpg
	OljtJMUxIPtAN+54FkuF2J4TIMqhB1cy0FVkNHpDJUoqbiEH0bPy0brjIErTO20jUEFU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sDodj-00GeBb-J4; Sun, 02 Jun 2024 19:05:03 +0200
Date: Sun, 2 Jun 2024 19:05:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu
Subject: Re: [PATCH net-next 2/3] arm64: dts: airoha: Add EN7581 ethernet node
Message-ID: <e79b7180-74ef-4306-9f73-47ee54c91660@lunn.ch>
References: <cover.1717150593.git.lorenzo@kernel.org>
 <0f4194ef6243ae0767887f25a4e661092c10fbbd.1717150593.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f4194ef6243ae0767887f25a4e661092c10fbbd.1717150593.git.lorenzo@kernel.org>

On Fri, May 31, 2024 at 12:22:19PM +0200, Lorenzo Bianconi wrote:
> Introduce the Airoha EN7581 ethernet node in Airoha EN7581 dtsi
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  arch/arm64/boot/dts/airoha/en7581-evb.dts |  4 +++
>  arch/arm64/boot/dts/airoha/en7581.dtsi    | 31 +++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/airoha/en7581-evb.dts b/arch/arm64/boot/dts/airoha/en7581-evb.dts
> index cf58e43dd5b2..82da86ae00b0 100644
> --- a/arch/arm64/boot/dts/airoha/en7581-evb.dts
> +++ b/arch/arm64/boot/dts/airoha/en7581-evb.dts
> @@ -24,3 +24,7 @@ memory@80000000 {
>  		reg = <0x0 0x80000000 0x2 0x00000000>;
>  	};
>  };
> +
> +&eth0 {
> +	status = "okay";
> +};

Is that enough to make it useful? Don't you need a phy-handle, or
phy-mode?

	Andrew

