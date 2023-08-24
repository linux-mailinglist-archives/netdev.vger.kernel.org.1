Return-Path: <netdev+bounces-30386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116D478715B
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF2728156E
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B489B111AE;
	Thu, 24 Aug 2023 14:21:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83191119E
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 14:21:56 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CD91BC7
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:21:55 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58d40c2debeso73126037b3.2
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692886914; x=1693491714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CDAvf6CRXvymIu0Aj3fcuUeAuEDIC/nMPHrUJUD9mQ=;
        b=eVtpcXLAilzyx4k9OGUJ1KcxsWo3CIFM7xWlF5uK9dcikzxpYG0beuN2V3YGp67smE
         qz5I7oq8+c+DC2kgpoItxYlIfP6kKolzHD/Wv7HV6qZMLRlDN2wsNidOwfiu0oykHHrr
         +k+85MqeBOxUu2H7iypPxbrALQN6A3hPvMXhRVrILXcE8wv3gzQVp5q9yEdytPcN1FZF
         Sd7lJSKVQq68n03PQxQGY5uQUI3rlPjzYvjaTEGNs+Wn8KVS6bEiVv9pu0bdVSBajjPY
         BWhpXOSqb7AxrYNSvuDpRo5zJEpOlAPeYWsb8hU3QgXV0QrG3KfhxmLZwgCRaxZYiclP
         XHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692886914; x=1693491714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CDAvf6CRXvymIu0Aj3fcuUeAuEDIC/nMPHrUJUD9mQ=;
        b=dy38ATKstxn0fedvCluvyAYPEseWefktQBbekvvfEDPbRpzBJCYJKsnl16HjVVg/iT
         WXK2pShRKcj9JmnC5GC3PMWcu+OovftTdU5K6ejOBmTVLSgXo8CjOw/7Gkpp+ObDXJhM
         aB0PMFBkOqgRm5FkEPwH3ZwTnpGguj/wKhYX3EluY0q1ni63TZbXnEpXf9Th0eGv6TCJ
         5nHSXpdI/XPuj9VLqzx+gZRikchECtLstGlp506w/dpZTTXmE+B5TkKNrsYNOxMu7hBt
         3TFxay5tzpXwcGsYVzGa5aHEM0ECCgTv5o7oVmvGU8B4H6/oVvghIQ7+dJAy5zKvMF7o
         cffg==
X-Gm-Message-State: AOJu0YyAMvnsHOxKgOHsIbqfg9Q9jAYka7JiTn7qT4s59ZlSacqsKbj8
	6eaEIW73yfJn2MrESVyE1ZTm6D9pjCsjkVhoEwr1tEII+cR/wNs8
X-Google-Smtp-Source: AGHT+IF0h3g76dRixo6zReQGlPY4AAeFTSKRnvAinHT9zHvVFVF9nIdiQStuB2cNC8FVx+uweV2y4Vn7icJAuzzTJbw=
X-Received: by 2002:a81:5b87:0:b0:58c:4e9f:4ed4 with SMTP id
 p129-20020a815b87000000b0058c4e9f4ed4mr17024027ywb.42.1692886914456; Thu, 24
 Aug 2023 07:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824084905.422-1-markovicbudimir@gmail.com>
In-Reply-To: <20230824084905.422-1-markovicbudimir@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 24 Aug 2023 10:21:43 -0400
Message-ID: <CAM0EoM=7Z2bwHZuX+f5fJB1+UW9HdUCXGDa6hxGGccJEf2zH2Q@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: sch_hfsc: Ensure inner classes have fsc curve
To: Budimir Markovic <markovicbudimir@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 4:50=E2=80=AFAM Budimir Markovic
<markovicbudimir@gmail.com> wrote:
>
> HFSC assumes that inner classes have an fsc curve, but it is currently
> possible for classes without an fsc curve to become parents. This leads
> to bugs including a use-after-free.
>
> Don't allow non-root classes without HFSC_FSC to become parents.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
> Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/sch_hfsc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> index 70b0c5873..d14cff8d4 100644
> --- a/net/sched/sch_hfsc.c
> +++ b/net/sched/sch_hfsc.c
> @@ -1012,6 +1012,10 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, =
u32 parentid,
>                 if (parent =3D=3D NULL)
>                         return -ENOENT;
>         }
> +       if (!(parent->cl_flags & HFSC_FSC) && parent !=3D &q->root) {
> +               NL_SET_ERR_MSG(extack, "Invalid parent - parent class mus=
t have FSC");
> +               return -EINVAL;
> +       }
>
>         if (classid =3D=3D 0 || TC_H_MAJ(classid ^ sch->handle) !=3D 0)
>                 return -EINVAL;
> --
> 2.41.0
>

