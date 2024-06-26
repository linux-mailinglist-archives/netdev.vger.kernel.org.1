Return-Path: <netdev+bounces-106793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A46917A94
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36138282ED3
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDB715F3FE;
	Wed, 26 Jun 2024 08:12:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5CC13AA3C;
	Wed, 26 Jun 2024 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389573; cv=none; b=Ow/ARoD9/hgAhsmog/j1tAS2zFdwGZM4nbEVtXTymD2ji2fOloxpQKt9uvNNd2cx1mxyrkQ3p+ZZ2RQIs1lsQV6qx1JsPPzlEoWdi6ongEwdb8IzL6UpCms1Tm+LLAOsRI/tNgkPkx2WDUEaPSqQ/dyEjyst4kUjGNG9nA6dHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389573; c=relaxed/simple;
	bh=D5Cbu+U1HZWDIHt0LpKSf7Cur/m6GJUgdd7v+AQOkfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJDNp9zAgor1LassfiZi39cLa4qVYaejj1eElt6qgoqM8ZL0Dw4cQxd3dQvNgezp+pynzD3L5FOmY5wCxxcalk2gnf/LPAMb5+zt+Tr5SPM7hpYUcQYH7+lOuOa8Ya5ktc+ErhRKXOuk7Dr7Byv92cGT5nI4IX8ERGknAn1UtnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dfe1aa7cce2so6082997276.1;
        Wed, 26 Jun 2024 01:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719389569; x=1719994369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6yFjbUBltT3UtsPx++KaysizwCAujSrK4XvFo3PCu0=;
        b=qsx2/96nKQoKmzTk9WiEVnYY0JuqNHc6kwryyEkYgiXVaY2Bw7hnC/bspl7WjeOH9w
         7lJ2NqNWebTmGt2QVQlTW3ct6TjAFmxL8w145ynODVIALUo1IRCyJhTvAe7/ME/5SEHa
         KPPIfMFbgAzVGnsGDkIA+Vw4CqnNM6MwUkTXCaVxLkxwBUjqZA7rq8azQW3Yk+StcuBE
         oA5rP8Yk/hGsKq6swcgu1acP7z8HqYAys/2zG4tC0jQkAE2MV/N04n0nf53E/pdDWcYe
         ObAlDKSoad+arQcKUjuatE/UyVolWz1LA5LUQAFEzW3ejmVb2Z+9ePBCMBwbdNkaO0gQ
         IVXw==
X-Forwarded-Encrypted: i=1; AJvYcCUSp9m7n2p7fKt2nU5Lqy2jewR5/qnx3T3K7aca4f5KfPkxPzuZvFlqHkUsW+5LgwXtgj2SZ/gx7v0On1P5O745E1xT1SVJVlalDzaKsa3HiS+JYtRD1p6ffdytoQYXzHOwG8kc7Y4XxY/iH18EE+NRkQt/82XQCm+BrNkeB0BTE7jTV+Mzx4juh99jcKSnxz8eBvlo9tG76UPM
X-Gm-Message-State: AOJu0YxdVDBU8/ov4KkpAVeZ8ej0AjF055Y/kMXANYnOjBDxafx6sKhf
	MXRkN92zrTofXRHXCqWt7TmBwm4I1KKz7fQclKdQAYeIOCHgwHwbRc0SZpn6
X-Google-Smtp-Source: AGHT+IGu9u4YTJN2HEf5VgvjxqVtuKUriKszqMboR/wEfByBUIu3DhgMYGmysKeryJpwWVIZeN1flA==
X-Received: by 2002:a25:ae5d:0:b0:dee:8d62:8c10 with SMTP id 3f1490d57ef6-e0303ed450bmr10044937276.12.1719389569184;
        Wed, 26 Jun 2024 01:12:49 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e02e623c597sm4349136276.14.2024.06.26.01.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 01:12:48 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-646645f1387so20924417b3.1;
        Wed, 26 Jun 2024 01:12:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWp29cvZ/azbcQW6mwk+n9Z1csuRY3Gz7DzeVh060rXUwSuuH8rbm3eYQ1TPsYMlT1MPgsrJCR02+MRbkvW58bzwq0tygbNrdFZogP5GD/Hz2nCGZ/FAbgblw+9IfR9/3JammHZSZQ9Ol6HV+r6YzYgSyBa0/1YnrT5lF2C/semZYNLUHXKSB95KBi3P/a219ijK8Dx530s//fr
X-Received: by 2002:a05:690c:6e0c:b0:617:cbc7:26fe with SMTP id
 00721157ae682-643a9fcecb1mr105251747b3.16.1719389568194; Wed, 26 Jun 2024
 01:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org>
 <20240618-docs-patch-msgid-link-v1-2-30555f3f5ad4@linuxfoundation.org> <20240625172727.3dd2ad67@rorschach.local.home>
In-Reply-To: <20240625172727.3dd2ad67@rorschach.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Jun 2024 10:12:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXHa52RBjzA4eF4ERNuJjRHyq=FfyPz-yOsjOA7ZQfouQ@mail.gmail.com>
Message-ID: <CAMuHMdXHa52RBjzA4eF4ERNuJjRHyq=FfyPz-yOsjOA7ZQfouQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation: best practices for using Link trailers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Tue, Jun 25, 2024 at 11:27=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> On Tue, 18 Jun 2024 12:42:11 -0400
> Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> > +     A similar approach was attempted before as part of a different
> > +     effort [1], but the initial implementation caused too many
> > +     regressions [2], so it was backed out and reimplemented.
> > +
> > +     Link: https://lore.kernel.org/some-msgid@here # [1]
> > +     Link: https://bugzilla.example.org/bug/12345  # [2]
> > +
> > +   When using the ``Link:`` trailer to indicate the provenance of the
> > +   patch, you should use the dedicated ``patch.msgid.link`` domain. Th=
is
> > +   makes it possible for automated tooling to establish which link lea=
ds
> > +   to the original patch submission. For example::
> > +
> > +     Link: https://patch.msgid.link/patch-source-msgid@here
>
> Hmm, I mentioned this in the other thread, but I also like the fact
> that my automated script uses the list that it was Cc'd to. That is, if
> it Cc'd linux-trace-kernel, if not, if it Cc'd linux-trace-devel, it
> adds that, otherwise it uses lkml. Now, I could just make the lkml use
> the patch-source-msgid instead.
>
> This does give me some information about what the focus of the patch
> was. Hmm, maybe I could just make it:
>
>   Link: https://patch.msgid.link/patch-source-msgid@here # linux-trace-de=
vel
>
> Would anyone have an issue with that?

Or, just like with lore links:

    https://patch.msgid.link/linux-trace-devel/patch-source-msgid@here

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

