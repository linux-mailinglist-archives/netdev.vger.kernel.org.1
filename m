Return-Path: <netdev+bounces-59141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BC18197C4
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 05:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6DBCB2187B
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 04:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237D08F7D;
	Wed, 20 Dec 2023 04:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhcisWi6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B801911C81
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 04:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58d18c224c7so3286731eaf.2
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 20:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703046409; x=1703651209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lKOLkyxKLbuv67ADNH/6p3QMaN3DJ3V3H/nAxTEavlg=;
        b=EhcisWi6o7l5Bdpv3NorVjBg3Twvysx+IIBWR5y/hoebL5/L92TCmHHZbqRR7+N1AS
         TQ7PCkREevzhfa93PJvdwxkmxRRjkZCVez37FsbMmV9utdX6IdX+0J7oIpV74fku5mE7
         hUCQ2hZuuSTOHiLbb5WDifnVdMiXaKi3QQnpMwDaytvyhvksdRjJgtod51HdrV92KHUb
         yNLJQt/17eol5uYYTNXriBQ6s425je0lQN09V1hSgXM+HC13Z1+JE6JvnOJSrJoQjoxg
         cJnN1QcRPwQ439hsbt1x0vgn5eFHg7Q7AHwpJD1880NX0H1KdPyAildXf2Tge9jt6eEg
         Eb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703046409; x=1703651209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKOLkyxKLbuv67ADNH/6p3QMaN3DJ3V3H/nAxTEavlg=;
        b=ZesTzfjUAeY/6gzPS4fcFezkJSSlwZeYCHvBMPZWOjeQCK0dc03XTnv00HiZJjKZkw
         XCUxY+UPbkyFARMdUOGBe4RzXdAWQqFzxII/Hg+GubdWMd3r22PR+BjlZ57lqcDLtnR6
         kg1but3DclChuk3DQLfGyUQpbRkBvGXSKVj5FXC5hw3nE9xknpP/CXYihD8OF4CB9SUN
         feWZlJNXPhczQEo5OlCPuUltRr0dSmsd/oDsYaRDq+GK+uYBioXbM0ypfQVkg4uNWH+J
         lDv0GtyYW159vrf/DZvM/1xXRFGpXHXMhLdwAR84NcUgzbj0h8H5UTrqwl40cg3XU+NP
         OyOw==
X-Gm-Message-State: AOJu0Yxt9moDZ5io5fb2j7JBEuR/hKcLAqm7Mrl1wlljFBeEVqeJ3xY3
	MNc2d7WmPUgXb4fjoj7fncQAoQEzvAK1bp+N
X-Google-Smtp-Source: AGHT+IGBMqir+22JXA7xTtkAnop/X5CHKyTcUZAYy2lbRUBuXcri/1qf4B2u3x5SUVCKisDnKocpOg==
X-Received: by 2002:a05:6808:1454:b0:3bb:723a:9b94 with SMTP id x20-20020a056808145400b003bb723a9b94mr6977oiv.93.1703046408808;
        Tue, 19 Dec 2023 20:26:48 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id ei3-20020a056a0080c300b006d46af912a7sm6325554pfb.23.2023.12.19.20.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 20:26:47 -0800 (PST)
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
Subject: [PATCH net-next v2 0/7] net: dsa: realtek: variants to drivers, interfaces to a common module
Date: Wed, 20 Dec 2023 01:24:23 -0300
Message-ID: <20231220042632.26825-1-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current driver consists of two interface modules (SMI and MDIO) and two family/variant modules (RTL8365MB and RTL8366RB). The SMI and MDIO modules serve as the platform and MDIO drivers, respectively, calling functions from the variant modules. In this setup, one interface module can be loaded independently of the other, but both variants must be loaded (if not disabled at build time) for any type of interface. This approach doesn't scale well, especially with the addition of more switch variants (e.g., RTL8366B), leading to loaded but unused modules. Additionally, this also seems to be upside down, as the specific driver code normally depends on the more generic functions and not the other way around.

The series begins by removing an unused function pointer at realtek_ops->cleanup.

Each variant module was converted into real drivers, serving as both a platform driver (for switches connected using the SMI interface) and an MDIO driver (for MDIO-connected switches). The relationship between the variant and interface modules is reversed, with the variant module now calling both interface functions (if not disabled at build time). While in most devices only one interface is likely used, the interface code is significantly smaller than a variant module, consuming fewer resources than the previous code. With variant modules now functioning as real drivers, compatible strings are published only in a single variant module, preventing conflicts.

The patch series introduces a new common module for functions shared by both variants. This module also absorbs the two previous interface modules, as they would always be loaded anyway.

The series relocates the user MII driver from realtek-smi to common. It is now used by MDIO-connected switches instead of the generic DSA driver. There's a change in how this driver locates the MDIO node. It now searches for either a child named "mdio" (compatible with realtek-mdio and binding docs) or a child with the compatible string (compatible with realtek-smi).

The dsa_switch in realtek_priv->ds is now embedded in the struct. It is always in use and avoids dynamic memory allocation.

Testing has been performed with an RTL8367S (rtl8365mb) using MDIO interface and an RTL8366RB (rtl8366) with SMI interface.

Luiz

---

Changes:

v1-v2:
1) Renamed realtek_common module to realtek-dsa.
2) Removed the warning when the MDIO node is not named "mdio."
3) ds->user_mii_bus is only assigned if all user ports do not have a phy-handle.
4) of_node_put is now back to the driver remove method.
5) Renamed realtek_common_probe_{pre,post} to realtek_common_{probe,register_switch}.
6) Added some comments for realtek_common_{probe,register_switch}.
7) Using dev_err_probe whenever possible.
8) Embedded priv->ds into realtek_priv, removing its dynamic allocation.
9) Fixed realtek-common.h macros.
10) Save and check the return value in functions, even when it is the last one.
11) Added the #if expression as a comment to #else and #endif in header files.
12) Unregister the platform and the MDIO driver in the reverse order they are registered.
13) Unregister the first driver if the second one failed to register.
14) Added the revert patch for "net: dsa: OF-ware slave_mii_bus."



