Return-Path: <netdev+bounces-43236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CE37D1D29
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 14:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C8E282062
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 12:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE7315D5;
	Sat, 21 Oct 2023 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LU1xEtzv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AA1A48;
	Sat, 21 Oct 2023 12:38:38 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1737A1A4;
	Sat, 21 Oct 2023 05:38:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bf20d466cdso319819b3a.1;
        Sat, 21 Oct 2023 05:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697891916; x=1698496716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pT2a60W5b99aNzf8nFI9/WY2ze+GwSU3HjJQSnLWIQ=;
        b=LU1xEtzvdLyA4WalJzlHX41uPC/IzlYtromAVMK7fbzvgBuAdDYohZQDNIgUuJ7oEO
         GOiPp14yvPF9fScXs5aDPYrRNApC1A0r103o/gwUjZwvd9BhTXiiYMskwphiZxPklaT8
         CyPaLb56yl96uslWjr/D5vbbs+n26PsfaivOABRcbGD/Zi7ZWK13Iziifp7KxHyZdM7S
         cqn6zm9cm3fx4A6KY7h1FE2s7C+3LLKnd5hkbDXhlVx/pvgQZLtr5LzLvJDVaJt0qAZ6
         21UGcImel+/5cFYJtU3nqe4TWZX0WiY4bQr06NpfCbKBnhOxtauCmpBAM9qa8vuSlK/K
         e+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697891916; x=1698496716;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7pT2a60W5b99aNzf8nFI9/WY2ze+GwSU3HjJQSnLWIQ=;
        b=CCUiTvx0MnI3DkUm/gveV6IrnbBuTD+uqMwr1cmn8rNMg92y/WJenNANLN7PwiwJBs
         eeW8zh095mfbcnjCNBZERKbRW1HUMOhkdxGgpxWlGH4cFmhfDuQgqtZuPBMTu1JzBPo3
         6z3dWfPUI8vM5S6P5c7NkRcih7RabkCt5+LprbHk7ptutd2tHmTmMW68kKxhDQT89tnm
         TVt2kU3maBmXndsXYFHPO9Qg8pHvL3YHNyo67Y0mV6c/H9BhD0wyA+dcQXtsH2/Pmmk3
         CWkFycJb6uj2Sv8DIHErXLqqMC0mruawwjI2Z/IF3SkYJ4Nf4tz9oemS8iWYR/ogEZEz
         5Z7g==
X-Gm-Message-State: AOJu0YxJFJzsb6FCkmPSQ6pyZMoxqFKDTeWnXyCSp4r+sWzWXMy0m0CF
	b42FsAT4WkEhlTOoZrTdvAsWBohJHtvrosRW
X-Google-Smtp-Source: AGHT+IHpZ4awz7glluPHL6WIkq8CJfFuSxqZ/PjUcTyKujtEvlPdtFvy6RgV5FKpgP6if4F0ddd3wQ==
X-Received: by 2002:a05:6a00:3a0a:b0:690:d0d4:6fb0 with SMTP id fj10-20020a056a003a0a00b00690d0d46fb0mr4449944pfb.3.1697891916353;
        Sat, 21 Oct 2023 05:38:36 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id r26-20020aa7989a000000b00696e8215d28sm3200367pfl.20.2023.10.21.05.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 05:38:35 -0700 (PDT)
Date: Sat, 21 Oct 2023 21:38:34 +0900 (JST)
Message-Id: <20231021.213834.76499402455687702.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <d8b23faa-4041-4789-ae96-5d8bf87070ad@proton.me>
References: <fa420b54-b381-4534-8568-91286eb7d28b@proton.me>
	<20231021.203622.624978584179221727.fujita.tomonori@gmail.com>
	<d8b23faa-4041-4789-ae96-5d8bf87070ad@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 21 Oct 2023 12:13:32 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

>>>>> Can you please share your setup and the error? For me it booted
>>>>> fine.
>>>>
>>>> You use ASIX PHY hardware?
>>>
>>> It seems I have configured something wrong. Can you share your testing
>>> setup? Do you use a virtual PHY device in qemu, or do you boot it from
>>> real hardware with a real ASIX PHY device?
>> 
>> real hardware with real ASIX PHY device.
> 
> I see.
> 
>> Qemu supports a virtual PHY device?
> 
> I have no idea.

When I had a look at Qemu several months ago, it didn't support such.

> [...]
> 
>>> I think this is very weird, do you have any idea why this
>>> could happen?
>> 
>> DriverVtable is created on kernel stack, I guess.
> 
> But how does that invalidate the function pointers?

Not only funciton pointers. You can't store something on stack for
later use.


>>> If you don't mind, could you try if the following changes
>>> anything?
>> 
>> I don't think it works. If you use const for DriverTable, DriverTable
>> is placed on read-only pages. The C side modifies DriverVTable array
>> so it does't work.
> 
> Did you try it? Note that I copy the `DriverVTable` into the Module
> struct, so it will not be placed on a read-only page.

Ah, I misunderstood code. It doesn't work. DriverVTable on stack.


>>>       (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f:tt)*) => {
>>>           const N: usize = $crate::module_phy_driver!(@count_devices $($driver),+);
>>>           struct Module {
>>>               _drivers: [::kernel::net::phy::DriverVTable; N],
>>>           }
>>>
>>>           $crate::prelude::module! {
>>>               type: Module,
>>>               $($f)*
>>>           }
>>>
>>>           unsafe impl Sync for Module {}
>>>
>>>           impl ::kernel::Module for Module {
>>>               fn init(module: &'static ThisModule) -> Result<Self> {
>>> 		const DRIVERS: [::kernel::net::phy::DriverVTable; N] = [$(::kernel::net::phy::create_phy_driver::<$driver>()),+];
>>>                   let mut m = Module {
>>>                       _drivers: unsafe { core::ptr::read(&DRIVERS) },
>>>                   };
>>>                   let ptr = m._drivers.as_mut_ptr().cast::<::kernel::bindings::phy_driver>();
>>>                   ::kernel::error::to_result(unsafe {
>>>                       kernel::bindings::phy_drivers_register(ptr, m._drivers.len().try_into()?, module.as_ptr())
>>>                   })?;
>>>                   Ok(m)
>>>               }
>>>           }
>>>
>>> and also the variation where you replace `const DRIVERS` with
>>> `static DRIVERS`.
>> 
>> Probably works. But looks like similar with the current code? This is
>> simpler?
> 
> Just curious if it has to do with using `static` vs `const`.

static doesn't work too due to the same reason.

