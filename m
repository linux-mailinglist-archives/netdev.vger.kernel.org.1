Return-Path: <netdev+bounces-59995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512BB81D0DB
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 01:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B6D1C2192A
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 00:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3C7384;
	Sat, 23 Dec 2023 00:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFhZySOZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA731EC7
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d40eec5e12so14889965ad.1
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 16:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703292818; x=1703897618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6GK3VVYS3/GCnw7jmXG7E6qxb/QgPHZZ5u1iAf6qSuQ=;
        b=HFhZySOZ9lPT43tABzOXA78ugH0tuCZ5DTTerT0pqJePADo6MAHmgaspM979iIdUVf
         F7MG4eHf110pRa5TMjnKNFTOsiaK6cKW9LhfqrwZoArto8LGcT1zCtAg2b/LqSxfKfzA
         JFKQ5AD1wpi0Pl02y5lNB+WjWR0NH4dnNpkj+UZam+amkvB2eCCbcxCjkYJqqDuyV366
         ay2ZmdoY1++l0D2RSfIKpQzYGH7idtr+Or6e4JbnmS9TsO/t84W/Q1QVHrgFCYqrJ0TP
         cOASoovLzSdkiI7jBJ/XHmtR0ImWKAbrGhPErv8YD9H4yTza0RFRvy6Z5mk82TwJyRpG
         NZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703292818; x=1703897618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GK3VVYS3/GCnw7jmXG7E6qxb/QgPHZZ5u1iAf6qSuQ=;
        b=fyt2lp0vHqcBDP9APmvLxyE8naVGxLUzcN0+CGbgWr9zK+9oVnIJX3qMPPulnOWKlh
         JXlxfLru3ANH3WizQROvgUqO5d96LUZqEuF4gLi1pBxkWH25QVzwJZU1dzLunRpKC4z1
         Z3QaZP6ZdPwJR5DWHIZ4RXCya0tUsjsjFDorhysbWngibLj2Qf/w9kTjNwURbQ/GoOwt
         iwXKajhPTTO9z0rBrNcAxKpl52rDq3mwQ5GPFLl//E71XjXOZfLVDonlRiHKMK1M0cxq
         0aTwUL4gPA3lwWBP4LhKdJ68x6pJqRsBMChPpetz3Q9iTLLq8KLcKuw7a0MIIZqdJhJ8
         c47A==
X-Gm-Message-State: AOJu0Yz2Vr5tJR+yHae+ckwXm8ZHcnuhPE2J/9mWX+dQOAY95Fxy/lFe
	eufhvuNEOROlFldgPg49d2Y8lzbyTrQ7IMh/
X-Google-Smtp-Source: AGHT+IHRXRdMiXt2DXcBa7xMtMicYDwBTZADPkFojHIbAjwRZjcvhBhfehCCBTWjWeLRVh251QEYbA==
X-Received: by 2002:a17:902:6f16:b0:1d3:ac38:74a4 with SMTP id w22-20020a1709026f1600b001d3ac3874a4mr1752625plk.130.1703292818067;
        Fri, 22 Dec 2023 16:53:38 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id iz11-20020a170902ef8b00b001d076c2e336sm4028257plb.100.2023.12.22.16.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 16:53:37 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: [PATCH net-next v3 0/8] net: dsa: realtek: variants to drivers, interfaces to a common module
Date: Fri, 22 Dec 2023 21:46:28 -0300
Message-ID: <20231223005253.17891-1-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current driver consists of two interface modules (SMI and MDIO) and
two family/variant modules (RTL8365MB and RTL8366RB). The SMI and MDIO
modules serve as the platform and MDIO drivers, respectively, calling
functions from the variant modules. In this setup, one interface module
can be loaded independently of the other, but both variants must be
loaded (if not disabled at build time) for any type of interface. This
approach doesn't scale well, especially with the addition of more switch
variants (e.g., RTL8366B), leading to loaded but unused modules.
Additionally, this also seems upside down, as the specific driver code
normally depends on the more generic functions and not the other way
around.

The series begins by removing an unused function pointer at
realtek_ops->cleanup.

Each variant module was converted into real drivers, serving as both a
platform driver (for switches connected using the SMI interface) and an
MDIO driver (for MDIO-connected switches). The relationship between the
variant and interface modules is reversed, with the variant module now
calling both interface functions (if not disabled at build time). While
in most devices only one interface is likely used, the interface code is
significantly smaller than a variant module, consuming fewer resources
than the previous code. With variant modules now functioning as real
drivers, compatible strings are published only in a single variant
module, preventing conflicts.

The patch series introduces a new common module for functions shared by
both variants. This module also absorbs the two previous interface
modules, as they would always be loaded anyway.

The series relocates the user MII driver from realtek-smi to common. It
is now used by MDIO-connected switches instead of the generic DSA
driver. There's a change in how this driver locates the MDIO node. It
now only searches for a child node named "mdio", which is required by
both interfaces in binding docs.

The dsa_switch in realtek_priv->ds is now embedded in the struct. It is
always in use and avoids dynamic memory allocation.

Testing has been performed with an RTL8367S (rtl8365mb) using MDIO
interface and an RTL8366RB (rtl8366) with SMI interface.

Luiz

---

Changes:

v2-v3:
1) Look for the MDIO bus searching for a child node named "mdio" instead
   of the compatible string.
2) Removed the check for a phy-handle in ports. ds->user_mii_bus will
   not be used anymore.
3) Dropped comments for realtek_common_{probe,register_switch}
4) Fixed a compile error in "net: dsa: OF-ware slave_mii_bus"
5) Used the wrapper realtek_smi_driver_register instead of
   platform_driver_register

v1-v2:
1)  Renamed realtek_common module to realtek-dsa.
2)  Removed the warning when the MDIO node is not named "mdio."
3)  ds->user_mii_bus is only assigned if all user ports do not have a
    phy-handle.
4)  of_node_put is now back to the driver remove method.
5)  Renamed realtek_common_probe_{pre,post} to
    realtek_common_{probe,register_switch}.
6)  Added some comments for realtek_common_{probe,register_switch}.
7)  Using dev_err_probe whenever possible.
8)  Embedded priv->ds into realtek_priv, removing its dynamic
    allocation.
9)  Fixed realtek-common.h macros.
10) Save and check the return value in functions, even when it is the
    last one.
11) Added the #if expression as a comment to #else and #endif in header
    files.
12) Unregister the platform and the MDIO driver in the reverse order
    they are registered.
13) Unregister the first driver if the second one failed to register.
14) Added the revert patch for "net: dsa: OF-ware slave_mii_bus."


