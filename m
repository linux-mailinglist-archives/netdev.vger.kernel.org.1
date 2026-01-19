Return-Path: <netdev+bounces-251182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC223D3B2F6
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6ECAF315BE7E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11007322DB7;
	Mon, 19 Jan 2026 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmWpC+mw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC431E0FB
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840454; cv=none; b=KBafYHosGxcpRlychp3LvE0krPaaJX2SK2MyQL9SoX40DaeVWyDqPhlZ8zEMYjWiZMA5vKBnAyhJ3MMkAgH899kM6w3R0YBz4A0Qh7BL99OTNYVub1+JlyJOE8JV32yN6hhQzIgab7voBx7g6IhtOckeRclGIpioh4hrMF7GDhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840454; c=relaxed/simple;
	bh=5MRLRL6loFbBhHojKGLogBBY83yVD6kHxgI4PPxjSZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHurTkA7Eg/36TIjbfk38qwBBw+PIIXPonKy0R6FnFj7PzhyBcUEQxssHxKvYi2NNUw89XR+2fK+vUIWULU7sRkdceRxdT+MLELsAchD7mDFnJR9XEUkYIO9UKFq7ly+de52v1gn6Nc06DasSEAjqvY7kH3fQJO/hY1nBHWv+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmWpC+mw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32E1C116C6;
	Mon, 19 Jan 2026 16:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840454;
	bh=5MRLRL6loFbBhHojKGLogBBY83yVD6kHxgI4PPxjSZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HmWpC+mwmK6HAPA8cJL4/piTa2i7ILS4kIUABIcR4O8HrCKlzLgFCInW8yr/t+ckN
	 9of3urk3I6NLQGFt/pJUaQCgani3FWNx1OzH9tY4TFByrTUl/M1kGBisySLW/7c2as
	 UxgmNzjBa/8bcemU1DcBo+ICKVvMLf63OO37f7fMVX6NO2lensodEQxmN/cariziVf
	 Bsu93PjO4i0/ea3qzw6rrFlKp4CNsKqVlaMUDBoNwGWdCzB+4VZm0EaJd8ef3V7sN/
	 +cirWKULrRkVLniZNRAVMZHFHWYqnQnzo/ekoSTdD82yShrZAh5VsuG2cfXKqSROzZ
	 aAJ/9Yn2Yf+2w==
From: Jakub Kicinski <kuba@kernel.org>
To: linusw@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	olteanv@gmail.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	woojung.huh@microchip.com,
	andrew@lunn.ch,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org,
	edumazet@google.com
Subject: Re: [net-next,v2,2/4] net: dsa: ks8955: Delete KSZ8864 and KSZ8795 support
Date: Mon, 19 Jan 2026 08:34:10 -0800
Message-ID: <20260119163410.1147227-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119-ks8995-fixups-v2-2-98bd034a0d12@kernel.org>
References: <20260119-ks8995-fixups-v2-2-98bd034a0d12@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: ks8955: Delete KSZ8864 and KSZ8795 support

This commit removes support for KSZ8864 and KSZ8795 chip variants from
the ks8995 driver, since those variants are better supported by the
dedicated Microchip KSZ driver.

> diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
> index ff01097601ec..5ad62fa4e52c 100644
> --- a/drivers/net/dsa/ks8995.c
> +++ b/drivers/net/dsa/ks8995.c

[ ... ]

> @@ -804,8 +700,8 @@ static int ks8995_probe(struct spi_device *spi)
>  	if (err)
>  		return err;
>
> -	dev_info(&spi->dev, "%s device found, Chip ID:%x, Revision:%x\n",
> -		 ks->chip->name, ks->chip->chip_id, ks->revision_id);
> +	dev_info(&spi->dev, "KS8955MA device found, Chip ID:%x, Revision:%x\n",
                             ^^^^^^^

Should this be "KS8995MA" instead of "KS8955MA"? The chip name appears to
have a typo - the driver is for KS8995 (as in the file name, module
description, and all other references), but the dev_info prints "KS8955MA"
with transposed digits.

> +		 KS8995_CHIP_ID, ks->revision_id);
-- 
pw-bot: cr

