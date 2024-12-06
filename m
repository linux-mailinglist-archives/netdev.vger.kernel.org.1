Return-Path: <netdev+bounces-149851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A38B9E7B81
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 23:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6254A16A4D7
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D072147F8;
	Fri,  6 Dec 2024 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QugtRP2o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B187E2147ED;
	Fri,  6 Dec 2024 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523188; cv=none; b=XyJMfu6CjhdXtMqZR5JBNaDKUqrICPFP8sGoMIWYyCYcf68wWazliurUHr9lBLTaaADAwgj+25iVSP4TcNodRWP6ZlWY4op9DNt1x8UzrG2P+X8B8n6ymt8pBy2X6Aj/Nc0JrZA+IALQ3JuREedvT95c/NykuAfXGWOwtUBhIZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523188; c=relaxed/simple;
	bh=cuLU+yr92U1uHjewZ/aEJ+erWQI/1e+MOKI1DEOper0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=EDCUIyrP5aa/Sgg1Iol4rgzfswDudaiJ+ZLU+g6ys72Rd5CrkUmndsiIgvIo6QNaPKXz8MMNWw6dHkOEpJohPVuQiCIaTVRHKqN3QWJSNhgXaaMHcEFJkllDzjq2YlHE23uAP+nQMlUCUFMbl5ZkABUZjqRB9TdK7JvrCMlET9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QugtRP2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB1BC4CED2;
	Fri,  6 Dec 2024 22:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733523188;
	bh=cuLU+yr92U1uHjewZ/aEJ+erWQI/1e+MOKI1DEOper0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=QugtRP2ohbKYyW4XJFJe2wqmICWC4eCg4+pdl5x+IMzZ6z89518pnEqPDQk+8wYNI
	 lMT/t4S6mnNERucaip2SPSg1z8y0XXLgwu3wjs+2Mhs0end80m48dqzVZWcZ1KRrcH
	 Me5YeEQYv7Ce8g+wXxrXSnvp82dJdsPi3m8G21vDm7C5rs/4mJQ4rVgBSdjsnjRbeo
	 y+3O7QrWlUU0CkzInN7ZzhiFYDhHjexmC99K88BDInfxBjaF9WYbmgKRXh1jPHVXXN
	 u6OIbh2N3CfzogMcjmGn6lB46gq+J9Oo1Vu+PV7CvbqfPRYFu9xp9veE+8la7iNTNr
	 g34Gq79F9ASmg==
Message-ID: <dee94bf85dd158e4f0846617ba20d2d8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241205-v6-12-topic-socfpga-agilex5-v3-0-2a8cdf73f50a@pengutronix.de>
References: <20241205-v6-12-topic-socfpga-agilex5-v3-0-2a8cdf73f50a@pengutronix.de>
Subject: Re: [PATCH v3 0/6] ARM64: dts: intel: agilex5: add nodes and new board
From: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-clk@vger.kernel.org, kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Fri, 06 Dec 2024 14:13:05 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Steffen Trumtrar (2024-12-05 01:06:00)
> This series adds the gpio0 and gmac nodes to the socfpga_agilex5.dtsi.
> As the the socfpga-dwmac binding is still in txt format, convert it to
> yaml, to pass dtb_checks.
>=20
> An initial devicetree for a new board (Arrow AXE5-Eagle) is also added.
> Currently only QSPI and network are functional as all other hardware
> currently lacks mainline support.
>=20
[...]
> Steffen Trumtrar (6):
>       dt-bindings: net: dwmac: Convert socfpga dwmac to DT schema
>       dt-bindings: net: dwmac: add compatible for Agilex5
>       arm64: dts: agilex5: add gmac nodes
>       arm64: dts: agilex5: add gpio0
>       dt-bindings: intel: add agilex5-based Arrow AXE5-Eagle
>       arm64: dts: agilex5: initial support for Arrow AXE5-Eagle
>=20
>  .../devicetree/bindings/arm/intel,socfpga.yaml     |   1 +
>  .../devicetree/bindings/net/socfpga-dwmac.txt      |  57 ---------
>  .../devicetree/bindings/net/socfpga-dwmac.yaml     | 126 +++++++++++++++=
++++
>  arch/arm64/boot/dts/intel/Makefile                 |   1 +
>  arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi     | 109 ++++++++++++++++
>  .../boot/dts/intel/socfpga_agilex5_axe5_eagle.dts  | 140 +++++++++++++++=
++++++
>  6 files changed, 377 insertions(+), 57 deletions(-)

Why are clk framework maintainers Cced on this patch series?

