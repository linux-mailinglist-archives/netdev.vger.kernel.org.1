Return-Path: <netdev+bounces-32077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11C179229A
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 14:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2DB81C2031E
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 12:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD14AD2FE;
	Tue,  5 Sep 2023 12:25:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11DD507
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 12:25:06 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43DB1A8
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 05:25:03 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-414ba610766so502641cf.0
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 05:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693916703; x=1694521503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdsXwPmvXML4+Qm/m/VvMGGOOyVmLVA7zD6o+BsnP1I=;
        b=wgjWcOk53c/9fZ8Ju68Hl5KU6OsV7Gm2smWddIdW/jeDze3xU3gxLlX41CI6qmQtHT
         c1RJXSVVFpfVNUuIhyGiiVwD2tNAfVG7IDl8xOd8snDmk4FwdKkvYm+YllJwrtxBbPQ8
         OUTxCZAMbU6ALeCnSxqf/ukJ5F0Ezt1FX6RhefpYHT8+lazkvUltWGCZNgF5j+IgrhG2
         oA0iFE9YbJnmWMHrm7Su+yjv5jtMqxsxEvHf4trGq/UD6zc+IZFcjy4YKRoVsTCZDQLw
         gth9vF3GoQ7CCtf7vAcPFh7FZBHvqY/qj+JnPOyLtzwpaBahgJ0h6/FeVkLA+3PD1i4+
         MvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693916703; x=1694521503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdsXwPmvXML4+Qm/m/VvMGGOOyVmLVA7zD6o+BsnP1I=;
        b=KTvjqJ3Ps2G5boauo0pUPdND7YfZR3dZQx5ucRSd6J513492HGgCAXEaU62ernwebi
         5SJtSgAHCFEQrB8WDQB/lfBSjwH8geOkxufUkH4Z57pGH9OyP/NBWh4XHpBPzbTk3rA6
         OSdYma8DR+nVCupqFcS+d64YhbvFrYAd/KLGXwsBL2ZYWHBV9hMCFR5aaEm02qZ72lMO
         UVKSFrCgF4Kxs+X6lxSWcUkNSshB+MKe1Wt9lf5IfMtM5WNvaEFO6qP3+DbyKtpWd4u+
         FRWD2ww9a5KyG/+LZlGiIfPZd1+UKn0E/9GcRsOFXw9Vs4LcedxPpjfDo48xPUzeBZFM
         MhHw==
X-Gm-Message-State: AOJu0Ywrofc1bLScb8nf9cbSzAbU/mBQlyqsES502fqiSAdE5WAQllmZ
	DjMB79DdGjIXsTbpOAgzxSG4jq75llLOJ7lpJo8t/VIVAkq++MRt9TE=
X-Google-Smtp-Source: AGHT+IHgZMkCa0jLo4BFAP7tMCRpK0h045WSNR+ie9dsj55qctyeuQlpF2GZfdZqJEgNgsIBj3lFa6W3s8B0JOM+pbo=
X-Received: by 2002:ac8:5852:0:b0:410:385c:d1e0 with SMTP id
 h18-20020ac85852000000b00410385cd1e0mr476023qth.25.1693916702700; Tue, 05 Sep
 2023 05:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830112600.4483-1-hdanton@sina.com> <f607a7d5-8075-f321-e3c0-963993433b14@I-love.SAKURA.ne.jp>
 <20230831114108.4744-1-hdanton@sina.com> <CANn89iLCCGsP7SFn9HKpvnKu96Td4KD08xf7aGtiYgZnkjaL=w@mail.gmail.com>
 <20230903005334.5356-1-hdanton@sina.com> <CANn89iJj_VR0L7g3-0=aZpKbXfVo7=BG0tsb8rhiTBc4zi_EtQ@mail.gmail.com>
 <20230905111059.5618-1-hdanton@sina.com>
In-Reply-To: <20230905111059.5618-1-hdanton@sina.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Sep 2023 14:24:51 +0200
Message-ID: <CANn89iKvoLUy=TMxW124tiixhOBL+SsV2jcmYhH8MFh3O75mow@mail.gmail.com>
Subject: Re: selftests: net: pmtu.sh: Unable to handle kernel paging request
 at virtual address
To: Hillf Danton <hdanton@sina.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Netdev <netdev@vger.kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 5, 2023 at 1:52=E2=80=AFPM Hillf Danton <hdanton@sina.com> wrot=
e:
>
> On Mon, 4 Sep 2023 13:29:57 +0200 Eric Dumazet <edumazet@google.com>
> > On Sun, Sep 3, 2023 at 5:57=3DE2=3D80=3DAFAM Hillf Danton <hdanton@sina=
.com>
> > > On Thu, 31 Aug 2023 15:12:30 +0200 Eric Dumazet <edumazet@google.com>
> > > > --- a/net/core/dst.c
> > > > +++ b/net/core/dst.c
> > > > @@ -163,8 +163,13 @@ EXPORT_SYMBOL(dst_dev_put);
> > > >
> > > >  void dst_release(struct dst_entry *dst)
> > > >  {
> > > > -       if (dst && rcuref_put(&dst->__rcuref))
> > > > +       if (dst && rcuref_put(&dst->__rcuref)) {
> > > > +               if (!(dst->flags & DST_NOCOUNT)) {
> > > > +                       dst->flags |=3D DST_NOCOUNT;
> > > > +                       dst_entries_add(dst->ops, -1);
> > >
> > > Could this add happen after the rcu sync above?
> > >
> > I do not think so. All dst_release() should happen before netns removal=
.
>
>         cpu2                    cpu3
>         =3D=3D=3D=3D                    =3D=3D=3D=3D
>         cleanup_net()           __sys_sendto
>                                 sock_sendmsg()
>                                 udpv6_sendmsg()
>         synchronize_rcu();
>                                 dst_release()
>
> Could this one be an exception?

No idea what you are trying to say.

Please give exact locations, instead of being rather vague.

Note that an UDP socket can not send a packet while its netns is dismantled=
,
because alive sockets keep a reference on the netns.

