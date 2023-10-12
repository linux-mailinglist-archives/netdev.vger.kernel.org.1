Return-Path: <netdev+bounces-40345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD6E7C6D81
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 13:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C8E282830
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 11:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E4025100;
	Thu, 12 Oct 2023 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O816NhHn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F89F24A05;
	Thu, 12 Oct 2023 11:57:40 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE204EFD;
	Thu, 12 Oct 2023 04:57:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690d935dbc2so173570b3a.1;
        Thu, 12 Oct 2023 04:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697111859; x=1697716659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQEM11ppiLh7tdmfqX7SGRNzgwI01XZbHBFYgkzMudM=;
        b=O816NhHnCBuOb9KT1Ntwv0SYoB/JpObccZzBmZftnpMmFz73iSmlvQ1IMKWs1z2IwA
         7M0bOgRmbO8NKTyRns5ls49hXiZfeTrfhUUJSwLH46bpf3ycl+uyIgv27BvZDa9rYO2T
         8zmLz0uTeP3oaa3hHORabE8WVFMCT74BGVfVXmJ0xjW11r/fJxA4NrTIiFvcH8gDnZJK
         3DnE71AUY3IkXkQy+k3HWuH1z9hewMeShu8GrwRwnrO3tar+xuckDf+ur3WB8hUltInn
         M/lrIWIqN7QRpFJ0UFqBTKk9DdnUzwzqwaKwHyhSueMzCJAkSTyu9yE5C4D701PFbbNP
         lsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697111859; x=1697716659;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HQEM11ppiLh7tdmfqX7SGRNzgwI01XZbHBFYgkzMudM=;
        b=aRQzXwUk97Ei5m/D7lIV8hVcelhlaUetZWpPZ1AD32zj8dV1lNvNPatBwwoo+Pc5G/
         AbJ2LxiCsLwETguxfmIOHuvm/awRaEVv4eRyO3Ntd8TUgMNnzYCpSdRWrcq5rAte/gK5
         SEA5K5d9IUHzk6NK2QWHO22ZQg9SL/cxbacwnF6bw4NV0PmYMPN+pIABliwqzxTkE7fY
         FMY+VRYDEMzmdigz82rlefkMZLIKB0q+WDXpSAUkPKFtD5P0J8krNPDIT2CB8DyR0mbZ
         eKewCSbvD0GKZG06w/p+b0lIZb8ULsXvQ0ilPSjdY4fDojMM+sYWsi+WXm0SFYTLLkTd
         8D2w==
X-Gm-Message-State: AOJu0YxlStsztDEp9OqwbNM2qckipNLy25oji+7V4QdJn36St99lTray
	hEr9f8h42yKfWEk1YWB8h4M=
X-Google-Smtp-Source: AGHT+IFQB4pa2UXDP3wFPGP2pMgjGtpDDufEZjp8IjMJWD2LoqE3iqudQD+MbIB1de4mu8iF0qOCuA==
X-Received: by 2002:a05:6a00:3985:b0:68f:c8b3:3077 with SMTP id fi5-20020a056a00398500b0068fc8b33077mr25660139pfb.1.1697111858510;
        Thu, 12 Oct 2023 04:57:38 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id v5-20020a63bf05000000b005894450b404sm1342433pgf.63.2023.10.12.04.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 04:57:38 -0700 (PDT)
Date: Thu, 12 Oct 2023 20:57:37 +0900 (JST)
Message-Id: <20231012.205737.1152392964209884159.fujita.tomonori@gmail.com>
To: gregkh@linuxfoundation.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 3/3] net: phy: add Rust Asix PHY driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <2023100955-scrambler-radio-e93a@gregkh>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
	<20231009013912.4048593-4-fujita.tomonori@gmail.com>
	<2023100955-scrambler-radio-e93a@gregkh>
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

On Mon, 9 Oct 2023 12:10:11 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Oct 09, 2023 at 10:39:12AM +0900, FUJITA Tomonori wrote:
>> This is the Rust implementation of drivers/net/phy/ax88796b.c. The
>> features are equivalent. You can choose C or Rust versionon kernel
>> configuration.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
>>  drivers/net/phy/Kconfig          |   7 ++
>>  drivers/net/phy/Makefile         |   6 +-
>>  drivers/net/phy/ax88796b_rust.rs | 129 +++++++++++++++++++++++++++++++
>>  rust/uapi/uapi_helper.h          |   2 +
>>  4 files changed, 143 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/net/phy/ax88796b_rust.rs
>> 
>> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
>> index 421d2b62918f..0317be180ac2 100644
>> --- a/drivers/net/phy/Kconfig
>> +++ b/drivers/net/phy/Kconfig
>> @@ -107,6 +107,13 @@ config AX88796B_PHY
>>  	  Currently supports the Asix Electronics PHY found in the X-Surf 100
>>  	  AX88796B package.
>>  
>> +config AX88796B_RUST_PHY
>> +	bool "Rust version driver for Asix PHYs"
>> +	depends on RUST_PHYLIB_BINDINGS && AX88796B_PHY
>> +	help
>> +	  Uses the Rust version driver for Asix PHYs (ax88796b_rust.ko)
>> +	  instead of the C version.
> 
> This does not properly describe what hardware this driver supports.  And

I'll add (by copying the description of the C driver).


> that's an odd way to describe the module name, but I see none of the
> other entries in this file do that either, so maybe the PHY subsystm
> doesn't require that?

I leave it to Andrew. This is the first driver in Rust so I thought
that users had no idea the relationship between the source file name
and the module file name.

