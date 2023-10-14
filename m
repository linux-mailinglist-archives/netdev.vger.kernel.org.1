Return-Path: <netdev+bounces-40954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 076EE7C92E1
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 08:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FBA282CD8
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 06:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C86F1FDB;
	Sat, 14 Oct 2023 06:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjW++VVQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1A97E;
	Sat, 14 Oct 2023 06:01:55 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B6FC9;
	Fri, 13 Oct 2023 23:01:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6bbfb8f7ac4so39216b3a.0;
        Fri, 13 Oct 2023 23:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697263313; x=1697868113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsrmjeedRmndhI5oS2QuPLFeCL4M0GNNy483xruZaHM=;
        b=ZjW++VVQ2F06MyzIHjm8+rjIrW3Ut7XuBli2302HUOw9YFuS9KJTLtqLUm9egWFs0K
         sWrdy2TTMRgtdo5fkl9/F1dBBsMfamA9bEHFxNmY4ifG5QQuj3PiZUQ2oPUvmKKHTt6+
         Bu5dkxJvRP9wR6UONI3gmg5rE7Y2JDwmgXW58BvcgSMrPQ2vcFTGQASPHjNJOCpv06e8
         v7UrqYXnTc04L6xKLzUwlJfyr0TJh/Rg2lktKGQsYxKwAswCNB23K1IqIW3x+MS0FRpS
         qF4u8hQDjenXp0y3P843U4AjDQ1iMLTRq8dNb+ExYcaMoJnc/PMcGUZzqy2qXSlmzRyl
         V6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697263313; x=1697868113;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jsrmjeedRmndhI5oS2QuPLFeCL4M0GNNy483xruZaHM=;
        b=gnslkq3P7XNqoDCfBYaEppzJESEjsGeX6kGhJiQUsQw9ZpPL9WoSkCSVH9b2SgDcZg
         h7wbJARneESLwdpTz8fN8CZfkeGT7Up/dEz6W6SyEqhbpeBGVFYIOBvlUes3lXzgPR8O
         Rn6F/QC0VWi3IDb9tLlASXalIgiuni+mP96dBBVHv5gax/C3oxQx5+pi8oU2HXsOG2n8
         nYCFEET3tCAus47h+klfE8CKNX+EH9JEfVhvaDk4eLW3tlYDMxh7YIJBtRQN2Fw8du6I
         E9Mt7RIjo3Yjq4VyTws5QXsGbTfFUNcSnZVmQlQUX3gRm8SKhO/kDJ3Cp+HWp4GtG8vD
         G7fw==
X-Gm-Message-State: AOJu0YxglEnXuvnqzoSJToGfkzlgewKPPb1Cibv7e2t5htOsBQSJV2zp
	8XwQld1rWmvcbZxbqz1gFx8=
X-Google-Smtp-Source: AGHT+IHqGvEGvsptJP/nQyf49LJyfR8Qxsjv7t6WSoYfzuaKvPtsgqMPNDuu2j+/8P2QqNLfH4ucxQ==
X-Received: by 2002:a05:6a20:3d04:b0:13d:d5bd:758f with SMTP id y4-20020a056a203d0400b0013dd5bd758fmr35140214pzi.6.1697263313175;
        Fri, 13 Oct 2023 23:01:53 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id e59-20020a17090a6fc100b00276bde3b8cesm1123255pjk.15.2023.10.13.23.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 23:01:52 -0700 (PDT)
Date: Sat, 14 Oct 2023 15:01:52 +0900 (JST)
Message-Id: <20231014.150152.235653841163958426.fujita.tomonori@gmail.com>
To: fujita.tomonori@gmail.com
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, benno.lossin@proton.me, greg@kroah.com
Subject: Re: [PATCH net-next v4 4/4] net: phy: add Rust Asix PHY driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20231012125349.2702474-5-fujita.tomonori@gmail.com>
References: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
	<20231012125349.2702474-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 12 Oct 2023 21:53:49 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> This is the Rust implementation of drivers/net/phy/ax88796b.c. The
> features are equivalent. You can choose C or Rust versionon kernel
> configuration.
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  drivers/net/phy/Kconfig          |   8 ++
>  drivers/net/phy/Makefile         |   6 +-
>  drivers/net/phy/ax88796b_rust.rs | 129 +++++++++++++++++++++++++++++++
>  rust/uapi/uapi_helper.h          |   2 +
>  4 files changed, 144 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/phy/ax88796b_rust.rs

I'll add the following entry to MAINTAINERS file in the next version.

+ASIX PHY DRIVER
+M:     FUJITA Tomonori <fujita.tomonori@gmail.com>
+R:     Trevor Gross <tmgross@umich.edu>
+L:     netdev@vger.kernel.org
+L:     rust-for-linux@vger.kernel.org
+S:     Maintained
+F:     drivers/net/phy/ax88796b_rust.rs

