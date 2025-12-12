Return-Path: <netdev+bounces-244512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14313CB9429
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 318423059586
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493AB28E571;
	Fri, 12 Dec 2025 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="BZBrcksN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA422580D7
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765556979; cv=none; b=kVVQQyObZ+X/HC77B2a0kPPrSROc8m76aC7+2zZ4g77/2CfGm6px9L+SqM59+Byamr8Bp1Ovhpfaf5+0yzo0qfnDS7hfqSq4AbJKRzan71QAIBD+W0D+SeN3avEzfOBlAasJUBoHdvjaEPJ3s0cuioip0Yt4QXUDkqxC89wZLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765556979; c=relaxed/simple;
	bh=e2QFJCDiTu1MC5rOgdGGlN02BuoKkU9uEB6eycMMq/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G35klb+y8qkUNe0JAV//g+MW6rj5SrmCnSGR6t/kvl0mWPAUxNuPXkkUznUEXa7AHgvLK9CWltWruleKjukw9SGW4uXKokFWARt0ZQsawVc0gNFMcbEVBVSezanr2IXLBYQ0gep7NsbKpNmSWtDr39ybZR9vHZte6mQMevl2t2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=BZBrcksN; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-787da30c50fso14477797b3.3
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 08:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1765556976; x=1766161776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJow7Wat0dBZgcBjMOFWKCi/EiaoPVvKY0E1GqR6BaU=;
        b=BZBrcksNQhTg69vgJD9hYcl1DEPC5OWVzmytHLze/YnHLolg1IHN3NGFgyFQAljntx
         hJKM+OMVA3SEU4IIjiHyUeK7Lfowid8yQavBaA9hwwLkrZE+pA7HZ64pxtdq5eXvEeJ3
         SNCmOrggh7et7+dOnd2SR2aTW/vcQh5kwOIlEVhXjO7PzonW8JE8vIgZ3Is/F8UlpzTG
         kG7USoZ6XxHS2PASoespkFeWEL95JOrcIdDDMHI/tjuJzURx3ildQIAXdskbV/W85OHS
         FcePui7xbqL7oX8RmrT250eoO4RgkYLUwGp/cAsLGX7/8+Awu+x43YzVUqz5Efi89iEi
         lzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765556976; x=1766161776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SJow7Wat0dBZgcBjMOFWKCi/EiaoPVvKY0E1GqR6BaU=;
        b=mRQrnFuPlnBwNLPDTTc7dlIIwe+Ujy2PVt/MTbfhHvUfH5UzJsKP+Kk7NRfQUjm5v8
         p8/heN2V9BrCPNwnfzsroD/hGD/CV9PGXaIJUH/emyFuW3vIvwd1jO0DqPh6xurzy99f
         rCb0x2Ffj/W7I8kCcyMxqttgfPggn4GCmX/sC17XRV/7P/jTn77UJ+ws2rtNrn1yze58
         3cKLGCqRPF2QLdeyO0hysn8kw0KvRwrnceNzRCHuTOwM823CsbUPSOjKzjG4m9cnzGL3
         UZWHyRQlII6zg4L+WVVtoKdl3cyzeM2fWjzH+RpACZlvvDonHR77w/JhHYH6QFERtH9D
         KhTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVcGC5ynAMBEPAsqFGhMs0+yn7HpJofnv0EX6bNfvQ2NhKFtUkHZQ7irxbvF9Pm4hcpUtl9WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeBziB6Jy6Zf/ZwPq/bcn79wMCuQlNaZL1fjj8MZKx5TQzK72E
	k7STWwW1YDYgmAEyNj94vi7A2xq30fYQL3LNUWHToxs5nBb0FjY8TgoNYdFXnigIrtQuTXsM+8F
	UujJh46b7q6wvF7DW8lg5mRdqBjY3fwGue8HXsJNB
X-Gm-Gg: AY/fxX5RoMGBgMvF3qgtuht3I6Tf86O+yDmrHXDGZYDfr5u5sfM52PexzAvoBNaZim7
	RxM7w3qTDIZ3GpBMGoVsHoJsP4W7g7qb84zVQM10BoMq3Hrj/UbiJPPtLl/0tUK5vGNbgkoo+uC
	M4M/R7QnZl8joycTnfPQz5dctKHiAWoSamVoWkCXxU+wo2W1qcPpQd/Z+FVBxAkFWEczZV/8lEc
	0+FwLASIa3BySOEjf+aO0scbvw9dHEpu43ay1rTHLvk/5UtcE0tvKuW2E55g3AXEBNj4zp2JjkD
	638=
X-Google-Smtp-Source: AGHT+IHaCND4QYQNKb0sfZyUrgjcJb4Tl1REioQfJr6s0KfYPAgTx2l5OrJ0PYZlIxMazIhPRs6SmTOkhIal+8HyztQ=
X-Received: by 2002:a05:690c:6089:b0:787:e3c0:f61f with SMTP id
 00721157ae682-78e66e22f5amr44620867b3.57.1765556976377; Fri, 12 Dec 2025
 08:29:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109091336.9277-1-vnranganath.20@gmail.com>
 <20251109091336.9277-3-vnranganath.20@gmail.com> <tnqp5igbbqyl6emzqnei2o4kuz@altlinux.org>
 <CAM0EoMmnDe+Re5P0YPiRTJ=N+4omhtv=r3i5iicav8R7hg6TTQ@mail.gmail.com>
In-Reply-To: <CAM0EoMmnDe+Re5P0YPiRTJ=N+4omhtv=r3i5iicav8R7hg6TTQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 12 Dec 2025 11:29:24 -0500
X-Gm-Features: AQt7F2pc8asveroE2R-jp3qpZF_HQsuK7_ZalmtZEec2fHvVTs0GDCVOo6E1_d4
Message-ID: <CAM0EoMneOSX=AMe53hQibY=O6n=KYnudAWfVtUdOf8qc_Bmw+Q@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] net: sched: act_ife: initialize struct tc_ife
 to fix KMSAN kernel-infoleak
To: Vitaly Chikunov <vt@altlinux.org>
Cc: Ranganath V N <vnranganath.20@gmail.com>, linux-rt-devel@lists.linux.dev, 
	edumazet@google.com, davem@davemloft.net, david.hunter.linux@gmail.com, 
	horms@kernel.org, jiri@resnulli.us, khalid@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, xiyou.wangcong@gmail.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 11:26=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Thu, Dec 11, 2025 at 7:54=E2=80=AFPM Vitaly Chikunov <vt@altlinux.org>=
 wrote:
> >
> > On Sun, Nov 09, 2025 at 02:43:36PM +0530, Ranganath V N wrote:
> > > Fix a KMSAN kernel-infoleak detected  by the syzbot .
> > >
> > > [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
> > >
> > > In tcf_ife_dump(), the variable 'opt' was partially initialized using=
 a
> > > designatied initializer. While the padding bytes are reamined
> > > uninitialized. nla_put() copies the entire structure into a
> > > netlink message, these uninitialized bytes leaked to userspace.
> > >
> > > Initialize the structure with memset before assigning its fields
> > > to ensure all members and padding are cleared prior to beign copied.
> > >
> > > This change silences the KMSAN report and prevents potential informat=
ion
> > > leaks from the kernel memory.
> > >
> > > This fix has been tested and validated by syzbot. This patch closes t=
he
> > > bug reported at the following syzkaller link and ensures no infoleak.
> > >
> > > Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D0c85cae3350b7d486ae=
e
> > > Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> > > Fixes: ef6980b6becb ("introduce IFE action")
> > > Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> > > ---
> > >  net/sched/act_ife.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> > > index 107c6d83dc5c..7c6975632fc2 100644
> > > --- a/net/sched/act_ife.c
> > > +++ b/net/sched/act_ife.c
> > > @@ -644,13 +644,15 @@ static int tcf_ife_dump(struct sk_buff *skb, st=
ruct tc_action *a, int bind,
> > >       unsigned char *b =3D skb_tail_pointer(skb);
> > >       struct tcf_ife_info *ife =3D to_ife(a);
> > >       struct tcf_ife_params *p;
> > > -     struct tc_ife opt =3D {
> > > -             .index =3D ife->tcf_index,
> > > -             .refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> > > -             .bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> > > -     };
> > > +     struct tc_ife opt;
> > >       struct tcf_t t;
> > >
> > > +     memset(&opt, 0, sizeof(opt));
> > > +
> > > +     opt.index =3D ife->tcf_index,
> > > +     opt.refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> > > +     opt.bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> >
> > Are you sure this is correct to delimit with commas instead of
> > semicolons?
> >
> > This already causes build failures of 5.10.247-rt141 kernel, because
> > their spin_lock_bh unrolls into do { .. } while (0):
> >
>
> Do you have access to this?
> commit 205305c028ad986d0649b8b100bab6032dcd1bb5
> Author: Chen Ni <nichen@iscas.ac.cn>
> Date:   Wed Nov 12 15:27:09 2025 +0800
>
>     net/sched: act_ife: convert comma to semicolon
>

Sigh. I see the problem: that patch did not have a Fixes tag;
otherwise, it would have been backported.

cheers,
jamal

