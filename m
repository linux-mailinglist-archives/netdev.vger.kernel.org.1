Return-Path: <netdev+bounces-39188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B4F7BE481
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC0E2820FE
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0BB36B09;
	Mon,  9 Oct 2023 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRBvdASL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B267110A36;
	Mon,  9 Oct 2023 15:19:29 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99ABA6;
	Mon,  9 Oct 2023 08:19:28 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59e88a28b98so39811807b3.1;
        Mon, 09 Oct 2023 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696864768; x=1697469568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NQgphY94HzWJF0y7pko/rMyJdGEhcOIox0qCNbTGxg=;
        b=PRBvdASLmD7E6STntBYoErxOu6+G8HNOaHsJfLn0wb4lVTQH9kdcHC8NJWzeIrUza5
         vwLszH7G4bPO44Q9atEpJEsnAo7mt5xTg/5VBrUBDDVIaQix5NQsjK5Z9sKlNxbWXVlZ
         kN76yCZN4hNk8v6rELp7gz1rq8W61R7weitxdMO5TiNBSOB+btRRK8lwkfqb/tud50Hp
         hUP6948EmitQKYqp+SGHLc8H8pcc4TkKHFvwLKX1Y/L7Ptab1qtj/zw0ZSH6p83pJu3p
         5KmsdJ40RZWRYEwPoKKlEbIodh43W3FMeUw2qJ4z/j1RwQZb2PILBMp+Wuyd0hDdxjxW
         at6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864768; x=1697469568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NQgphY94HzWJF0y7pko/rMyJdGEhcOIox0qCNbTGxg=;
        b=bh/oMuA73QqCQr5RlpkY2jKj71wHDH4ZTkx9UNIuX1m0mIv+4/QBzOH0TF4cBpxXAW
         iHx5E65QJdtGXsRBPSXQbZ7Lylhzu4DZt5r46auVzaSRrughirj3eiR6RYhHBStYabFQ
         KVAaKxsapsPqoS4yvtTNTJ0cihDfO4oao5FaGTvL8MsbCcrI9vreV1ZO1s/BEV2jb/XU
         ZTojrBhV6ZTwjKRTKpjQEk8ZZz6vjTlZOOJ3SatQ4HZadlvvxZ0EyRYo+c69J4M6uNiG
         TYOQglewxKK5dyl14fziHvvp3E8n/BFw5PXrT46ZCmnlbzx7OloFfTvQ6Tss9FJKW6eD
         l/QQ==
X-Gm-Message-State: AOJu0Yx3XFnGFUMO5+nUz06hAvMAJNVRMUeIkSqQSwmQn6+SFYVtsatK
	/575wtwfF2JpUdU1awMWYEPx681EhP4+sEuE9Go=
X-Google-Smtp-Source: AGHT+IF49SOFoWhkhwkHNX54Ao5xnIzrZKnB5R8TEtlBUTMDCu2IQaEl2aU3tbQp3fDbjDfFJ+kiei2O3Yktvre13Yg=
X-Received: by 2002:a81:49d7:0:b0:59b:5255:4882 with SMTP id
 w206-20020a8149d7000000b0059b52554882mr6688622ywa.20.1696864767975; Mon, 09
 Oct 2023 08:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
 <20231009.224907.206866439495105936.fujita.tomonori@gmail.com>
 <CANiq72nf1ystSiV_BavRvMHA79bO7XapA3TURag1Kw_wzUr2Og@mail.gmail.com> <20231010.001536.1522827516505306330.fujita.tomonori@gmail.com>
In-Reply-To: <20231010.001536.1522827516505306330.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 17:19:16 +0200
Message-ID: <CANiq72mawL=997yWzUigJscBLbf=R1wPtpwSv70GvT5-15-WvA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	greg@kroah.com, tmgross@umich.edu, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 5:15=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> It's up to PHY maintainers. I prefer that the patchset are merged very
> soon. Much easier to improve the code in tree.

Yes, sorry, my message was meant for Andrew.

Cheers,
Miguel

