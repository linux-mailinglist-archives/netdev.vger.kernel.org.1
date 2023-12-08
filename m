Return-Path: <netdev+bounces-55383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B9080AAF6
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E316DB20C8B
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989083B782;
	Fri,  8 Dec 2023 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TNgcHEjw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51552D54
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 09:40:04 -0800 (PST)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B5740421DF
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 17:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702057202;
	bh=0Wg7c2RtoSlacNEX+QsvU/G8vYuCUeUJAnALPbL3Qqk=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=TNgcHEjw+8dxmz9N1APT/UXU5Vm7dhy6o1JW4+/+XdGLjRFqTC6iKeUfYPMMFqAVY
	 0K8ImLbhmS61jc6ehKvB1DCrWBcQc5Td33lHgMq9s0lTNV+mPIQExFQNqKnY1F8eH/
	 WZ+VO42gdUs3wxF7bB9CXNtdSKfU3LPHaaRLM4e+acj0HybUhNPiIMyjiZmw3zr5+N
	 6CcdkuSrFni3fMJeoImjDBmrVWcCb3w7WYHA4ub2KO8rWhOBGaW3LUJFvxR3UdL4MJ
	 mZl001IbIhrTj3RehNx+8/2v6xwyEYqTw5bhrSykbE8V0emltCL4zlpoQPjqQ5/c58
	 iJGVkk4JzmcWw==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1fb05b08fd5so3724818fac.0
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 09:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057201; x=1702662001;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Wg7c2RtoSlacNEX+QsvU/G8vYuCUeUJAnALPbL3Qqk=;
        b=Nj17SRmQ2JgVWCxMJXXqsNpBms2yRY82D0He2/9XsUt7fa/DRTokEnbMUk5l32kUxY
         SnQ0BYEBuWn+qX3MN7ncrdGb+Rg6tz538NCPkPOmW/jChb8B/a8skHnZaFeIQ193AbAd
         NWbjnE3S8KnFD/21jE/Yl1WLhRYOJv8FgmYK+70sDFU7wPqB/Ak1sXdud9v4pmhPJY1q
         XRjvj6+lwX4YIGE1aZgiyn5AjtgDHwu3Zg29T6Gqm6LaA+SzEM7YWKVLcgIpe3aSlIyA
         YAJ8uEa6Ao3kkYl85yYSWu93C8swhAl9ranZEfjExyCUn8VXIM5Tcd73wfcBMBC1AbKd
         ediw==
X-Gm-Message-State: AOJu0YxoMONp6RSziBLuzEw/UO/XfDmAsjqnHkoOil8PH2Hxt3LML21L
	r0PbHzz1JV6Mje03d93jRKstvcYdrG1lNkZekcS73tV0VeHKxT/OQElr5bfn5B06fVjJqpNoEId
	5fYkRyjYI2A3PtzyktVAqQJuTbojsfTGYPmWt2Qz0ShtYKN4s8w==
X-Received: by 2002:a05:6870:829f:b0:1fa:1ca4:b917 with SMTP id q31-20020a056870829f00b001fa1ca4b917mr505704oae.41.1702057201368;
        Fri, 08 Dec 2023 09:40:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvoxqbD9MmiUzi/kijiStuj/gY6AFJbn8AI5LFKGHA7PcQEWa4r0J5A0xv1noNymQSla3/fUfHzp1Y4889ZZA=
X-Received: by 2002:a05:6870:829f:b0:1fa:1ca4:b917 with SMTP id
 q31-20020a056870829f00b001fa1ca4b917mr505697oae.41.1702057201119; Fri, 08 Dec
 2023 09:40:01 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Dec 2023 09:40:00 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231208-unripe-maximum-fc77f4967561@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud> <20231208-unripe-maximum-fc77f4967561@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 8 Dec 2023 09:40:00 -0800
Message-ID: <CAJM55Z_ozf=MwOJCSM154L__TE1Gv7Ec=gM8LFJ31-_eX66OKA@mail.gmail.com>
Subject: Re: [PATCH RESEND v1 1/7] dt-bindings: clock: mpfs: add more MSSPLL
 output definitions
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Wolfgang Grandegger <wg@grandegger.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> There are 3 undocumented outputs of the MSSPLL that are used for the CAN
> bus, "user crypto" module and eMMC. Add their clock IDs so that they can
> be hooked up in DT.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  include/dt-bindings/clock/microchip,mpfs-clock.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/dt-bindings/clock/microchip,mpfs-clock.h b/include/dt-bindings/clock/microchip,mpfs-clock.h
> index 79775a5134ca..b52f19a2b480 100644
> --- a/include/dt-bindings/clock/microchip,mpfs-clock.h
> +++ b/include/dt-bindings/clock/microchip,mpfs-clock.h
> @@ -44,6 +44,11 @@
>
>  #define CLK_RTCREF	33
>  #define CLK_MSSPLL	34
> +#define CLK_MSSPLL0	34

You add this new CLK_MSSPLL0 macro with the same value as CLK_MSSPLL, but
never seem to use it in this series. Did you mean to rename the CLK_MSSPLL
instances CLK_MSSPLL0?

> +#define CLK_MSSPLL1	35
> +#define CLK_MSSPLL2	36
> +#define CLK_MSSPLL3	37
> +/* 38 is reserved for MSS PLL internals */
>
>  /* Clock Conditioning Circuitry Clock IDs */
>
> --
> 2.39.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

