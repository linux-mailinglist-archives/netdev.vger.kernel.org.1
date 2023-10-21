Return-Path: <netdev+bounces-43233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF857D1CDB
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 13:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADCA81F21CD6
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 11:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FE7DF5C;
	Sat, 21 Oct 2023 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVKr4wbO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A6D313;
	Sat, 21 Oct 2023 11:36:29 +0000 (UTC)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3784C1A4;
	Sat, 21 Oct 2023 04:36:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27d27026dc2so500936a91.0;
        Sat, 21 Oct 2023 04:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697888183; x=1698492983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owbeeYpVzZ73tMjz7dmgBH9T/s/2Ttd2PFihL1Ia2d0=;
        b=MVKr4wbORZu1Ly2M8wnthDya5qUDD0eAPOJq2S0RWByR/h9L9NJqTV/i+OExEk8D3Q
         z9uMZKCvM3VGuOdLeWFM0HNbdWz9vi6l58vNI1b5iWOApLQBb6lRUiGZtnQnl3NM5vNw
         k1WB+J0+fCKel0gZT25oDuQUbyJ/2ZFVeAFriShUuOURzlrjviLx1hNKzB1WJbXAeYQP
         gONYfwfMPIblSyGQAXV+3O8YrcQVFkZ68/VU3U2SXmBk3WnjrYJwDuoL6Ln9E1cEkGgo
         07st7S5BDIpy8oBQnaAeNJkYCqWL+7vm1cHxVAu2JkMp045k9tCFuwlprU8YVr2WOU51
         K9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697888183; x=1698492983;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=owbeeYpVzZ73tMjz7dmgBH9T/s/2Ttd2PFihL1Ia2d0=;
        b=rVkSv9bhIMPAcy2ZQyaqeghN5Oe0/gwXh0p1uasohNfUcE+8PBkTvG72zDcWrJ64xl
         rFGeINgOoD2B8IgkSez40JYZG1RDVjvyXo7ECncsB5sTFDsnm0lr0Fk4P250l1mRYATv
         SdyxRfwqtXjGwd1flYu4aPkJ7bUbtSV+3RMw4x0iKvHOCaFv3eao2+O8WPv4TcW9IQ47
         7MYkiwdF9QAQozVOqRPjpefKMa4GKhonEObgrS19yy4d/9RNGsXGCAXBesaHoR/O5+NG
         LqRVtninQe6W6ayIDjVwRJTZIIFrnb2iFfIWmHSVv6kPDVqggLtjjeQFa/Ho2hbr76kz
         ejPQ==
X-Gm-Message-State: AOJu0YxHy5Vq7GhF4LFuLPFk5FiKRJylxjqozhSoNErsmRHJorXpfEjM
	9YhDY1/Df/CZRNku4hqa45w=
X-Google-Smtp-Source: AGHT+IHotfB2sZSs4qd1GsIN6q+4toschiovcinyh2+QNpmEM/xv8ZW7ruPygzhcIc1vzZ/J/av1lw==
X-Received: by 2002:a17:90b:3e8e:b0:27d:32d8:5f23 with SMTP id rj14-20020a17090b3e8e00b0027d32d85f23mr4899051pjb.2.1697888183480;
        Sat, 21 Oct 2023 04:36:23 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a005400b0026cecddfc58sm5175166pjb.42.2023.10.21.04.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 04:36:22 -0700 (PDT)
Date: Sat, 21 Oct 2023 20:36:22 +0900 (JST)
Message-Id: <20231021.203622.624978584179221727.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <fa420b54-b381-4534-8568-91286eb7d28b@proton.me>
References: <4e3e0801-b8b2-457b-aee1-086d20365890@proton.me>
	<20231021.192741.2305009064677924338.fujita.tomonori@gmail.com>
	<fa420b54-b381-4534-8568-91286eb7d28b@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 21 Oct 2023 11:21:12 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 21.10.23 12:27, FUJITA Tomonori wrote:
>> On Sat, 21 Oct 2023 08:37:08 +0000
>> Benno Lossin <benno.lossin@proton.me> wrote:
>> 
>>> On 21.10.23 09:30, FUJITA Tomonori wrote:
>>>> On Sat, 21 Oct 2023 07:25:17 +0000
>>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>
>>>>> On 20.10.23 14:54, FUJITA Tomonori wrote:
>>>>>> On Fri, 20 Oct 2023 09:34:46 +0900 (JST)
>>>>>> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>>>>>>
>>>>>>> On Thu, 19 Oct 2023 15:20:51 +0000
>>>>>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>>>>
>>>>>>>> I would like to remove the mutable static variable and simplify
>>>>>>>> the macro.
>>>>>>>
>>>>>>> How about adding DriverVTable array to Registration?
>>>>>>>
>>>>>>> /// Registration structure for a PHY driver.
>>>>>>> ///
>>>>>>> /// # Invariants
>>>>>>> ///
>>>>>>> /// The `drivers` slice are currently registered to the kernel via `phy_drivers_register`.
>>>>>>> pub struct Registration<const N: usize> {
>>>>>>>        drivers: [DriverVTable; N],
>>>>>>> }
>>>>>>>
>>>>>>> impl<const N: usize> Registration<{ N }> {
>>>>>>>        /// Registers a PHY driver.
>>>>>>>        pub fn register(
>>>>>>>            module: &'static crate::ThisModule,
>>>>>>>            drivers: [DriverVTable; N],
>>>>>>>        ) -> Result<Self> {
>>>>>>>            let mut reg = Registration { drivers };
>>>>>>>            let ptr = reg.drivers.as_mut_ptr().cast::<bindings::phy_driver>();
>>>>>>>            // SAFETY: The type invariants of [`DriverVTable`] ensure that all elements of the `drivers` slice
>>>>>>>            // are initialized properly. So an FFI call with a valid pointer.
>>>>>>>            to_result(unsafe {
>>>>>>>                bindings::phy_drivers_register(ptr, reg.drivers.len().try_into()?, module.0)
>>>>>>>            })?;
>>>>>>>            // INVARIANT: The `drivers` slice is successfully registered to the kernel via `phy_drivers_register`.
>>>>>>>            Ok(reg)
>>>>>>>        }
>>>>>>> }
>>>>>>
>>>>>> Scratch this.
>>>>>>
>>>>>> This doesn't work. Also simply putting slice of DriverVTable into
>>>>>> Module strcut doesn't work.
>>>>>
>>>>> Why does it not work? I tried it and it compiled fine for me.
>>>>
>>>> You can compile but the kernel crashes. The addresses of the callback
>>>> functions are invalid.
>>>
>>> Can you please share your setup and the error? For me it booted
>>> fine.
>> 
>> You use ASIX PHY hardware?
> 
> It seems I have configured something wrong. Can you share your testing
> setup? Do you use a virtual PHY device in qemu, or do you boot it from
> real hardware with a real ASIX PHY device?

real hardware with real ASIX PHY device.

Qemu supports a virtual PHY device?


>> I use the following macro:
>> 
>>      (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f:tt)*) => {
>>          const N: usize = $crate::module_phy_driver!(@count_devices $($driver),+);
>>          struct Module {
>>              _drivers: [::kernel::net::phy::DriverVTable; N],
>>          }
>> 
>>          $crate::prelude::module! {
>>              type: Module,
>>              $($f)*
>>          }
>> 
>>          unsafe impl Sync for Module {}
>> 
>>          impl ::kernel::Module for Module {
>>              fn init(module: &'static ThisModule) -> Result<Self> {
>>                  let mut m = Module {
>>                      _drivers:[$(::kernel::net::phy::create_phy_driver::<$driver>()),+],
>>                  };
>>                  let ptr = m._drivers.as_mut_ptr().cast::<::kernel::bindings::phy_driver>();
>>                  ::kernel::error::to_result(unsafe {
>>                      kernel::bindings::phy_drivers_register(ptr, m._drivers.len().try_into()?, module.as_ptr())
>>                  })?;
>>                  Ok(m)
>>              }
>>          }
>> 

(snip)

>> [  615.365054] RIP: 0010:phy_check_link_status+0x28/0xd0
>> [  615.365065] Code: 1f 00 0f 1f 44 00 00 55 48 89 e5 41 56 53 f6 87 dd 03 00 00 01 0f 85 ac 00 00 00 49 89 fe 48 8b 87 40 03 00 00 48 85 c0 74 13 <48> 8b 80 10 01 00 00 4c 89 f7 48 85 c0 74 0e ff d0 eb 0f bb fb ff
>> [  615.365104] RSP: 0018:ffffc90000823de8 EFLAGS: 00010286
>> [  615.365116] RAX: ffffc90000752d88 RBX: ffff8881023524e0 RCX: ffff888102e39980
>> [  615.365130] RDX: ffff88846fbb18e8 RSI: 0000000000000000 RDI: ffff888102352000
>> [  615.365144] RBP: ffffc90000823df8 R08: 8080808080808080 R09: fefefefefefefeff
>> [  615.365157] R10: 0000000000000007 R11: 6666655f7265776f R12: ffff88846fbb18c0
>> [  615.365171] R13: ffff888102b75000 R14: ffff888102352000 R15: ffff888102352000
>> [  615.365185] FS:  0000000000000000(0000) GS:ffff88846fb80000(0000) knlGS:0000000000000000
>> [  615.365210] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  615.365222] CR2: ffffc90000752e98 CR3: 0000000111635000 CR4: 0000000000750ee0
>> [  615.365237] PKRU: 55555554
>> [  615.365247] note: kworker/14:1[147] exited with irqs disabled
> 
> I think this is very weird, do you have any idea why this
> could happen?

DriverVtable is created on kernel stack, I guess.

> If you don't mind, could you try if the following changes
> anything?

I don't think it works. If you use const for DriverTable, DriverTable
is placed on read-only pages. The C side modifies DriverVTable array
so it does't work.


>      (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f:tt)*) => {
>          const N: usize = $crate::module_phy_driver!(@count_devices $($driver),+);
>          struct Module {
>              _drivers: [::kernel::net::phy::DriverVTable; N],
>          }
> 
>          $crate::prelude::module! {
>              type: Module,
>              $($f)*
>          }
> 
>          unsafe impl Sync for Module {}
> 
>          impl ::kernel::Module for Module {
>              fn init(module: &'static ThisModule) -> Result<Self> {
> 		const DRIVERS: [::kernel::net::phy::DriverVTable; N] = [$(::kernel::net::phy::create_phy_driver::<$driver>()),+];
>                  let mut m = Module {
>                      _drivers: unsafe { core::ptr::read(&DRIVERS) },
>                  };
>                  let ptr = m._drivers.as_mut_ptr().cast::<::kernel::bindings::phy_driver>();
>                  ::kernel::error::to_result(unsafe {
>                      kernel::bindings::phy_drivers_register(ptr, m._drivers.len().try_into()?, module.as_ptr())
>                  })?;
>                  Ok(m)
>              }
>          }
> 
> and also the variation where you replace `const DRIVERS` with
> `static DRIVERS`.

Probably works. But looks like similar with the current code? This is
simpler?

