Return-Path: <netdev+bounces-38635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 425617BBC95
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 18:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46CA280FE6
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEDA28DBC;
	Fri,  6 Oct 2023 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVUz30t5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3897A273F9;
	Fri,  6 Oct 2023 16:21:04 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE09A6;
	Fri,  6 Oct 2023 09:21:02 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57c0775d4fcso307027eaf.0;
        Fri, 06 Oct 2023 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696609262; x=1697214062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nw5/xjBCmUwohSuhLXL/rRAwQj9/lRA3/thm9H4Vl7E=;
        b=NVUz30t58DJVQHoYLMJYJf0POpQciBUy6LovrfP+Kiz8V13sxtNd8jFBbEznqi50R/
         cjdfGWEQoAFdLIt+lHx4kfBm0wGv37YIwvRaws00e8/GRVD0T5jzVbJFufuTeEHgygQa
         a5G4Penf6ZgQCebndLwJ6JA067dokmomXeAHTjoL1HhrNnsTHHEDuwlGtCYJnqZtPqBZ
         /DyvdBt1mqJ3MYDFfTq/AHXcmNXjqD008xHwxqx2J4+dOz4wKVoLgfSaySwV2Fl4yrc4
         Dzwfa9d8uOqZkSvWdxkM81OBIINHCoPFzXtXmiHBZy6uzrKVwBEnoUOIsLy8iLVNK9RM
         UV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696609262; x=1697214062;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nw5/xjBCmUwohSuhLXL/rRAwQj9/lRA3/thm9H4Vl7E=;
        b=sHTVdL7p7BdgWVPDn9fM1gyp4B6QWyEjF9mZTlmqDOrx0ct1h3Gi9Dsr9yda9VGZrB
         BTVocOj25M2jKycIYsvKVq221CBow3c6rHJ6mgAkmQDS6nbwZpPO4abKzxApJawByYOf
         VIYhCuITvzZWVZ8YGpVXLKiSi5dhwFmAwm9BrzSVfaCJe29t6N+5m2yL+OW0qr0di4Ru
         5Z5+OryAmzYtWFnVEXxVvAUXcuBxCQnWNulg7TBWD8GqZYG7DR2JYGmDpsaMP1bFXEOI
         Rl32DDUisWcH0rc5NkhwOe2FzFfVJrym0KFjK/crlWcVmOVaedS0+9lzrbbpeTIlFkOX
         S0lA==
X-Gm-Message-State: AOJu0Yy0Kv2NZbWe6W4ZWnvKGTERrrgQgTLGkxPrf434iAzHv9dGsBcL
	zE2YwX1SAsXZFdhzHk0bEWctahf6Xvikgkg/
X-Google-Smtp-Source: AGHT+IFnIp3CF0zJjjt5NEaLlDPrAPXopfdRr1AXulF4fnTUCf8iuvU/P8P2Se04qlZRVFTzHg/0tQ==
X-Received: by 2002:a05:6359:219:b0:14a:cca4:5601 with SMTP id ej25-20020a056359021900b0014acca45601mr7654906rwb.3.1696609261983;
        Fri, 06 Oct 2023 09:21:01 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id b2-20020aa78702000000b00690fb385ea9sm1671713pfo.47.2023.10.06.09.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 09:21:01 -0700 (PDT)
Date: Sat, 07 Oct 2023 01:21:00 +0900 (JST)
Message-Id: <20231007.012100.297660999016269225.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <3db1ad51-a2a0-4648-8bc5-7ed089a4e5dd@lunn.ch>
References: <19161969-1033-4fd5-9a24-ec21d66c6735@lunn.ch>
	<20231007.002609.681250079112313735.fujita.tomonori@gmail.com>
	<3db1ad51-a2a0-4648-8bc5-7ed089a4e5dd@lunn.ch>
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

On Fri, 6 Oct 2023 17:57:41 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> Now I'm thinking that this is the best option. Kconfig would be the following:
>> 
>> config AX88796B_PHY
>>         tristate "Asix PHYs"
>>         help
>>          Currently supports the Asix Electronics PHY found in the X-Surf 100
>>          AX88796B package.
>> 
>> choice
>>         prompt "Implementation options"
>>         depends on AX88796B_PHY
>>         help
>>          There are two implementations for a driver for Asix PHYs; C and Rust.
>>          If not sure, choose C.
>> 
>> config AX88796B_C_PHY
>>         bool "The C version driver for Asix PHYs"
>> 
>> config AX88796B_RUST_PHY
>>         bool "The Rust version driver for Asix PHYs"
>>         depends on RUST
>> 
>> endchoice
>> 
>> 
>> No hack in Makefile:
>> 
>> obj-$(CONFIG_AX88796B_C_PHY)    += ax88796b.o
>> obj-$(CONFIG_AX88796B_RUST_PHY) += ax88796b_rust.o
> 
> This looks reasonable. Lets use this. But i still think we need some
> sort of RUST_PHYLIB_BINDING.

How about adding CONFIG_RUST_PHYLIB to the first patch. Not
selectable, it's just a flag for Rust PHYLIB support.

diff --git a/init/Kconfig b/init/Kconfig
index 4b4e3df1658d..2b6627aeb98c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1889,7 +1889,7 @@ config RUST
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
	depends on PHYLIB=y
+	select RUST_PHYLIB
 	select CONSTRUCTORS
 	help
 	  Enables Rust support in the kernel.
@@ -1904,6 +1904,10 @@ config RUST
 
 	  If unsure, say N.
 
+config RUST_PHYLIB
+	bool
+
 config RUSTC_VERSION_TEXT
 	string
 	depends on RUST


Then the driver depends on RUST instead of RUST_PHYLIB.

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 82ecfffc276c..e0d7a19ca774 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -119,7 +119,7 @@ config AX88796B_C_PHY
 
 config AX88796B_RUST_PHY
 	bool "The Rust version driver for Asix PHYs"
-	depends on RUST
+	depends on RUST_PHYLIB
 
 endchoice

