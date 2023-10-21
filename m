Return-Path: <netdev+bounces-43184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E767D1AB3
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 06:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AAF28255C
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 04:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97534EC7;
	Sat, 21 Oct 2023 04:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpWZqVmu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF647EC4;
	Sat, 21 Oct 2023 04:01:09 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D50ED71;
	Fri, 20 Oct 2023 21:01:08 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27d21168d26so331948a91.0;
        Fri, 20 Oct 2023 21:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697860868; x=1698465668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSNcD+HgZymNCXssJRf/JUQ/GGO6fxVh2RO98yd9ZWE=;
        b=ZpWZqVmuMLcUoZuUIjA4o6yZLewoo6fw9L4bN20aL/e8PMIXXG6eIqyUrSza6rjrQ3
         kJgXk/Xc/FnwDpyRdWYSYJ2JqTJN4eLKufp03m9VTnCh0TkhReOej78xaAjDxtVAA91l
         fFivsCtFc0avwWLp2eFTCHkre0+kRLNAb3711LPC4wCUjovVNlbmaqU8u6wVZlVQ5Q9O
         3E4c18A52pTcnsRHMhV42fLqlgyeyCIwUxCKFGjUbJg1ZunzZSFje4MKRusBoVm9JW8i
         +C50BHJnR3vk3soFKztrEXtXYPn1nxmDvy4RfaxOgWFwoI2qlb7c75lkkXiTlaol3Hma
         AW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697860868; x=1698465668;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RSNcD+HgZymNCXssJRf/JUQ/GGO6fxVh2RO98yd9ZWE=;
        b=Kh2+RJIGi4/J9E6QD2wu49FrpD0pdzb2gDE52rSS5QzYQGF4zsgOiQCPTi5t98t0gG
         QmJT2DSCBGWJtRUgfUmlSjEsIu6fXF4fyfEM23Tml9blG6bICknB9pFFtbb1XukgKhpK
         7d0mpEsMTakx7Uka4yABdr/mBuVa2RyD3MIAGbOb37vjbSHei+iORBy/LVUfLcu4Q671
         l/1cVoeZpHPIuqqTKi3vr5g35aCdiPDXqFTh6cbkxJtDEm72GEUpBH+oL+NeXKjwTQBv
         DRiIYvVZYOmhepJlGGm0mAJfZYvu2tTcsOCsjvBo3S+TRFcyBUIT3nUpwWm0npU4UxXZ
         61/g==
X-Gm-Message-State: AOJu0YzGTBg1hd2M/WVL1wMXDUfoc7bDO1MwNhfyCxP39UBv/CXhvsf5
	QW+ndjJbkiUfzfjnFqTuzEM=
X-Google-Smtp-Source: AGHT+IGijIErUaFpfqPqRRtIKwSfmwfqdYU5vOaGxb5QsatvhoXthQIkKX7JMiZuFX3I5pxU4vlrVA==
X-Received: by 2002:a17:90b:1bcb:b0:27d:2261:73e4 with SMTP id oa11-20020a17090b1bcb00b0027d226173e4mr4091343pjb.2.1697860867678;
        Fri, 20 Oct 2023 21:01:07 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id 15-20020a17090a018f00b0027782f611d1sm4356589pjc.36.2023.10.20.21.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 21:01:07 -0700 (PDT)
Date: Sat, 21 Oct 2023 13:01:06 +0900 (JST)
Message-Id: <20231021.130106.420701850571246291.fujita.tomonori@gmail.com>
To: nmi@metaspace.dk
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, benno.lossin@proton.me, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <87sf65gpi0.fsf@metaspace.dk>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
	<20231017113014.3492773-2-fujita.tomonori@gmail.com>
	<87sf65gpi0.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 19:26:50 +0200
"Andreas Hindborg (Samsung)" <nmi@metaspace.dk> wrote:

>> +/// An instance of a PHY driver.
>> +///
>> +/// Wraps the kernel's `struct phy_driver`.
>> +///
>> +/// # Invariants
>> +///
>> +/// `self.0` is always in a valid state.
>> +#[repr(transparent)]
>> +pub struct DriverType(Opaque<bindings::phy_driver>);
> 
> I don't like the name `DriverType`. How about `DriverDesciptor` or
> something like that?

Benno suggested DriverVTable. I plan to use that name in the next
version.

>> +
>> +    // macro use only
>> +    #[doc(hidden)]
>> +    pub const fn mdio_device_id(&self) -> bindings::mdio_device_id {
>> +        bindings::mdio_device_id {
>> +            phy_id: self.id,
>> +            phy_id_mask: self.mask.as_int(),
>> +        }
>> +    }
> 
> Would it make sense to move this function to the macro patch?

IMHO, either is fine.

You could say that the function is used only in the macro but also you
could say that this is the method of DeviceId.


