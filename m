Return-Path: <netdev+bounces-44310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5B07D7875
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D519B2113F
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FB537176;
	Wed, 25 Oct 2023 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idxEv0GZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF0B266BC;
	Wed, 25 Oct 2023 23:19:15 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30E4DE;
	Wed, 25 Oct 2023 16:19:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6bcdfcde944so52394b3a.1;
        Wed, 25 Oct 2023 16:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698275954; x=1698880754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBIEEn8kYXOXlQ5FZ8ZKXcmFkULtjFrSQCuI8zWKuW0=;
        b=idxEv0GZQGjRPG2wWLC0PzeoS8GB83jOj6Y8AsVRsJ3lfOA0XD0e3MgxdoENk7F8ca
         wmq6fU3EKPP0YeV8Rt95aAEXCRngBOsFaYpmgTDENdoonD517Ni+NLE/kPcjtIC3jopa
         2gIsHBkQo60Q/ZA1B5tFUc62HxXaq0I4SYjQAR/FMw6MMlofHTYe15/l6N1CmLkbbUP7
         soklH39ju3O+xeCTUXu1nxo1HTIzPhETXiDIF/8SCE/YMWaA7lRq5CEcE3sXW4X8Dhid
         YAss68a1Aq2umFVJ0Ugf2NV5myZ3zf4krzmuLOxMdvzUvQAxMAd/j4lH41G/EOQONoa2
         q2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698275954; x=1698880754;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eBIEEn8kYXOXlQ5FZ8ZKXcmFkULtjFrSQCuI8zWKuW0=;
        b=dpL/e61dFv7eP7SAkq9nFyaaj2YzriBVP0SRdkMmWj10ITOkc/UjTB1/KV7XK5JQXX
         /g4vkIiccFpTJuRutQEHQi4Tn6/sUbXTlDQpJz1BEFCFcEmlvMDKu3qva/BcxXJ9KEYm
         BWyirOmSvO23r+LvtY+ppP8uw9EnOzVvAbvZuLQ6ganP5RTKxu1SGpm0Y7NvEspWpiWO
         cX+H9NrR5l44zpQNEFEATGki33Yk0htg1MWV0plszgKIZlnaIJNidaT472uBVc/IYdZJ
         zJbaDVd3LfnX/2BuhFJuAsE45KIkAlFZQGckrGhXDXYj92+46455zefirj6ZZF5LSKCk
         9rqg==
X-Gm-Message-State: AOJu0YxB2fREPzss3v3Wd9KD7J3L8EyipFgab2Z9Cts+liQ3LGgpqUim
	uJ6nYy0vnv/q+qWjDPNUHwlIeOijXl44MAWd
X-Google-Smtp-Source: AGHT+IFnOGvKql4F2nSoXjfKHHIm6+FZIbSYInNcOe7vnO98vxx23NnA/iZpSptDpGLE9swrYVfmnA==
X-Received: by 2002:a05:6a20:8e19:b0:163:ab09:195d with SMTP id y25-20020a056a208e1900b00163ab09195dmr19244103pzj.0.1698275954200;
        Wed, 25 Oct 2023 16:19:14 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id w3-20020aa79a03000000b006933f85bc29sm9918198pfj.111.2023.10.25.16.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 16:19:13 -0700 (PDT)
Date: Thu, 26 Oct 2023 08:19:13 +0900 (JST)
Message-Id: <20231026.081913.30894727187541245.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v6 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <f99c8f3b-95eb-4e68-af25-62a5a0a8de64@proton.me>
References: <46b4ea56-1b66-4a8f-8c30-ecea895638b2@proton.me>
	<20231025.195741.1692073290373860448.fujita.tomonori@gmail.com>
	<f99c8f3b-95eb-4e68-af25-62a5a0a8de64@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 14:54:42 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

>>> /// PHY state machine states.
>>> ///
>>> /// Corresponds to the kernel's [`enum phy_state`].
>>> ///
>>> /// Some of PHY drivers access to the state of PHY's software state machine.
>>> ///
>>> /// [`enum phy_state`]: ../../../../../networking/kapi.html#c.phy_state
>>>
>>> But as I noted before, then people who only build the rustdoc will not
>>> be able to view it. I personally would prefer to have the correct link
>>> offline, but do not know about others.
>> 
>> I prefer a link to online docs but either is fine by me. You prefer a
>> link to a header file like?
>> 
>> /// [`enum phy_state`]:  ../../../include/linux/phy.h
> 
> No. I think the header file should be mentioned for the whole
> abstraction. I personally always use [1] to search for C symbols, so
> the name suffices for me. And the documentation is (for me at least)
> less accessible (if there is a nice tool for that as well, please tell me).
> 
> [1]: https://elixir.bootlin.com/linux/latest/source

Understood. I use links to the PHY header file like other Rust
abstractions do.

IMHO, adding a link to kerneldoc would be nice but consistency in all
the abstractions is needed.

