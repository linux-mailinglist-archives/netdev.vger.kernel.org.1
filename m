Return-Path: <netdev+bounces-63265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F64582C091
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 14:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295111C214C2
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FB66A019;
	Fri, 12 Jan 2024 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXCOfspj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69835917D
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-557bbcaa4c0so7866a12.1
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 05:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705065117; x=1705669917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCYb41/q7WFAPMZE12PFyfM/tISC9uBiVVmNnuRAK9E=;
        b=EXCOfspjuoyVrmkioFc0ihX76A7xSR+lbwVfsaRAvzvIZePHDBToepC/V5nDZHEpPn
         LNiH21odljty3rrLC3Q1px8p7eQZ/YtAIoh2/34HjlgUuANwVepPe009Xwgr3kYPJSe1
         dC71qUf1OZkNK6wZH10IO0rXiAHvHLWnJZDr7GezkFvDfxWpjZf8XYoRWQ18RDLArnil
         ncM0Kw7s5PegHqthSSua2Fr5uwzvMLPIcpo5ACjxwPaIij8pQWAxJyf8LfEbFrK9KYqW
         E2xJUC/Mdnehlv0I249A8BNWm1ppRGLG9rPH4OCgTgWusOPYcI4U/3xwjHGsTEyDYD9a
         sGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705065117; x=1705669917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCYb41/q7WFAPMZE12PFyfM/tISC9uBiVVmNnuRAK9E=;
        b=jCzFWiHKL7ui7sFCL7sNmy/PEgX0D4q7aY9KSzWbYwY/Loyk9ek2t482Eq3SbXAQTp
         Nj2SGNAOabJcq7MIvTyVUxZoIMPNNMUMNeiCQnJn2KK5zpZhii1CYiAjblx0dWsFk/96
         cftDX/KAkHk1dgEXrYzt+dBw79ymlv4bBEGJBqr+jzMnmYSWQhXkTkFMRKnSdIpHqoj2
         8l0PF5XXROP6PdxQ/wv0+CeTLYpM59qjq0YHDz82grXzPBKkyJVTlbTdsCaVXYKwafCT
         LnUyAyCD4PTOH+KNuGEu3+1ehBMHfbDg51xPNQlykXX9TnS358ALVUpWTTN0Qrhqxhyb
         6roA==
X-Gm-Message-State: AOJu0YyFrXqt4E6ZpwSguKK2cpeIzxOLAwv8HZJCdVMDoF6O7PPcq4Xw
	LMc6RQeimJYB/0k3zyCTuL84E22ICiV6fvBcHEiw1ocjngd1
X-Google-Smtp-Source: AGHT+IEPoGo6mEL2Wmd3WrwtwlBysLzEZOB6azKEPl1j4qLLgIcqXx4kXJcW0oQmA0iFh5OIeBEaK6pPhozX4axb5Q4=
X-Received: by 2002:a05:6402:350e:b0:558:c7cb:49c with SMTP id
 b14-20020a056402350e00b00558c7cb049cmr119268edd.0.1705065116720; Fri, 12 Jan
 2024 05:11:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112122816.450197-1-edumazet@google.com> <ZaE39F93nKy4NKqj@nanopsycho>
In-Reply-To: <ZaE39F93nKy4NKqj@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Jan 2024 14:11:43 +0100
Message-ID: <CANn89iLam6JDbJ3NJ3cRs1fnDz2HAN_gMhAn0SewoYbqBLbW4w@mail.gmail.com>
Subject: Re: [PATCH net] net: add more sanity check in virtio_net_hdr_to_skb()
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 2:00=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Fri, Jan 12, 2024 at 01:28:16PM CET, edumazet@google.com wrote:
> >syzbot/KMSAN reports access to uninitialized data from gso_features_chec=
k() [1]
> >
> >The repro use af_packet, injecting a gso packet and hdrlen =3D=3D 0.
> >
> >We could fix the issue making gso_features_check() more careful
> >while dealing with NETIF_F_TSO_MANGLEID in fast path.
> >
> >Or we can make sure virtio_net_hdr_to_skb() pulls minimal network and
> >transport headers as intended.
>
> You describe "either or", but don't really say what to do. Bit
> confusing :/

Not sure I understand your point?

 Patch title is " net: add more sanity check in virtio_net_hdr_to_skb() ",
and the change is implementing that option.

I am saying I prefer not touching gso_features_check(), even if we
could just do this.

Had I been silent about that option, I am sure some reviewers would
have raised the question,
given the stack trace ?

Apparently you are saying these kinds of things should not be ever mentione=
d,
because of some "imperative mood" request that you often raise with my patc=
hes.

I have not written a novel, only one sentence, admittedly not written
in perfect English.

