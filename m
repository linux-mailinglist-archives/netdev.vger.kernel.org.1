Return-Path: <netdev+bounces-43262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF9A7D1FDD
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 23:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246261C2090F
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 21:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952FB210EF;
	Sat, 21 Oct 2023 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEBGF0DS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C18F10A04;
	Sat, 21 Oct 2023 21:45:05 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C197E3;
	Sat, 21 Oct 2023 14:45:03 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27d27026dc2so612691a91.0;
        Sat, 21 Oct 2023 14:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697924703; x=1698529503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSxWB/BuTCe6ijouqhC0kKQQiTmed/neUYNgs866ylU=;
        b=bEBGF0DSBJerPMNdqDE73ZqWC4TJbzrhwAhV5WtetbRFUJthVaYEmGrBEUr4pQFlGV
         5BLfn0PgE6cfl1n0+DoYHd4PJB2b0PqZgeq3HEsDmHnmRqCpEO2ClVp34jywK0aYnG8v
         BiYaS3ct2Zqlx++SyRycJ9qq6+p3OUuqu5XnDbf1KGQZW7hPoC2d2UV0o3RqxXAa5As9
         N/Bw1cPjYfYk02nC+dnjdVH3AO47taIbKIvsgcWCOZYiHcb53d7lHBcRrTLjLgH4WLQ0
         TPGGVs+YvlbTM8HzKIVUHXN9ige0W9Bc89pguHWu5sepxLYWpOo9p3q+Hto2Hp3K+lRd
         7Gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697924703; x=1698529503;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qSxWB/BuTCe6ijouqhC0kKQQiTmed/neUYNgs866ylU=;
        b=V7l8lvPWLSxKXZDqFPg2s5n9nQjySKW12OwwsmxodUgO5mb5mMqvOtqxWTtHdfgDt6
         ehtGjm0b8z8u/zTL5rml2JK4AuWNinXuML1mHGWbDGabpYqv2/u5DtBoLAvtmzRwwNrz
         m1oWGh5v01+r+FWY3WQYfDCPzzjZ0ZZ8CzQKcnhr9oaoLEvQgb/ItUDKqXqbxNDGkvov
         JHEgBTShK5c3LvVQB41TG1HpWZmepL5p9ewxruDtDcYyupoL8r3McqxpfN1c0B3cJg0j
         PBDsEsGldBwh9upfmMCwynl8i+X2cEHhzuikP3QxdGiMVA8NvhUYZ1nmx7VVp3ZGkHEh
         wWgw==
X-Gm-Message-State: AOJu0YwLpPZS0hfcUzFZ+xNKW7FkebOo1yICkzkE5Q7cVYCtL+sBNAUp
	BTIfecud6gLmKgagDI6OvUk=
X-Google-Smtp-Source: AGHT+IGhMoItA07DV2rXa7mu9Gm3p22TC5Pf9yqQT6KvP95P0+iOkZIYrTfMdOWKQt1ZUZiCO9XMvw==
X-Received: by 2002:a17:90b:1e45:b0:27d:6268:b75c with SMTP id pi5-20020a17090b1e4500b0027d6268b75cmr6206171pjb.4.1697924702866;
        Sat, 21 Oct 2023 14:45:02 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id jh10-20020a170903328a00b001c736370245sm3583314plb.54.2023.10.21.14.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 14:45:02 -0700 (PDT)
Date: Sun, 22 Oct 2023 06:45:01 +0900 (JST)
Message-Id: <20231022.064501.394351620043801227.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <cd3ff8e6-214e-4a80-980e-e92751223002@proton.me>
References: <fb45d4aa-2816-4457-93e9-aec72f8ec64e@proton.me>
	<20231021.223115.1115424295905877996.fujita.tomonori@gmail.com>
	<cd3ff8e6-214e-4a80-980e-e92751223002@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 21 Oct 2023 13:35:57 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

>> Currently, it needs &'static DriverVTable
>> array so it works.
> 
> That is actually also incorrect. As the C side is going to modify
> the `DriverVTable`, you should actually use `&'static mut DriverVTable`.
> But since it is not allowed to be moved you have to use
> `Pin<&'static mut DriverVTable>`.

I updated Registration::register(). Needs to add comments on requirement?

impl Registration {
    /// Registers a PHY driver.
    pub fn register(
        module: &'static crate::ThisModule,
        drivers: Pin<&'static mut [DriverVTable]>,
    ) -> Result<Self> {
        // SAFETY: The type invariants of [`DriverVTable`] ensure that all elements of the `drivers` slice
        // are initialized properly. So an FFI call with a valid pointer.
        to_result(unsafe {
            bindings::phy_drivers_register(drivers[0].0.get(), drivers.len().try_into()?, module.0)
        })?;
        // INVARIANT: The `drivers` slice is successfully registered to the kernel via `phy_drivers_register`.
        Ok(Registration { drivers })
    }
}


>> The C side uses static allocation too. If someone asks for, we could
>> loosen the restriction with a complicated implentation. But I doubt
>> that someone would ask for such.
> 
> With Wedson's patch you also would be using the static allocation
> from `module!`. What my problem is, is that you are using a `static mut`
> which is `unsafe` and you do not actually have to use it (with
> Wedson's patch of course).

Like your vtable patch, I improve the code when something useful is
available.

