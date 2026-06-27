Return-Path: <netdev+bounces-302335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WB/HOPXNP2qWYQkAu9opvQ
	(envelope-from <netdev+bounces-302335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 15:19:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 504E76D1FBE
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 15:19:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=I88UiKZ+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302335-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302335-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F56C300E15F
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 13:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7533AFD16;
	Sat, 27 Jun 2026 13:11:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BAF3AD516
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 13:11:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782565884; cv=none; b=pt2f5xILaHGtzIfJ+DZ/nrDNGrdCDqQyoZWNNVfIEQCAokxEyyvctSJlSHZfTijO6sd0PPg3AWGoMQ8u+FKkxrvBbJ5FqfUqcP4OQoawqsNH9TX4YmrqUa04xnw9+rz2q769bfmL6M86aKBBa6JAD8JhdHRg1LaNdNjqPtLXrbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782565884; c=relaxed/simple;
	bh=0D3QtVTQ9/VyZ2GHdi7eh0l4L5UHK8hpuhOW6sOiDcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvyWFqX46yBLbj2ARM9NFjprEWSKQ/ceSF3GWNADi8ViXYh4V8izk5KYNkTVXMTC74av+2W2OOtLx/hMRzNe4nB2PMpLDDgIjyMAbP6EJkkh25G1qDeYcCdESeSJqYU2ge52CwiGHl8YeAbdPxQUfv+jnSHuu7bNlLd/OZBeSLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I88UiKZ+; arc=none smtp.client-ip=91.218.175.184
Message-ID: <b35c76ac-030a-4458-b85b-90ef7bcd3894@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782565869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTfmCVZgLsQAYxOGmqgi+d9SGTwihp06nkzRCBL0e+M=;
	b=I88UiKZ+5NSVSOCF6J4gIIRkkZToigFcGN3SeLfMhryeUfJLFw4kvfe+NuwObJ0Mm2vtFf
	tpQ1eQi/oIHPtsZgpegcnpq7MyzNRpWpRQ5M3ApzXTndtytC16U3Rb06RVXWdNorU7alQy
	0BGxL8bMeCgEkMhwf/yUBhSRJmUrCN4=
Date: Sat, 27 Jun 2026 21:10:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 07/10] rust: configfs: use `LocalModule` for
 `THIS_MODULE`
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann
 <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>,
 Carlos Llamas <cmllamas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260624-fix-fops-owner-v6-0-5295e333cb3e@linux.dev>
 <20260624-fix-fops-owner-v6-7-5295e333cb3e@linux.dev>
 <DJI7IOXAD84M.2F6VSBY64BO62@garyguo.net>
 <34a009d9-a1f3-4347-9e92-866ec05ddb60@linux.dev>
 <DJJ25JJ3TDO9.1UFOP60U0IPX5@garyguo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <DJJ25JJ3TDO9.1UFOP60U0IPX5@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: add header
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[rust-lang.github.io:url];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:atomlin@atomlin.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:daniel.almeida@collabora.com,m:arnd@arndb.de,m:brendan.higgins@linux.dev,m:david@davidgow.net,m:raemoar63@gmail.com,m:leitao@debian.org,m:axboe@kernel.dk,m:david.m.ertman@intel.com,m:leon@kernel.org,m:igor.korotin@linux.dev,m:fujita.tomonori@gmail.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rust-for-linux@vger.kernel.org,m:linux-modules@vger.kernel.org,m:driver-core@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:nova-gpu@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:kunit-dev@
 googlegroups.com,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-pci@vger.kernel.org,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	TAGGED_FROM(0.00)[bounces-302335-lists,netdev=lfdr.de];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER(0.00)[alvin.sun@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[46];
	FREEMAIL_TO(0.00)[garyguo.net,kernel.org,protonmail.com,google.com,umich.edu,suse.com,atomlin.com,linuxfoundation.org,gmail.com,ffwll.ch,collabora.com,arndb.de,linux.dev,davidgow.net,debian.org,kernel.dk,intel.com,android.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvin.sun@linux.dev,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,rust-lang.github.io:url,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 504E76D1FBE
X-Spam: Yes


On 6/26/26 22:41, Gary Guo wrote:
> On Fri Jun 26, 2026 at 3:35 AM BST, Alvin Sun wrote:
>> On 6/25/26 22:40, Gary Guo wrote:
>>> On Wed Jun 24, 2026 at 4:00 PM BST, Alvin Sun wrote:
>>>> Replace the `THIS_MODULE` static reference in the `configfs_attrs!`
>>>> macro with `this_module::<LocalModule>()`, and update
>>>> rnull to import `LocalModule` instead of `THIS_MODULE`, consistent
>>>> with the move of `THIS_MODULE` into the `ModuleMetadata` trait.
>>>>
>>>> Assisted-by: opencode:glm-5.2
>>>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>>>> Acked-by: Danilo Krummrich <dakr@kernel.org>
>>>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
>>>> ---
>>>>    drivers/block/rnull/configfs.rs | 6 ++----
>>>>    rust/kernel/configfs.rs         | 8 +++++---
>>>>    2 files changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
>>>> index c10a55fc58948..b2547ad1e5ddd 100644
>>>> --- a/drivers/block/rnull/configfs.rs
>>>> +++ b/drivers/block/rnull/configfs.rs
>>>> @@ -1,9 +1,7 @@
>>>>    // SPDX-License-Identifier: GPL-2.0
>>>>    
>>>> -use super::{
>>>> -    NullBlkDevice,
>>>> -    THIS_MODULE, //
>>>> -};
>>>> +use super::NullBlkDevice;
>>>> +use crate::LocalModule;
>>>>    use kernel::{
>>>>        block::mq::gen_disk::{
>>>>            GenDisk,
>>>> diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
>>>> index 2339c6467325d..c31d7882e216d 100644
>>>> --- a/rust/kernel/configfs.rs
>>>> +++ b/rust/kernel/configfs.rs
>>>> @@ -875,7 +875,7 @@ fn as_ptr(&self) -> *const bindings::config_item_type {
>>>>    ///                 configfs::Subsystem<Configuration>,
>>>>    ///                 Configuration
>>>>    ///                 >::new_with_child_ctor::<N,Child>(
>>>> -///             &THIS_MODULE,
>>>> +///             ::kernel::module::this_module::<crate::LocalModule>(),
>>>>    ///             &CONFIGURATION_ATTRS
>>>>    ///         );
>>>>    ///
>>>> @@ -1021,7 +1021,8 @@ macro_rules! configfs_attrs {
>>>>    
>>>>                        static [< $data:upper _TPE >] : $crate::configfs::ItemType<$container, $data>  =
>>>>                            $crate::configfs::ItemType::<$container, $data>::new::<N>(
>>>> -                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
>>>> +                            $crate::module::this_module::<LocalModule>(),
>>> ^ You only changed one single place. This is still plain `LocalModule`.
>> Initially I wrote it as `crate::LocalModule`, but clippy warned about it. So
>> instead of putting the crate path in the macro body, I added `use
>> crate::LocalModule` in the calling file.
>>
>> ```
>> warning: `crate` references the macro call's crate
>>       --> rust/kernel/configfs.rs:1024:59
>>        |
>> 1024 | ...  $crate::module::this_module::<crate::LocalModule>(),
>>        |                                                     ^^^^^ help:
>> to reference the macro definition's crate, use: `$crate`
>>        |
>>        = help: for further information visit
>> https://rust-lang.github.io/rust-clippy/rust-1.94.0/index.html#crate_in_macro_def
>>        = note: `-W clippy::crate-in-macro-def` implied by `-W clippy::all`
>>        = help: to override `-W clippy::all` add
>> `#[allow(clippy::crate_in_macro_def)]`
>>
>> warning: 1 warning emitted
>> ```
> Clippy has a point about `crate::` being usually wrong in macros, but it is what
> we actually want here, so obviously you should allow the warning.
>
> It is the exact same case in `vtable` macro, just that Clippy is unable to check
> proc macros!

Thanks for the detailed explanation.

I specifically searched for issues related to `crate_in_macro_def`, and 
this information is very useful to me.

Best regards,

Alvin

>
> Best,
> Gary
>
>> Alternatively, `#[allow(clippy::crate_in_macro_def)]` could be added on
>> the macro
>> definition. Would you suggest that approach?

