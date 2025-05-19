Return-Path: <netdev+bounces-191542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96FAABBE4B
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CD53BB53F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA82278E47;
	Mon, 19 May 2025 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaytfcXk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A398278E42;
	Mon, 19 May 2025 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747659124; cv=none; b=eLWAb00Ca3aN9vUvNpPYBhGM82hUkJ0JulFdyeAo09fwctxEyxVzE4ZC3FesRSjyCOxkZ9fClc3HijFgj/MtX8O/3sZKsnNae1JBqyOM5LT/mXtpIfyqBK1x6j1YPgZDT8+AjUscvYX/Qtqbrvs6xwz1SDTmuM76EFq3q1w3YDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747659124; c=relaxed/simple;
	bh=sfW3T+vo1+Sy5qSz9UXUWZ/rKPHP36qwJ6NQxledKXc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=b8blglemLLbUb/RTphTFywEXAyh2WJbNSH8S4JiALbAKSb9PeE+aIuXSldXOrrsN1Bnmbpyle2kZlfMSdjZP6BRftke+sE313rOZqiehXc+prxeIMlMErKJB19PWiOX5WFeMxWHKCArmoc4vgdP9r2+2OmYLN2xsMzcM7QQ4TUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaytfcXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBB1C4CEE4;
	Mon, 19 May 2025 12:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747659123;
	bh=sfW3T+vo1+Sy5qSz9UXUWZ/rKPHP36qwJ6NQxledKXc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=LaytfcXkBzo1JYDQs1kmjiB56pSbeBrNpE1LgdKpfoBYR7YKFhKD9Bq3bsqCJDRSf
	 z0gNVal+VZjmhk7VaDxwzKWhxzyst5z21AIBYa0/738kxOnm+OmFrscu7UuMiOcqXA
	 p11542j4iuWbGQ/bLfONlyLRJ5WJMhqbOIpjX5JXAYOchJIAP7wVHW00T6lPIzojCE
	 ZoBQ71JIORNKtRyIBOFBiytUppWc2I2o6A0QczLMHs1D8RYwHV34MAC5R9Sr94EJ9K
	 F/1YvKtkmP2+jJv1UzbbF/ZJcsqTA6cWW3NPdrwfzxUdIk8FWML5xxTU+CTIo/m+xq
	 Jm+31dgbaxPMQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 14:51:55 +0200
Message-Id: <DA05GA6QUD1R.1XR0GFPLNXPTQ@kernel.org>
Cc: <ansuelsmth@gmail.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
 <kabel@kernel.org>, <andrei.botila@oss.nxp.com>, <tmgross@umich.edu>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <dakr@kernel.org>,
 <sd@queasysnail.net>, <michael@fossekall.de>, <daniel@makrotopia.org>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [net-next PATCH v10 7/7] rust: net::phy sync with
 match_phy_device C changes
From: "Benno Lossin" <lossin@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
X-Mailer: aerc 0.20.1
References: <D9YO3781UI2X.1CI7FG1EATN8G@kernel.org>
 <20250519.210059.2097701450976383427.fujita.tomonori@gmail.com>
 <DA051LGPX0NX.20CQCK4V3B6PF@kernel.org>
 <20250519.214449.1761137544422192991.fujita.tomonori@gmail.com>
In-Reply-To: <20250519.214449.1761137544422192991.fujita.tomonori@gmail.com>

On Mon May 19, 2025 at 2:44 PM CEST, FUJITA Tomonori wrote:
> On Mon, 19 May 2025 14:32:44 +0200
> "Benno Lossin" <lossin@kernel.org> wrote:
>>>>> The other use case, as mentioned above, is when using the generic hel=
per
>>>>> function inside match_phy_device() callback. For example, the 4th
>>>>> patch in this patchset adds genphy_match_phy_device():
>>>>>
>>>>> int genphy_match_phy_device(struct phy_device *phydev,
>>>>>                            const struct phy_driver *phydrv)
>>>>>
>>>>> We could add a wrapper for this function as phy::Device's method like
>>>>>
>>>>> impl Device {
>>>>>     ...
>>>>>     pub fn genphy_match_phy_device(&self, drv: &phy::DriverVTable) ->=
 i32=20
>>>>=20
>>>> Not sure why this returns an `i32`, but we probably could have such a
>>>
>>> Maybe a bool would be more appropriate here because the C's comment
>>> says:
>>>
>>> Return: 1 if the PHY device matches the driver, 0 otherwise.
>>>
>>>> function as well (though I wouldn't use the vtable for that).
>>>
>>> What would you use instead?
>>=20
>> The concept that I sketched above:
>>=20
>>     impl Device {
>>         fn genphy_match_phy_device<T: Driver>(&self) -> bool {
>>             self.phy_id() =3D=3D T::PHY_DEVICE_ID.id
>>         }
>>     }
>
> I think there might be a misunderstanding.
>
> Rust's genphy_match_phy_device() is supposed to be a wrapper for C's
> genphy_match_phy_device():
>
> https://lore.kernel.org/rust-for-linux/20250517201353.5137-5-ansuelsmth@g=
mail.com/

Oh yeah you're right. But using `DriverVTable` for that doesn't sound
nice...

---
Cheers,
Benno

