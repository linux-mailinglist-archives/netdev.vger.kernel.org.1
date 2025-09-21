Return-Path: <netdev+bounces-225081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBD9B8E0C4
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4984A3B8DA2
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4F1288CA6;
	Sun, 21 Sep 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyccR8Tt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2814288504;
	Sun, 21 Sep 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473674; cv=none; b=nM2ZLzIHX6cfOzWXgizTYAHauyJ5lE551cwcqZVYbvBFVDif1Hmg3bXyqsDEXhK1ZeSXv0TGApDdkLm1QaDcUqRzL0grokYvVMUFDiWgn1Aa0q1dlnHGyT1ELEJ1F784yR21zF1+GyexISR+e6aDe1iW7+VkBTsicQr243OOPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473674; c=relaxed/simple;
	bh=ksmZH47dOUvvwWU8YpKXgQH7ifwlEkw270FW0y31JhA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=AOgTlLV4DjCsBDICYetagKZuBRDlYr0vs1luyPLvRCCt5O27tuV+C65jUsGWiGlZAl8PWDatuOFfB09WzK9uFLP8kMdITUCXYgRFRvtgNXGCZRrkQDoOWRWcjD0PhrZ9RkW/KhL9AUPDXRfKmBzhwVBpo/qSNp8G7jMvfGjd1Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyccR8Tt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D6CC4CEE7;
	Sun, 21 Sep 2025 16:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473674;
	bh=ksmZH47dOUvvwWU8YpKXgQH7ifwlEkw270FW0y31JhA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=HyccR8Ttsd/W5KUyJbt8XagVWYQVhWqh2rGsfm5BZNLNzKsqtBvSxZxmwRfyXjk0H
	 30hLxk7ng3l2IAAlqzdWHVCIFHq4jgpIugHyyBfpSBk4CSPKf56A6lYO8Mfg0KZ+eQ
	 exH7+gX0+sJvePAzqsPtvjeAd0XvRCcvw7uwW2adj/ErIw3VpcZZYuBDd0MJHth+ts
	 ZH9MSNp+XFwsaTropNzl/iew8CZrL3Rg/FxtOwUMYkCjgo3LPspG7JgVj9ReJa52ZZ
	 d5/bT+6aybBBjzz7S+6/dWYW01gAYEorOVFbwNq7CMpnPps5748jERIfK95TfiW5q5
	 3KNgAxLJ07uug==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-19-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-19-laura.nao@collabora.com>
Subject: Re: [PATCH v6 18/27] clk: mediatek: Add MT8196 mcu clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:54:33 -0700
Message-ID: <175847367333.4354.15922282572758969909@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:38)
> Add support for the MT8196 mcu clock controller, which provides PLL
> control for MCU.
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

