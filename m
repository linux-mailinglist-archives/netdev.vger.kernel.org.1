Return-Path: <netdev+bounces-33024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA9A79C4D1
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 06:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6542815EF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 04:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D46A94C;
	Tue, 12 Sep 2023 04:48:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC723A6
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:48:47 +0000 (UTC)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FB3196
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 21:48:46 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-34f3dd14b66so42505ab.1
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 21:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694494126; x=1695098926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCKiXCBnsGLM9/DUGxw3G03F93in1L5QwEZIH8TjhvQ=;
        b=tjwLoScKdTU4FHi8gEhKgip+VO6CAjnTVyeukeqsxT/ffnA0TFD1QINmn5DnBY0zHF
         QQzaHH4sMEHyyhr8wAkdOGs13jqeRhE5v+hXw56URly3RJDk/jaQj8+8V2fx6L7lS9BF
         nXLT2RKzMOc5v3QmIbwwjrrOdrOnhdt3XKnxQJ+NYmncxLRvlZAU1tGS3qo2qXsRSIcf
         5NfU/XEhLNsiCfazEto//f6x9UA1xbLjkojfE0mk//Z57YkCf9dGOln15dwns1VgbjWu
         NbHcnhdic9hivhfEcmvclZmaW2A1cWGIRMl9ju8bwsB7zJkif2M9c226OBi2hBwompY9
         tIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494126; x=1695098926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCKiXCBnsGLM9/DUGxw3G03F93in1L5QwEZIH8TjhvQ=;
        b=LE9moPP6nZW62PzPkVPM9odCLkerRCjwV4dFQcirjgjd7Mgm8992yphmHjyDXmUwvX
         NmfpUy1aMFNfkgVL9+0Fi+7hshGVKeVbFvW5C51ntQ3SHLMAwt3e8QGQF+yaLmuudUlk
         P/zhJR2dxsKFNjbYAAaSneC2XCJqVJxBCwsyR3BycAvPY4nkW7GZ3X9gXzpc4hiAJjve
         4KyL1l8tXWGU4+jcs+9wjevlgDlIeoKf61soSBSR8jtHBsV6eM1Y7UQGH3ALJZeurWBX
         /9PpmXnFeJySvtWU3VyBF6rLipQPxFuQz/T6SSxsuI9/Jg6Ooph69bpwbLg4zGlXob3V
         Io7w==
X-Gm-Message-State: AOJu0YzJvH2PzY8TAes8UPX4gZidwwav6r1Tu0S3dxO5IpGo9bip5SWF
	5kyr59OK76ccClDmJLVS6YJLjg6zaUSvZYI5R0OxyQ==
X-Google-Smtp-Source: AGHT+IHGkfqYUFGUDhPSS4KI2Q4Hp8z6uCq4kGtYcI969bHFw5Sz2C/efVSgsDpkuasAL8nZt9CFbpFpeeOFcry/Kc8=
X-Received: by 2002:a92:cdaa:0:b0:348:8674:6706 with SMTP id
 g10-20020a92cdaa000000b0034886746706mr146452ild.10.1694494126029; Mon, 11 Sep
 2023 21:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911183700.60878-1-kuniyu@amazon.com> <20230911183700.60878-2-kuniyu@amazon.com>
In-Reply-To: <20230911183700.60878-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 12 Sep 2023 06:48:34 +0200
Message-ID: <CANn89i+Qpgr8FOnoHaThpXs35Ow5Mn2pJHKRkS-mBkTUeNQCww@mail.gmail.com>
Subject: Re: [PATCH v2 net 1/6] tcp: Factorise sk_family-independent
 comparison in inet_bind2_bucket_match(_addr_any).
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 8:37=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> This is a prep patch to make the following patches cleaner that touch
> inet_bind2_bucket_match() and inet_bind2_bucket_match_addr_any().
>
> Both functions have duplicated comparison for netns, port, and l3mdev.
> Let's factorise them.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

