Return-Path: <netdev+bounces-47209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 774057E8CF1
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 22:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073821F20F72
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 21:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CFE1DDFB;
	Sat, 11 Nov 2023 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFL1HlsK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE141DA50;
	Sat, 11 Nov 2023 21:57:13 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3B62737;
	Sat, 11 Nov 2023 13:57:12 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ce2ee17cb5so1873205a34.2;
        Sat, 11 Nov 2023 13:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699739831; x=1700344631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXqAk6xN281UpSgUatM/i7XchjeZPtdGe/hPZ9eSb6o=;
        b=PFL1HlsKlCNdeyufI/ja0COxZeRn8ENLPEkImQm92yLnkXA5k4Fy2+fiYpLTl16Pso
         yl+ZmsR91rCs0NxnnjO4qqkaawLXWWiq3EVDVgegbK5g5PwujdcJSboANjiAHHC0N1eO
         l94TpEZvVn7NX2mQg+iMzOLLBVi3DjeZcIZNHZzhBCk5z6FjCD3P6L/8R92lDjYQ0t5p
         3YSCzo2Of+SGMJc8xrtRoJmSl/FzluN6aB3k2l/HYEMPVZ4LniV80WfoWjpBU+yBA7ZW
         IWXrKEjw4kLDhwYv8214kuHPkv9TvTYd/QcZr/OUMRQAgvCX+2H+pypRAC53yDSzsc6j
         i6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699739831; x=1700344631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXqAk6xN281UpSgUatM/i7XchjeZPtdGe/hPZ9eSb6o=;
        b=a6nZwXpYuyiPYGyULw48VhFSdcCuVzE21faDQhENn5q7/0UA7JyizGpmu+tByBK5gK
         5bsBSPNZzE6V2DKw4WyM477jJvp8PRMqVh7cuXvJK5ADIY+K0/Ub4MfSvxUN8BEPKy1k
         OtQC9dn96nIW5LHdnPPyXT8YA8n3TSZyawVa75jZXvSzaQFyf/km6QUbpYipNkz5rGuP
         eWPDNm1BHu/XVknUjxUvMvxc5ZtBo5DksSQo8510bm1palVZkwBeSICG6lKa7ldUDEg8
         ZKAe3kyvc2NbYh3//ZSGiZvnkJJiOlJo/azpkhs/2KUQhslGpfD9+NKLaMOqHzUFNlQ9
         utlA==
X-Gm-Message-State: AOJu0Yw1oZwR5U1xHbX5hSPkChmSo8q3/CMlLtCrpXRYgOV3gXMC7NLO
	kyje9WfSKx6KYdW56YsT+NRuVPcTR0UfIg==
X-Google-Smtp-Source: AGHT+IGHH3mShd6Tpzm45Xac6betq7nRzlhXyxCv5mxIKsLYRZ12Vtbov4OWTH7z4Y+UAdkrvsXnKQ==
X-Received: by 2002:a05:6870:2b04:b0:1e9:94c1:9179 with SMTP id ld4-20020a0568702b0400b001e994c19179mr4496278oab.21.1699739831265;
        Sat, 11 Nov 2023 13:57:11 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a199900b002801184885dsm1867210pji.4.2023.11.11.13.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 13:57:10 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	vivien.didelot@gmail.com,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	arinc.unal@arinc9.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [RFC net-next 1/5] dt-bindings: net: dsa: realtek: reset-gpios is not required
Date: Sat, 11 Nov 2023 18:51:04 -0300
Message-ID: <20231111215647.4966-2-luizluca@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231111215647.4966-1-luizluca@gmail.com>
References: <20231111215647.4966-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 'reset-gpios' should not be mandatory. although they might be
required for some devices if the switch reset was left asserted by a
previous driver, such as the bootloader.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: devicetree@vger.kernel.org
Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/dsa/realtek.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index cce692f57b08..46e113df77c8 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -127,7 +127,6 @@ else:
     - mdc-gpios
     - mdio-gpios
     - mdio
-    - reset-gpios
 
 required:
   - compatible
-- 
2.42.1


