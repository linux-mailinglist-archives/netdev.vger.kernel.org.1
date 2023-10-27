Return-Path: <netdev+bounces-44835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E4A7DA127
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E44E28251E
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 19:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E573D3A5;
	Fri, 27 Oct 2023 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsEOGJ5s"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D218C2E;
	Fri, 27 Oct 2023 19:09:55 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2FEFA;
	Fri, 27 Oct 2023 12:09:54 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7c011e113so19843007b3.1;
        Fri, 27 Oct 2023 12:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698433793; x=1699038593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DHal/WfnOt0F/bUzqgVKdReu0rsmHy97KCWbd2FIy4=;
        b=gsEOGJ5sRfwcn1SMLKcQCvKWn/vA2aAVCWiHW/+bSlKW/ZbzUDXY4GFiMfq3dWZjtR
         sJyANzBSTT2EuJFL/0lGwduAzcPfcUj/PcNx5MksOYPOv/9TjMAVhgXFBSuPswaBAxFV
         BU1pmwBpe7uKQBxupgK04u6dIcqR9DS4wVQIuh4vm4RpXMjF/KuqBfW0iaS4Xv8c0a6Y
         CrpkKfoCPs6YBBg3oLBCjhDa96p4n0Ly3BgZmXaKkDmY56zFAiCwyKGYM0KM69YDWvNP
         E/9oV0giJOFkg9wPK0dvTqORJLovDyx1jIhYqqXjJ4Fy7uIpO2IzNTrCD/Fme3/+15yp
         ErHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698433793; x=1699038593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DHal/WfnOt0F/bUzqgVKdReu0rsmHy97KCWbd2FIy4=;
        b=vEJ9imthX4CGHK7IoFprMPBTE89W8Oq21HLJZgra2qK7XfefbEWZuWqAPuaorS3uu3
         chax9T2WfU5m34NsS/Lbq6Lbc15fMkK+2OFbCKyX7AolvB5FT3IKOsbxujU8tfo+MNB8
         9EU9dE89VMu9iXTHRucpnczFf236t8UxpSWBG549MOCPcCMKZkX0PRkFKXkhrDIiGewd
         fwf5V2u8C3S96Qx/sE8zofgLnvc38x0T/9x9kLCc1L6FgwqBk5cjht3R8VfN0ZlUSv4U
         5wxhuMVL73Vo+Bp+IDzHpEhZ3ZawoUhcTTLOn+rUb2mMmFJbPucNXvBcqoHgqaZWs5uR
         NTcQ==
X-Gm-Message-State: AOJu0YzQ+AyarAAs4hSylfG+scUbePDM7eTkN7iDWrXkBq5NvHsBfsxq
	2aEj4EgWzAUVerqscwxDkJK3VTn1EMhMrw==
X-Google-Smtp-Source: AGHT+IGmCJKCSHLQvZDv3+bYpIGHFwwmGuYO0V4HVvm0U6XgV7xPo3U4MmezZEzezmD4V8fi0j/3uA==
X-Received: by 2002:a81:ac22:0:b0:5a7:bbd1:ec1d with SMTP id k34-20020a81ac22000000b005a7bbd1ec1dmr3565642ywh.17.1698433792785;
        Fri, 27 Oct 2023 12:09:52 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id g190-20020a8152c7000000b0059c8387f673sm958696ywb.51.2023.10.27.12.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 12:09:52 -0700 (PDT)
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
	devicetree@vger.kernel.org
Subject: [PATCH net-next v2 1/3] dt-bindings: net: dsa: realtek: reset-gpios is not required
Date: Fri, 27 Oct 2023 16:00:55 -0300
Message-ID: <20231027190910.27044-2-luizluca@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027190910.27044-1-luizluca@gmail.com>
References: <20231027190910.27044-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'reset-gpios' should not be mandatory. although they might be
required for some devices if the switch reset was left asserted by a
previous driver, such as the bootloader.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: devicetree@vger.kernel.org
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
2.42.0


