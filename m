Return-Path: <netdev+bounces-41050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C29E7C9715
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 00:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87449281C0A
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 22:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCEC12B88;
	Sat, 14 Oct 2023 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3rhDgFz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9CC26E16;
	Sat, 14 Oct 2023 22:39:32 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12637C9;
	Sat, 14 Oct 2023 15:39:31 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9d132d92cso9222675ad.0;
        Sat, 14 Oct 2023 15:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697323170; x=1697927970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPFaQ1LTAbMrVygJhEFrkNUoW5dlpLhBgjY1bYITzXs=;
        b=D3rhDgFzSeNGxDtWgl4q2NxQTBzk4cvychGD3N1B6k8+eqvzFFpAQR0IwjKM/SD4Iu
         t+V88Vgb2047aAxySL/zK/prcUi8UKzjaYVHRKYfUegWLd3dBIYt5KrdDgrpnBA7kx7W
         glRr8ar1yLhvEytOq4qvzSLD5HJ63mckBYUda6hcLUYYTy/6kiNHBjjGSCCp4LMl/qTi
         i/QMwWXImJjfHsz7oRyu7+PboyOqPREcqcYqMAwCW7O6gKbS3jc6H9hjhcIPIksHePeP
         oPMbmYiE1UhxYSvNR4e4Bpy3Qq4u6a8HO0Ie0s5ldbWum5xU2+RIySEiTD7yf+ZBarxh
         mLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697323170; x=1697927970;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uPFaQ1LTAbMrVygJhEFrkNUoW5dlpLhBgjY1bYITzXs=;
        b=euwNPyw4GVcmHLkUjVV0m/cDRKU5j3cXQgCiAZKvTw4yoqQKK+kjM6XdApJ0fq4OGc
         B0wf1CTRfoFVB3FXStoP5CtqGLpEn1uJo7oWhh5ntfV42erKb4w6JTDKWFcQgutCjYq0
         7MAj1UVJ3mNJQlW20qPgQXaeG/gUAx8KvceXxgU9BDF3FjVdn28c1tDY2M1g1w/DLkoT
         uFo2h8H6tI1UMIt/dbefiXaDusb+jKrUxB/HkRXEwVyLAP57sst2XLV+WCWeqHwb8jSX
         XhEMdrRtB2w/N7FlmqswtDSwl8iD8msYNjpToTB1Ahz/Y3oEQ43Ez58851sBxEXHOi8Z
         2LTw==
X-Gm-Message-State: AOJu0Yzpru7bxJtFxGFhqrzzFa53a/yz9JQJ/wGVIjYCJ8iqYDjFmOsI
	xGHSTBI4TA6yuzHwmhuwBPxVehuT5gDDZtQw
X-Google-Smtp-Source: AGHT+IHAqzwSlxWogHqzIsVcozo+6nCwl5Lh6L7CwjIU9doHT3b1Ny0FMs/nV+c7OGFYcBIU6iEjoA==
X-Received: by 2002:a17:90a:4d88:b0:263:730b:f568 with SMTP id m8-20020a17090a4d8800b00263730bf568mr28626896pjh.3.1697323170256;
        Sat, 14 Oct 2023 15:39:30 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a19c500b0027d0a60b9c9sm2326067pjj.28.2023.10.14.15.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 15:39:29 -0700 (PDT)
Date: Sun, 15 Oct 2023 07:39:29 +0900 (JST)
Message-Id: <20231015.073929.156461103776360133.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <9d70de37-c5ed-4776-a00f-76888e1230aa@proton.me>
References: <3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me>
	<20231015.011502.276144165010584249.fujita.tomonori@gmail.com>
	<9d70de37-c5ed-4776-a00f-76888e1230aa@proton.me>
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

On Sat, 14 Oct 2023 17:07:09 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 14.10.23 18:15, FUJITA Tomonori wrote:
>> On Sat, 14 Oct 2023 14:54:30 +0000
>> Benno Lossin <benno.lossin@proton.me> wrote:
>> 
>>> On 14.10.23 12:32, FUJITA Tomonori wrote:
>>>> On Sat, 14 Oct 2023 08:07:03 +0000
>>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>
>>>>> On 14.10.23 09:22, FUJITA Tomonori wrote:
>>>>>> On Fri, 13 Oct 2023 21:31:16 +0000
>>>>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>>>>> +    /// the exclusive access for the duration of the lifetime `'a`.
>>>>>>>
>>>>>>> In some other thread you mentioned that no lock is held for
>>>>>>> `resume`/`suspend`, how does this interact with it?
>>>>>>
>>>>>> The same quesiton, 4th time?
>>>>>
>>>>> Yes, it is not clear to me from the code/safety comment alone why
>>>>> this is safe. Please improve the comment such that that is the case.
>>>>>
>>>>>> PHYLIB is implemented in a way that PHY drivers exlusively access to
>>>>>> phy_device during the callbacks.
>>>>>
>>>>> As I suggested in a previous thread, it would be extremely helpful
>>>>> if you add a comment on the `phy` abstractions module that explains
>>>>> how `PHYLIB` is implemented. Explain that it takes care of locking
>>>>> and other safety related things.
>>>>
>>>>   From my understanding, the callers of suspend() try to call suspend()
>>>> for a device only once. They lock a device and get the current state
>>>> and update the sate, then unlock the device. If the state is a
>>>> paticular value, then call suspend(). suspend() and resume() are also
>>>> called where only one thread can access a device.
>>>
>>> Maybe explain this in the docs? In the future, when I will come
>>> into contact with this again, I will probably have forgotten this
>>> conversation, but the docs are permanent and can be re-read.
>> 
>> You meant adding this to the code?  like dding this to Device's #
>> Safety comment?
> 
> I would not put it in the `# Safety` section. Instead, put this
> information on the phy module itself (the `//!` comments at the very
> top of the file). I also would suggest to not take the above paragraph
> word by word, but to improve and extend it.

Sure, I'll try.


>>>> Anyway,
>>>>
>>>> phy_id()
>>>> state()
>>>> get_link()
>>>> is_autoneg_enabled()
>>>> is_autoneg_completed()
>>>>
>>>> doesn't modify Self.
>>>
>>> yes, these should all be `&self`.
>>>
>>>> The rest modifies then need to be &mut self? Note that function like read_*
>>>> updates the C data structure.
>>>
>>> What exactly does it update? In Rust there is interior mutability
>>> which is used to implement mutexes. Interior mutability allows
>>> you to modify values despite only having a `&T` (for more info
>>> see [1]). Our `Opaque<T>` type uses this pattern as well (since
>>> you get a `*mut T` from `&Opaque<T>`) and it is the job of the
>>> abstraction writer to figure out what mutability to use.
>>>
>>> [1]: https://doc.rust-lang.org/reference/interior-mutability.html
>>>
>>> I have no idea what exactly `read_*` modifies on the C side.
>>> Mapping C functions to `&self`, `&mut self` and other receiver types
>>> is not obvious in all cases. I would focus more on the following aspect
>>> of `&mut self` and `&self`:
>>>
>>> Since `&mut self` is unique, only one thread per instance of `Self`
>>> can call that function. So use this when the C side would use a lock.
>>> (or requires that only one thread calls that code)
>> 
>> I guess that the rest are &mut self but let me continue to make sure.
>> 
>> I think that you already know that Device instance only was created in
>> the callbacks. Before the callbacks are called, PHYLIB holds
>> phydev->lock except for resume()/suspend(). As explained in the
>> previous mail, only one thread calls resume()/suspend().
> 
> The information in this paragraph would also fit nicely into the
> phy module docs.

Ok.

>> btw, methods in Device calling a C side function like mdiobus_read,
>> mdiobus_write, etc which never touch phydev->lock. Note that the c
>> side functions in resume()/suspned() methods don't touch phydev->lock
>> too.
>> 
>> There are two types how the methods in Device changes the C side data.
>> 
>> 1. read/write/read_paged
>> 
>> They call the C side functions, mdiobus_read, mdiobus_write,
>> phy_read_paged, respectively.
>> 
>> phy_device has a pointer to mii_bus object. It has stats for
>> read/write. So everytime they are called, stats is updated.
> 
> I think for reading & updating some stats using `&self`
> should be fine. `write` should probably be `&mut self`.

Can you tell me why exactly you think in that way?

Firstly, you think that reading & updating some stats using `&self` should be fine.

What's the difference between read() and set_speed(), which you think, needs &mut self.

Because set_speed() updates the member in phy_device and read()
updates the object that phy_device points to?


Secondly, What's the difference between read() and write(), where you
think that read() is &self write() is &mut self.

read() is reading from hardware register. write() is writing a value
to hardware register. Both updates the object that phy_device points
to?


>> 2. the rest
>> 
>> The C side functions in the rest of methods in Device updates some
>> members in phy_device like set_speed() method does.
> 
> Those setter functions should be `&mut self`.

Ok.

>>> Since multiple `&self` references are allowed to coexist, you should
>>> use this for functions which perform their own serialization/do not
>>> require serialization.
>> 
>> just to be sure, the C side guarantees that only one reference exists.
> 
> I see, then the `from_raw` function should definitely return
> a `&mut Device`. Note that you can still call `&T` functions
> when you have a `&mut T`.

It already returns &mut Device so no change is necessary here, right?

unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self
{

If you want more additional comment on from_raw(), please let me know.


>>> If you cannot decide what certain function receivers should be, then
>>> we can help you, but I would need more info on what the C side is doing.
>> 
>> If you need more info on the C side, please let me know.
> 
> What about these functions?
> - resolve_aneg_linkmode
> - genphy_soft_reset
> - init_hw
> - start_aneg
> - genphy_read_status
> - genphy_update_link
> - genphy_read_lpa
> - genphy_read_abilities

As Andrew replied, all the functions update some member in phy_device.



