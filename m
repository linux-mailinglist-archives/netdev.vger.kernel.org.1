Return-Path: <netdev+bounces-43111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9CB7D1758
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 22:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABAA282684
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 20:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A72222329;
	Fri, 20 Oct 2023 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="GiHooIrI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497D200C4
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 20:46:28 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C4B170A
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:46:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b95622c620so192404466b.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1697834781; x=1698439581; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=0xLbKrzLSv791LtrfmJiZOU87aMy819HkdD8l/X5dIc=;
        b=GiHooIrIiouqbcotoDeu4lWBgOiUF496/5m3dziAK57RZEnuaec4hN2s8d6JEbDAvo
         A1d0ar6p/UCVY/No6JORrJkT9jfhL8v3nJRuHr0/pE4ZJ3s8eUQz30o9i7X1jzV3PhOX
         3Xh5IXiM35DWR0UBZw/ujSCk0kMqTBeveJ/evazYhgRpqocdUiomybZ9SPf8ykbPxSlR
         SpPf/kINqJM0bJol9zz4MvwkGgB8hDc8bmU5N0pyBRWRJmNpScLmon2yk2zCiBEez03g
         D1bhg/iddT5XrG7PwkokArrkCxRT2ATqJoagoNx4Xq011VlhhKAJndQW0E5nX5eAaxvb
         IOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697834781; x=1698439581;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xLbKrzLSv791LtrfmJiZOU87aMy819HkdD8l/X5dIc=;
        b=oHt27kd0DOatbBdJQIHRIhEkrqtYPFgpaNfJqlINcL/WHRZ+P6Bj1eBAhKNER0PTdo
         rtoj/J5Sf2B7pYPY0BpJLfTxp0Dmzw5wVkpCKLAPOhCnnBkRv5lSSD40fncPt9mwvGU/
         HJGTbFnXVdUnnezuAj1KVgqQZ1fqBniHAN8iRS2ulKW53vT3o3eJ2E3MI3zxv1wByjYa
         3ZBfo4W4LQ+lzXFunhVRKYCZcWN5HfPxiEumiHagkCstKQSlay3/9Ye2fq4+/a0DDtii
         S0PVOYTb/3YveybO/5FFiuVlEpcHUGBx/6DeYjkGWgr+iVyKgOpmjcH1403Bu0j27gA2
         8heQ==
X-Gm-Message-State: AOJu0YxToZZRLXrQHR9BnxAAZsdRGp01qqrSZXGcPO7PecYSaW67LngD
	u0MGLhiHfXroRgTQ+L4Ai66cBA==
X-Google-Smtp-Source: AGHT+IHjw8P0wKcFm85MQbdsrJ9SZjW5bwXlouWGvvBiGWEoMvKrD293bufSOOoWR8BzKWGMlw3AcA==
X-Received: by 2002:a17:907:36c9:b0:9be:fc31:8cd2 with SMTP id bj9-20020a17090736c900b009befc318cd2mr2054312ejc.24.1697834780831;
        Fri, 20 Oct 2023 13:46:20 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906225000b0098921e1b064sm2162747ejr.181.2023.10.20.13.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 13:46:20 -0700 (PDT)
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
 <20231017113014.3492773-2-fujita.tomonori@gmail.com>
 <87sf65gpi0.fsf@metaspace.dk>
 <e5109b0f-5fd5-4ae7-91e2-3975e3371ebb@lunn.ch>
User-agent: mu4e 1.10.7; emacs 28.2.50
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
 tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com,
 benno.lossin@proton.me, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY
 drivers
Date: Fri, 20 Oct 2023 22:30:49 +0200
In-reply-to: <e5109b0f-5fd5-4ae7-91e2-3975e3371ebb@lunn.ch>
Message-ID: <87o7gtggyt.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Andrew Lunn <andrew@lunn.ch> writes:

> On Fri, Oct 20, 2023 at 07:26:50PM +0200, Andreas Hindborg (Samsung) wrote:
>> 
>> Hi,
>> 
>> FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
>> 
>> <cut>
>> 
>> > +
>> > +    /// Returns true if the link is up.
>> > +    pub fn get_link(&self) -> bool {
>> > +        const LINK_IS_UP: u32 = 1;
>> > +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> > +        let phydev = unsafe { *self.0.get() };
>> > +        phydev.link() == LINK_IS_UP
>> > +    }
>> 
>> I would prefer `is_link_up` or `link_is_up`.
>
> Hi Andreas
>
> Have you read the comment on the previous versions of this patch. It
> seems like everybody wants a different name for this, and we are going
> round and round and round. Please could you spend the time to read all
> the previous comments and then see if you still want this name, and
> explain why. Otherwise i doubt we are going to reach consensus.

Thanks, I'll read through it.

>
>> If this function is called with `u32::MAX` `(*phydev).speed` will become -1. Is that OK?
>
> Have you ever seen a Copper Ethernet interface which can do u32:MAX
> Mbps? Do you think such a thing will ever be possible?

Probably not. Maybe a dummy device for testing? I don't know if it would
be OK with a negative value, hence the question. If things break with a
negative value, it makes sense to force the value into the valid range.
Make it impossible to break it, instead of relying on nobody ever doing
things you did not expect.

>
>> > +    /// Callback for notification of link change.
>> > +    fn link_change_notify(_dev: &mut Device) {}
>> 
>> It is probably an error if these functions are called, and so BUG() would be
>> appropriate? See the discussion in [1].
>
> Do you really want to kill the machine dead, no syncing of the disk,
> loose everything not yet written to the disk, maybe corrupt the disk
> etc?

A WARN then? Benno suggests a compile time error, that is probably a
better approach. The code should not be called, so I would really want
to know if that was ever the case.

BR Andreas

