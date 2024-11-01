Return-Path: <netdev+bounces-140948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 498F69B8C5D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 08:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0D62864EB
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 07:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07B71553AB;
	Fri,  1 Nov 2024 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYk1Kh6J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BBD15535B;
	Fri,  1 Nov 2024 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730447475; cv=none; b=spQcSXLsMuXe+zAOGASqMUJsnwnGuSFk9lUITafieJBzsa5KWmuK3Vj78f208WrVxviKxmzdbPKmXrWWBms0IalcGp9AMItTqx8PVnz5VUb+rrZPPEztXC7qU4trEtk5PLvQZ9ESYzgU0qjQ30MZVIKgrMyKR49ByjlTocmtfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730447475; c=relaxed/simple;
	bh=WzA5otiOSUL6o5Euerp+1UpdYOZq+P7lE1gAI6ODFsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3YLxgm28I9KWh6+X6r/niUYHGefx8SepJ5vmGYtVYgwKTG1XBgNtQGqn0YuDkZuEoBfw83tTxg8U55l/lfUc5c8glDEhJDca8zOpBYhQW/HrwomXp7MO5MfaqAzZn5/R6iJlfL2VlGJZ5RCCwFWyodU81Anz5xSr87CiTJC+O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYk1Kh6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F071C4CECD;
	Fri,  1 Nov 2024 07:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730447475;
	bh=WzA5otiOSUL6o5Euerp+1UpdYOZq+P7lE1gAI6ODFsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYk1Kh6JVKRcNIC4hb/yBHxRh8hXwWAf+wkojDf07TMwx15qqsjpxSo/t52kJUqac
	 ytYPa2XLyaItfJWZrmCcC3Lsb9mIRII2xSvQaO58e7SWsvKJLQZGwd9NVZD95Hh7VM
	 Twzsi1uVv/zp3SoKEwj2MG7PocdrY4tFXBV5TmpttU1P9cr40QUJXLcCqz363+2YBB
	 qRASwsw/mOlxK3f/cxbHUbPcqsyBsMDerLkBhNcRQp1W/uypa991XyQgUahSa43pE/
	 fEVK3yyJrcdYDwyezahBW2QFp6i5eG0+LY9KSfrvTMwJvjXD2o1QX4S2sTTECcHlv9
	 0zGkTZK2VMsag==
Date: Fri, 1 Nov 2024 08:51:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC net-next 1/3] dt-bindings: net: Add support for
 Sophgo SG2044 dwmac
Message-ID: <uzr6gpmyng3irrhuf3q3bvswlbzyxnr74jwccyosplr32ceczu@jjrva67iq4ce>
References: <20241101014327.513732-1-inochiama@gmail.com>
 <20241101014327.513732-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101014327.513732-2-inochiama@gmail.com>

On Fri, Nov 01, 2024 at 09:43:25AM +0800, Inochi Amaoto wrote:
> The GMAC IP on SG2044 is almost a standard Synopsys DesignWare
> MAC (version 5.30a) with some extra clock.
> 
> Add necessary compatible string for this device.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   4 +
>  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 124 ++++++++++++++++++
>  2 files changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> 

I wish patches for review were not marked as RFC. I remember this
patch, so I don't consider this as RFC... but that's rather exception.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


