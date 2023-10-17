Return-Path: <netdev+bounces-42038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE767CCC00
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 21:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCBFB281AAB
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 19:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BC42EB04;
	Tue, 17 Oct 2023 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9Zsz9pH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397722EAEF
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 19:15:42 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770E6FD
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 12:15:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so5a12.0
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 12:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697570139; x=1698174939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oopxp9TwN2h/JkyMuEtN5Ny1VADX1X+/wXCGgacoWvU=;
        b=O9Zsz9pHfcK5pZI3WlSGuDYbjwkhSQZq+0YmQzWw5plenZjhpyjn3JWt5hoQRN+Thy
         tWdJRVcaMRo/pEHBVbuGqHo3rIKpX0516i5k4M5HJioStYZjO/nBgca7EEzqOXkwDXvb
         ibEb5DXsH5f9DcvlurZ/JISOvuvQWScdkEgfoJ/K/KjI8IAB475wAM8m2OQJS8T2+aGT
         g+pKD5CuYgl9FbfBCchnj8fFXXji0VNuym76SnUmTJULglYwuWLDJyOehKxpbRNuCsmi
         YeXGs8FyfLXmr2/jiI50WQdkb+LZbt8gaLWa4NzWyYYO7Hd+Xyk8EpHkF9u9jP1JrRY2
         8LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570139; x=1698174939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oopxp9TwN2h/JkyMuEtN5Ny1VADX1X+/wXCGgacoWvU=;
        b=RCDzsy/IiU5qWddGV4UdwyLSHcu5IwtbanfvajcwFEMSon+2sEWcz3r/U/80Z7Eidx
         MDRW848Xa/z0J339Sss823ZQDvc6EyQP/OFvS7JbPbv+L2TNwOaACsJSRq0DJdUjzfu8
         GGB2xP3wdiMNmG6vPaVhRz3B27H6BqWBArZ7rSBiw+GO0Z9Z+gtGXEoXNxyvoXQtvs/J
         eprkAGrCeiD3gE9oxT5+uUfum+yjkLXZ645LdgSbTH6HfA8CzfDX3J+z/Qk2zjpNA+jw
         gE7POR4dzWqivoTDWadQN2t8PyHu8L0c0lc4Okg0ZfQR97ry+5JFViNmQSOQ0QWmp+ko
         EjPA==
X-Gm-Message-State: AOJu0Yz6VqWtxnON5H3qeRP98e3Bx8KPYfFimKoQ4PyxGC4ewG9unk1b
	tD/1GVnhgao7rO5MR6HG5eMQ4fW5eVk6uHuBGgQhXg==
X-Google-Smtp-Source: AGHT+IEes36Yw05GYpvEuZ+9fzBedX2dcD0S2PPO6z1c2N5G1AYBAsbZTSRhmiyNxmBib4IqH/5/nMNAJ46q7WsOqw4=
X-Received: by 2002:a50:cd98:0:b0:53d:b53c:946b with SMTP id
 p24-20020a50cd98000000b0053db53c946bmr34794edi.2.1697570138732; Tue, 17 Oct
 2023 12:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017014716.3944813-1-lixiaoyan@google.com>
 <20231017014716.3944813-3-lixiaoyan@google.com> <a666cea7-078d-4dc0-bad9-87fa15e44036@lunn.ch>
 <CANn89iJVGQ0hpX8aSXjyfubntfy_a9xrZ5gGrx+ekY0THZ4p+Q@mail.gmail.com> <353dcd1e-a191-488c-8802-fede2a644453@lunn.ch>
In-Reply-To: <353dcd1e-a191-488c-8802-fede2a644453@lunn.ch>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Oct 2023 21:15:24 +0200
Message-ID: <CANn89iKfXxaLr0b-rp0_+X7QY82pK21zeLCVjqxNipfKkwOnDg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/5] net-smnp: reorganize SNMP fast path variables
To: Andrew Lunn <andrew@lunn.ch>
Cc: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 9:10=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Oct 17, 2023 at 08:10:21PM +0200, Eric Dumazet wrote:
> > On Tue, Oct 17, 2023 at 3:57=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > On Tue, Oct 17, 2023 at 01:47:13AM +0000, Coco Li wrote:
> > > > From: Chao Wu <wwchao@google.com>
> > > >
> > > > Reorganize fast path variables on tx-txrx-rx order.
> > > > Fast path cacheline ends afer LINUX_MIB_DELAYEDACKLOCKED.
> > > > There are only read-write variables here.
> > > >
> > > > Below data generated with pahole on x86 architecture.
> > > >
> > > > Fast path variables span cache lines before change: 12
> > > > Fast path variables span cache lines after change: 2
> > >
> > > As i pointed out for the first version, this is a UAPI file.
> > >
> > > Please could you add some justification that this does not cause any
> > > UAPI changes. Will old user space binaries still work after this?
> > >
> > > Thanks
> > >         Andrew
> >
> > I do not think the particular order is really UAPI. Not sure why they
> > were pushed in uapi in the first place.
> >
> > Kernel exports these counters with a leading line with the names of the=
 metrics.
> >
> > We already in the past added fields and nothing broke.
> >
> > So the answer is : user space binaries not ignoring the names of the
> > metrics will work as before.
> >
> > nstat is one of the standard binary.
>
> This is the sort of thing which i think should be in the commit
> message. It makes it clear somebody has thought about this, and they
> think the risk is minimal. Without such a comment, somebody will ask
> if changing to a uapi file is safe.

Sure, although we never said such a thing in prior changes.

Perhaps add a big comment in the file itself, instead of repeating it
on future commit changelogs ?

