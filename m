Return-Path: <netdev+bounces-31562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5341878EC77
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848811C20AB9
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 11:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AA59464;
	Thu, 31 Aug 2023 11:51:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40D28F6A
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 11:51:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E20DC5
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 04:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693482701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HA1rOAetNRxuhUM9NoRUcE5ZYks/FWqTpfdzdFJKn8s=;
	b=e3oiv28esg0fVlMQsFL/LY47WrZml6T4RtOxMOIBuFiYKF24byNr4mLxjDdVZSxH9n96KY
	B9NUaYp88aupifdllJm2vUlF+CXFeaGvM8CgK5MkMi+UPAewQk7GorFawVdskASf2kWhfd
	WwkTImRVMy/10B+yp20zcWOw4VJr5To=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-lHDKC9ISMvec2Iy8RqAMXA-1; Thu, 31 Aug 2023 07:51:39 -0400
X-MC-Unique: lHDKC9ISMvec2Iy8RqAMXA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a1c758ef63so5921466b.1
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 04:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693482698; x=1694087498;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HA1rOAetNRxuhUM9NoRUcE5ZYks/FWqTpfdzdFJKn8s=;
        b=KwqfPCA0wugnsxArNd3BY4eFlyAAKT7anN/ArpugFHUX051zb1ZBeCaZu8RkKGYOyP
         0Wjjs2USQye3dXZGOQJ8BB/AXf2GdCncWlNTdkYCkxQ5AX4r1YysQfmUBCAR/RmYTXgm
         oVwXPsKfI/brqao5CPrSRg898VJ81WziCE6QEXW04ajkizwkZmA3Vc74dhOPXXVUEtML
         EsSidFCbcTsw0lhgn3zklP1DaCUO7Urly+zaBI1R0600dnigiAgVed29i1Y4X9wNqUAS
         ZJJAiGoIRN60zwS+0eHbW50yusjDSkSTcSkRoSaENplYa5oJDw8qVJhdNmd9YKY2nfEf
         XnpQ==
X-Gm-Message-State: AOJu0YwFWlM/Wl9zH1BciDfi0ad1sw47EePgb++2wphaPbGuAY9/d+9/
	wowtR6qiiVgckVisI7nqtpZXUb2Y8xDiZFMneJZHce8UGI8SciP37SHsLuaP7TXkWs84K5sGtZM
	DrfcQpHQpDcOh8x+o
X-Received: by 2002:a17:906:19:b0:9a1:f96c:4bb9 with SMTP id 25-20020a170906001900b009a1f96c4bb9mr3536662eja.6.1693482698713;
        Thu, 31 Aug 2023 04:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGfqbMiAZnbTzey2RXfsU5qEewFCbDRPo/4/Oy55iKUmW3AuIcCEVbKwGjLs907T3p3M11hA==
X-Received: by 2002:a17:906:19:b0:9a1:f96c:4bb9 with SMTP id 25-20020a170906001900b009a1f96c4bb9mr3536650eja.6.1693482698359;
        Thu, 31 Aug 2023 04:51:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-255-219.dyn.eolo.it. [146.241.255.219])
        by smtp.gmail.com with ESMTPSA id yy10-20020a170906dc0a00b0099364d9f0e2sm681691ejb.98.2023.08.31.04.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 04:51:37 -0700 (PDT)
Message-ID: <b32f292d26aec59ae68749bbd3107d51cf3c2f1f.camel@redhat.com>
Subject: Re: [PATCH v4 0/4] Move Loongson1 MAC arch-code to the driver dir
From: Paolo Abeni <pabeni@redhat.com>
To: Keguang Zhang <keguang.zhang@gmail.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Serge Semin
 <Sergey.Semin@baikalelectronics.ru>
Date: Thu, 31 Aug 2023 13:51:36 +0200
In-Reply-To: <20230830134241.506464-1-keguang.zhang@gmail.com>
References: <20230830134241.506464-1-keguang.zhang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-08-30 at 21:42 +0800, Keguang Zhang wrote:
> In order to convert Loongson1 MAC platform devices to the devicetree
> nodes, Loongson1 MAC arch-code should be moved to the driver dir.
> Add dt-binding document and update MAINTAINERS file accordingly.=20
>    =20
> In other words, this patchset is a preparation for converting
> Loongson1 platform devices to devicetree.
>=20
> Changelog
> V3 -> V4: Add Acked-by tag from Krzysztof Kozlowski
>           Add "|" to description part
>           Amend "phy-mode" property
>           Drop ls1x_dwmac_syscon definition and its instances
>           Drop three redundant fields from the ls1x_dwmac structure
>           Drop the ls1x_dwmac_init() method.
>           Update the dt-binding document entry of Loongson1 Ethernet
>           Some minor improvements
> V2 -> V3: Split the DT-schema file into loongson,ls1b-gmac.yaml
>           and loongson,ls1c-emac.yaml (suggested by Serge Semin)
>           Change the compatibles to loongson,ls1b-gmac and loongson,ls1c-=
emac
>           Rename loongson,dwmac-syscon to loongson,ls1-syscon
>           Amend the title
>           Add description
>           Add Reviewed-by tag from Krzysztof Kozlowski
>           Change compatibles back to loongson,ls1b-syscon
>           and loongson,ls1c-syscon
>           Determine the device ID by physical
>           base address(suggested by Serge Semin)
>           Use regmap instead of regmap fields
>           Use syscon_regmap_lookup_by_phandle()
>           Some minor fixes
>           Update the entries of MAINTAINERS
> V1 -> V2: Leave the Ethernet platform data for now
>           Make the syscon compatibles more specific
>           Fix "clock-names" and "interrupt-names" property
>           Rename the syscon property to "loongson,dwmac-syscon"
>           Drop "phy-handle" and "phy-mode" requirement
>           Revert adding loongson,ls1b-dwmac/loongson,ls1c-dwmac
>           to snps,dwmac.yaml
>           Fix the build errors due to CONFIG_OF being unset
>           Change struct reg_field definitions to const
>           Rename the syscon property to "loongson,dwmac-syscon"
>           Add MII PHY mode for LS1C
>           Improve the commit message
>=20
> Keguang Zhang (4):
>   dt-bindings: mfd: syscon: Add compatibles for Loongson-1 syscon
>   dt-bindings: net: Add Loongson-1 Ethernet Controller
>   net: stmmac: Add glue layer for Loongson-1 SoC
>   MAINTAINERS: Update MIPS/LOONGSON1 entry
>=20
>  .../devicetree/bindings/mfd/syscon.yaml       |   2 +
>  .../bindings/net/loongson,ls1b-gmac.yaml      | 114 +++++++++
>  .../bindings/net/loongson,ls1c-emac.yaml      | 113 +++++++++
>  MAINTAINERS                                   |   3 +
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 219 ++++++++++++++++++
>  7 files changed, 463 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1b-g=
mac.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1c-e=
mac.yaml
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
>=20
>=20
> base-commit: 56585460cc2ec44fc5d66924f0a116f57080f0dc

I guess the whole series should go through the networking tree, but
please note that net-next is currently closed:

---
## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#develop=
ment-cycle


