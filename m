Return-Path: <netdev+bounces-43696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EF37D4465
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC26B20CB0
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C922187D;
	Tue, 24 Oct 2023 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3g9tnY+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B0A7E;
	Tue, 24 Oct 2023 01:01:47 +0000 (UTC)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E21CC;
	Mon, 23 Oct 2023 18:01:45 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a950f1451fso19532539f.1;
        Mon, 23 Oct 2023 18:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698109305; x=1698714105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gCnGJIAkzmcBzTAXnOhGKfxN6A+3ny8E52Dd47yc1qU=;
        b=S3g9tnY+wuTcVwy/m+Mdt1/jqI4n29fKLV/EE5TK7fQ31banfYQqmGXyNj9MtHhWRc
         iR4Wi1CxhXFYj7yG9q0mwFCOfYK6Kmh6nul++IcCaw5Odv2poO7aAj5Mcgk/+QM1FTjg
         3h1lmXO+66876+BrcyE5UupoaujPFkm63jJzWEVKHphx/RTno1M8svSsuOYdvZgrHG3e
         w1a+G6UUg8R2ziQvT7zw4Acth+wqrldBs1XRCyBfaToG7hHRa6Nz2NMXXYi2UFJ3VgBb
         MUv2ydrO8YQuzMtlG8Hl3XDdPo+mz6zS7dXEn7TYO4e6R1pc0VuleG7AyeW9QGu+fovF
         ljjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698109305; x=1698714105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCnGJIAkzmcBzTAXnOhGKfxN6A+3ny8E52Dd47yc1qU=;
        b=FHgFwE6fJFx8yFaRQ3lRNldhcbD+4tenQ6xM0OeHwOhsUL6P/2drmZAqIzzoqEXmI+
         v2NIW+vbEwRQWaLG5obhnFVeSSrTL5GD/XAwVSXtK79jiillSzihmeS7KuOHBW3lFHdu
         6bw5cPpr+gwE+tlJCBjflxtTM3zxrVaNQX8EgnOL7TCh3gbJxgiBqD+xxpeFPFg4mPNc
         LgDI3cCl8ckgt8/J+7L7RVMlg0cDK5z1q38gVtjHEUMewQ6V4B03U0pz7vPhSXPJ6yZv
         unCijwJl/xM19d7zkmroJnJOdSTx+1CqbHmt3zxLxA+khnCm4kivzvsynmfXSZT8Xete
         4u2w==
X-Gm-Message-State: AOJu0YyoyI3eK9zn0BPxSDLt3pCkDoD4fgh+4z4ywi+dc7w0PA9QDWPW
	FVahaRmdDu8G1sAZRgiz1ooYWt0usj4yMg==
X-Google-Smtp-Source: AGHT+IEeDAK829vqiJsRQ6gDAFuWRAlAV7CRBgvgYPt278LIF2C8l7wDX3QOMspbbVHhJ76NjC51cA==
X-Received: by 2002:a05:6e02:320a:b0:357:4682:d128 with SMTP id cd10-20020a056e02320a00b003574682d128mr11555538ilb.1.1698109304864;
        Mon, 23 Oct 2023 18:01:44 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id k6-20020aa78206000000b006be077531aesm6707888pfi.220.2023.10.23.18.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 18:01:44 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	wedsonaf@gmail.com,
	greg@kroah.com
Subject: [PATCH net-next v6 0/5] Rust abstractions for network PHY drivers
Date: Tue, 24 Oct 2023 09:58:37 +0900
Message-Id: <20231024005842.1059620-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds Rust abstractions for phylib. It doesn't fully
cover the C APIs yet but I think that it's already useful. I implement
two PHY drivers (Asix AX88772A PHYs and Realtek Generic FE-GE). Seems
they work well with real hardware.

The first patch introduces Rust bindings for phylib.

The second patch add a macro to declare a kernel module for PHYs
drivers.

The third patch add Miguel's work to make sure that the C's enum is
sync with Rust sides. If not, compiling fails. Note that this is a
temporary solution. It will be replaced with bindgen when it supports
generating the enum conversion code.

The fourth add the Rust ETHERNET PHY LIBRARY entry to MAINTAINERS
file; adds the binding file and me as a maintainer (as Andrew Lunn
suggested) with Trevor Gross as a reviewer.

The last patch introduces the Rust version of Asix PHY drivers,
drivers/net/phy/ax88796b.c. The features are equivalent to the C
version. You can choose C (by default) or Rust version on kernel
configuration.

v6:
  - improves comments
  - makes the requirement of phy_drivers_register clear
  - fixes Makefile of the third patch
v5: https://lore.kernel.org/all/20231019.094147.1808345526469629486.fujita.tomonori@gmail.com/T/
  - drops the rustified-enum option, writes match by hand; no *risk* of UB
  - adds Miguel's patch for enum checking
  - moves CONFIG_RUST_PHYLIB_ABSTRACTIONS to drivers/net/phy/Kconfig
  - adds a new entry for this abstractions in MAINTAINERS
  - changes some of Device's methods to take &mut self
  - comment improvment
v4: https://lore.kernel.org/netdev/20231012125349.2702474-1-fujita.tomonori@gmail.com/T/
  - split the core patch
  - making Device::from_raw() private
  - comment improvement with code update
  - commit message improvement
  - avoiding using bindings::phy_driver in public functions
  - using an anonymous constant in module_phy_driver macro
v3: https://lore.kernel.org/netdev/20231011.231607.1747074555988728415.fujita.tomonori@gmail.com/T/
  - changes the base tree to net-next from rust-next
  - makes this feature optional; only enabled with CONFIG_RUST_PHYLIB_BINDINGS=y
  - cosmetic code and comment improvement
  - adds copyright
v2: https://lore.kernel.org/netdev/20231006094911.3305152-2-fujita.tomonori@gmail.com/T/
  - build failure fix
  - function renaming
v1: https://lore.kernel.org/netdev/20231002085302.2274260-3-fujita.tomonori@gmail.com/T/

FUJITA Tomonori (4):
  rust: core abstractions for network PHY drivers
  rust: net::phy add module_phy_driver macro
  MAINTAINERS: add Rust PHY abstractions for ETHERNET PHY LIBRARY
  net: phy: add Rust Asix PHY driver

Miguel Ojeda (1):
  rust: add second `bindgen` pass for enum exhaustiveness checking

 MAINTAINERS                          |  16 +
 drivers/net/phy/Kconfig              |  16 +
 drivers/net/phy/Makefile             |   6 +-
 drivers/net/phy/ax88796b_rust.rs     | 129 +++++
 rust/.gitignore                      |   1 +
 rust/Makefile                        |  14 +
 rust/bindings/bindings_enum_check.rs |  36 ++
 rust/bindings/bindings_helper.h      |   3 +
 rust/kernel/lib.rs                   |   3 +
 rust/kernel/net.rs                   |   6 +
 rust/kernel/net/phy.rs               | 837 +++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h              |   2 +
 12 files changed, 1068 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/ax88796b_rust.rs
 create mode 100644 rust/bindings/bindings_enum_check.rs
 create mode 100644 rust/kernel/net.rs
 create mode 100644 rust/kernel/net/phy.rs


base-commit: f4dbc2bb7a54d3bff234a9f1915f1b7187bedb1f
-- 
2.34.1


