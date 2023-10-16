Return-Path: <netdev+bounces-41478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4087CB17F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4319F1C2087D
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E82431A9E;
	Mon, 16 Oct 2023 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkW8Qd/b"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2911286B9
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 17:43:46 +0000 (UTC)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C6E9F
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 10:43:44 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-49aa8518df8so3191408e0c.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697478224; x=1698083024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRPnvY3Y0/NeBihYG/qEse+MEjta3d9Yr1JT064ZGa8=;
        b=KkW8Qd/bk8LAWK8AXau1KUZDon58bYKxHyXrr2MioMPjtdAZmwZck9Ld9r65qSbxKu
         cYVaTqnRK7+qy2aIIZUHrpFBpFvluk4CUxYyTvT00XNBX1waq3K85p7jJHef6QyatFBO
         m2t0Otgw308Z3gbqNpXHSn82593CzECep08C9lFuACdXUaG1U7wi6KCeSaNPMo/AUQ7z
         iatxR/QidxUOB67mOkTQc5KRbLVvMd5BmDIyuBBo/ddhdTzOehvLIOvhlTx9+9+4fXGY
         KM+EhkjWM2IeGsaJZUPJeHJiR8bFZyC5vEld/mjjhEl6Fw+aPxDgy3i1p2MVje/rKrkt
         QNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697478224; x=1698083024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRPnvY3Y0/NeBihYG/qEse+MEjta3d9Yr1JT064ZGa8=;
        b=LAwq4x+jdL93j97iUHP2T4rzH1ZpUf/eNUAUtdc86D4lCKkI/O3sIBfaocr2z3m8tr
         GBUk0oDTim8d5RyVrqUN/jn5bgCbmefx+bzDg7vn3Lx8J1DnpHKREDcBLvE3M/YnjMwA
         qojKpGFS2raCYiAOHcw0VSOXdpvMjvi0U4hb7zFI/Q97Zz+WTYHR6/hBiRXkxXmPN5Z+
         xm7mYRhA4XlWbVXmztI4RKp7h6hY1usuSH+oBKdgsc9tXUNQDgsE39Vb08C4x46RmOvW
         pDhOw1dMhbZCWtQh9Ak40AIv1HqKC+HWl1OMpabITa5VQiXtBeWC/PpKKqHe4JkqLzda
         jaFQ==
X-Gm-Message-State: AOJu0YxQgkkG7wN5ZgxYPJwfTOcHemv1hHKLdPs0uv61IA48ezkM1jnE
	VeTUVySBzeRYvuVzLsLpHi8Gvb9PYZw9o6+qVcg=
X-Google-Smtp-Source: AGHT+IH8OIPgdGWOMVJDO21ECjxfhCuxdZsrg5LyG26XeSqAMl2TiW+6OHHzYw8XF6ytBWOe0+FQhWM0ulkdxOc2aLE=
X-Received: by 2002:a05:6122:3107:b0:494:63f7:4e7f with SMTP id
 cg7-20020a056122310700b0049463f74e7fmr128778vkb.2.1697478223980; Mon, 16 Oct
 2023 10:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003153416.2479808-1-kuba@kernel.org> <20231003153416.2479808-2-kuba@kernel.org>
 <ZS10NtQgd_BJZ3RU@google.com>
In-Reply-To: <ZS10NtQgd_BJZ3RU@google.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 16 Oct 2023 13:43:07 -0400
Message-ID: <CAF=yD-Lx7eWLHwNaTwarBPmZEJZ-H=QJVcwpcrgMUXDSkc6V3A@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] ynl: netdev: drop unnecessary enum-as-flags
To: Stanislav Fomichev <sdf@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, lorenzo@kernel.org, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 1:35=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 10/03, Jakub Kicinski wrote:
> > enum-as-flags can be used when enum declares bit positions but
> > we want to carry bitmask in an attribute. If the definition
> > is already provided as flags there's no need to indicate
> > the flag-iness of the attribute.
>
> Jakub, Willem hit an issue with this commit when running cli.py:
>
> ./cli.py --spec $KDIR/Documentation/netlink/specs/netdev.yaml --dump dev-=
get --json=3D'{"ifindex": 12}'
>
> Traceback (most recent call last):
>   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/./cli.py", line=
 60, in <module>
>     main()
>   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/./cli.py", line=
 51, in main
>     reply =3D ynl.dump(args.dump, attrs)
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.py", li=
ne 729, in dump
>     return self._op(method, vals, [], dump=3DTrue)
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.py", li=
ne 714, in _op
>     rsp_msg =3D self._decode(decoded.raw_attrs, op.attr_set.name)
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.py", li=
ne 540, in _decode
>     decoded =3D self._decode_enum(decoded, attr_spec)
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.py", li=
ne 486, in _decode_enum
>     value =3D enum.entries_by_val[raw].name
>             ~~~~~~~~~~~~~~~~~~~^^^^^
> KeyError: 127

Indeed. The field is now interpreted as a value rather than a bitmap.

More subtly, even for requests that do not fail, all my devices now
incorrectly report to support xdp feature timestamp, because that is
enum 0.

