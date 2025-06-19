Return-Path: <netdev+bounces-199591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38569AE0E5B
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 22:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68E11BC4D6E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 20:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAC921FF3B;
	Thu, 19 Jun 2025 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ02kzcb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1958230E849;
	Thu, 19 Jun 2025 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750363254; cv=none; b=BhelHq90iuRsSwnEB9d/jRy/0134sB/JEJuZegAzUPiDKOGHLK+sF2xgLZGSOUqFy4dc2o5pj6GK9cFfJ7dYDyCrzY9Mmiwy5/vEEHR+Kq/npdD2gzXPde579Evzcd9LeRGuwlcJm+ML8xJqui+nPLOIpVk6BajOf+lM8mu3P5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750363254; c=relaxed/simple;
	bh=W2J0i+WG/PKJ/ZkG9vyA2DkvGy1gkKZsqlYj/4o9WVc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=VvpeXsbRAHLwPIU+02O7FGG/69Lom0WDJoX4GkdMHPmAK08ahkKzwe79LLZHUGC/wMqrKGcGxPgdt/gJ1dB92qRr3DP3ElDzUp0LSmAPf5GsAqmuO5nwWXzvWvO8V0Dn+7JJFBvUWIuWlIF9L7uFKoQ4qvS4iXbBnPvQ2SgiAxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ02kzcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3DBC4CEEA;
	Thu, 19 Jun 2025 20:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750363253;
	bh=W2J0i+WG/PKJ/ZkG9vyA2DkvGy1gkKZsqlYj/4o9WVc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UJ02kzcbZJZeiNEHd5b99bUhLyNEtRcBgfSKjSh+UOnyIc7kkQLDZFtwAZMz1ywhz
	 7/SXXYjPRqVYlVdLVBpLLnv/0AdaP5zLVChg+Tw4+8CuqLhghPw+PajRVJop8jHJ9g
	 7aoYF4o1rAUSU1tRakIJq4BHPyQC8FaUyLbmoWCiZBNWED3ibxKpPtxLs2xYsmhpcb
	 Vr6I1QEx469iI9xEYTi15uvFqFwAkO0grFJvGWl5RJE9ZA69jqpzL1JDIOzpxWohyg
	 2CMKHT1xuftnB62ZsAJGxOJ0TjfrmYKLdeRI+zzmBb9xPjdtnPFonlS4Dca3fHGxVo
	 xLXoKV1K/Wewg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250610012406.3703769-3-jacky_chou@aspeedtech.com>
References: <20250610012406.3703769-1-jacky_chou@aspeedtech.com> <20250610012406.3703769-3-jacky_chou@aspeedtech.com>
Subject: Re: [net-next v2 2/4] dt-bindings: clock: ast2600: Add reset definitions for MAC1 and MAC2
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, mturquette@baylibre.com, p.zabel@pengutronix.de, BMC-SW@aspeedtech.com, Conor Dooley <conor.dooley@microchip.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 19 Jun 2025 13:00:52 -0700
Message-ID: <175036325275.4372.17530886047439204374@lazor>
User-Agent: alot/0.11

Quoting Jacky Chou (2025-06-09 18:24:04)
> Add ASPEED_RESET_MAC1 and ASPEED_RESET_MAC2 reset definitions to
> the ast2600-clock binding header. These are required for proper
> reset control of the MAC1 and MAC2 ethernet controllers on the
> AST2600 SoC.
>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

