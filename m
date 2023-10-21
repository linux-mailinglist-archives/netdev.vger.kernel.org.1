Return-Path: <netdev+bounces-43185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975FB7D1AC4
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 06:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2BD1C20E6A
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 04:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94613650;
	Sat, 21 Oct 2023 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9ZTQzhY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BFF63D;
	Sat, 21 Oct 2023 04:44:12 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27CFD63;
	Fri, 20 Oct 2023 21:44:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2739c8862d2so331736a91.1;
        Fri, 20 Oct 2023 21:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697863447; x=1698468247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTkCk6/BkFb6Bq/acWtqxyXHHBgKuQDSgoD8Bi427F8=;
        b=A9ZTQzhYeW6xeVT75DM8iH7UlJJ1cK9a1kpB0iZiOwfJG9Ex4Aw+iWGR3WCJ3BOgZC
         Iz29GlJq0YCAfbQ8q7MNgax+OxGr5NBFcX6KlafvhHn9b20pM3WErVVoTg1HvfnDQJ5D
         LrSYVHZiPbF7+SePjpx1ybtI0qG4NWuppzzoZhqu8eMki4yqpeoRAul+xnyyKXaEn2eJ
         IKPG+Sh2sFeaVhOKpv5i+CYPsdVa5AmKG/tgpNtmQ2/mSJLbitH1odzAEhnPGxyKOBP1
         +Fie2ZZCPjmTseylJ0RnXYtQsrYhJPVJbNMZErGPeq0z4tRFPCA6QsvBtRAhhnFRbiBZ
         BrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697863447; x=1698468247;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wTkCk6/BkFb6Bq/acWtqxyXHHBgKuQDSgoD8Bi427F8=;
        b=hFeeuZiSKuMyo9QFlvo+kVcA8dpj6TuIAcOkF4pTVv2UuzlPeI38Z3MFNrwSjA15Zl
         aD6kL+ZJTBoyZOiE5UXevtIxdocFJmQ10eE5U1HIIiovcScpmoy7IEBVhsx1O+VsWdti
         GrQxohgWAIkyH5lODjbL8xDdOzzykhdIMrZ5Gj8E/OHf9Fac0LDIZTY1Ix73bKu1a4pb
         vQuvHg2OCway671aFZG/vLN/j6esYeGk2/mp3OD5Q6luWiYu5pV5oYpt7boGnFU2YONs
         R/SB2QE4Wer5x5bTz1fLTUyElcS6q2y236fNZGpBWKHq17AdFHNIum9jQ+Lukd+TR0WK
         ky4g==
X-Gm-Message-State: AOJu0YxbpKOsI5tCPyaYKBlclkc4GLjWIjJxAYN2wIO/ZxYpPIM3yPxl
	ZAoq6Iz2+1BjmwMm/Pnum3O14tK1AHvT98UJ
X-Google-Smtp-Source: AGHT+IHMM9DF546PJnB+pFNHj8MY9LHH/B0WhYGMpHU8S/q3OWZlUM9pr5NENgyGSb8aJRkdl58faQ==
X-Received: by 2002:a17:90b:1812:b0:27d:2762:2728 with SMTP id lw18-20020a17090b181200b0027d27622728mr4219053pjb.0.1697863447190;
        Fri, 20 Oct 2023 21:44:07 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id mg1-20020a17090b370100b00274bbfc34c8sm4031360pjb.16.2023.10.20.21.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 21:44:06 -0700 (PDT)
Date: Sat, 21 Oct 2023 13:44:06 +0900 (JST)
Message-Id: <20231021.134406.872906134955921319.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: benno.lossin@proton.me, fujita.tomonori@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <4935f458-4719-4472-b937-0da8b16ebbaa@lunn.ch>
References: <20231017113014.3492773-2-fujita.tomonori@gmail.com>
	<e361ef91-607d-400b-a721-f846c21e2400@proton.me>
	<4935f458-4719-4472-b937-0da8b16ebbaa@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 20:42:10 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> > +//! All the PHYLIB helper functions for `phy_device` modify some members in `phy_device`. Except for
>> > +//! getter functions, [`Device`] methods take `&mut self`. This also applied to `read()`, which reads
>> > +//! a hardware register and updates the stats.
>> 
>> I would use [`Device`] instead of `phy_device`, since the Rust reader
>> might not be aware what wraps `phy_device`.
> 
> We don't want to hide phy_device too much, since at the moment, the
> abstraction is very minimal. Anybody writing a driver is going to need
> a good understanding of the C code in order to find the helpers they
> need, and then add them to the abstraction. So i would say we need to
> explain the relationship between the C structure and the Rust
> structure, to aid developers.

I'm sure that Rust readers would notice Device wraps `phy_device`
because the comment on Device clearly says so.

/// An instance of a PHY device.
///
/// Wraps the kernel's `struct phy_device`.
///
/// # Invariants
///
/// `self.0` is always in a valid state.
#[repr(transparent)]
pub struct Device(Opaque<bindings::phy_device>);


I think that the relationships between the C and Rust structures are
documented in phy.rs.



