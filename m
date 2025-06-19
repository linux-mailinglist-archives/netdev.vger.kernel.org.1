Return-Path: <netdev+bounces-199292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB8ADFADF
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 03:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADD45A0814
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 01:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C841DB92C;
	Thu, 19 Jun 2025 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpXJqfyf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4742913B58B;
	Thu, 19 Jun 2025 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750297230; cv=none; b=aIN7yLI1jQLEkrkFYWWuV+y7/jZGC+t0BsxensJ3HhNJBxdsU/fc00v0P2vULTbZdMyAFEINhnspRD+HEHBZwKR2sCDN2n39XioVorEin9IptfklxTxEAjCkOerTlMaRZtwOhTPKHBBYVNUXiavUHWGTyy2qM84KWHaVRyDB/L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750297230; c=relaxed/simple;
	bh=SvpJaLgxZ01hhEyPBK7m+g0OO/xO6+1O9tYOQcbbOzA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=rinM9h6c2u6d3HMEVLVGNDUvjC9wKDfXP3C92bV+SHFA5RRxgSqjg+ySv8h22+UfOiinhmIXJSn+xcmBzqzHbgbHcYhACYgDIh5rxjQfT8YRAvDeq9QhtPs/ZW0JyYbifwrEU7UeA1SL40G50zRzliltBEtYQkmYiU9Yehawsxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpXJqfyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A610AC4CEE7;
	Thu, 19 Jun 2025 01:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750297229;
	bh=SvpJaLgxZ01hhEyPBK7m+g0OO/xO6+1O9tYOQcbbOzA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=IpXJqfyfPrj+58MPxmgcnMA3cRgcvyJEh8E4R5kq80Z+oDRAVyInhWgDU9FykbD5J
	 ry50fE6U0iAJWoK+RdyXZ9WLoBxaqcYOZ+2ckm6g77fkQTK7XjjLnyvkMlSWJAP1+c
	 zTBeV8mEajEq5L6kf6lYKvO9sGARGN0X+YqpCUnGURNrMnOwXH0NfGL6O/V26iWtrp
	 WzjGw3/ARoHUROUr3WpLOwjSblgqoK1PwJDvcNPuOkflBePl35+w+GBc99iMLvhwKC
	 YtZAaMoZZnvm+vBggQWxqiVsrHew4KT58S31/uOcP0QFeYuFZQJAcECBPn8s8fG+7U
	 Z3OKQG1j4klEg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250521210813.61484-1-robh@kernel.org>
References: <20250521210813.61484-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Convert marvell-armada-370-gating-clock to DT schema
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>, Gregory Clement <gregory.clement@bootlin.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Richard Cochran <richardcochran@gmail.com>, Rob Herring (Arm) <robh@kernel.org>
Date: Wed, 18 Jun 2025 18:40:28 -0700
Message-ID: <175029722892.4372.16473400898661004974@lazor>
User-Agent: alot/0.11

Quoting Rob Herring (Arm) (2025-05-21 14:08:11)
> Convert the Marvell gating clock binding to DT schema format. It's a
> straight forward conversion.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

