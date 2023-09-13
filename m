Return-Path: <netdev+bounces-33575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0328079EA63
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 16:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F201C20C82
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 14:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043461F166;
	Wed, 13 Sep 2023 14:03:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CDF1EA74
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 14:03:25 +0000 (UTC)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C5419B1
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:03:25 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4943862e73dso2140509e0c.1
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694613804; x=1695218604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjzbHnSvAqIQYDELTaH1Gq6eiRXRq5flC8+idgkGMLs=;
        b=k5B0ZhDpF7vzAAJAlCM0kn4bmCW8+byZg+b7oD2t7hPy37MESRpgv7t8a4U6ehp15Q
         5HRAa46ZtV9Q/+pwpIkIuF2TkQuIBUsahbAIW2KO59rkGXHKn73rt4gc+eewTsSvHFq1
         AhADH9QJrRpGSXmPg8MGKo+Q2V0bV7wdsGdMQ5mQZi96DtISr7/moYdhEK/XaxFiiRaJ
         KVFherJQ84lmY4C+QLnlxV8IHXo/zgQgqeBx0e52H7/QErIAl52VAk1Y7LC5sW8W1P/k
         n4wC38nZDGypCRue9zdOrVRJW6xv+YWlgKMe0YK87qFfHy0FgGsMTQDSi0bnMjpnjTtD
         MG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694613804; x=1695218604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjzbHnSvAqIQYDELTaH1Gq6eiRXRq5flC8+idgkGMLs=;
        b=hnokP5pV1rstI5wUd6tIusYqpElp5AgIUiqqAxO+9OtCshhixLNHG2TPUcFJI9OWWi
         XJcPnbk6N4qZYjgtvthqKEeJrlOC6Q4edWMQCycGELblUN6BItFO/BNak48MT43kofoO
         pLnn8ZxqBPXbMNJXApuPhk+f9vzdD+h4F9BOdj5wEgO1iLtaepAevt3ZcoOVlXOK+jsr
         XYZhi8Bl0ix1mWdxXRxt6BWlplJ43giTZW8jkmFE4oEJ2E0nOnbXbuoTZi4doMMcYzJT
         VitKhTLSJyXCf57xVxUUQHpHznW92lFPgh2KPCyICTSvD2UApNHyVdwgJ3GelgeuHY2J
         tRrg==
X-Gm-Message-State: AOJu0YwbA463Q2hcFYk5VYuQ4rJqyZ2Qyr9A4s64/DCFYNHFyNJrRBNa
	FqoW6xo2V+vh6u5C1w+gjCzWb7aFtedSaT2vMFk=
X-Google-Smtp-Source: AGHT+IF1lAbN8btfTZBgIdggkQPnepRwFtWbtA+Gtbwc87g2ntv9gEeBFAxlR7Ak+csX/0FDiW0vJA9kNPmKakHEz7M=
X-Received: by 2002:a1f:ec84:0:b0:48d:eaa:45c4 with SMTP id
 k126-20020a1fec84000000b0048d0eaa45c4mr2487181vkh.7.1694613803687; Wed, 13
 Sep 2023 07:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912013332.2048422-1-jrife@google.com> <65006891779ed_25e754294b8@willemb.c.googlers.com.notmuch>
 <1ca3ca8a-6185-bc55-de74-53991ffc6f91@iogearbox.net> <CADKFtnTOD2+7B5tH8YMHEnxubiG+Cs+t8EhTft+q51YwxjW9xw@mail.gmail.com>
 <CAF=yD-KKGYhKjxio9om1rz7pPe1uiRgODuXWvoLqrGrRbtWNkA@mail.gmail.com>
 <CADKFtnSgBZcpYBYRwr6WgnS6j9xH+U0W7bxSqt9ge5aumu4QQg@mail.gmail.com>
 <CAF=yD-JW+Gs+EeJk2jknU6ZL0prjRO41Q3EpVTOTpTD8sEOh6A@mail.gmail.com> <CADKFtnTzqLw4F2m9+7BxZZW_QKm_QiduMb6to9mU1WAvbo9MWQ@mail.gmail.com>
In-Reply-To: <CADKFtnTzqLw4F2m9+7BxZZW_QKm_QiduMb6to9mU1WAvbo9MWQ@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 13 Sep 2023 10:02:47 -0400
Message-ID: <CAF=yD-Lapvy4J748ge8k5v7gUoynDxJPpXKV8rOdgtAw7=_ErQ@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent address overwrite in connect() and sendmsg()
To: Jordan Rife <jrife@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 5:09=E2=80=AFPM Jordan Rife <jrife@google.com> wrot=
e:
>
> > If we take this path, it could be a single patch. The subsystem
> > maintainers should be CC:ed so that they can (N)ACK it.
> >
> > But I do not mean to ask to split it up and test each one separately.
> >
> > The change from sock->ops->connect to kernel_connect is certainly
> > trivial enough that compile testing should suffice.
>
> Ack. Thanks for clarifying.
>
> > The only question is whether we should pursue your original patch and
> > accept that this will continue, or one that improves the situation,
> > but touches more files and thus has a higher risk of merge conflicts.
> >
> > I'd like to give others some time to chime in. I've given my opinion,
> > but it's only one.
> >
> > I'd like to give others some time to chime in. I've given my opinion,
> > but it's only one.
>
> Sounds good. I'll wait to hear others' opinions on the best path forward.

No other comments so far.

My hunch is that a short list of these changes

```
@@ -1328,7 +1328,7 @@ static int kernel_bindconnect(struct socket *s,
struct sockaddr *laddr,
        if (rv < 0)
                return rv;

-       rv =3D s->ops->connect(s, raddr, size, flags);
+       rv =3D kernel_connect(s, raddr, size, flags);
```

is no more invasive than your proposed patch, and gives a more robust outco=
me.

Please take a stab.

If it proves at all non-trivial, e.g., in the conversion of arguments
between kernel_sendmsg and sock_sendmsg/sock->ops->sendmsg, then let's
submit your original patch. And I will do the conversion in net-next
instead.

