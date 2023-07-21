Return-Path: <netdev+bounces-20010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723BF75D5D1
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 22:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FC01C217B4
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 20:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C6DDDA5;
	Fri, 21 Jul 2023 20:39:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E00527F1E
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 20:39:18 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A991701
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 13:39:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fdddf92b05so3399138e87.3
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 13:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-sg.20221208.gappssmtp.com; s=20221208; t=1689971955; x=1690576755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvc7XncaY/nbw1mRwSGlivGewcgyjCIAG6+XjLiyzgc=;
        b=t1rolmL8ovuRHH2jPGmmM9aIRY2zhen9fYGEKNe0Z9wGmoLfFScPkhXloCqeFO7hpC
         EPfjuprTkPUa3ff+J+yEcVVNtaH7yEk24BWIlLjPeYNF5LAUxrHoRvjmmR/5sovu66kq
         NNPBLH7PHscBWiHrWEkxLE8fOBCKezg8GgxtvpICkJkgN4eVE4/X14CjRlNlc9RgAQXX
         uad10ItZo5ClsdR8httswVu/SmrUG18l5FFlRm7E0QDfyVVdeZOsCY9FrqGrw6eO4CTJ
         mGy/ixQVm/+KCZkE7jkLCWQOPCVXUlbSc7TlA4+P7Q7FlrzmGOc0pmaR/QzIPP00TAfO
         su6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689971955; x=1690576755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvc7XncaY/nbw1mRwSGlivGewcgyjCIAG6+XjLiyzgc=;
        b=MXmfzlusYB1NhOtZHHxfFgyadE2a8vyaNJDBYUngmAr+QB5ZodGbWxSKlROYsnycUM
         hOTBC2usrDGWeh+fXfD+l5eXe6GD562yhnONE4kbleNqJCgxCSGNHe5YVW5TjXaoWBo+
         odrVkid+LTiqLAImGypl6fB/cSpAqcHooDApprXC/vp+Bhm2HXRvZxEwyW5zHHAPpzte
         iOW9+BujF7zaPYLqMD63QD+sEUd9E7NuwNraQ84fVN6mfq7Y2iQY7O0fglEcmA6WXjrW
         TyK3YPbfqqhEVtjrLrMLnfjt8DvAjXErqq3IFhA5VzvFrdQ2+XEvd7XvHYhMFtti152l
         iBCA==
X-Gm-Message-State: ABy/qLZ0SY2TWaNX1iLQ6eZJXOrbFwUP3k8WapXLvxnp5lbQIrhwon1Y
	HjQqRqJKH14TCDYKuc+Qion4OaRREcZnc3Gwqlmc
X-Google-Smtp-Source: APBJJlFxXyVdB1U4xre0y+W4GQKn5INlvEtqasMnmDxxfTySEexp78UXZQqjvtVWflM7YOZmbEF6Kj8LJ8ITnu6ekbg=
X-Received: by 2002:a19:8c1c:0:b0:4f3:80a3:b40a with SMTP id
 o28-20020a198c1c000000b004f380a3b40amr2083664lfd.69.1689971954865; Fri, 21
 Jul 2023 13:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230721174856.3045-1-sec@valis.email> <20230721174856.3045-2-sec@valis.email>
 <CACSEBQQdOJAX1yqDMLb_yQMpU2yoUShhS_pCSDndWepxfw3Rsw@mail.gmail.com> <39d1a433-d44f-1a90-e943-8e9f046bdf80@mojatatu.com>
In-Reply-To: <39d1a433-d44f-1a90-e943-8e9f046bdf80@mojatatu.com>
From: M A Ramdhan <ramdhan@starlabs.sg>
Date: Sat, 22 Jul 2023 03:38:38 +0700
Message-ID: <CACSEBQSnm2eX+FG3m7xz13X7BeDyZ2SHn06AmSuama26A2f-+g@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net/sched: cls_u32: No longer copy tcf_result on
 update to avoid use-after-free
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: valis <sec@valis.email>, netdev@vger.kernel.org, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com, 
	billy@starlabs.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 22, 2023 at 1:59=E2=80=AFAM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> On 21/07/2023 15:04, M A Ramdhan wrote:
> > On Sat, Jul 22, 2023 at 12:51=E2=80=AFAM valis <sec@valis.email> wrote:
> >>
> >> When u32_change() is called on an existing filter, the whole
> >> tcf_result struct is always copied into the new instance of the filter=
.
> >>
> >> This causes a problem when updating a filter bound to a class,
> >> as tcf_unbind_filter() is always called on the old instance in the
> >> success path, decreasing filter_cnt of the still referenced class
> >> and allowing it to be deleted, leading to a use-after-free.
> >>
> >> Fix this by no longer copying the tcf_result struct from the old filte=
r.
> >>
> >> Fixes: de5df63228fc ("net: sched: cls_u32 changes to knode must appear=
 atomic to readers")
> >> Reported-by: valis <sec@valis.email>
> >> Reported-by: M A Ramdhan <ramdhan@starlabs.sg>
> >> Signed-off-by: valis <sec@valis.email>
> >> Cc: stable@vger.kernel.org
> >> ---
> >>   net/sched/cls_u32.c | 1 -
> >>   1 file changed, 1 deletion(-)
> >>
> >> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> >> index 5abf31e432ca..19aa60d1eea7 100644
> >> --- a/net/sched/cls_u32.c
> >> +++ b/net/sched/cls_u32.c
> >> @@ -826,7 +826,6 @@ static struct tc_u_knode *u32_init_knode(struct ne=
t *net, struct tcf_proto *tp,
> >>
> >>          new->ifindex =3D n->ifindex;
> >>          new->fshift =3D n->fshift;
> >> -       new->res =3D n->res;
> >>          new->flags =3D n->flags;
> >>          RCU_INIT_POINTER(new->ht_down, ht);
> >>
> >> --
> >> 2.30.2
> >>
> > Hi,
> >
> > We also thought it's also the correct fixes,
> > but we're not sure because it will always remove the already bound
> > qdisc class when we change the filter, even tho we never specify
> > the new TCA_U32_CLASSID in the new filter.
>
> The user should always explicitly tell the classid. Some other
> classifiers are already behaving like this, these were just wrong.
>

Understand, thanks for the clarification.

Regards,
M A Ramdhan
> >
> > I also look at the implementation of cls_tcindex and cls_rsvp which sti=
ll copy
> > the old tcf_result, but don't call the tcf_unbind_filter when changing
> > the filter.
>
> Both were deprecated and removed as they were beyond saving.
>
> >
> > If it's the intended behaviour, then I'm good with this patch.
> >
> > Thanks & Regards,
> > M A Ramdhan
>

