Return-Path: <netdev+bounces-44255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BD47D761B
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 22:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8634D1C20AC7
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 20:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307672E63A;
	Wed, 25 Oct 2023 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iU8WKEPG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFB21A289
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 20:56:53 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44A1133
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 13:56:51 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so131214276.0
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 13:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698267411; x=1698872211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WG2LOwP2YUSM4kF/CWYh6XOfM1kKSnVAjdUICrmoXPE=;
        b=iU8WKEPG1/xuPI7BVPix4IeGz+l1PMhKsQm136UQiknfIKijoWPO58kKyHLG7od84K
         DB+ZsZMhlKeajB5ZDtkUZl/Hwe9I2jd5/1RjtpcSiKlat8/WG8n1OxkSxR/RJJgsNDFC
         Kw/ACWRiwrpARfiIN1qkYiMVCJUBQSBhCdRZI/P9ta3A0ljcW6JHhCMueMdZMtCS5RZM
         aU6rXaY/t04xEmtOpLrhoGXD12VgrlK3G8tvY67AFogA8pdnxbtqA5OODAO2iSbEfhxq
         WY5hiSvS0mSH6Q2ZBo5XX/fbRdCxeoC2ZFj1vseCS12fHYzo3Ck8+eUBtRXqu3AE6fWg
         u1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698267411; x=1698872211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WG2LOwP2YUSM4kF/CWYh6XOfM1kKSnVAjdUICrmoXPE=;
        b=pptaMSHIAJQ2PdFkl6nszDinw3gxGELgBi6T+LW5Z690dYVCrdNEyKrEPQcNYfbWIq
         qe9RNKVu/ILPqWVRLN2WO/N+Yz6DyjU0L7TiiSR9JUNwCU/jgNtE5bpthM0WSNchPIa1
         hXy0zK9uvd9H64ZI84UkBwY6XqWWByDV/ezXGsqEHQFM+BCQKs8V1f5rhvqQ7P+WhSWD
         pGzr3yMCA5/R2lszN9NbHuioEm3s8LdK/vGqtwM9Ypj+TgWGzykU+84NLzp4LTNqo0jD
         vMPE+eu1EYPCvpNdbx1bH57aCefZKCP/gRlz/sYc3FWx+Xen0oM3kX2Y0Jgxq9ImaFuN
         MmHA==
X-Gm-Message-State: AOJu0YzEVZIv9BzeULTSgBBchIRtfdFC+JIfnj6W9H9a8jirBFULf4bk
	y3Sp3qfotWJzd2051rAe6WhHOx5A2nuK05rZkV6azQ==
X-Google-Smtp-Source: AGHT+IGXXbun7Hf+dUXEuikfpHvl8n/63gi7dVrSpK3hXwtRu+jy2r2BRyY4j+m/SH08Vbku+REHVc4l9a6ordHfoS0=
X-Received: by 2002:a25:d88b:0:b0:d9c:7f5d:e202 with SMTP id
 p133-20020a25d88b000000b00d9c7f5de202mr15916753ybg.36.1698267411053; Wed, 25
 Oct 2023 13:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
 <20231024-marvell-88e6152-wan-led-v7-5-2869347697d1@linaro.org>
 <20231024182842.flxrg3hjm3scnhjo@skbuf> <CACRpkdb-4GPnVegc+OqyPaZN2rNCkgmNL4qjf-LGnnz27+EBbg@mail.gmail.com>
In-Reply-To: <CACRpkdb-4GPnVegc+OqyPaZN2rNCkgmNL4qjf-LGnnz27+EBbg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 25 Oct 2023 22:56:38 +0200
Message-ID: <CACRpkdaZYUxar8ESi6X7qLWJhuyRcFpYSF-70DvGdSn-rb7r6w@mail.gmail.com>
Subject: Re: [PATCH net-next v7 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Enrico Mioso <mrkiko.rs@gmail.com>, Robert Marko <robert.marko@sartura.hr>, 
	Russell King <linux@armlinux.org.uk>, Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Christian Marangi <ansuelsmth@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 9:48=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> We  *COULD* add a second over-specified compatible to the switch
> node. Such as:
>
>       switch0@10 {
>                 compatible =3D "marvell,turris-mox-mv88e6190-switch",
> "marvell,mv88e6190";
>
> (and the same for the 6085 version)
>
> And use that to relax the requirement for that variant with an - if:
> statemement.
>
> This should work fine since U-Boot is only looking for nodenames, not
> compatible strings. I think I will try this approach.

This works. Compatibles added like such to the turris-mox nodes:

        switch0@10 {
-               compatible =3D "marvell,mv88e6190";
+               compatible =3D "marvell,turris-mox-mv88e6190",
"marvell,mv88e6190";

The mv88e6xxx schema will look like so:

 properties:
   compatible:
+    oneOf:
+      - enum:
+          - marvell,mv88e6085
+          - marvell,mv88e6190
+          - marvell,mv88e6250
(...)
+      - items:
+          - const: marvell,turris-mox-mv88e6085
+          - const: marvell,mv88e6085
+      - items:
+          - const: marvell,turris-mox-mv88e6190
+          - const: marvell,mv88e6190

Then ethernet-switch.yaml gets this:

-properties:
-  $nodename:
-    pattern: "^(ethernet-)?switch(@.*)?$"
+allOf:
+  # This condition is here to satisfy the case where certain device
+  # nodes have to preserve non-standard names because of
+  # backward-compatibility with boot loaders inspecting certain
+  # node names.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - marvell,turris-mox-mv88e6085
+              - marvell,turris-mox-mv88e6190
+    then:
+      properties:
+        $nodename:
+          pattern: "switch[0-3]@[0-3]+$"
+    else:
+      properties:
+        $nodename:
+          pattern: "^(ethernet-)?switch(@.*)?$"

This latter thing is maybe not so nice for everyone to process.

The alternative is however to copy all of dsa.yaml, dsa-port.yaml and
ethernet-port.yaml (maybe more) into the Marvell binding. Which I can do,
of course. (qca8k is already deviant).

Unless there is a better way.

Yours,
Linus Walleij

