Return-Path: <netdev+bounces-43239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6491D7D1D31
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 15:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A46281DB4
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF891D280;
	Sat, 21 Oct 2023 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCYpDuwz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB679C5;
	Sat, 21 Oct 2023 13:00:20 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15ADD51;
	Sat, 21 Oct 2023 06:00:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27d1433c4ebso471986a91.0;
        Sat, 21 Oct 2023 06:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697893215; x=1698498015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vI9dKPvOUN2Bx6VXW3PBquv8M09qEjMsbU8isu2up4Y=;
        b=dCYpDuwzmIRV7gYFTjJgkCY7iELsQFXjZdzQQ/onERBWX2Yz4r7okyZ3qg9k73MC5y
         VosLc9r/1lRMllOaQhZRw7YZZ4OH17awGPiLVW8zXqjbqNR1H23rBtCzGkv3ATdbO7J9
         FVww3kO4HypTOfICKK/iOw4YZTXtpPSXlQF52EYQKFYTrP3cbsvGHw6ErFZn7rO1R0+a
         aDuuhKKpiBbGWWZuXQH3yxMBiYs/1LAlrMrv8nIyTMaupLmD2eaLNaMdUcM8rmcVjMek
         VGD9BokpoGd6qPW6t/7ik1Ibao97msI2JTeKaK8ruas8ml6Rdb3u4js/t8edbLatAoji
         NgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697893215; x=1698498015;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vI9dKPvOUN2Bx6VXW3PBquv8M09qEjMsbU8isu2up4Y=;
        b=DXFICs2XTr6n+IUucHJLgNaljOWep2Os4Q8KT8pxuxngqIUXVoqaEG2no2t07Ie0UM
         m4VET8MxbLzFOUPgdy+4ZcaFMqtGhz9HVMcVSGFExkIlUgi70fu2oeLmBHoXgp56cH61
         hXe3+SVehtDVZ6t5d6UtuHzoLtEHwCgYGobjA/WdMGa/Vtn26G4iMgTU4jcDb1VPmkdV
         82lCHRNgn7YLXY2K0muILivhOD/wmbQq6wjlIGliBb+8AaLkzxi2OoUoZtH/PDssDh1b
         QLK2/ToU9GgVNFextwQYr1cI3DpE44ZyME7Boq7Wbpaq1Ei79pM15bLvEzR5I3iE2vmn
         uvPA==
X-Gm-Message-State: AOJu0Ywa17jqdGl4AQfnyj1lgvGjT8PeYh1BGkg8cYblGk9cXNzGdw96
	hqoY/5dQ4fUIUPxzU5ZQwh4=
X-Google-Smtp-Source: AGHT+IFiZFP3wdribopm0Vr4QswAXV/v5kjmFUBHQgdDZhQTmwDP5SLu/8qQrZV3QoJ+i9glr0WwRA==
X-Received: by 2002:a17:903:2348:b0:1bb:9e6e:a9f3 with SMTP id c8-20020a170903234800b001bb9e6ea9f3mr4451755plh.4.1697893213837;
        Sat, 21 Oct 2023 06:00:13 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id jj5-20020a170903048500b001ca21c8abf7sm3156565plb.188.2023.10.21.06.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 06:00:13 -0700 (PDT)
Date: Sat, 21 Oct 2023 22:00:12 +0900 (JST)
Message-Id: <20231021.220012.2089903288409349337.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <23348649-2ef2-4b2d-9745-86587a72ae5e@proton.me>
References: <d8b23faa-4041-4789-ae96-5d8bf87070ad@proton.me>
	<20231021.213834.76499402455687702.fujita.tomonori@gmail.com>
	<23348649-2ef2-4b2d-9745-86587a72ae5e@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 21 Oct 2023 12:50:10 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 21.10.23 14:38, FUJITA Tomonori wrote:
>> On Sat, 21 Oct 2023 12:13:32 +0000
>> Benno Lossin <benno.lossin@proton.me> wrote:
>> 
>>>>>>> Can you please share your setup and the error? For me it booted
>>>>>>> fine.
>>>>>>
>>>>>> You use ASIX PHY hardware?
>>>>>
>>>>> It seems I have configured something wrong. Can you share your testing
>>>>> setup? Do you use a virtual PHY device in qemu, or do you boot it from
>>>>> real hardware with a real ASIX PHY device?
>>>>
>>>> real hardware with real ASIX PHY device.
>>>
>>> I see.
>>>
>>>> Qemu supports a virtual PHY device?
>>>
>>> I have no idea.
>> 
>> When I had a look at Qemu several months ago, it didn't support such.
>> 
>>> [...]
>>>
>>>>> I think this is very weird, do you have any idea why this
>>>>> could happen?
>>>>
>>>> DriverVtable is created on kernel stack, I guess.
>>>
>>> But how does that invalidate the function pointers?
>> 
>> Not only funciton pointers. You can't store something on stack for
>> later use.
> 
> It is not stored on the stack, it is only created on the stack and
> moved to a global static later on. The `module!` macro creates a
> `static mut __MOD: Option<Module>` where the module data is stored in.

I know. The problem is that we call phy_drivers_register() with
DriverVTable on stack. Then it was moved.


> It seems that constructing the driver table not at that location
> is somehow interfering with something?
> 
> Wedson has a patch [1] to create in-place initialized modules, but
> it probably is not completely finished, as he has not yet begun to
> post it to the list. But I am sure that it is mature enough for
> you to test this hypothesis.
> 
> [1]: https://github.com/wedsonaf/linux/commit/484ec70025ff9887d9ca228ec631264039cee355
> 
> -- 
> Cheers,
> Benno
> 
>>>>> If you don't mind, could you try if the following changes
>>>>> anything?
>>>>
>>>> I don't think it works. If you use const for DriverTable, DriverTable
>>>> is placed on read-only pages. The C side modifies DriverVTable array
>>>> so it does't work.
>>>
>>> Did you try it? Note that I copy the `DriverVTable` into the Module
>>> struct, so it will not be placed on a read-only page.
>> 
>> Ah, I misunderstood code. It doesn't work. DriverVTable on stack.
>> 
>> 
>>>>>        (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f:tt)*) => {
>>>>>            const N: usize = $crate::module_phy_driver!(@count_devices $($driver),+);
>>>>>            struct Module {
>>>>>                _drivers: [::kernel::net::phy::DriverVTable; N],
>>>>>            }
>>>>>
>>>>>            $crate::prelude::module! {
>>>>>                type: Module,
>>>>>                $($f)*
>>>>>            }
>>>>>
>>>>>            unsafe impl Sync for Module {}
>>>>>
>>>>>            impl ::kernel::Module for Module {
>>>>>                fn init(module: &'static ThisModule) -> Result<Self> {
>>>>> 		const DRIVERS: [::kernel::net::phy::DriverVTable; N] = [$(::kernel::net::phy::create_phy_driver::<$driver>()),+];
>>>>>                    let mut m = Module {
>>>>>                        _drivers: unsafe { core::ptr::read(&DRIVERS) },
>>>>>                    };
>>>>>                    let ptr = m._drivers.as_mut_ptr().cast::<::kernel::bindings::phy_driver>();
>>>>>                    ::kernel::error::to_result(unsafe {
>>>>>                        kernel::bindings::phy_drivers_register(ptr, m._drivers.len().try_into()?, module.as_ptr())
>>>>>                    })?;
>>>>>                    Ok(m)
>>>>>                }
>>>>>            }
>>>>>
>>>>> and also the variation where you replace `const DRIVERS` with
>>>>> `static DRIVERS`.
>>>>
>>>> Probably works. But looks like similar with the current code? This is
>>>> simpler?
>>>
>>> Just curious if it has to do with using `static` vs `const`.
>> 
>> static doesn't work too due to the same reason.
> 
> 
> 

