Return-Path: <netdev+bounces-38755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C568A7BC5AA
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 09:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E5E282016
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 07:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05BD11C82;
	Sat,  7 Oct 2023 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1gXc2m8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E89E54A;
	Sat,  7 Oct 2023 07:41:15 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D6EB9;
	Sat,  7 Oct 2023 00:41:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-277317a0528so585945a91.0;
        Sat, 07 Oct 2023 00:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696664472; x=1697269272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9SDgvSUqsFrdWIu2qz/7AkqL4vIEqi9zxwIB5I4Svc=;
        b=c1gXc2m8fGHDCgDKYCcVhQk4q5ylA2u93+Hf75kc5YZ55ix/AUzDc09fXb0Fq7GGos
         r+RYIVmmcrmU+LqvFDGDzcpIYxlDPlGlzv6QNLNVDMUTuPei5K5w9BstnSBGjERZbeid
         8dnM7vsYn4UV/8OI38HZrvLboZNajyZWO8zpAs6UELuCzLsK5uo5qPphrAcikhRR4/CE
         Mkyxmi8kxyc6DQO3dGphLVFuT3qSgB2TICUcWwix7LSKtr7ZJvcgjkEYyWCUqHCQX0GT
         oCv3b71AjR5TcrXHl9y+HS4BktAWGFyP5Wr1FMbaXlBdlXcQkBFBEU5JCj1VKB0seGpr
         rAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696664472; x=1697269272;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G9SDgvSUqsFrdWIu2qz/7AkqL4vIEqi9zxwIB5I4Svc=;
        b=g10gKsRNLFj+GW22CvMC+pZ6C5+P2fcqYfdljLBNPhnyJyfdgBQXt00kqkWdVAy+p3
         JVMXOeC6ACBMigI0F0S2crsCTANpzLNAK0w+u/HKTtZ2STwbe4ljj/87NcLo6C1+Rmuh
         L/OjfU64QfuZyaU+2yZnuoJo/IRQxZQa0Etx+PDIyW8Z+Y16b1/BVaakMI4tVp+PuQ87
         m3yB+uX4uGduKjteEUMmpzDolkkczlHEKKmI/OLGA3AvsbwEEZzpxupU27rfJtJk4a+u
         IxlX/v+bgrwkNrFEEic+5u+TxFyfYsO41sBEOClcXL24TWXUD9Dy0lgeI0uyPWMv3V+o
         x6Uw==
X-Gm-Message-State: AOJu0YwT1xEX0qjvlYGHIBiiOL8AqkvE3P1J6RvVt4nV+no6l26HlHdr
	jQlZjofZK0kX9ccsXcVhKQSLdR+zxKR9p2+1
X-Google-Smtp-Source: AGHT+IEUNrbu0Z9BpUItXofBaI+n5z5lCx24thBAXbpI0Px4fxT7uJcUOynP4KDp00WsSdonRMa8TQ==
X-Received: by 2002:a17:90a:1783:b0:279:e6f:2e4b with SMTP id q3-20020a17090a178300b002790e6f2e4bmr9188351pja.0.1696664472020;
        Sat, 07 Oct 2023 00:41:12 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id v6-20020a17090a00c600b00277326038dasm4948411pjd.39.2023.10.07.00.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 00:41:11 -0700 (PDT)
Date: Sat, 07 Oct 2023 16:41:10 +0900 (JST)
Message-Id: <20231007.164110.2300519476669399189.fujita.tomonori@gmail.com>
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

Sorry, I found that it doesn't work well when you try to build
AX88796B_PHY as a module.

With AX88796B_PHY=m, if you choose the C version, then you got
AX88796B_C_PHY=y; the driver will be built-in.

Seems that we need a trick in Makefile in any ways, I'll go with the
original version of this patch; the simplest, I think.


