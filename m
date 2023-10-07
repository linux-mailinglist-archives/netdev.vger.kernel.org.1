Return-Path: <netdev+bounces-38832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB907BCA66
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 00:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB34281C8E
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 22:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D386F15C4;
	Sat,  7 Oct 2023 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clSg3H62"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D7415BF;
	Sat,  7 Oct 2023 22:33:50 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910AA9F;
	Sat,  7 Oct 2023 15:33:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c746bc3bceso6787805ad.1;
        Sat, 07 Oct 2023 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696718025; x=1697322825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIpVpFd1qo1wKYDKXr3CBdcj3/YWZHQ5x5BXebNEx4M=;
        b=clSg3H62KKvFvbFJdnpuo4SXal2Y8Zx/w5jU4X7NcqdQU47NQ6EQsRPgGOpSUUPRwY
         Rz76uteI9hwejS2qBF9iQ+9+GnSFjHhtWYIecLNIZn7nQA6oCfhPm4bUQtzycZJMGUcM
         SYtgQ2ZLDk+zp4jK9AZVYxgUw5D9VWSQCEpXKpwjyGvkPO2yu/KxNxJ8BNynz79qxYy9
         J7NGX6P0vp3vaE4ZgEA56ucyZIHLQgrJwcb3aab5ucqunlyl6D+K96ecEV2m5veJxXOd
         yJeIIqOc1PY0midMrlN4YjahPzBEF6AyXk4TpQl0p86Ho1ZoW40URZeVIiNqPox0onnM
         I3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696718025; x=1697322825;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KIpVpFd1qo1wKYDKXr3CBdcj3/YWZHQ5x5BXebNEx4M=;
        b=ZYwvHzVAj8lDk+ul24dMkmg9EevCWKqdNam/FsWQCLH76KhB52XBY9ZfCfu63Ha7P1
         8oJiPX5TdiehLdlSqoZSZX5vnbKOkR5E83i0TZXuhjq2Z+KFVv+SvduoyC8o3tVwhZ4f
         t81KOLpEzCqpGhfvd/I08XIWEgU/uz1xdv8sq9Q7abeVgTR5nsvL0Zb8Q0zCrT89ix8d
         9ytS48ig+VZKi8MCT6ooAO+GLCYJq9em0eblnmzj4q4t4zUGKHpibcxNBs30T9pnJoXN
         8s5/H/s+zg32zjWFTsF3yMd04XX+FgF7BLX0PVQGnciLuH9reva9AWqG8hoPHtNaCI+7
         sy5g==
X-Gm-Message-State: AOJu0YxyFnbLbzWL8OQBJNvT+3z4r8SpyQMsY93ngy3VgXyKV8PKUUR+
	Rf68kyAEy05ZOUU/3GCUlAbEKfoqyLkbxTfu
X-Google-Smtp-Source: AGHT+IEwLTcFzUIBF5U3uUCiIt9ra0QHhiiuydPTPbVrediFDoYU3kKO3H1VFZTSVlRB0eRYBdNQgQ==
X-Received: by 2002:a17:902:ce84:b0:1c6:9312:187 with SMTP id f4-20020a170902ce8400b001c693120187mr13099340plg.3.1696718024884;
        Sat, 07 Oct 2023 15:33:44 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902d34900b001b9be3b94d3sm6363615plk.140.2023.10.07.15.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 15:33:44 -0700 (PDT)
Date: Sun, 08 Oct 2023 07:33:43 +0900 (JST)
Message-Id: <20231008.073343.1435734022238977973.fujita.tomonori@gmail.com>
To: tmgross@umich.edu, fujita.tomonori@gmail.com
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Subject: Re: [PATCH v2 1/3] rust: core abstractions for network PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20231007.195857.292080693191739384.fujita.tomonori@gmail.com>
References: <20231006094911.3305152-2-fujita.tomonori@gmail.com>
	<CALNs47sdj2onJS3wFUVoONYL_nEgT+PTLTVuMLcmE6W6JgZAXA@mail.gmail.com>
	<20231007.195857.292080693191739384.fujita.tomonori@gmail.com>
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

On Sat, 07 Oct 2023 19:58:57 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

>>> +/// # Examples
>>> +///
>>> +/// ```ignore
>>> +///
>>> +/// use kernel::net::phy::{self, DeviceId, Driver};
>>> +/// use kernel::prelude::*;
>>> +///
>>> +/// kernel::module_phy_driver! {
>>> +///     drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],
>>> +///     device_table: [
>>> +///         DeviceId::new_with_driver::<PhyAX88772A>(),
>>> +///         DeviceId::new_with_driver::<PhyAX88772C>(),
>>> +///         DeviceId::new_with_driver::<PhyAX88796B>()
>>> +///     ],
>>> +///     type: RustAsixPhy,
>>> +///     name: "rust_asix_phy",
>>> +///     author: "Rust for Linux Contributors",
>>> +///     description: "Rust Asix PHYs driver",
>>> +///     license: "GPL",
>>> +/// }
>>> +/// ```
>> 
>> I can't find the discussion we had about this, but you said you have
>> the `type` parameter to be consistent with `module!`, correct?
> 
> No, `driver!` in rust branch, which is used by platform, amba, etc.
> 
> https://github.com/Rust-for-Linux/linux/blob/rust/samples/rust/rust_platform.rs
> 
>> I think that it is more important to be consistent with C's
>> `MODULE_PHY_DRIVER` where you don't need to specify anything extra,
>> since the module doesn't do anything else. And I think it is less
>> confusing for users if they don't wonder why they need to define a
>> type they never use.
>> 
>> Why not just remove the field and create an internal type based on
>> `name` for now? We can always make it an optional field later on if it
>> turns out there is a use case.
> 
> Sure, I'll try. I have no preference and driver! macro isn't in
> upstream.

To create an internal type based on `name`, we need to unstringify
`name`? I can't find a easy way to do it.

