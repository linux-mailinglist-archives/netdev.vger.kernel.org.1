Return-Path: <netdev+bounces-38626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503107BBBB8
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 17:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497011C20962
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8C82773D;
	Fri,  6 Oct 2023 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7bKDADo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDB023778;
	Fri,  6 Oct 2023 15:26:13 +0000 (UTC)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BB4A6;
	Fri,  6 Oct 2023 08:26:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-277317a0528so402246a91.0;
        Fri, 06 Oct 2023 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696605970; x=1697210770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWs8ND7KCyuXQOgmk8RXDoEuFVtGvmhdxOkCFO0nsMM=;
        b=C7bKDADoD9L+UtVsIOVGfX6MQXRVxxMVHVqWJMOj7lh6k5yhWsaJPNEMJPFQe7CtZC
         NVc0Aj0UvuJvaf6G3hBBtFeLaqLkmX8ea6Ysu7xxwFyOtL0ZkM9sZ9cLSIVPayaJRLrE
         AFJEIiNN9o5r70Q71z/vOGTdJ6u3A4BIakFWj2oEwBpbKX33poXo4gIik+wVIrVgAo2b
         1GfS45Rmc5gWvhUxLulllFzhCW9v/Qa/cK85yJiqmQUnPkMzXupG8HS29zTeEpXx8OTH
         Vbd8nSr1EpauIm38tD3Atd3ahqoDZLqFrg4BW7YlWDtAEzH/IuQUHeuYqOpRovvVAPGv
         nYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696605970; x=1697210770;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YWs8ND7KCyuXQOgmk8RXDoEuFVtGvmhdxOkCFO0nsMM=;
        b=fFI5LXLz9CoDgdivSXSkIoEsNrsgr6qJ2g30y3e03E8ri4RNyC1lor6RIE9AlUrdDf
         opb7I02nXLCsJQszBJFlw1BiQ1xtQixejkeSMzHlD04hnLg8Rn7AsrlqfPWg0Gl+H3n+
         YbfXGfB6Ifh28oE9DcBjFc4Oyh0Om4AoiMhSneoulNbqwOzyCUVh2SDCjVrRfv1XB9Pg
         U8WMeTBZhRPw6a2QMmThfOtQAm9z6wazW/a/RrHELn9PfeBLOEOBEDjUrg+siJmgSVMa
         cfZghMwRaWTIkUgni9jOwehHs/8i33lORPQJ0LGlOXU8DHdtt9VKqSssjcixAbGFmBK7
         bQEQ==
X-Gm-Message-State: AOJu0YzliMj7AWmZfrdwYXqCLATfJshkk7mcXd9MosPgVtzaiX0KwPdP
	51fAtENIId5WpH1My+WzwYo=
X-Google-Smtp-Source: AGHT+IEBMZq3QMFNEJ+N1fBnFBp2ehmLKpMFCEJZE3WIu+xKunY6REOe/9hF/u93a3O4kH3zo+Ddcg==
X-Received: by 2002:a17:90a:664d:b0:277:653b:3fef with SMTP id f13-20020a17090a664d00b00277653b3fefmr7665330pjm.3.1696605970423;
        Fri, 06 Oct 2023 08:26:10 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id co11-20020a17090afe8b00b00279060a0fccsm3620306pjb.9.2023.10.06.08.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 08:26:10 -0700 (PDT)
Date: Sat, 07 Oct 2023 00:26:09 +0900 (JST)
Message-Id: <20231007.002609.681250079112313735.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <19161969-1033-4fd5-9a24-ec21d66c6735@lunn.ch>
References: <2023100635-product-gills-3d7e@gregkh>
	<20231006.225325.1176505861124451190.fujita.tomonori@gmail.com>
	<19161969-1033-4fd5-9a24-ec21d66c6735@lunn.ch>
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

On Fri, 6 Oct 2023 16:35:28 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> The Kconfig file would be like the following. AX88796B_RUST_PHY
>> depends on AX88796B_PHY so the description of AX88796B_PHY is enough?
>> I'll add the name of the module.
>> 
>> 
>> config AX88796B_PHY
>> 	tristate "Asix PHYs"
>> 	help
>> 	  Currently supports the Asix Electronics PHY found in the X-Surf 100
>> 	  AX88796B package.
> 
> I _think_ you can add
> 
> 	depends on !AX88796B_RUST_PHY
> 
>> config AX88796B_RUST_PHY
>> 	bool "Rust reference driver"
>> 	depends on RUST && AX88796B_PHY
> 
> And then this becomes
> 
>     	depends on RUST && !AX88796B_PHY
> 
>> 	default n
>> 	help
>> 	  Uses the Rust version driver for Asix PHYs.
> 
> You then express the mutual exclusion in Kconfig, so that only one of
> AX88796B_PHY and AX88796B_RUST_PHY is ever enabled.
> 
> I've not actually tried this, so it might not work. Ideally you need
> to be able disable both, so that you can enable one.

This doesn't work.

ubuntu@ip-172-30-47-114:~/git/linux$ make LLVM=1 -j 32 menuconfig
drivers/net/phy/Kconfig:111:error: recursive dependency detected!
drivers/net/phy/Kconfig:111:    symbol AX88796B_RUST_PHY depends on AX88796B_PHY
drivers/net/phy/Kconfig:104:    symbol AX88796B_PHY depends on AX88796B_RUST_P

The following gurantees that only one is built but we hit the `select
AX88796B_PHY` problem in my previous mail.

config AX88796B_PHY
        tristate "Asix PHYs"
        help
          Currently supports the Asix Electronics PHY found in the X-Surf 100
          AX88796B package.

config AX88796B_RUST_PHY
        bool "Rust reference driver"
        depends on RUST && AX88796B_PHY=n
        help
          Uses the Rust version driver for Asix PHYs.


Greg, Sorry. I messed up copy-and-paste in the previous mail. I think that you meant the above.

> There is good documentation in
> 
> Documentation/kbuild/kconfig-language.rst
> 
>> >> +ifdef CONFIG_AX88796B_RUST_PHY
>> >> +  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b_rust.o
>> >> +else
>> >> +  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
>> >> +endif
>> > 
>> > This can be expressed in Kconfig, no need to put this here, right?
>> 
>> Not sure. Is it possible? If we allow both modules to be built, I
>> guess it's possible though.
> 
> If what i suggested above works, you don't need the ifdef, just list
> the two drivers are normal and let Kconfig only enable one at most.
> Or go back to your idea of using choice. Maybe something like
> 
> choice
> 	tristate "AX88796B PHY driver"
> 
> 	config CONFIG_AX88796B_PHY
> 		bool "C driver"
> 
> 	config CONFIG_AX88796B_RUST_PHY
> 	        bool "Rust driver"
> 		depends on RUST
> endchoice
> 
> totally untested....

Now I'm thinking that this is the best option. Kconfig would be the following:

config AX88796B_PHY
        tristate "Asix PHYs"
        help
         Currently supports the Asix Electronics PHY found in the X-Surf 100
         AX88796B package.

choice
        prompt "Implementation options"
        depends on AX88796B_PHY
        help
         There are two implementations for a driver for Asix PHYs; C and Rust.
         If not sure, choose C.

config AX88796B_C_PHY
        bool "The C version driver for Asix PHYs"

config AX88796B_RUST_PHY
        bool "The Rust version driver for Asix PHYs"
        depends on RUST

endchoice


No hack in Makefile:

obj-$(CONFIG_AX88796B_C_PHY)    += ax88796b.o
obj-$(CONFIG_AX88796B_RUST_PHY) += ax88796b_rust.o

