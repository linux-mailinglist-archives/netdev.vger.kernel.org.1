Return-Path: <netdev+bounces-38888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2627BCDB2
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 11:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A7C281B41
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 09:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B3EBE4D;
	Sun,  8 Oct 2023 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="BylOMK7N"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BAF210D
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 09:58:43 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318EEB6
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 02:58:42 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59f6441215dso43732597b3.2
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 02:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696759121; x=1697363921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BUOfZ5u4Lzp581IO/H3NzM1c5ss1yPUdACAcJ9LVNM=;
        b=BylOMK7NmVSahNBAlo1SDdHmhmy+RdGakW0TSqehnucOdj8zoJlzKZt/zkuNgaqtf9
         TG/cqny8r6JOJfpjHOjA2zoBEyKq57KqB27zZLVCWVY3xdN2YgFRqCT81dida0mNrsYb
         5fXnX6aAQjm0VXBHcd1bdSTJRktC8BqTBJ9P0p2sD833ccOk097rV8nbBnhTVDxHpbee
         jhkOpzP3TWTziSWYnPuPaccCdKqvjEkh+Z/droVlNWXyCAfYoQ2/wJEB/m1Iqi7zJZU9
         sx3jvAUF2qii4Mjt9dulG2zNCjkr/14ZMutsrE1nmmrE8KGdY+hEYWXNjRu04RhGVRvh
         FJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696759121; x=1697363921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BUOfZ5u4Lzp581IO/H3NzM1c5ss1yPUdACAcJ9LVNM=;
        b=KC3WExuPL5KjQBKdZPAFzQNx68EAKj2ntEXMyU9TUrnRnLqkC5/XhYoqeYtAtCDTbJ
         9rGRLUtszLtU2lPn2Ge+DCOnG3HjUdbnTlWHea/SVXaOOp+FGY6d+I3Wtbe2/2u/jS18
         qOo2TTZ4gVlPa25Yf+npUAP+wLRXtCFzie1WV5e1Kg7Z+i0KIC8cd2FRIs9+vveEPyek
         lLRTKl7l0bNUSJa/RzH5saI8lOBu1QwrzktBQawgjRU2Yd3GbGG58VniCVbDGlmQfssR
         TDBeqU9FN3cmV+L6utjYZUiohtMX63wvpbURWE1VHbSzhn8tbwpUr630ierGSGrgypKL
         ZhxA==
X-Gm-Message-State: AOJu0Yyol0VVZv7PqsdVWDHr4/7DaR104NxdQ3QwhujZJDxl1gZnSUvN
	BwjNkNQzgfPkqPLngmEKTtkQW7Ue+MAe+gD2mqP+XA==
X-Google-Smtp-Source: AGHT+IFYOapup9gAZulsLb2yT23Pw+WtoQf6F8HLfw0peZSp+NaZDSv11chD2x3ak9BjYSOZSCCsE/cEu0u/YnZ14LI=
X-Received: by 2002:a0d:cdc2:0:b0:59b:d3cd:ffb6 with SMTP id
 p185-20020a0dcdc2000000b0059bd3cdffb6mr12651258ywd.33.1696759121425; Sun, 08
 Oct 2023 02:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALNs47v3cE-_LiJBTg0_Zkh_cinktHHP3xJ3tL3PAHn5+NBNCA@mail.gmail.com>
 <20231008.164906.1151622782836568538.fujita.tomonori@gmail.com>
 <CALNs47sh+vAXrZRQR8aK2B_mVoUfiHMzFEF=vxbb-+TbgwGpQw@mail.gmail.com> <20231008.180257.1638765262944543712.fujita.tomonori@gmail.com>
In-Reply-To: <20231008.180257.1638765262944543712.fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 8 Oct 2023 05:58:29 -0400
Message-ID: <CALNs47u66Lr5LaD_+V14eh4vyrV_FKsQYdxyDTzgD35gBc5FOQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 8, 2023 at 5:03=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Yeah, now I don't use paste! in PHY bindings.

Even better!

The fix was small so I sent it anyway,
https://lore.kernel.org/rust-for-linux/20231008094816.320424-1-tmgross@umic=
h.edu/T/#u

