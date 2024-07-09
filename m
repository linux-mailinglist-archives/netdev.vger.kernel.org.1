Return-Path: <netdev+bounces-110258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C7B92BABB
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B691C217A6
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8368156C73;
	Tue,  9 Jul 2024 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+XplV81"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD304382;
	Tue,  9 Jul 2024 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530697; cv=none; b=qQZ4NU/NPxBAiCNG2Nc+tGBy0zdy9umwq+OwHafsPip5A1C5b6dwDBwomYgfO+Kp/uiycPCAkYe/Gy9aNurM8y04x5XXyU6UgJxWy5K+w7sP/v0XOgV3TI3T0nhvI6vlngop1sd6X6NIJiVw+U+p6fH7gpqiqelvAC6nnV7bXdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530697; c=relaxed/simple;
	bh=DVEv9DvcsDzxQ0vbfPH4/h8AixT+OkH5pEWKxWdHcUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFa20Vf/bxwD2oOJzeU5soSqMlhqNjwCU24jEQoIEA+Njd6aiZO4CK1MBrmgNFhZSwwvxmM415x6aFdBsn/xlCRJQWtZQmsDd5DYUgEHlGgQK3vJhWfVxu7Z1YEZ/+P94DWkZ3SaEllU/klYFabBYjm9SbnvRco7srwSl3J3Ew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+XplV81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C18C3277B;
	Tue,  9 Jul 2024 13:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720530697;
	bh=DVEv9DvcsDzxQ0vbfPH4/h8AixT+OkH5pEWKxWdHcUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+XplV81fdIg9PZHwPmzUIcCBEj4CMQyYMuEZASiAF9RPG7+tJWfRXarWEiUSIQTp
	 0sXvckujszQBW/s4JvHG+eCJAIR3/7goLdNswRJUkzkJpNv78RPlMa2bzjHLIuPyVM
	 t34JXnjTj/9avv3e0XB3zs2SPLQyg0gU6U68GApT9bmpX08WmkT92hU7bs7Az+QZWi
	 qiRRoiRgdNItVcM0LhCAxHKGjhKseo7b+t/RN+Z7Bt93jQb2MFayjoqUKUibSeTreO
	 r2y++6gci588WVCnbwohEyNtsKf1k2hbAfxwqxTcM3aFLgKsZHijSrq2Pj8CGbiHG2
	 UWkPSfHO5TSjQ==
Date: Tue, 9 Jul 2024 14:11:30 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de
Subject: Re: [PATCH v6 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <20240709131130.GK346094@kernel.org>
References: <cover.1720504637.git.lorenzo@kernel.org>
 <bafc8bcf6c2d8c2b80e6bafebe3661d795ffcbee.1720504637.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bafc8bcf6c2d8c2b80e6bafebe3661d795ffcbee.1720504637.git.lorenzo@kernel.org>

On Tue, Jul 09, 2024 at 08:05:22AM +0200, Lorenzo Bianconi wrote:
> Add airoha_eth driver in order to introduce ethernet support for
> Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
> en7581-evb networking architecture is composed by airoha_eth as mac
> controller (cpu port) and a mt7530 dsa based switch.
> EN7581 mac controller is mainly composed by Frame Engine (FE) and
> QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
> functionalities are supported now) while QDMA is used for DMA operation
> and QOS functionalities between mac layer and the dsa switch (hw QoS is
> not available yet and it will be added in the future).
> Currently only hw lan features are available, hw wan will be added with
> subsequent patches.
> 
> Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


