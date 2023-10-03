Return-Path: <netdev+bounces-37553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6B07B5F70
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 05:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B00471C20756
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 03:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626017F4;
	Tue,  3 Oct 2023 03:43:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD164EA3;
	Tue,  3 Oct 2023 03:43:14 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5049D;
	Mon,  2 Oct 2023 20:43:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27909dabf1cso106279a91.1;
        Mon, 02 Oct 2023 20:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696304592; x=1696909392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNwOC9N4ruq7sxgNc7Qo8qd72bZpAOd5wtjGETdiya4=;
        b=O1FpdidjRmDDr2dKcBcKpUx7GoAmpUytaNhrGGXeSBAS7LklCrXpA0KdXzZWugeQh3
         /ztDPxFPquOuTPrieB2oyaFOXMApwIi7w6p8RfJCJaabv0fLPd/cf1ZJjM4Tn8yeCl/g
         /hTi4dX7cpnvlnepmz/Loc2W8YrpGOxvysgrBd7IqYn3CVPUrcYk5lNH7xtlnCrrYUpY
         ahSmiPx3F0KafFzwwB1PG/jg2Q7J1oge6Oyvk9ZYPm4Ap3bmZSdRsY3Gpy6A19giyU2I
         LEQdfhQqmOJbQv7gWv1Wv90bS3WHuZZBJkB319wJu4mF2e1AO2Is0+aywHOadnk0qyZL
         ExSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696304592; x=1696909392;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aNwOC9N4ruq7sxgNc7Qo8qd72bZpAOd5wtjGETdiya4=;
        b=lz1k0Q8rpHm2aN2R0LTOvAwFVAp1CFvC8mBbKraIiDCcx2Ur8+TPxMZd7HD5bs8Vfa
         7QWoP2Epxj5in5rGtqnFHbsRHDqK23dHhmPpmchyd6ZxWzP8z7jKQgO9lUfZU6xxtRMO
         HbGdCH7wFt6vI9mswI4Dm/qG30aK/ezq4yXSY5zQEAH+28XinxsUjB2WTtOHA7KyPoDL
         GQFV0hdCbaGwScK2SFz/bgTGFYYYKeQXI0nX/gwS9YhMd54rGdbPFFWKL9dOk3Hfj07/
         6DqojCaPrcVpAmLvdiTEPvLQYdUL9bYkcO5dw+2T+fyG5q0O01BOGN1Dqssd9lpgiBYu
         D6Vw==
X-Gm-Message-State: AOJu0YzyZtNarSTusVX9e2CGAA08ctdd072it4VnWLSD1Mh0U9CZWbRr
	TmHH2hQLQmjv5ivREy8Mpv2+l6JwUXYbOHPC
X-Google-Smtp-Source: AGHT+IH9418wYSuNA6gPH8dq1Z5qkhsrKrLVs2G8TtQFhW11Q0P616j2AHtA5QZGketa7exvGIkFtQ==
X-Received: by 2002:a17:90b:3144:b0:279:9611:1020 with SMTP id ip4-20020a17090b314400b0027996111020mr857251pjb.1.1696304592558;
        Mon, 02 Oct 2023 20:43:12 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id i15-20020a63b30f000000b00563826c66eesm216426pgf.61.2023.10.02.20.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 20:43:12 -0700 (PDT)
Date: Tue, 03 Oct 2023 12:43:11 +0900 (JST)
Message-Id: <20231003.124311.1007471622916115559.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, miguel.ojeda.sandonis@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v1 1/3] rust: core abstractions for network PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <9efcbc51-f91d-4468-b7f3-9ded93786edb@lunn.ch>
References: <ec65611a-d52a-459a-af60-6a0b441b0999@lunn.ch>
	<20231003.093338.913889246531201639.fujita.tomonori@gmail.com>
	<9efcbc51-f91d-4468-b7f3-9ded93786edb@lunn.ch>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 3 Oct 2023 03:40:50 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, Oct 03, 2023 at 09:33:38AM +0900, FUJITA Tomonori wrote:
>> On Mon, 2 Oct 2023 16:52:45 +0200
>> Andrew Lunn <andrew@lunn.ch> wrote:
>> 
>> >> +//! Networking.
>> >> +
>> >> +#[cfg(CONFIG_PHYLIB)]
>> > 
>> > I brought this up on the rust for linux list, but did not get a answer
>> > which convinced me.
>> 
>> Sorry, I overlooked that discussion.
>> 
>> 
>> > Have you tried building this with PHYLIB as a kernel module? 
>> 
>> I've just tried and failed to build due to linker errors.
>> 
>> 
>> > My understanding is that at the moment, this binding code is always
>> > built in. So you somehow need to force phylib core to also be builtin.
>> 
>> Right. It means if you add Rust bindings for a subsystem, the
>> subsystem must be builtin, cannot be a module. I'm not sure if it's
>> acceptable.
>  
> You just need Kconfig in the Rust code to indicate it depends on
> PHYLIB. Kconfig should then remove the option to build the phylib core
> as a module. And that is acceptable.  

The following works. If you set the phylib as a module, the rust
option isn't available.

diff --git a/init/Kconfig b/init/Kconfig
index 6d35728b94b2..4b4e3df1658d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1889,6 +1889,7 @@ config RUST
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
+	depends on PHYLIB=y
 	select CONSTRUCTORS
 	help
 	  Enables Rust support in the kernel.
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 0588422e273c..f9883bde4459 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -37,7 +37,6 @@
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
-#[cfg(CONFIG_NET)]
 pub mod net;
 pub mod prelude;
 pub mod print;
diff --git a/rust/kernel/net.rs b/rust/kernel/net.rs
index b49b052969e5..fbb6d9683012 100644
--- a/rust/kernel/net.rs
+++ b/rust/kernel/net.rs
@@ -2,5 +2,4 @@
 
 //! Networking.
 
-#[cfg(CONFIG_PHYLIB)]
 pub mod phy;

