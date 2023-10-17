Return-Path: <netdev+bounces-41892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAE37CC1C3
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5280B21056
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3760D41AAA;
	Tue, 17 Oct 2023 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNOa1nYG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76241777;
	Tue, 17 Oct 2023 11:30:25 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12D3EA;
	Tue, 17 Oct 2023 04:30:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27d797f349fso347975a91.1;
        Tue, 17 Oct 2023 04:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697542223; x=1698147023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cm8cSvNWKoxfm6hF/iwR7l0ep11grdZ9FoT/C19EihE=;
        b=bNOa1nYGxlYtV38nO0DwgRneDal3CqqqOrNJeIMjlUI6ZDEroguOO5Tnq0yaSO3s6N
         5MJV8ONpss5FdfbXvC6ZQPyOxd2mFpMRVafaCYAc+oVJcUumVnuIY7Bk8cWWgYIlRLgJ
         EJfFklxmyiF3AdL6an1rucchXMjbsrpo+H8rnIoMdhW0PFCuXktb3dKSyJQSodw9agdZ
         0qXq7/m68FIbXLXEsWnumBxy938Jsh9BYKQ7syx1xgjF5yRdJTFSaoDlCBtqFRo5Wslj
         fgTdjqtlHGl11H8jbUquAEPyOtqo2E1mXAY1J7Ih2CWu0AsRhzByU+wsPRKkaT/KtsYf
         H5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697542223; x=1698147023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cm8cSvNWKoxfm6hF/iwR7l0ep11grdZ9FoT/C19EihE=;
        b=oiKbqrbm+rXNxy1iDFRIoNI1XYijfQjQdlEiCxamiiBUJs5L5izuUmVBzdaLjSxmjj
         8hCtkwwYZ4l0kjY53Z0aiLt+4D4803t534liENMdK609a+wB2DhW/UY723R14eXapne3
         FHCdD1T07LmBlgEAsXCYetrL8WgmYtwvKBnBinsaeSxo8UwKTjTbWpdCkIHhdkaGHEMR
         XZ3K78Mr0TxMlpkMBd8jUVwiMG9G822bhkcN8wt0vKhqqGQ9xbeG8MiLT2hvZjPbU+z6
         OF8zhhDEBvV8tSItdidEMdgY75amc3CKhz3ooIgR3jR/h2EYuISQQOIO63f2RWsqDV5C
         3Tbg==
X-Gm-Message-State: AOJu0YzcTsYkCa0bzWjYDe1c1U8bfK4cncixz8HnRqnbrfyIDYm0klFe
	eOv4GZxRLFxAmKtYibxAljiKkP/FfULFGUF3
X-Google-Smtp-Source: AGHT+IHPyIViyonxjUdtLwLaCaUDTfD0mTleeEpComj0W9Z5J3peYG1s6j0i/fhZBsIce9ojcr7bgQ==
X-Received: by 2002:a17:90b:3eca:b0:263:730b:f568 with SMTP id rm10-20020a17090b3eca00b00263730bf568mr2016000pjb.3.1697542222817;
        Tue, 17 Oct 2023 04:30:22 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id r16-20020a17090ad41000b002635db431a0sm1116277pju.45.2023.10.17.04.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:30:22 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	wedsonaf@gmail.com,
	benno.lossin@proton.me,
	greg@kroah.com
Subject: [PATCH net-next v5 0/5] Rust abstractions for network PHY drivers
Date: Tue, 17 Oct 2023 20:30:09 +0900
Message-Id: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

v5:
  - drops the rustified-enum option, writes match by hand; no *risk* of UB
  - adds Miguel's patch for enum checking
  - moves CONFIG_RUST_PHYLIB_ABSTRACTIONS to drivers/net/phy/Kconfig
  - adds a new entry for this abstractions in MAINTAINERS
  - changes some of Device's methods to take &mut self
  - comment improvment
v4: https://lore.kernel.org/netdev/20231012125349.2702474-1-fujita.tomonori@gmail.com/
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
  WIP rust: add second `bindgen` pass for enum exhaustiveness checking

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
 rust/kernel/net/phy.rs               | 835 +++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h              |   2 +
 12 files changed, 1066 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/ax88796b_rust.rs
 create mode 100644 rust/bindings/bindings_enum_check.rs
 create mode 100644 rust/kernel/net.rs
 create mode 100644 rust/kernel/net/phy.rs


base-commit: a3c2dd96487f1dd734c9443a3472c8dafa689813
-- 
2.34.1


