Return-Path: <netdev+bounces-54029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A2B805AD2
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419031F21A60
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDF869290;
	Tue,  5 Dec 2023 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nn1mW42N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD351B9
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 09:09:10 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso13032a12.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 09:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701796148; x=1702400948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkFwzVvbe6yA1cIGZShUgkfM/+JdLkcU+PGFPzrYDiU=;
        b=Nn1mW42Ntk6S9u0SXVGzDwkIxzFQXdacusxu0YE20oQtR50XCAfnGrN5uEXnxkjJH6
         tX8tyr8s5f94c8kwmt4aLjZV47wIzngjzFzYkCGgoYzwSkEWE/mrg6drVKcgiNKFxOa+
         xPT5YXWFu9tWTrxPgjFKcnlI3VWSd+JNwy8u3BjyT0n7uEbtriTGqq5BcdjPzlRstMmi
         prNdnrSA0x3dI1luVwIiMTrygQ2FNEdIVpGeSAw+C3TD5A4PXaB2FK4CeTRBHwISyWJK
         81ARf6vf6315JJQtNjhAIsIqOhgWQuq0DEny+mGeDcJ32wrzwnEyUWYE+28/IVbEk2Pe
         qQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701796148; x=1702400948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkFwzVvbe6yA1cIGZShUgkfM/+JdLkcU+PGFPzrYDiU=;
        b=QVp9vNprMONOBBDeT7ZEJzWh6YUwOlqPYLyDJGv0tQcY6dg0CbMJjdlhwZhv8CViL5
         FIROOB3yIKbUKMSUZr7qlF28/N+KQHnhdEZ8+wSRphE4ICsZ8zeW+DIjp9uQzDDE72ax
         VkQPgLRoQjXleFlnnNPPK3Jolt4jZ4g30K69Hy2x9A/yusp+DIREoPEAnLBFygik+8+M
         tumAboneCvDalQqKoiHcDl9aqOPo2SxVfIZB9JBed8fl9g2CqQwZnK9xLL3G7Jo0Y4Ow
         XwckNYZ9lAAG669qzCRAFeuuk93S86yJ2pWddB2l3AQLcXYSuQA5gP16GpQIrblMGaxE
         kRAw==
X-Gm-Message-State: AOJu0Yw8zKxMCVNls8g3yRcDUA0wTCgsqQRO0jbydc5xaMoUPxhT9Ty1
	H6U5kIYObtxrgXWPGUrzZ71heJL3iOhM8+ROe5Yu7pLmy6gbwByDRfc=
X-Google-Smtp-Source: AGHT+IF2i5XyQR1RU0uyna1eHXekO04dHiuZe6LQ98fv76mTz4QyL/jue4lAyxNlVBJ58/FzkHyI8lVwMuntfPY/V1c=
X-Received: by 2002:a05:6402:35d3:b0:54c:9996:7833 with SMTP id
 z19-20020a05640235d300b0054c99967833mr312277edc.7.1701796147967; Tue, 05 Dec
 2023 09:09:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0TfTAkaRWFCTb44x=TWP_sDZVx-5U2hvfQSFOhghNrCA@mail.gmail.com>
In-Reply-To: <CAG48ez0TfTAkaRWFCTb44x=TWP_sDZVx-5U2hvfQSFOhghNrCA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 5 Dec 2023 18:08:29 +0100
Message-ID: <CAG48ez1hXk_cffp3dy-bYMcoyCCj-EySYR5SzYrNiRHGD=hOUg@mail.gmail.com>
Subject: Re: Is xt_owner's owner_mt() racy with sock_orphan()? [worse with new
 TYPESAFE_BY_RCU file lifetime?]
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, netfilter-devel <netfilter-devel@vger.kernel.org>, coreteam@netfilter.org
Cc: Christian Brauner <brauner@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Network Development <netdev@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 5:40=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> Hi!
>
> I think this code is racy, but testing that seems like a pain...
>
> owner_mt() in xt_owner runs in context of a NF_INET_LOCAL_OUT or
> NF_INET_POST_ROUTING hook. It first checks that sk->sk_socket is
> non-NULL, then checks that sk->sk_socket->file is non-NULL, then
> accesses the ->f_cred of that file.
>
> I don't see anything that protects this against a concurrent
> sock_orphan(), which NULLs out the sk->sk_socket pointer, if we're in

Ah, and all the other users of ->sk_socket in net/netfilter/ do it
under the sk_callback_lock... so I guess the fix would be to add the
same in owner_mt?

