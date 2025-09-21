Return-Path: <netdev+bounces-225090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D62DBB8E136
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 19:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8EB7189857E
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1014A2DC77B;
	Sun, 21 Sep 2025 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSj9EssM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F27262FD4;
	Sun, 21 Sep 2025 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473716; cv=none; b=lB9EEjjpbqVW4c45yD30yV/dzjLqUlzjJ0CVKhOgqTW7Y/zbItkQoBijzQfBJftogoj3t8CAiOdVLR3XKQA7W65BGR7DsQzjO//mKIwvallh2cPA5IgET4OYF8pAmY+lSJ/XDKbjEkk1Zo1Lny6Q3DuEfxB+2O5zhp9iSWG81Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473716; c=relaxed/simple;
	bh=gladXUT5F0XURCw6JuQBdgxcedelWcH2hcrlQcX0DOc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=rptKXUy9NtL5pwAjRmQo2UsW5CWk50UGDNEzcY9JmKe6jw4Q0f4ROoeYh8J7atCSdSQqdXA0tUNGc2o5p7MWgPg0veOWhIBAvt0QsCWOw1gsKDdYqSEmpR89A6bqhymfM6qDWUjAWNdi3oRwO1M39fiUUjA7asRqsh3yk+xKCHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSj9EssM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C83C4CEE7;
	Sun, 21 Sep 2025 16:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473715;
	bh=gladXUT5F0XURCw6JuQBdgxcedelWcH2hcrlQcX0DOc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=HSj9EssM6Pxf5rY/zKangvdCD4/dxy/LP46OVg7ucuK6LIHBr8Y2vYVWHg73C1SUe
	 pU7hbDILv5qHCZ4Y1g11RSmHLmj5jvY1DfDVfYrZaISfLbJfwYsdNIeg4fk70MkkJV
	 cGb+R63jQ3qsMUbLwG/byY/bHYuBtElrsMSXapEVzWFNagumVf5cHumZQGPEyiNX8G
	 gUYrUoqW/1OM+wSP+g86QQz6QbskDGjB6t7hpKQ3A9NiJ7dJ7ylW6kl2tErBkqe0L2
	 46I5Q6u1oRHwUFMc3BT5B2LrxtP8bG1uN4ywU/ctkwnI7iqZY2SQvUviJ/Bx5F5Rrx
	 jE8ZtStQV2Q4Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-28-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-28-laura.nao@collabora.com>
Subject: Re: [PATCH v6 27/27] clk: mediatek: Add MT8196 vencsys clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:55:14 -0700
Message-ID: <175847371427.4354.3269379078117550500@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:47)
> Add support for the MT8196 vencsys clock controller, which provides
> clock gate control for the video encoder.
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

