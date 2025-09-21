Return-Path: <netdev+bounces-225071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C8DB8E055
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9D93BF47A
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31A32765C1;
	Sun, 21 Sep 2025 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpfbD+SU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8622F14C;
	Sun, 21 Sep 2025 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473624; cv=none; b=hB2Cm7ktRSxkC94RJyzG5gzz3+UA1OzbZaA2bo6GJtG0floQWoG8ZnKx+rg4MRoork/d0CIE5F4ccoazmG0VST3EAf6Gto1oNOnKvM9MeKNGnBlGhVHR34d3gjZglZXU6X7alEy9uJ5rqGaIt89tMpqDXlwFLTbW1ClY+n+DXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473624; c=relaxed/simple;
	bh=JuNL8Di1bZ8KVjRFUwK62J9Adan9uB2Pvz6G50bBMHc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=iobj0D+7+RoAFBUWFdKmERqtHV+1l3l0z4HzWbt/rGiyRT+sYp1UF3Y7KtyAATB9rh5USdqDxuDktXBXn4YrvdgbeR4A21r7y7fljYUbJboA+0LIiUiCxOcQ3FIblrjtq5re5RQ6naBxt64ta+YDym1q+DUQVyo+SDeso0SkLP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpfbD+SU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE00C4CEE7;
	Sun, 21 Sep 2025 16:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473624;
	bh=JuNL8Di1bZ8KVjRFUwK62J9Adan9uB2Pvz6G50bBMHc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=lpfbD+SUIXTjMhYP0tTZBHTLl0ZUA8Vlzc6v93zVO4lWaY5ZCE45l70qWgCt3g51t
	 vQx2jxCbt2CIEVWR77w5/zmmXz941FXm1DqQhqFq5/QocEq92liHmHOYjPdnwLY2Zn
	 4QjeNnKRYalXG1iVzk6Qwlq1G+BfaYWROkNnuhS6ThOxuOc8iiSqwWttoWOvMSKzUG
	 8TF66Ds0O6pxy7tbPe9SGJ/F/3SpW6owM++WCcYQz4TopfAFiCXIDLANDHIK2pPBG7
	 m+9sB/86ofA2e68DRM/w08LmQTYEqeGboG2Do2zTOk7RnlNhUDAY1pgxGJKJAQw8kx
	 wLcTEU+1nSzNQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-9-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-9-laura.nao@collabora.com>
Subject: Re: [PATCH v6 08/27] clk: mediatek: clk-mtk: Add MUX_DIV_GATE macro
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:53:42 -0700
Message-ID: <175847362271.4354.15117894061507090727@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:28)
> On MT8196, some clocks use one register for parent selection and
> gating, and a separate register for frequency division. Since composite
> clocks can combine a mux, divider, and gate in a single entity, add a
> macro to simplify registration of such clocks by combining parent
> selection, frequency scaling, and enable control into one definition.
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

