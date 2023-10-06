Return-Path: <netdev+bounces-38597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39D37BB9CF
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 15:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173AA1C209AE
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD5B2376B;
	Fri,  6 Oct 2023 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QocZy6Nd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD720B15;
	Fri,  6 Oct 2023 13:53:32 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938F883;
	Fri,  6 Oct 2023 06:53:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-692af7b641cso343688b3a.1;
        Fri, 06 Oct 2023 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696600407; x=1697205207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFDCbxb27UG+FdpCEjiPZrC2+8I39JUfcTEB3I34fZs=;
        b=QocZy6Nd+3KdsswEye1hRheRXLK/d/y6hdET2XRvaW91rwnkRj740L3zu6WW1IUYXn
         ssdUaVksLI2rrL+ezw0/l/jttkuqtLi++21vR9QFlMnc9z3m3OMY6ykCHxxqyuKSfEjf
         BgdU0CMbJHpbuY0RLPu6wLPX6G9rYlUgS8yszEJoVJv24caqHFosTbIeQDP9c5wf0ytm
         kyoTIreaB8OxM0aipJmbLVyZdAt5msmnM32VezyY6AdOXDs9E2Xq92UEwTriA+2+dhbH
         2DxEbD3WSV8o2Zq8cqJBP/IL3aGODrRhVyrH/IcjqUJvUJot4F6kTCLUEWy12raBZMvt
         aq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696600407; x=1697205207;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BFDCbxb27UG+FdpCEjiPZrC2+8I39JUfcTEB3I34fZs=;
        b=sW2zCCFKCk6DkrMgn6YooGO4A6XvFEX7QAsHnnVAEqF4Ll3YH8EfldtG8byRCq5fcv
         5QEjzUhVxsW6dKm5Ba83sZnho4wTFpADERi/EW1a0x37dOLzX0Rp/hh3FHsUee4AZSAK
         DYGScQdDD/VP38vxeskicu/d5ULb9xiKiSxcJ2KLthA5APiCAMBnPxlkaLDEToZ1UHa/
         xVR8NxtRhzZgLL2hkNlOxEXKe7ETvUJovHO0ZMrl2KkyOubYSPxfrQ6ONYBTY8oo4Va9
         9mNLjcpDrdbuVY0ZOi2jBEgT6SREgFxH1xzl4sx6/zG/g2T9WO6DFIKVZbvNi0gelxCP
         4JUw==
X-Gm-Message-State: AOJu0YztokwzBYAT7bGaWmT5vJCu3hzTFdk7ePRHdCJyOCpfPWqv2JqZ
	/mO5YEK4SLyAC0KV+InE7fQ=
X-Google-Smtp-Source: AGHT+IFSvkZv1D+f4638newpnqJU8/7iKcMKCEtj1XiUfVOToIaCgbfg5f7gKbmzMv70ipZ/pzToNg==
X-Received: by 2002:a05:6a21:6da4:b0:15a:3285:e834 with SMTP id wl36-20020a056a216da400b0015a3285e834mr8588973pzb.4.1696600406871;
        Fri, 06 Oct 2023 06:53:26 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id a2-20020a1709027d8200b001c736b0037fsm3856268plm.231.2023.10.06.06.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 06:53:26 -0700 (PDT)
Date: Fri, 06 Oct 2023 22:53:25 +0900 (JST)
Message-Id: <20231006.225325.1176505861124451190.fujita.tomonori@gmail.com>
To: gregkh@linuxfoundation.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <2023100635-product-gills-3d7e@gregkh>
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
	<20231006094911.3305152-4-fujita.tomonori@gmail.com>
	<2023100635-product-gills-3d7e@gregkh>
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

On Fri, 6 Oct 2023 12:31:59 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Oct 06, 2023 at 06:49:11PM +0900, FUJITA Tomonori wrote:
>> +config AX88796B_RUST_PHY
>> +	bool "Rust reference driver"
>> +	depends on RUST && AX88796B_PHY
>> +	default n
> 
> Nit, "n" is always the default, there is no need for this line.

Understood, I'll remove this line.

>> +	help
>> +	  Uses the Rust version driver for Asix PHYs.
> 
> You need more text here please.  Provide a better description of what
> hardware is supported and the name of the module if it is built aas a
> module.
> 
> Also that if you select this one, the C driver will not be built (which
> is not expressed in the Kconfig language, why not?

Because the way to load a PHY driver module can't handle multiple
modules with the same phy id (a NIC driver loads a PHY driver module).
There is no machinism to specify which PHY driver module should be
loaded when multiple PHY modules have the same phy id (as far as I know).

The Kconfig file would be like the following. AX88796B_RUST_PHY
depends on AX88796B_PHY so the description of AX88796B_PHY is enough?
I'll add the name of the module.


config AX88796B_PHY
	tristate "Asix PHYs"
	help
	  Currently supports the Asix Electronics PHY found in the X-Surf 100
	  AX88796B package.

config AX88796B_RUST_PHY
	bool "Rust reference driver"
	depends on RUST && AX88796B_PHY
	default n
	help
	  Uses the Rust version driver for Asix PHYs.

>> +
>>  config BROADCOM_PHY
>>  	tristate "Broadcom 54XX PHYs"
>>  	select BCM_NET_PHYLIB
>> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
>> index c945ed9bd14b..58d7dfb095ab 100644
>> --- a/drivers/net/phy/Makefile
>> +++ b/drivers/net/phy/Makefile
>> @@ -41,7 +41,11 @@ aquantia-objs			+= aquantia_hwmon.o
>>  endif
>>  obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia.o
>>  obj-$(CONFIG_AT803X_PHY)	+= at803x.o
>> -obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
>> +ifdef CONFIG_AX88796B_RUST_PHY
>> +  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b_rust.o
>> +else
>> +  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
>> +endif
> 
> This can be expressed in Kconfig, no need to put this here, right?

Not sure. Is it possible? If we allow both modules to be built, I
guess it's possible though.


>>  obj-$(CONFIG_BCM54140_PHY)	+= bcm54140.o
>>  obj-$(CONFIG_BCM63XX_PHY)	+= bcm63xx.o
>>  obj-$(CONFIG_BCM7XXX_PHY)	+= bcm7xxx.o
>> diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
>> new file mode 100644
>> index 000000000000..d11c82a9e847
>> --- /dev/null
>> +++ b/drivers/net/phy/ax88796b_rust.rs
>> @@ -0,0 +1,129 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> No copyright line?  Are you sure?

Ah, I'll add.

