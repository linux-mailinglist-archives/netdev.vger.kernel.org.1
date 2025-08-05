Return-Path: <netdev+bounces-211703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C35D4B1B535
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9431832E3
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 13:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45361A3166;
	Tue,  5 Aug 2025 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTJt2iVQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962F033997;
	Tue,  5 Aug 2025 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401703; cv=none; b=QpVvaQ+9CSkx4H0W1tzyiba8NOFwHaHuR7jAIK3yZjGm4og+cTRGBg8f3ebljwf+D2xCms0OxNwSUeCrVDjsjLdLUDpfmWQSZukYl0kwJBHoa+lkVSiBPjw2x/el8SPl6dJ3Pdr2z2JR2SFWpCpeW3GYhmGEcLJtRWEMskcOec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401703; c=relaxed/simple;
	bh=ii7MUREVcea/8UbyeiswMNSULRCwnlO5STpDI2KjI+Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=VkM/dA6vNiAQ5Xkh5FTymM3K+JZS0m4x83RppdLFmAMcP+tVfHv3hn6C93e61YRYwX2pguMm5Kqni/dg2P11XtYk5CRbgyaHRCjSjDuhOFC0HmdsSq0oLV099fEPn+xS4C6tmkBZZptNGFps78jjpZw+5us1Bn81+E87x2vA1do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTJt2iVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF5DC4CEFA;
	Tue,  5 Aug 2025 13:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754401703;
	bh=ii7MUREVcea/8UbyeiswMNSULRCwnlO5STpDI2KjI+Y=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=KTJt2iVQROAVd34MI+xrBRauI0WnFN229RbBbmHANbt/EaUVfV0h2ElInh1FpVsXF
	 aoDAOpjcxW8cHvlOGTv6v4GeU0VsdniTMROsBs5gBNGdqgrr5sA4J5Ev5E8WteQWyY
	 PBmwwdDzPlj4NplJBicGxeo6b7hq+jQINGZLD5f3nr6ocWM+8HzAUe14ls9EoLPkiK
	 7M9vCIAqztxnLr0Fxu7ETqFPx8faDahNMFLPcKIMgPN6SfD3Z9WiJZK8UNAfwgVIcU
	 2VaZ3zN4x3tjub1e36NGD8vuH6CBLUplmxhI1qaHCGfhTVPDLloAbikygMT1hOP3c0
	 7QQEnBtZ77avQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Aug 2025 15:48:14 +0200
Message-Id: <DBUJHW6E5XKQ.25IT6RQ5MEUW1@kernel.org>
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
Cc: <linux-kernel@vger.kernel.org>, <daniel.almeida@collabora.com>,
 <rust-for-linux@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew@lunn.ch>, <hkallweit1@gmail.com>, <tmgross@umich.edu>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
 <a.hindborg@samsung.com>, <aliceryhl@google.com>,
 <anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
 <arnd@arndb.de>, <jstultz@google.com>, <sboyd@kernel.org>,
 <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
 <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
 <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
 <vschneid@redhat.com>, <tgunders@redhat.com>, <me@kloenk.dev>,
 <david.laight.linux@gmail.com>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <DBNPR4KQZXY5.279JBMO315A12@kernel.org>
 <20250802.104249.1482605492526656971.fujita.tomonori@gmail.com>
 <DBRW63AMB4D8.2HXGYM6FZRX3Z@kernel.org>
 <20250805.223721.524503114987740782.fujita.tomonori@gmail.com>
In-Reply-To: <20250805.223721.524503114987740782.fujita.tomonori@gmail.com>

On Tue Aug 5, 2025 at 3:37 PM CEST, FUJITA Tomonori wrote:
> On Sat, 02 Aug 2025 13:06:04 +0200
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>
>> On Sat Aug 2, 2025 at 3:42 AM CEST, FUJITA Tomonori wrote:
>>> On Mon, 28 Jul 2025 15:13:45 +0200
>>> "Danilo Krummrich" <dakr@kernel.org> wrote:
>>>> On Thu Feb 20, 2025 at 8:06 AM CET, FUJITA Tomonori wrote:
>>>>> +/// This process continues until either `cond` returns `true` or the=
 timeout,
>>>>> +/// specified by `timeout_delta`, is reached. If `timeout_delta` is =
`None`,
>>>>> +/// polling continues indefinitely until `cond` evaluates to `true` =
or an error occurs.
>>>>> +///
>>>>> +/// # Examples
>>>>> +///
>>>>> +/// ```rust,ignore
>>>>=20
>>>> Why ignore? This should be possible to compile test.
>>>
>>> https://lore.kernel.org/rust-for-linux/CEF87294-8580-4C84-BEA3-EB72E63E=
D7DF@collabora.com/
>>=20
>> I disagree with that. 'ignore' should only be used if we can't make it c=
ompile.
>>=20
>> In this case we can make it compile, we just can't run it, since there's=
 no real
>> HW underneath that we can read registers from.
>>=20
>> An example that isn't compiled will eventually be forgotten to be update=
d when
>> things are changed.
>
> I also prefer the example that can be compiled however I can't think
> of a compilable example that is similar to actual use cases (for
> example, waiting for some hardware condition). Do you have any ideas?

With my suggestion below, it should be compilable.

When you just take a &Io<SIZE> as argument in wait_for_hardware() you can c=
all
io.read(). Then define HW_READY as some random value and it should compile.

>>>>> +/// fn wait_for_hardware(dev: &mut Device) -> Result<()> {
>>>>=20
>>>> I think the parameter here can just be `&Io<SIZE>`.
>>>>=20
>>>>> +///     // The `op` closure reads the value of a specific status reg=
ister.
>>>>> +///     let op =3D || -> Result<u16> { dev.read_ready_register() };
>>>>> +///
>>>>> +///     // The `cond` closure takes a reference to the value returne=
d by `op`
>>>>> +///     // and checks whether the hardware is ready.
>>>>> +///     let cond =3D |val: &u16| *val =3D=3D HW_READY;
>>>>> +///
>>>>> +///     match read_poll_timeout(op, cond, Delta::from_millis(50), So=
me(Delta::from_secs(3))) {
>>>>> +///         Ok(_) =3D> {
>>>>> +///             // The hardware is ready. The returned value of the =
`op`` closure isn't used.
>>>>> +///             Ok(())
>>>>> +///         }
>>>>> +///         Err(e) =3D> Err(e),
>>>>> +///     }
>>>>> +/// }
>>>>> +/// ```

