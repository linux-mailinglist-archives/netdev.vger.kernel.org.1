Return-Path: <netdev+bounces-37347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 302857B4E1E
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 10:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9C3AF283675
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 08:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA9853B7;
	Mon,  2 Oct 2023 08:53:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF010A02;
	Mon,  2 Oct 2023 08:53:24 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415A5DC;
	Mon,  2 Oct 2023 01:53:22 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a707bc2397so2383170b6e.0;
        Mon, 02 Oct 2023 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696236801; x=1696841601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZxcvuXQCGJdKauDfykcR6RyUoZDrW0lEXnuqeviIGA=;
        b=TVHJllkJ0hXB6WQvQgKriHfqY2pYxSkD/YxtJqmgNPa5Gg09uGmLYeCJ8d512r5d77
         A/WYz06nFKL+/UtyTiirtU2Z7jnfSFdlfqhlo1yuYEAma+Fn5qAu3gE1YrXWl8q+mW9x
         SOc4NNAhSdy3FH42iGGGPq7cby+77DpW4fC9+uDlwcah3/nZPp+Yv7Nl4Hbomw1D1CFm
         chWebwyZaiz9PobbrI7ELVub++hIqnFvAhtClr2LMrbfQZSx0BuDCnWR701toddriTwx
         8D0Sc6/DrjFkulT/VG9kuHNab7Uo00MUTrT/3mH6BdStZvjiUfjDRZMzX27AsbJ53Bur
         F58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696236801; x=1696841601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZxcvuXQCGJdKauDfykcR6RyUoZDrW0lEXnuqeviIGA=;
        b=R7357+HUSQ9dIKkZBGZEFPG9e93Zhty59PIDr0V//HU14wMjEcb0ovzNX4EC7C1bTc
         sUmX2VcgtWZ1vb4EW4Z8twJ5w9QNtG+8H7tEbREYcnUlGAzXVEnzEuFVVbJx5S7ffFO0
         vnECnsASacge76DTR52z5Z4dhV6kex8a1dn3LOcPk0QUZv+PkzbB4UeP1MbSG2A4/y2l
         8ODDPu+yd5Te0wvqD5ELZu+TDf8TsB81rc3VuT5PGheahnHPE+hGaGTayPyBQbn18hL6
         eCTT1o00Xn6QJIFJdy4rjIwMdNZ73VaPYJ4ty/7CmcMNsB5QTJPaHt50iFjqAuwEu/j3
         HbWQ==
X-Gm-Message-State: AOJu0YycwCLzQzLNwcYZ7qVTWx0WJQDHQgJ+irSAgcR6SWAyE98RaOac
	CGHq88+wtd3S4L7qZX3NaAQtKHimO10SkW1R
X-Google-Smtp-Source: AGHT+IHQnDfc0OwbRvwBL7482lujg871ixrgEOZiQDep30iZ2eImk6ey7TdnQ/mzHHzJjxoLDxxdsg==
X-Received: by 2002:a05:6808:f92:b0:3ae:df5:6d0d with SMTP id o18-20020a0568080f9200b003ae0df56d0dmr11877222oiw.2.1696236800599;
        Mon, 02 Oct 2023 01:53:20 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00274c541ac9esm5656270pju.48.2023.10.02.01.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 01:53:20 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com
Subject: [PATCH v1 0/3] Rust abstractions for network PHY drivers
Date: Mon,  2 Oct 2023 17:52:59 +0900
Message-Id: <20231002085302.2274260-1-fujita.tomonori@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset adds Rust abstractions for network PHY drivers. It
doesn't fully cover the C APIs for PHY drivers yet but I think that
it's already useful. I implement two PHY drivers (Asix AX88772A PHYs
and Realtek Generic FE-GE). Seems they work well with real hardware.

The first patch introduces Rust bindings for the C APIs for network
PHY drivers.

The second patch adds the bindings to the ETHERNET PHY LIBRARY, and
also me as a maintainer of the Rust bindings (as Andrew Lunn
suggested).

The last patch introduces the Rust version of Asix PHY drivers,
drivers/net/phy/ax88796b.c. The features are equivalent to the C
version. You can choose C (by default) or Rust version on kernel
configuration.

You can find discussions on the RFC patches at rust-for-linux ml:

v1:
https://lwn.net/ml/rust-for-linux/20230913133609.1668758-1-fujita.tomonori@gmail.com/
v2:
https://lwn.net/ml/rust-for-linux/20230924064902.1339662-1-fujita.tomonori@gmail.com/
v3:
https://lwn.net/ml/rust-for-linux/20230928225518.2197768-1-fujita.tomonori@gmail.com/


FUJITA Tomonori (3):
  rust: core abstractions for network PHY drivers
  MAINTAINERS: add Rust PHY abstractions to the ETHERNET PHY LIBRARY
  net: phy: add Rust Asix PHY driver

 MAINTAINERS                      |   2 +
 drivers/net/phy/Kconfig          |   7 +
 drivers/net/phy/Makefile         |   6 +-
 drivers/net/phy/ax88796b_rust.rs | 129 ++++++
 rust/Makefile                    |   1 +
 rust/bindings/bindings_helper.h  |   3 +
 rust/kernel/lib.rs               |   3 +
 rust/kernel/net.rs               |   6 +
 rust/kernel/net/phy.rs           | 706 +++++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h          |   1 +
 10 files changed, 863 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/ax88796b_rust.rs
 create mode 100644 rust/kernel/net.rs
 create mode 100644 rust/kernel/net/phy.rs


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.34.1


