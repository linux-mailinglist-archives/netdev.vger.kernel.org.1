Return-Path: <netdev+bounces-41237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC527CA47D
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4FAB20C9A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BF21C689;
	Mon, 16 Oct 2023 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="yNRGpjuh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C58482
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:48:34 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ADBAB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:48:33 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9a64ca9cedso4277436276.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697449712; x=1698054512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5uO+ztcDK4SVzy15LTmX6cwoy2MNphJgOWb+mfVe7s=;
        b=yNRGpjuh398MgWlGkzhQFJUAK0A4Nx9htTPQia26cNu6mUNVO5K3lW6g7tbAl1UaaU
         /SsmbaSQfd/3vnXz53d0ml/59qO2pBselF3gbIml3CUFkUIuMpxz4oNSORw2/wHuivnP
         yWDEDWrWTnEP09grkRYBMwUk4AxNcLhnVKfBsvcEiE6w6IC2Ogi1GlbL6zD+vHMM6ub+
         8LE4ZnuYX3en8b4rR5KSqbRBM/Ei69Iy1jtLUwWb29o3gIJzxY+LrOQpMd+0q6mEERJ6
         32crGJw39uauTMsFFh1V34Y4lQDTJszcLT9x223de0cOuLGAuTO3ASmdUES+rq8kS8hL
         5Bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697449712; x=1698054512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5uO+ztcDK4SVzy15LTmX6cwoy2MNphJgOWb+mfVe7s=;
        b=kW5s9VGQ+jCRqSOSOfJFRmvzaKRsjxNT73lnhAUaxUYqNJx/JxVXTdP37DJoLh9LMV
         SHSyjGijz62hUSB554lWMVKMWrCuVTjxfiIfsyiYudze8KBXYEsx7V0j7n+388E3T1v0
         7u26zgd0DcCJO3trSJpBDv7C4l8qY3Y8MndRf+fZp7Onbjjqlu1ZVF2A38VQBzKwmXuG
         bWFQeMXxbT54kv39/qzVYfcy1UYgVCwShvkbfoUNRzdIdCmQ+p49aFVtZ+AcpIg+rgCk
         yIv3JI+qABhD6vm7kKXsanG5+R+bXDxcyLv9hZ99t9DVwerw8MSRO9+iH4ebn0twq9Li
         He2g==
X-Gm-Message-State: AOJu0YzWlkBGsrgailTbvouvZcVD63MZfzn3vp3h1vJ7Sr3LQnGNmebS
	FIh5RoHi7lH8Pf6EonnIa5nuBaNVE5zx+7GCpyv9+NrSjI9KdXZ2
X-Google-Smtp-Source: AGHT+IEn1N8e8vOFpvhFW4R8qzoVsxuVP8peeLzoWbKiBvavVHR055//LxsE9pYmO7+fVi3S1/qeBBfRimAZoBwZUz4=
X-Received: by 2002:a25:6989:0:b0:d9a:b957:116d with SMTP id
 e131-20020a256989000000b00d9ab957116dmr10608586ybc.27.1697449711967; Mon, 16
 Oct 2023 02:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013151057.2611860-1-pctammela@mojatatu.com>
In-Reply-To: <20231013151057.2611860-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 16 Oct 2023 05:48:20 -0400
Message-ID: <CAM0EoMmLat0VGwN7f-ugk2UkDGDoFOwXT0ARubCmmGPX2X_QkQ@mail.gmail.com>
Subject: Re: [PATCH net 0/2] net/sched: sch_hfsc: safely allow 'rt' inner curves
To: netdev@vger.kernel.org
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Christian Theune <ct@flyingcircus.io>, Pedro Tammela <pctammela@mojatatu.com>, 
	Budimir Markovic <markovicbudimir@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 11:11=E2=80=AFAM Pedro Tammela <pctammela@mojatatu.=
com> wrote:
>
> As reported [1] disallowing 'rt' inner curves breaks already existing
> scripts. Even though it doesn't make sense 'qdisc wise' users have been
> relying on this behaviour since the qdisc inception.
>
> We need users to update the scripts/applications to use 'sc' or 'ls'
> as a inner curve instead of 'rt', but also avoid the UAF found by
> Budimir, which was present since the qdisc inception.
>
> Instead of raising an error when classes are added with a 'rt' as a
> parent, upgrade the 'rt' to an 'sc' on the fly, avoiding the UAF, and set
> a warning for the user. Hopefully the warning laso triggers users to upda=
te
> their scripts/applications.
>
> [1] https://lore.kernel.org/all/297D84E3-736E-4AB4-B825-264279E2043C@flyi=
ngcircus.io/
>

For the series:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

Christian, this should fix it for you but with a caveat: if you
configure a "faulty" inner qdis to be rt it will "fixed" - meaning you
can keep your scripts but when you dump you will see the "fixed"
version instead of the "faulty" one.

cheers,
jamal

