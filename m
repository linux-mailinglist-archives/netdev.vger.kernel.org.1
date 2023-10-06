Return-Path: <netdev+bounces-38510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016E47BB47F
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315461C2096F
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 09:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669F313FEF;
	Fri,  6 Oct 2023 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgqXVxmN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8CCF9DF;
	Fri,  6 Oct 2023 09:49:23 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D05EB;
	Fri,  6 Oct 2023 02:49:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-69361132a60so384841b3a.1;
        Fri, 06 Oct 2023 02:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696585759; x=1697190559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MxbPnXByqARWW4d9IxkTUQpmmfUcxQ8zXr93a77EDrY=;
        b=VgqXVxmN8Qutu1awm75f+t1ZKkVqtnRdaRIx7NuXPPKysJWxuBZ9vkzChkhPup4wVt
         dwkpruOyh0CiXjC0B0f+0Ffgewxz/bF6PUUwXHhUmvnDMDK3Rqkl1fLTadUhAr3KQM4U
         ImfBhrlNGcdVNMtaWDSiohxciUFhehzqiubNFOiabFhuVNw19X0C9OLW28rc57QZUQj9
         YoODxmIvgC/spdggDeLIxSuuGBR95FCgxms8H6UY69mf8Bwgm1fMWopyrWLA2XwD/bJZ
         5Fd3Rnpfm4J7suDqlBgNYEw/giT6qL4iRKSJ2uzEGfAwyTnnWherwnT7rzA3o2q/ChVC
         1gWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696585759; x=1697190559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxbPnXByqARWW4d9IxkTUQpmmfUcxQ8zXr93a77EDrY=;
        b=hVWjeYG4vkSORLIlgN9wx8hRFXzf5IFZfHSKVBsAkLaikHYZLbGBe33cvhC8y9DLkU
         RlORCjRbAVEtSHIFS3IMYxrBWJ9guySV4kRcpy6Fe0M2Ts5huYOqgSyKazGvnBqtt59T
         63pFizlZk6FwlN1zJI5PnuxGVnISdK+m2cV05idOfJOReZEJWWr5NyXpgKZ8VJyBMGxO
         c50pOmw/8accjXRNXlWx6Y99WGwKcCvSQ9d0SY5ScXPDfriMat7ZMn2olRj9NP3P6f/v
         BcCenCCBqfDoh3viFJJzYE6KAIH9l3RmP7w3GZq7j7nMvPAKkWgVGlT62WP+Q0MBPc4N
         SbMg==
X-Gm-Message-State: AOJu0YwrLmzr8qTuRSS0XXJtQ6upOk0FweIONWb1egtmNYRg6TJcNeJ7
	ZDcM+CEXj7rn8gTPIQKctQ/OIg6WksGIaQ==
X-Google-Smtp-Source: AGHT+IHJm+OFQlnRyTweXhvJlhdg7LjTu8KbEYosLPdxinpkXAp4NiyPEIi16MTjah6BKW904k3Kjg==
X-Received: by 2002:a05:6a20:1595:b0:163:ab09:195d with SMTP id h21-20020a056a20159500b00163ab09195dmr8429103pzj.0.1696585759535;
        Fri, 06 Oct 2023 02:49:19 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902eecd00b001c446f12973sm3362144plb.203.2023.10.06.02.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:49:19 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com,
	greg@kroah.com
Subject: [PATCH v2 0/3] Rust abstractions for network PHY drivers
Date: Fri,  6 Oct 2023 18:49:08 +0900
Message-Id: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
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

There is no major changes from v1; build failure fix and function renaming.

v1:
https://lore.kernel.org/netdev/20231002085302.2274260-3-fujita.tomonori@gmail.com/T/

FUJITA Tomonori (3):
  rust: core abstractions for network PHY drivers
  MAINTAINERS: add Rust PHY abstractions to the ETHERNET PHY LIBRARY
  net: phy: add Rust Asix PHY driver

 MAINTAINERS                      |   2 +
 drivers/net/phy/Kconfig          |   7 +
 drivers/net/phy/Makefile         |   6 +-
 drivers/net/phy/ax88796b_rust.rs | 129 ++++++
 init/Kconfig                     |   1 +
 rust/Makefile                    |   1 +
 rust/bindings/bindings_helper.h  |   3 +
 rust/kernel/lib.rs               |   2 +
 rust/kernel/net.rs               |   5 +
 rust/kernel/net/phy.rs           | 706 +++++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h          |   1 +
 11 files changed, 862 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/ax88796b_rust.rs
 create mode 100644 rust/kernel/net.rs
 create mode 100644 rust/kernel/net/phy.rs


base-commit: b2516f7af9d238ebc391bdbdae01ac9528f1109e
-- 
2.34.1


