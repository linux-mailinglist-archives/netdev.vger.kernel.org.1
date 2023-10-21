Return-Path: <netdev+bounces-43183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E867D1AAE
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 05:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7001C21019
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 03:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842D7EC4;
	Sat, 21 Oct 2023 03:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfmhK9O5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733CEA59;
	Sat, 21 Oct 2023 03:51:28 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B2DD7A;
	Fri, 20 Oct 2023 20:51:26 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bb744262caso347588b3a.0;
        Fri, 20 Oct 2023 20:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697860286; x=1698465086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkdtBVcRO0F8ybiIDAuZktT8o2AAFdetWo48zAD51tE=;
        b=DfmhK9O5Q5cpsjfTzUtif2Mha7sd5t3vcBTCGo9qwBY9sb9n1L5H9qRxkKb/9YHfNB
         ikJ8pUyb+aTYG5YgyQ9GIbAKUHzzqOHXrUXzcWKReRwWamuls/rAJDp5qXkgv7hPtZHS
         6R6ZnqfNCxMw3mAu7pSC0JvKYV2a5ofcXftmtxI7CLYYO3HdrxdZ3Mevl3JQalYhD/W4
         zUoi1ERVQM9KbTetMEI2mYIELLwa+Z8mVh5bDUbp5cpB20sIpTQhbjTcTDBrzJ8Oj8BB
         MedRFW/u2eo699VAAozNBDOcGBJ6T9q0AMBmZ2m+4ULXeOBxDQ6K68Lp4cWYO4Rrdgau
         qFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697860286; x=1698465086;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LkdtBVcRO0F8ybiIDAuZktT8o2AAFdetWo48zAD51tE=;
        b=m/QCNDKT8ahfju+gMkIGbBg08F7XaNR3tPJ0lkLeJz/4h4Rebfe4j24Fkk1kU+TW4M
         dNxa0q+pt7B3jpMASmqpqll9mOy9GNTD3EejSJySbLczmk4nbwr8eLerxZaqQ6t/q5X+
         PXYu2Mp4CbdeMxZTAMsU7XSXBQNMEmNoxj9Vsv54Qw7vAb0nCyC+xoVnZxhmlPs2/xsz
         hPvykir2NVM8dWmTBEk6F4D7HggYZWRihIiWXl6tzAVShz2kAqjnFN/vnYOCMBtnin/C
         AOocwrjo6WkYxHKMoD/Obkfmg3OJXnRS2zDM6VIcJs+Nm0/fwlwrFOIiwE+HjITXPtqw
         NsRg==
X-Gm-Message-State: AOJu0Yw7A0TsOmKrgSt+sFWuGKeQg8wb69/l0isu6iDodwy6f0Zemx2r
	PiiQztA+WL/ZQsaE4Iquy3M=
X-Google-Smtp-Source: AGHT+IFJ5yCKj+ac4VvIGsZ/ITztWgdh5TBi/cWPyn8VSAelD74acatyF62VIjDkWTrMN8HOLaiHcw==
X-Received: by 2002:a05:6a20:8e19:b0:163:ab09:195d with SMTP id y25-20020a056a208e1900b00163ab09195dmr3660938pzj.0.1697860286186;
        Fri, 20 Oct 2023 20:51:26 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id p5-20020a625b05000000b0068fdb59e9d6sm2399884pfb.78.2023.10.20.20.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 20:51:25 -0700 (PDT)
Date: Sat, 21 Oct 2023 12:51:25 +0900 (JST)
Message-Id: <20231021.125125.1778736907764380293.fujita.tomonori@gmail.com>
To: nmi@metaspace.dk
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, benno.lossin@proton.me, greg@kroah.com,
 ojeda@kernel.org
Subject: Re: [PATCH net-next v5 3/5] WIP rust: add second `bindgen` pass
 for enum exhaustiveness checking
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <871qdpikq9.fsf@metaspace.dk>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
	<20231017113014.3492773-4-fujita.tomonori@gmail.com>
	<871qdpikq9.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 13:37:14 +0200
"Andreas Hindborg (Samsung)" <nmi@metaspace.dk> wrote:

> 
> FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
> 
>> From: Miguel Ojeda <ojeda@kernel.org>
>>
>>     error[E0005]: refutable pattern in function argument
>>          --> rust/bindings/bindings_enum_check.rs:29:6
>>           |
>>     29    |       (phy_state::PHY_DOWN
>>           |  ______^
>>     30    | |     | phy_state::PHY_READY
>>     31    | |     | phy_state::PHY_HALTED
>>     32    | |     | phy_state::PHY_ERROR
>>     ...     |
>>     35    | |     | phy_state::PHY_NOLINK
>>     36    | |     | phy_state::PHY_CABLETEST): phy_state,
>>           | |______________________________^ pattern `phy_state::PHY_NEW` not covered
>>           |
>>     note: `phy_state` defined here
>>          --> rust/bindings/bindings_generated_enum_check.rs:60739:10
>>           |
>>     60739 | pub enum phy_state {
>>           |          ^^^^^^^^^
>>     ...
>>     60745 |     PHY_NEW = 5,
>>           |     ------- not covered
>>           = note: the matched value is of type `phy_state`
>>
>> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> 
> This patch does not build for me. Do I need to do something to make it
> work?

Hmm, this works for me.

Note that it depends on the first patch (the changes to binings_helper.h).

