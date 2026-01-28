Return-Path: <netdev+bounces-254375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF36OBREemn34wEAu9opvQ
	(envelope-from <netdev+bounces-254375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:15:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65792A6A54
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F29453008286
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8157832471A;
	Wed, 28 Jan 2026 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V3y5C+ab"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4EB23EA92
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769620454; cv=pass; b=LUn+Ca2gPdiTjYoENZt11/lm+WgE/Hpx4fNhf3r0L8YNbmpkPHHRazwB0PIGRh8CxAWl2ZY7x89TTxRhB2wv/seQbuqAiM13RU2uJ6NlNv8tehZVlwhvUfeLgy5/YYGUjeJx2XTyp7W1XccbjdW6JKx0En3G9/hBbOU5CKNp1pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769620454; c=relaxed/simple;
	bh=wN5o768Qjiy4MWug0NAzXR4CJSVk9cWwSKAgCw3rR8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNyVYrvnU4yQCo2Vc2ByfUldiOvNyPhdtwu+8/PuKFECI/PVonk4aK/ojJiowhyKqqRDOiodc12RuXwd0IqS03Y3gS279CF9raeIz+aUrnv+f6lS7gh5ZxhMsm5NheWYjHzYk22TuWbLNk645XHNc0NUnILVYLGwLKksSRLPWT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V3y5C+ab; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-124566b6693so15937869c88.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 09:14:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769620452; cv=none;
        d=google.com; s=arc-20240605;
        b=WugtqoEEsWJH96KiBlSjg542uLiLWv0X+jvjfcK4cEwAJzpe8PufcWLbHo7ai07aK/
         EhRH1WBebxirpU0zDA5moHjmuBsFyIz5g0Wb428VTJreTtI+ej4MNtxiRzzFPqmgAU0E
         7/LRmYhKiro+0UMf4nDu0U4DMeqwW6Kav+DeGsLOlv6a/GZS9sfamfd/zlc2P08zXd3d
         xUyKqzMVSnb6pgfRlbm37qsF01XY40I2VpwzfGShmGzeDt1OjIa0TeyAdrZ56/1be4ME
         SIG+PMZVM+Vihkeiqdw0nbIP5KjyFrlq0s7+lvq5bnmqfRCT+1x03QCzkbwmDIfkw6SZ
         d0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LQNYu1QEKpuhkqqyEvAR6Nk2/zdMMwJfXQNsWTkhra4=;
        fh=29q28dCfDpHS2m03ZVcSRCBspc3tkLvZ5SRM27Ax+Q8=;
        b=AVPOkAWEos2NQRvRpTngm/DvQkwrJ4kz2cmPXelyuniVJibKBG1vVerpJ4JCIehkb3
         MEdp9iQPhSMv3EKs0D7mAATiFY7vE/m4F/EvRJGFiuW4koZqK1uKKr1FHSYurC889n6g
         CKcX+BzRDRdGpacRYZTJMKcNCDDOy45WEkVLLDCRupJJvUW1tmVnU64mMcEnxNUsM/69
         XIpnoXE+TvwoNS9GCWBw9YITCPIK6kk5DGrZSYEjKOatIvlvoeYX558jTTljCfSSG5qz
         0a/k+IMJ5dbBIIEvNm+cNNstBrf2Xry8OAaRns/olNLEyZF6tjMvmnEaCiN9T79av/S3
         2QUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769620452; x=1770225252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQNYu1QEKpuhkqqyEvAR6Nk2/zdMMwJfXQNsWTkhra4=;
        b=V3y5C+abK2lVAbdMWKqDS5dm2rDPuuMOgMZ5Pl1XaGN0zbuw55I6rWQsa6f9tFjK7B
         bv006d2VAjYKkXrokehmUYukuNBE5H7K5Q0ltismTWwu5xC61fqlYgMLb4Qayt3p08ti
         3FGoh7CauqG37beVmJNiTn6UD6MjpZsX64/mrChNmi6zKVw2YAHbMSGHjHcgfYrSE7g3
         xCfeZ422+UTIjyyLmQeI6xi/xGAVj1Vd39+HztQ5n0G8PKRGzjc+4m1fx28Dez0ucbjU
         4qD/I9MO9aAzr9ezdzh+TvbHtL37YGi2O/YhKXdNiWEsVbSM8OEafRoT1XEmmVKcisB5
         VU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769620452; x=1770225252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LQNYu1QEKpuhkqqyEvAR6Nk2/zdMMwJfXQNsWTkhra4=;
        b=o6CVR28GwjXLEyC6qloanNMFl36TNP39rvY+69q026zG5ff1iUhsycd+Q0QhS2+gyx
         y4pGTv+VRRrs00miTKUZ08jn2YJCI3r5e+jwvBlI9DVZ+A8+iXYIDNH2MZIwxvxGf+AF
         o6XcgjvKTmN3J/XpYbKVH9rLT7+0PYh03HHDtxYzBOHxkR5/wFgAV1JSzX5elDByjtGs
         9NP7hbFLVYYYBRJtvSyp73g55zRCg40NvhU2HitPxf0Jw687eyTWbpc5mbWrGADxEyQj
         VI5YxAnOZn6+Hx67/lvuki8YYtKhw3JhEfaQb7kuWv75DpuOKx2cQc6aS2mqmwZszNlY
         HLPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEN3VLdJat1kEnL02/0eHhPdmLtz0nqE2641GTTOUDrM7v1wxtZzQWiMq2g2LLqjB55oFXYOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFS2EU44a5mBSL/OU3ZoDhKDMKLBylNkbyPoSnXFgQaXo+nprS
	MMZ+Sv+oWvVGWrhEhiXYxbyJBYPnRPyLaaks9yLuslVP/VoUbUNJClUBkBGrejxql6PmpQkPV8c
	5TZ9U8m9ExxpWL1czfX3fWluQOLRAewjo4+E3AoY0
X-Gm-Gg: AZuq6aKMJqPsOXCvb2bYIYkFosqt8zbGvdVz78g9L5ZZboWMqNavadmL1AEGBgG/o2u
	Z0p8/rRN/F9uqh5n+cX9qyjqPQPoMkMBUNcX9t85LbfAZzZZPj1t2pEk4/1G0dOI4mH6WPmH+Dy
	6Qxvv6595L3ZX0EvYALhXm6FW2rtwU3o30YaVuQPdQfqtaMZQF8DR0QO3565+hF9W0jb7Y2aVK4
	jtHmynMvYzE9OSouQAjAr+eUPyoTPCnoe6L+tUFmznRDGHL4L169C1nX60ovNHbYGhV+95anRuY
	IHfFhweIG20RBtWqnpyq6da8sIJ4
X-Received: by 2002:a05:7022:6892:b0:11d:c91e:3b58 with SMTP id
 a92af1059eb24-124a011453bmr3472392c88.39.1769620451392; Wed, 28 Jan 2026
 09:14:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAVpQUBbdsNPkvL7JHrgqen7DM70S2VYTtgHx-kjWq3ZqB6uqA@mail.gmail.com>
 <20260128121921.1761236-1-realwujing@gmail.com>
In-Reply-To: <20260128121921.1761236-1-realwujing@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 28 Jan 2026 09:13:59 -0800
X-Gm-Features: AZwV_QgvHRqMDVoxDe9FdxQhLJ7JRE5PqDA_gW6Zgb4fxfIU62MC9fj4GXrdMWg
Message-ID: <CAAVpQUDbYnzyBuN5SS9bSTfJDvVH18QNXrXGTYzZRb3Cgk=mQg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] netns: optimize netns cleaning by batching
 unhash_nsid calls
To: Qiliang Yuan <realwujing@gmail.com>
Cc: brauner@kernel.org, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jlayton@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, yuanql9@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254375-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65792A6A54
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 4:19=E2=80=AFAM Qiliang Yuan <realwujing@gmail.com>=
 wrote:
>
> Hi Kuniyuki,
>
> On Tue, Jan 27, 2026 at 6:05 PM Kuniyuki Iwashima <kuniyu@google.com> wro=
te:
> >
> > On Tue, Jan 27, 2026 at 5:22 PM Qiliang Yuan <realwujing@gmail.com> wro=
te:
> > >
> > > Currently, unhash_nsid() scans the entire net_namespace_list for each
> > > netns in a destruction batch during cleanup_net(). This leads to
> > > O(M_batch * N_system * M_nsids) complexity, where M_batch is the
> > > destruction batch size, N_system is the total number of namespaces,
> > > and M_nsids is the number of IDs in each IDR.
> > >
> > > Reduce the complexity to O(N_system * M_nsids) by introducing an
> > > 'is_dying' flag to mark namespaces being destroyed. This allows
> > > unhash_nsid() to perform a single-pass traversal over the system's
> > > namespaces. In this pass, for each survivor namespace, iterate
> > > through its netns_ids and remove any mappings that point to a marked
> > > namespace, effectively eliminating the M_batch multiplier.
> > >
> > > Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> > > Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> >
> > Why two SOBs with the same person ?
>
> - Signed-off-by: Qiliang Yuan <realwujing@gmail.com> (Personal email)
> - Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn> (Work email)
>
> My work email often has trouble receiving external mailing list replies,
> so I've included both to ensure I don't miss any feedback and to
> properly attribute the work. The v8 version should have everything
> matching correctly now.

You can just CC two of them and keep one SOB.


>
> > > diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> > > index a6e6a964a287..50fdd4f9bb3b 100644
> > > --- a/net/core/net_namespace.c
> > > +++ b/net/core/net_namespace.c
> > > @@ -624,9 +624,10 @@ void net_ns_get_ownership(const struct net *net,=
 kuid_t *uid, kgid_t *gid)
> > >  }
> > >  EXPORT_SYMBOL_GPL(net_ns_get_ownership);
> > >
> > > -static void unhash_nsid(struct net *net, struct net *last)
> > > +static void unhash_nsid(struct net *last)
> > >  {
> > >         struct net *tmp;
> > > +
> > >         /* This function is only called from cleanup_net() work,
> > >          * and this work is the only process, that may delete
> > >          * a net from net_namespace_list. So, when the below
> > > @@ -636,20 +637,34 @@ static void unhash_nsid(struct net *net, struct=
 net *last)
> > >         for_each_net(tmp) {
> > >                 int id;
> > >
> > > -               spin_lock(&tmp->nsid_lock);
> > > -               id =3D __peernet2id(tmp, net);
> > > -               if (id >=3D 0)
> > > -                       idr_remove(&tmp->netns_ids, id);
> > > -               spin_unlock(&tmp->nsid_lock);
> > > -               if (id >=3D 0)
> > > -                       rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0, NU=
LL,
> > > -                                         GFP_KERNEL);
> > > +               for (id =3D 0; ; id++) {
> >
> > Doesn't this rather slow down in a common case where
> > init_net has ids for other netns since it is never dismantled ?
>
> Yes, you're right. In the original code, we only scanned 'tmp' for specif=
ic 'net'
> which was being killed. Now we are scanning all IDs in 'tmp' to find any =
dying
> peers.
>
> If 'tmp' (like init_net) has many long-lived netns IDs, we end up iterati=
ng through
> them even if none of them are dying.
>
> To address this and avoid the overhead, I can use idr_for_each() with a c=
allback
> to find and collect dying IDs,

idr_for_each() sounds better to me.

If we replace list_del_rcu(&net->list); with
list_del_init_rcu(&net->list);, we can check net->list.pprev
instead of adding dying_net, which is a bit racy since
idr_for_each() could return a net which would have been
processed in the next cleanup_net() invocation.


> or keep the O(M_batch) outer loop but optimize the
> inner part if it's truly problematic.
>
> However, given that this is the cleanup path, I thought the batching bene=
fit
> (N_system vs M_batch * N_system) would outweigh the per-netns IDR scan.
>
> I'll revert to a more efficient iteration or use idr_for_each() to handle=
 this
> gracefully in v4.
>
> Thanks,
> Qiliang

