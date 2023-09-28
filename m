Return-Path: <netdev+bounces-36844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570B17B1FDD
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 16:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id B04EDB20C6F
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 14:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23123F4BC;
	Thu, 28 Sep 2023 14:38:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C753C6A8
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 14:38:29 +0000 (UTC)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5304C19D
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 07:38:27 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7ab8696d047so4462506241.1
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 07:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695911906; x=1696516706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLH+mn+CYz4JEjkQnO7COElnE8Isjtmmz94b2JcwmHg=;
        b=CJN/0KnKRZ66Yy3XwNBToTSTzWGd5fQzspUlQb2zNDwY8tiBsJBjqPwcEbSYHOGgb6
         aJo3wUL7xJaH0eAHhFctbmVEaG2CHoIna03QBXckyQOyujBCoR7QMZzrFWPBtl7RVuKW
         o+AUjb+9kSVYohsUbbbU/JGqFSCjKcQCBreoJXGcUH1+TVyyOlL6ismHzSl/v7ovqqks
         JDo/y+zOtq4yatgBv2XAX1c3+7/uAdhgjpZX2GPuyymsX1QVVAwspqg7HxkCg+nQWufV
         +Qr1+qsZG9Q9HTePBErMXuPkWjsCr6OItOC2CTfk1dMVBiZoA32i+VHF+i3HKDKUyD/M
         CftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695911906; x=1696516706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLH+mn+CYz4JEjkQnO7COElnE8Isjtmmz94b2JcwmHg=;
        b=GuFw1z7ebEiTsRddRtat4z86hbdj4O5id+cqF8lQQX4p+DVw5WhDqw10jo0KCWNmxn
         W46ToUU+Fv1rx4I2bycrXKasUSyonZpIpX1DiKKeDZzDz9cEAV/MuztVkCnULfC1nBWL
         y78fr7rA7vP5CW0d/rezjU4ru8GOGakW/DqAa0449szwnMiIbOkYjM3QSEtzVgzjCjqH
         /FBjZRni+atOz3BrnNJaCh3OVRDS7tg0VeFjFeMEH3Knh+f0GMZ/0IMIhxuXpM4Bbdta
         rvLF3y+9aAr+aB3GBykYOBh3F3M5FgavpFtgafmvLBzwpq2Fagn2ZB7n35c1N2dsL9ZN
         iv3Q==
X-Gm-Message-State: AOJu0YyYysQ1D8Qb+zeoeuOVVxLqR76SVdm2ellZb1qoyB0xBU9ihm6K
	1towo0bCd6cFOloHj1F9pqAaoNugWoRLW1h+4tegPA==
X-Google-Smtp-Source: AGHT+IEyzAdLXC2ZpeO4qFRix4x2XjOp+tODTuU6Z3a2feIIEIQ2TQTNcRkLELFSLJUxjEr7u8rN0dzSgvz7Ee/wo/0=
X-Received: by 2002:a67:f88a:0:b0:452:cfeb:1613 with SMTP id
 h10-20020a67f88a000000b00452cfeb1613mr1291851vso.23.1695911906290; Thu, 28
 Sep 2023 07:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927151501.1549078-1-ncardwell.sw@gmail.com>
 <20230927151501.1549078-2-ncardwell.sw@gmail.com> <CAMaK5_gz=B5wJhaC5MtgwiQi9Tm8fkhLdiWQLz9DX+jf0S7P=Q@mail.gmail.com>
In-Reply-To: <CAMaK5_gz=B5wJhaC5MtgwiQi9Tm8fkhLdiWQLz9DX+jf0S7P=Q@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 28 Sep 2023 10:38:09 -0400
Message-ID: <CADVnQymiStUHkzmrTrm_uzt1Cw-NgZ_4MuF5+BptArJfGRFQsA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] tcp: fix delayed ACKs for MSS boundary condition
To: Xin Guo <guoxin0309@gmail.com>
Cc: Neal Cardwell <ncardwell.sw@gmail.com>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Netdev <netdev@vger.kernel.org>, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023, 4:53=E2=80=AFAM Xin Guo <guoxin0309@gmail.com> wrote:
>
> Hi Neal:
> Cannot understand "if an app reads > 1*MSS data" , " If an app reads <
> 1*MSS data" and " if an app reads exactly 1*MSS of data" in the commit
> message.
> In my view, it should be like:"if an app reads and received data > 1*MSS"=
,
> " If an app reads and received data < 1*MSS" and " if an app reads and
> received data exactly 1*MSS".

AFAICT your suggestion for tweaking the commit message - "if an app
reads and received" - would be redundant.  Our proposed phrase, "if an
app reads", is sufficient, because a read of a certain amount of data
automatically implies that the data has been received. That is, the
"and received" part is implied already. After all, how would an app
read data if it has not been received? :-)

best regards,
neal

