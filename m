Return-Path: <netdev+bounces-225075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93592B8E085
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097AB17D983
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A53527F736;
	Sun, 21 Sep 2025 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K++q6ipj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6D926A1D8;
	Sun, 21 Sep 2025 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473644; cv=none; b=LfK50+eSgtyl7FpMp+mp9RuUlJ4DwCkoRQq7Wr2ALLb0TlIp2jbCO9Nbgs2AUoz8izDnsYkNmG4WbXCsuuqCpqSu2CmQC2sP7kX6RVssbkkFcOWM6SUJCunw1AMjK0RY8GJvZhJz91GArWg86T66gDcAmrKx6LQY9f2z89wA1s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473644; c=relaxed/simple;
	bh=svQU/cF+pOmeM0BRLCwmilYjYm0JWiJQpaE+UuqtBRc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=UDd1RIbyz1J2fgtsGqHd87aHkMBylD/fcWqJT7nzxxH6SLm/rb4qovn2wmot2cCG0XDJaL6M0kPk5Bjj6cZhCmY7SiAWoLpRbQDzilPGKjclh02k5mt3WmfJDyio6m9EROVvFcrz/BoN+NxkAAaXO8G58IxDZ50qoxqoHXD5uIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K++q6ipj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA0EC116B1;
	Sun, 21 Sep 2025 16:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473643;
	bh=svQU/cF+pOmeM0BRLCwmilYjYm0JWiJQpaE+UuqtBRc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=K++q6ipj+eSjUeFGBvjPonXr3MiQGB8iTWQL7KWjbxTq8OMTpXtQsKe+XSSqCNC8f
	 piKH8YSifvaE/nrXSnM64fUVxr7P9RhmiLaWdlUxD/jshYwsvOw0RZl8PU5pnRZ2fk
	 ZAWurhjLe9iNW8xYZNtdmNV3CS9uchIOxqK8v81QxNnPb4djO0XJZZ+aDdaKbJSpyD
	 m+OWHrSuFOmtMqxDq/DsWDv+g75XoVD6uhiMYo7n65+EcIrK2T2BXBcqA2CjPRtQ9e
	 jKaAcZ4kyQECqG3L4thc9K3gpI3qQu6zC/IcaExXEtmMT9yOJMfbqVRr+e5L8QugRC
	 BHB+WxShGeEmA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-13-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-13-laura.nao@collabora.com>
Subject: Re: [PATCH v6 12/27] clk: mediatek: Add MT8196 topckgen2 clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:54:02 -0700
Message-ID: <175847364242.4354.2630032735679327042@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:32)
> Add support for the MT8196 topckgen2 clock controller, which provides
> muxes and dividers for clock selection in other IP blocks.
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

