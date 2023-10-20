Return-Path: <netdev+bounces-42982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A5E7D0EFA
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 13:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2581C20AF4
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A1519471;
	Fri, 20 Oct 2023 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="P64bq5/3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282D199AF
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 11:42:47 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644FAB8
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 04:42:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40850b244beso4811885e9.2
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 04:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1697802128; x=1698406928; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=B8agxK5u1gb+Af+evzfFp7uhKxonxV/B9zlrWUsY0ZQ=;
        b=P64bq5/3dBJ3J+2RTnWDp2QEGQvWGKrLGaBR+FSGyZ1FomQt2ciW8X1m+Yp9rye+xF
         /6GAbUroTqIunAtYCQC1SmJW+lI9rAlxPX3U9ZMYjlbibp9qgbVWIaHZcsvFlWGG/L7c
         f2tkDSttuaDBu6iwBlj4j3tVCRQNAjXlkIQ2DO1+dfMm8QXIxQjsqyUnnXUzxpKgcNGO
         xNXA01RSqh9ApphtyNByrnum9tV5ULjrDOgogsieVgInAqCbccH2lSvQmjzDg9JTBb4B
         34MBldHxvqgSrlCYuimk68pUq8A6iZ132LBTlrQ4kT7zoGQOljeXhfsbE8znp5BdfDcZ
         wGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697802128; x=1698406928;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8agxK5u1gb+Af+evzfFp7uhKxonxV/B9zlrWUsY0ZQ=;
        b=o6Y7fNbADShGF3otmJpckzZe4eJxEwKuKnZ9pYzRSGGQ0a+l0UBgw2uGvza9Ukmqd+
         LGREsW+jUXYiLSfvWTdRai/Ab1yZrgwB8xb0LLOK2jW/SLGQWPM2/BuviZPmNPpRlfcv
         /c/zjJJl1SQoAGe4eX12rkU9vpxKaU2sC47sPgk1r0fVq3afawqe5CD10Z8mKhYgeRBd
         2JDQyDGeM1hjPf4usK9iW8Jw3tY4Wc6RRy7APpNytruAY9usy1Uvuxtc21P3Ut1aAUB4
         RstOrWLtFa2gTknquzTXIjBSQdPUPZLHGfK/XE6aPPnhMTbXFjT0HGgdyO79L3ShTTrU
         I4cg==
X-Gm-Message-State: AOJu0YxFa8JVlkP9nP3QwXfH9NwSC43iJx4Od4w6x+kxy6SjMESum40w
	5qrnsp+QsDpTHVA9DDetw6fllQ==
X-Google-Smtp-Source: AGHT+IE5s73v0RZapWCkmx3g4kuKn7rTxmtt16EJW65x15y6+Xp4nQcwQz9jDN8Ti/5KwvZRw8Kv3g==
X-Received: by 2002:a05:600c:4f88:b0:406:4a32:52fc with SMTP id n8-20020a05600c4f8800b004064a3252fcmr1249068wmq.21.1697802128068;
        Fri, 20 Oct 2023 04:42:08 -0700 (PDT)
Received: from localhost ([165.225.194.193])
        by smtp.gmail.com with ESMTPSA id a6-20020adfeec6000000b0032da8fb0d05sm1503862wrp.110.2023.10.20.04.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:42:07 -0700 (PDT)
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
 <20231017113014.3492773-4-fujita.tomonori@gmail.com>
User-agent: mu4e 1.10.7; emacs 28.2.50
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, benno.lossin@proton.me, greg@kroah.com, Miguel Ojeda
 <ojeda@kernel.org>
Subject: Re: [PATCH net-next v5 3/5] WIP rust: add second `bindgen` pass for
 enum exhaustiveness checking
Date: Fri, 20 Oct 2023 13:37:14 +0200
In-reply-to: <20231017113014.3492773-4-fujita.tomonori@gmail.com>
Message-ID: <871qdpikq9.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


FUJITA Tomonori <fujita.tomonori@gmail.com> writes:

> From: Miguel Ojeda <ojeda@kernel.org>
>
>     error[E0005]: refutable pattern in function argument
>          --> rust/bindings/bindings_enum_check.rs:29:6
>           |
>     29    |       (phy_state::PHY_DOWN
>           |  ______^
>     30    | |     | phy_state::PHY_READY
>     31    | |     | phy_state::PHY_HALTED
>     32    | |     | phy_state::PHY_ERROR
>     ...     |
>     35    | |     | phy_state::PHY_NOLINK
>     36    | |     | phy_state::PHY_CABLETEST): phy_state,
>           | |______________________________^ pattern `phy_state::PHY_NEW` not covered
>           |
>     note: `phy_state` defined here
>          --> rust/bindings/bindings_generated_enum_check.rs:60739:10
>           |
>     60739 | pub enum phy_state {
>           |          ^^^^^^^^^
>     ...
>     60745 |     PHY_NEW = 5,
>           |     ------- not covered
>           = note: the matched value is of type `phy_state`
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

This patch does not build for me. Do I need to do something to make it
work?

BR Andreas

