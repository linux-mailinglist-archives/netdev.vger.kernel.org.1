Return-Path: <netdev+bounces-31510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C2778E777
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 09:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B9328131B
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 07:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FEF6FA2;
	Thu, 31 Aug 2023 07:59:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D975633D7
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 07:59:01 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EC9A4
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 00:59:00 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40a47e8e38dso184851cf.1
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 00:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693468739; x=1694073539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zil0v0nCkbQM5xAwkqrhdJTcmiq+0AYkDTZ0gAt2d8s=;
        b=D75jA+NVbmp0GDpiJZ/+xQGERMb6jv6k/TZ07/XjBazbrJw8/rE1+x0TD6ZLt116bE
         mucvy1tBWoqyBRQocj1KBc2dvZbvLbI4+PU0D8BT2QdOq68DIcXI1rUjR5nocbWUGdVh
         IuKblGa8x0m/Vncyxus2XfGFXxHoLiz7QjEEJmLKgPrCiaRBz/tz9bEkGv4wXwQ47U3l
         OA9SRA1KGS6dte25xAMaOmJU/KmD/XMlCHmSEUiP0owIV+fk9F1nK5T3qts2RK6Pt4WY
         8uXMca5UfbpOn94vQqAmMTOGVUERNaTq7j2lItiOoskb7u1DlnQSYB9hm0nH04gZ05oT
         A9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693468739; x=1694073539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zil0v0nCkbQM5xAwkqrhdJTcmiq+0AYkDTZ0gAt2d8s=;
        b=WaVZcep1GRy7qtXFLpbxuhPxQ2eG+q55nc8Yi0pLHwrKtreYxqUS7KZhrTwyvouzLe
         9G/WWEtaEEQVddkRdbrOvvbZiaoPKIEbuT6VYJW3tXJRqDNF2lFii0FGjPy7I1igKoIK
         8A5MpLEOmy8WnTTf6ZrHyqzaNrAM7nojPI+IC9HFXryffkLsSITUVEY/gWXNZu0moI4r
         X0/S4QewPCUIYY0Erz5fOEUolb8L/WdGSQmkZUS+v2Iu70c7PPi2R5mJCPkBfLF3EB0R
         9xQKTKMBrLw+wXg7/VQwGXxKYmDlirhBBS7smdQm/g1f3n+GiwK/qaGWHXTfA9RXdMR9
         kIBw==
X-Gm-Message-State: AOJu0YzRq4tR5Bw6Bc6IAUcM16DJQ8QL0foHHdft8pfdHBNy7BzXKYhR
	5FnVWbx915C3XfWP+P7V4EIsKV0ql1qDa1EhGEJMHw==
X-Google-Smtp-Source: AGHT+IEJIDwonLo5SQWjryCsLxC88Rq3xYYZP9PAQjY9ylRt7c9TzwQvx3L9iZT2H5mZOKw/ODNFkv94Kls+Cs3hCZE=
X-Received: by 2002:ac8:4e47:0:b0:3fa:3c8f:3435 with SMTP id
 e7-20020ac84e47000000b003fa3c8f3435mr136504qtw.27.1693468739476; Thu, 31 Aug
 2023 00:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230828091325.2471746-1-edumazet@google.com> <566a0f821ec2fdbcb6b31aae56e478c6d4d59fa3.camel@redhat.com>
In-Reply-To: <566a0f821ec2fdbcb6b31aae56e478c6d4d59fa3.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 31 Aug 2023 09:58:48 +0200
Message-ID: <CANn89iJrf6-b4Qc074cpQCghab7Vu-=0XcNqnhccE5hJc46oXA@mail.gmail.com>
Subject: Re: [PATCH net] net/handshake: fix null-ptr-deref in handshake_nl_done_doit()
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 9:55=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2023-08-28 at 09:13 +0000, Eric Dumazet wrote:
> > We should not call trace_handshake_cmd_done_err() if socket lookup has =
failed.
>
> I think Chuck would like to have a tracepoint for all the possible
> handshake_nl_done_doit() failures, but guess that could be added later
> on net-next, possibly refactoring the arguments list (e.g. adding an
> explicit fd arg, and passing explicitly a NULL sk).
>
> > Also we should call trace_handshake_cmd_done_err() before releasing the=
 file,
> > otherwise dereferencing sock->sk can return garbage.
> >
> > This also reverts 7afc6d0a107f ("net/handshake: Fix uninitialized local=
 variable")
>
> I can be low on coffee, but
>
>         struct handshake_req *req =3D NULL;
>
> is still there after this patch ?!?

Hmmm, it seems I forgot to actually commit this part :)

I will send a v2.

