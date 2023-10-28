Return-Path: <netdev+bounces-44986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BC77DA62A
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 11:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834281C209A9
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 09:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4ECB670;
	Sat, 28 Oct 2023 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a74tq0Xi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5274D2595;
	Sat, 28 Oct 2023 09:27:27 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1ECF0;
	Sat, 28 Oct 2023 02:27:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bcdfcde944so739064b3a.1;
        Sat, 28 Oct 2023 02:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698485245; x=1699090045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oe6k9URnl0hGpafNj5yK6ToO4iREfmFUhc0Lu2xjTfA=;
        b=a74tq0XipV6rs2lGFzn+mYWgvrdt1bCOYp44e7ikgaN9+rxn4TmMIwTAle6HUbRytY
         Sz+f4OXgVBS8dFHpqjHbPWGDKQqz4OJMcI3mTcRbxS4CB00gGMzoxtCvNfArhmX56tRT
         oxNWSPiio9M/gHN3bzrCLXNoJJ5zlVaNGxe9j5L5spVffyCo1PLy8lqq3bRziUsaYFy3
         1jSwkyk8woO5HZBInu7YvOaO9X4zxWpXLZZtdjnAkxIbsUrNWXcsv3O7kWNlG6t14a2w
         XjUedKvCr1uPwZfVeYhQyeQW4jhzYv6d9jbN9zy3xoasLDuG1E4Ok01UDiri8ge3Ao3O
         gbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698485245; x=1699090045;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oe6k9URnl0hGpafNj5yK6ToO4iREfmFUhc0Lu2xjTfA=;
        b=e9bI3bRSWVGk1/SvB/xfVz6zr0Hlcoclfs9Ac9PIbPKX80iEqoDHBeD66cfvjNRdki
         BeubLEWeQc28kG+JfOKwXdGyMNgCIle+bIq+e8rlp/82S2nQM6UqW6zD/WEVnFB85Lar
         G5A5TUepPLhNh3Z+ytpJBvTJKGsQMfo/ObTKl4X/NLqQG6TGXRvkqEWBz1wkZW7Oa/F/
         HvlW4ykm50lqN9LB8OBjqWswFE78sY7Dba1cMp8AqAAmtFrGplJcem2V0rR/ROHexN9G
         yIZyicm9c4WBjldzbDaJRZVXwONoSvESqERN3FGLWRBK4m0HK7RXt3IYYp1uohhJCSVn
         YuFA==
X-Gm-Message-State: AOJu0YyIE0aEIp5D63/FJQpmZu0LlXcrCc4GWgOisoqKJK5jPKtwdxlw
	X+fMH49y9B2VPWWuZgsirmi7QQdVm9Vq1w==
X-Google-Smtp-Source: AGHT+IHXNok7nLFWAgysk5569g6xbuTE37WjdJM6vDESMGdoh3rkp1zAmmMt2cOuFt+YJ110ET7Ddg==
X-Received: by 2002:a17:902:d28b:b0:1c7:5581:f9c with SMTP id t11-20020a170902d28b00b001c755810f9cmr4980380plc.0.1698485244753;
        Sat, 28 Oct 2023 02:27:24 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b001a98f844e60sm2847089plg.263.2023.10.28.02.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 02:27:24 -0700 (PDT)
Date: Sat, 28 Oct 2023 18:27:23 +0900 (JST)
Message-Id: <20231028.182723.123878459003900402.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: boqun.feng@gmail.com, fujita.tomonori@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>
References: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
	<ZTwWse0COE3w6_US@boqun-archlinux>
	<ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 21:19:38 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 10/27/23 21:59, Boqun Feng wrote:
>> On Thu, Oct 26, 2023 at 09:10:46AM +0900, FUJITA Tomonori wrote:
>> [...]
>>> +    /// Gets the current link state.
>>> +    ///
>>> +    /// It returns true if the link is up.
>>> +    pub fn is_link_up(&self) -> bool {
>>> +        const LINK_IS_UP: u32 = 1;
>>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>>> +        let phydev = unsafe { *self.0.get() };
>> 
>> Tomo, FWIW, the above line means *copying* the content pointed by
>> `self.0.get()` into `phydev`, i.e. `phydev` is the semantically a copy
>> of the `phy_device` instead of an alias. In C code, it means you did:
> 
> Good catch. `phy_device` is rather large (did not look at the exact
> size) and this will not be optimized on debug builds, so it could lead
> to stackoverflows.
> 
>> 	struct phy_device phydev = *ptr;
>> 
>> Sure, both compilers can figure this out, therefore no extra copy is
>> done, but still it's better to avoid this copy semantics by doing:
>> 
>> 	let phydev = unsafe { &*self.0.get() };
> 
> We need to be careful here, since doing this creates a reference
> `&bindings::phy_device` which asserts that it is immutable. That is not
> the case, since the C side might change it at any point (this is the
> reason we wrap things in `Opaque`, since that allows mutatation even
> through sharde references).

You meant that the C code might modify it independently anytime, not
the C code called the Rust abstractions might modify it, right?


> I did not notice this before, but this means we cannot use the `link`
> function from bindgen, since that takes `&self`. We would need a
> function that takes `*const Self` instead.

Implementing functions to access to a bitfield looks tricky so we need
to add such feature to bindgen or we add getters to the C side?

