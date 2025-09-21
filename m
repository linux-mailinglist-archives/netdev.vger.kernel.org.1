Return-Path: <netdev+bounces-225066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CA1B8E016
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DEAC3BEB59
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26599262FE7;
	Sun, 21 Sep 2025 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekyQ5I5L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB459259CA0;
	Sun, 21 Sep 2025 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473600; cv=none; b=AeIEe2HwGyoks4lV6PwW6Fl+Uph0Nxo+/AM0uWNzDfdk423b+WhiP3b2A1AqRs4X9a5avUcvQNwd0Wyr3ru0ZhnVfR8FwDQ0lxT9UBbvP59hl2dqeGgs1ftL1+n9iI276c/ptEzcFMJMPK13BKbmt60qTdZpIlkVkcZOmnxMr0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473600; c=relaxed/simple;
	bh=5+wOJ9zBIdL0LDwVoPG6QMW/VZ5MaBHiB6tG1R3tmdg=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=u/wWLbopXpr176lRr5QpoKGy05ieqjPnF5XKzQiYfM9WBMjzE/3qYui1+5vB1YVJzdDouzGNoVATz21SZgy6HPW0o3RQIX0CgPAhSxckEnWz+Qvn3NLk2RK4+bGmGhoNepWHNdcXvGd3D1kZ91DIzWjnhKz9s5MumD/XUAffZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekyQ5I5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A353C4CEF7;
	Sun, 21 Sep 2025 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473599;
	bh=5+wOJ9zBIdL0LDwVoPG6QMW/VZ5MaBHiB6tG1R3tmdg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ekyQ5I5LiucYo4A1u5UC58kUOLEWhGBuFqguA8oXDzcgsX06/VlSJe3iaPkqw1amI
	 D52+T7wZaZkWbN6KakUTVvKt4FJmmY76EEP7Nr5g8iD441D0KcPV0XjwfdUD2w3Gj2
	 dHJAjdHv6TM5YRoQcR5U1BzFTGoAWhvvbBiRK71n9bm3Lr7jEJ9YiAt41E47ogx+Kc
	 szmxTxQlD5L4Exr6j5iIS6H+k5qiUWfBKYt/zOIOYd2zgr4fy7I5BL2f6P7rXkChOm
	 nMphi3qZm7GlW1tDlYfMyWiD9ZdaeGD1PZ/KSVsCjHVAxm9tbSYe1aT2Htejj0ZPJQ
	 lDBXoRqV9NGGQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-4-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-4-laura.nao@collabora.com>
Subject: Re: [PATCH v6 03/27] clk: mediatek: clk-mux: Add ops for mux gates with set/clr/upd and FENC
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:53:18 -0700
Message-ID: <175847359824.4354.6608148269345464225@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:23)
> MT8196 uses set/clr/upd registers for mux gate enable/disable control,
> along with a FENC bit to check the status. Add new set of mux gate
> clock operations with support for set/clr/upd and FENC status logic.
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

