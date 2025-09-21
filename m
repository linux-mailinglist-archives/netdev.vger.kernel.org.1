Return-Path: <netdev+bounces-225084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C88FB8E0FA
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E73616D810
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7F7298CCF;
	Sun, 21 Sep 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sglWRXT5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C6F2749CF;
	Sun, 21 Sep 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473687; cv=none; b=JSdq+Gt6QsqXtYeu/jKuhz3KvQ94hTsLLdFY4vKMRHaM8/nLFUAr7+Mk5FeXjgvy6Nd4doq4eWjwELKsIodpd/9SJhdxyUDorVFogvZOYwc3hPsan4IUQLOC78hw2GBMsTO/joQBrihHEbZYtcTRXO9Ih6CPhoXnVveLep0YjRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473687; c=relaxed/simple;
	bh=85bf3Bwm5zPNrRpw6Kz2kWnimc4LviNT955VzKxH2lk=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=oxbtgjTdnQGiuW930VT466AsySvdr7YInzI+nrCZcBbsyIjIKwKkzIyBHRVFOuFq6r316oHscFvJMbBh0IONyiYPGNYxwNedVH2FS6Cuu7xeCo65lgagwFw/ygzyeQ5f051HDxkWFUpOElu8V3hjCgDKJW327SS37bbMqXbPeMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sglWRXT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21659C4CEE7;
	Sun, 21 Sep 2025 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473687;
	bh=85bf3Bwm5zPNrRpw6Kz2kWnimc4LviNT955VzKxH2lk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=sglWRXT5eg3VsPmjVcdMnAvpaVOd1bi1fZcxXEGo48ARQRKosryzz5h3y3KswKUjV
	 1tJkZDVzHEk32g/AXEkiemECUhZYB6EhUI919En9rw11YnM6dhAYHsG6gQzos+NlIf
	 RzW5kfwmawaI3ucvMgHNkNA+lva3Fcu/UyoPsaA1nWjTO9b2w/vp31Syy0seQOFGPQ
	 3OQOS6q4DYZ2LTTAxJDWvF/i2t4Kczt0Gea3V52fCISo8rBN/JI9E94BluJpMdTN/+
	 7NzC+V2bBZqIrk9ZrwAYShTVxplVHZ1qQe+uO/fUVt4OHe+iWHi5wPlUU9r0Pne3LU
	 5vLUN2rLnbf6Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-22-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-22-laura.nao@collabora.com>
Subject: Re: [PATCH v6 21/27] clk: mediatek: Add MT8196 disp0 clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:54:46 -0700
Message-ID: <175847368604.4354.13252498572745408389@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:41)
> Add support for the MT8196 disp0 clock controller, which provides clock
> gate control for the display system. It is integrated with the mtk-mmsys
> driver, which registers the disp0 clock driver via
> platform_device_register_data().
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

