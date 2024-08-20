Return-Path: <netdev+bounces-120383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F36C959166
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A931F24E58
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D511C8FC2;
	Tue, 20 Aug 2024 23:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjRf5ooS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5801C8FB0;
	Tue, 20 Aug 2024 23:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198087; cv=none; b=kEYxvDwvNEfSt2RuB2Jdf7ABnpUT6BNUzcKgou73FEQkj/+pOg1Zmgsv3nzttFIwYK8uli8CkRkl1MRloPbY5gDXOW+FW0nQGUWcA0n3Ir3tOlkqh/f74ibTt4RBbujHUmWBAxgpNVnZcRPNSLoGv/Hk08LkLx9dAX9oXAxq4GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198087; c=relaxed/simple;
	bh=4mdkCSe0fkJOuOx4Ox5RpZdUfcgIarZoE3APQ1m02pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdYauo2KYYLVUOj4CIiDMIF18moXrGRP6ac+PXOpB6nX9iWNniMXq6lAlIOdI1wnxJsYORvi7ni/nwya9bTk88VKhl9Qq1+Ak6k7p4iJK4Hu56BWa0JCYNOGhShNM0SqtQoTBcjeujGdSZvdFb0yCTrGHcNmKQ8axcf/rmYyrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjRf5ooS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F3FC4AF09;
	Tue, 20 Aug 2024 23:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724198087;
	bh=4mdkCSe0fkJOuOx4Ox5RpZdUfcgIarZoE3APQ1m02pI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fjRf5ooSvbvaEcGuFHnnk2dD+IJ5GPDAmCulpfTNmnwbCkZgZEZLdHrNCHvQXATei
	 NmXAlmkMGnqLgsHc+WWT80UKQiPFN83IYob+KgcUp+KrYaGM1RaNlsa82TLFjy/nfn
	 ekvwLLLtRjgQK3bagVG+mL0HFk5MyBzoFR8PyfX2J9AcWcmHmDEYoF1g5BRiFzAcCe
	 JMMUi0yV4RFyhln/MtRrd8kfB7qeTz/iCo0Wh2zY98esJ1tBv6OLVe59aJS2uYW6DQ
	 9WChAGAsqX7HXnuUFoMHGMkOtxTbYCxgHqrRc3gYeXiIXM1p2zMsWwXQBTsvX5xTOE
	 T/LUWpaxaLsdw==
Message-ID: <93e4d643-a38b-4416-9097-af11b9c60f56@kernel.org>
Date: Wed, 21 Aug 2024 01:54:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/6] rust: sizes: add commonly used constants
To: Greg KH <gregkh@linuxfoundation.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me, aliceryhl@google.com
References: <20240820225719.91410-1-fujita.tomonori@gmail.com>
 <20240820225719.91410-2-fujita.tomonori@gmail.com>
 <2024082121-anemic-reformed-de75@gregkh>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <2024082121-anemic-reformed-de75@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/24 1:41 AM, Greg KH wrote:
> On Tue, Aug 20, 2024 at 10:57:14PM +0000, FUJITA Tomonori wrote:
>> Add rust equivalent to include/linux/sizes.h, makes code more
>> readable.
>>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
>> Reviewed-by: Trevor Gross <tmgross@umich.edu>
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
>>   rust/kernel/lib.rs   |  1 +
>>   rust/kernel/sizes.rs | 26 ++++++++++++++++++++++++++
>>   2 files changed, 27 insertions(+)
>>   create mode 100644 rust/kernel/sizes.rs
>>
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index 274bdc1b0a82..58ed400198bf 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -43,6 +43,7 @@
>>   pub mod page;
>>   pub mod prelude;
>>   pub mod print;
>> +pub mod sizes;
>>   mod static_assert;
>>   #[doc(hidden)]
>>   pub mod std_vendor;
>> diff --git a/rust/kernel/sizes.rs b/rust/kernel/sizes.rs
>> new file mode 100644
>> index 000000000000..834c343e4170
>> --- /dev/null
>> +++ b/rust/kernel/sizes.rs
>> @@ -0,0 +1,26 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Commonly used sizes.
>> +//!
>> +//! C headers: [`include/linux/sizes.h`](srctree/include/linux/sizes.h).
>> +
>> +/// 0x00000400
>> +pub const SZ_1K: usize = bindings::SZ_1K as usize;
>> +/// 0x00000800
>> +pub const SZ_2K: usize = bindings::SZ_2K as usize;
>> +/// 0x00001000
>> +pub const SZ_4K: usize = bindings::SZ_4K as usize;
>> +/// 0x00002000
>> +pub const SZ_8K: usize = bindings::SZ_8K as usize;
>> +/// 0x00004000
>> +pub const SZ_16K: usize = bindings::SZ_16K as usize;
>> +/// 0x00008000
>> +pub const SZ_32K: usize = bindings::SZ_32K as usize;
>> +/// 0x00010000
>> +pub const SZ_64K: usize = bindings::SZ_64K as usize;
>> +/// 0x00020000
>> +pub const SZ_128K: usize = bindings::SZ_128K as usize;
>> +/// 0x00040000
>> +pub const SZ_256K: usize = bindings::SZ_256K as usize;
>> +/// 0x00080000
>> +pub const SZ_512K: usize = bindings::SZ_512K as usize;
> 
> Why only some of the values in sizes.h?
> 
> And why can't sizes.h be directly translated into rust code without
> having to do it "by hand" here?  We do that for other header file
> bindings, right?

Those are all generated bindings from C headers, e.g. `bindings::SZ_2K `, but
bindgen isn't guaranteed to assign the type we want (`usize` in this case), plus
for size constants having the `bindings::` prefix doesn't really add any value.

Rust could also define those without using bindings at all, but this was already
discussed in earlier versions of this series.

- Danilo

> 
> thanks,
> 
> greg k-h
> 

