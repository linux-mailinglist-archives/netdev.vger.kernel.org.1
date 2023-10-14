Return-Path: <netdev+bounces-40949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C04D7C92C8
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 06:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D042829E3
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 04:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CDE7F6;
	Sat, 14 Oct 2023 04:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwTNqfNx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24607E;
	Sat, 14 Oct 2023 04:50:10 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E18BC0;
	Fri, 13 Oct 2023 21:50:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2791d5f1a09so581226a91.1;
        Fri, 13 Oct 2023 21:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697259009; x=1697863809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHIOABzd9pg0hiAHO27CaVAkEOv3e74bFJC5vZxEHSc=;
        b=kwTNqfNxmyw5zCktRNpgz6lywklKexp3LEtxpDk681GRKl0zA0W+V/hCPiqcpxCn5l
         XWHI4I4k9TK05OdoOpnAAJq8HAKUoCf3JU8qCCvF3O0WlI49Eq55oz9g2fvZWMDzkHg6
         UJWMdSzkpSZFIEDlCgo0IiH7q3T2qPI5oy7JyZ086ka2Dh89GLNaPQv5b0QJJ6E3fus9
         N1BnqDmUOkAynXhZkrP8sisx/2RputdTVGTVtFi4XHDDOKjNDa7ZBYnfaSDsbmrUhwOv
         srdi/hFkSQO+jVT3s48i5q5R9uUcI6Y0zayfxOiXrIg556Gd9hwq2KHvUq2UtYtWPyIx
         9CPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697259009; x=1697863809;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uHIOABzd9pg0hiAHO27CaVAkEOv3e74bFJC5vZxEHSc=;
        b=M1IRlYwPdU/4cDi9UFKYKCXnFz4vDsH/XfE0DjFlGv87GgdGze2sTOMk25h6POTS16
         eojZ+mK66qhoeYHg/qjOnGfJMylq0EtgglZtcZSWfMgY0kDVuaB+V5IkLU5XVIRMr70b
         YO/XCAVOyKpByyD0TFU/zsl0k8dOl2RVwIpID5xcVWNpWY0dbiFWCHfFeVM58lsPUS0Y
         TjXTMEdBPQQrUm1YwKDRYPxkCwkEvOHxnOSCzNFntt7IbvYgbUjcCQKEc2vEv23mnpq2
         ynrjZdgWptlAp6kPyIic6KFyqK42/ldxuhfzihXj07iRwr+sp4PvXgrEK/cnZuN7QHGN
         e66w==
X-Gm-Message-State: AOJu0Yy0B2KYA5Pxfjjgn+8nX4OsuigN32YGLqmUncTepj9zq1Ei/LhN
	EEDiEyFeM/lfABE4OtqelmY=
X-Google-Smtp-Source: AGHT+IE1/3Ht9qpQH9+MVE7fN0v4C4ifsbcHUGpPP8NcadgjNrawv2lPKsJPCOsDiJOCoZmxGpkuxw==
X-Received: by 2002:a17:903:280d:b0:1ca:273d:22f with SMTP id kp13-20020a170903280d00b001ca273d022fmr1308635plb.0.1697259008710;
        Fri, 13 Oct 2023 21:50:08 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id l21-20020a170902d35500b001b9c960ffeasm4717183plk.47.2023.10.13.21.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 21:50:08 -0700 (PDT)
Date: Sat, 14 Oct 2023 13:50:07 +0900 (JST)
Message-Id: <20231014.135007.2233950345551386934.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: benno.lossin@proton.me, fujita.tomonori@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <4b7096cd-076d-42fd-b0cc-f842d3b64ee4@lunn.ch>
References: <20231012125349.2702474-2-fujita.tomonori@gmail.com>
	<85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me>
	<4b7096cd-076d-42fd-b0cc-f842d3b64ee4@lunn.ch>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 14 Oct 2023 04:12:57 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> > +config RUST_PHYLIB_ABSTRACTIONS
>> > +        bool "PHYLIB abstractions support"
>> > +        depends on RUST
>> > +        depends on PHYLIB=y
>> > +        help
>> > +          Adds support needed for PHY drivers written in Rust. It provides
>> > +          a wrapper around the C phylib core.
>> > +
>> 
>> I find it a bit weird that this is its own option under "General". I think
>> it would be reasonable to put it under "Rust", since that would also scale
>> better when other subsystems do this.
> 
> To some extent, this is just a temporary location. Once the
> restrictions of the build systems are solved, i expect this will move
> into drivers/net/phy/Kconfig, inside the 'if PHYLIB'. However, i
> agree, this should be under the Rust menu.

Sure, I'll do in the next patchset.

