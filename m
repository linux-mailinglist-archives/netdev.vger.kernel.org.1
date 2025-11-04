Return-Path: <netdev+bounces-235500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D6FC319F3
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1789D3BEA11
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615AB255F22;
	Tue,  4 Nov 2025 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIMn1mOQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363CA230BD5;
	Tue,  4 Nov 2025 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267698; cv=none; b=ZzFc5f96azyIo5SWm0laAHujkaPMTd+P//i2VAuqpOS+GXHWmg2vAKKOWp/spnrfe/BlwJePqMrQ9AoAUd40RhnUHej8cQnzDYa/mjNPTLlwq95WGCvM0v4AEYMrcItGeAcKvXlz3Hhw+4rn0aynIq6izhOGXfkNj4jSw6/7yjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267698; c=relaxed/simple;
	bh=xCBxlDXzIhVQ/B7058fyymHUafvIparv+hEqSxtneH0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=cO7TfQfnSqfaw16BVH092hJ7Mlr2C4oXcfs9mbhZ3O0Qr2v7Acukd6STJv0dr3NWosxkH1GUJEVLb5exOYI15BJHZmUGe3gHQLEne0ef1jxmHFzsa6UnmVqNi2yIr/8pH8QLRqe3ZFANbnPKnHyvW2Y9RJ4mKLc1SB7BV3rD6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIMn1mOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F802C116B1;
	Tue,  4 Nov 2025 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762267697;
	bh=xCBxlDXzIhVQ/B7058fyymHUafvIparv+hEqSxtneH0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=SIMn1mOQrQQxcwiBwuWqP29ydZ+FP6EcFaa3okcvWYTrLLh4dqx1Aat7xwUVxgxP0
	 auydmpD+uvywmyro/TOJ9RZhvxObN1EV6F83xQErcgMXXiRUc2Uwl4SQDZE+kIQItk
	 bdVmf3q3inpKZN3kfVXj06HMZAYUfhzGptBS36PkdxxrGaIBWjgkrKpRMVHhRlHX0d
	 E2QCMTyie6s5pamvD/LI5E4V8QktSmB7hH7sB0v+HDD1MyWns7fHxF05+izv/ZK/Lg
	 HP3m4oD3DqawLom/Qt8t+yXEPUPfxdO0RgXv2csT0YxvTNkgEM/A6orgH+LfIRcH4x
	 ut3EPx4B99UXQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Nov 2025 15:48:10 +0100
Message-Id: <DDZZRCRHBLVI.MGWBUONLZ94K@kernel.org>
Subject: Re: [PATCH] firmware_loader: make RUST_FW_LOADER_ABSTRACTIONS
 select FW_LOADER
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Russ Weight" <russ.weight@linux.dev>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Andrew
 Lunn" <andrew@lunn.ch>, "Heiner Kallweit" <hkallweit1@gmail.com>, "Russell
 King" <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251104-b4-select-rust-fw-v1-1-afea175dba22@nvidia.com>
 <2025110407-scouting-unpiloted-39f4@gregkh>
In-Reply-To: <2025110407-scouting-unpiloted-39f4@gregkh>

On Tue Nov 4, 2025 at 3:35 PM CET, Greg Kroah-Hartman wrote:
> On Tue, Nov 04, 2025 at 11:04:49PM +0900, Alexandre Courbot wrote:
>> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmwar=
e_loader/Kconfig
>> index 752b9a9bea03..15eff8a4b505 100644
>> --- a/drivers/base/firmware_loader/Kconfig
>> +++ b/drivers/base/firmware_loader/Kconfig
>> @@ -38,7 +38,7 @@ config FW_LOADER_DEBUG
>>  config RUST_FW_LOADER_ABSTRACTIONS
>>  	bool "Rust Firmware Loader abstractions"
>>  	depends on RUST
>> -	depends on FW_LOADER=3Dy
>> +	select FW_LOADER
>
> Please no, select should almost never be used, it causes hard-to-debug
> issues.

I agree that select can be very annoying at times, but in this case it seem=
s to
be the correct thing to do?

For instance for something like:

	config MY_DRIVER
		depends on PCI
		depends on DRM
		select AUXILIARY_BUS
		select FW_LOADER

In this case MY_DRIVER is only available if PCI and DRM is enabled, which m=
akes
sense, there is no reason to show users PCI and DRM drivers if both are
disabled.

However, for things like AUXILIARY_BUS and FW_LOADER, I'd argue that they a=
re
implementation details of the driver and should be selected if the driver i=
s
selected.

Otherwise, wouldn't we expect users to know implementation details of drive=
rs
before being able to select them?

