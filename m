Return-Path: <netdev+bounces-49227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4EC7F13BE
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 13:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D557C281F3D
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E7A15E9F;
	Mon, 20 Nov 2023 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0xsiQydd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF4410C
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 04:48:27 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5ca77fc0f04so7069577b3.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 04:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700484506; x=1701089306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+L7aWxjlLUJAVJQ6dAsBWIt9SAaqNdTI15A4k2k3f5M=;
        b=0xsiQyddpKaaV5r6f3A0kcidhN+IBEbWFEW3PWH5IC3cScYLAtDEoW0HPNdMwhoKOi
         xHmIDhcWS2oBl8jFWPs5luEa35hDbvM3bz3wfXv9R8u7if4ODnFBYCDyNppzRc9DEcWE
         uCATO4yaekQeie6TxjP55L6r3xjwk3NbfcaAWJJQdo+s1MD3jhE0MQK/oihLT8GkLuAL
         QUDJf/7KsCMJRCU8yREAGXpaGs5ZyanT0NkQxV4R/kasUO4ajWRtJLqcCmNHx603qF7m
         f4D32mRtXvMDEhqSPMEUxXSP8o+9MwRjfWOXuzOX++wt+rUVNaCzTkXBBEDfw0AknVtg
         HE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700484506; x=1701089306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+L7aWxjlLUJAVJQ6dAsBWIt9SAaqNdTI15A4k2k3f5M=;
        b=tOiXY9AJsL907Crus3XwdQ1/ATaJ9MajP072YOCPE/jKBrbCy+LX873FrWBsVgCEw8
         QiEkn4Rm+vcei2RYBMVwvw1iVD5vysbTwEvBi+NA7WTV5MwntF9IJMkpQIW6K0qbf1w+
         skkdGktCmUeXFfjObCZTwSqB2+fEr2umy9GwKsKX81rBvCW6kpAxZkvPhuGG5nXvKsjg
         JRh+E4qTfwOEGnJHrdkINsfoQDp5FW26ZKdpknR5TKDpXO9tPwcFl1wXiPCTI03U388/
         Yhl3BjD5IiYoiGhvc2aRJTNDGa4HdhYyMA4Qj5DDSwU6ZeS2jafDhgQWv5cMFP2HXm2H
         UYmg==
X-Gm-Message-State: AOJu0Yzc6yCjLB0volujDS6fvBfHlytLTWSho7P0Vhz0TKldDPJGfqDZ
	JSKUT3s3+ujCB0tJPHrfhDLRaCUMEWM26NbsAaEiRQ==
X-Google-Smtp-Source: AGHT+IHycnc9QTfyKA28iQJmErLA6XhQ6tF31B7PvMkmBqmMTWFblKIBcx8MT/6NXLuzggGlAODAd3NegwPNRjeuj2I=
X-Received: by 2002:a0d:d6d2:0:b0:5a7:be33:8bd4 with SMTP id
 y201-20020a0dd6d2000000b005a7be338bd4mr5691724ywd.2.1700484506428; Mon, 20
 Nov 2023 04:48:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116145948.203001-1-jhs@mojatatu.com> <20231116145948.203001-10-jhs@mojatatu.com>
 <ZVY/GBIC4ckerGSc@nanopsycho> <CAM0EoMkdOnvzK3J1caSeKzVj+h-XrkLPfsfwRCS_udHem-C29g@mail.gmail.com>
 <ZVsWP29UyIzg4Jwq@nanopsycho>
In-Reply-To: <ZVsWP29UyIzg4Jwq@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 20 Nov 2023 07:48:14 -0500
Message-ID: <CAM0EoM=nANF_-HaMKmk0j6JXqGeuEUZVU3fxZp4VoB9GzZwjUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 09/15] p4tc: add template pipeline create,
 get, update, delete
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org, khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com, 
	David Ahern <dsahern@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 3:18=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Fri, Nov 17, 2023 at 01:09:45PM CET, jhs@mojatatu.com wrote:
> >On Thu, Nov 16, 2023 at 11:11=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> w=
rote:
> >>
> >> Thu, Nov 16, 2023 at 03:59:42PM CET, jhs@mojatatu.com wrote:
> >>
> >> [...]
> >>
> >>
> >> >diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
> >> >index ba32dba66..4d33f44c1 100644
> >> >--- a/include/uapi/linux/p4tc.h
> >> >+++ b/include/uapi/linux/p4tc.h
> >> >@@ -2,8 +2,71 @@
> >> > #ifndef __LINUX_P4TC_H
> >> > #define __LINUX_P4TC_H
> >> >
> >> >+#include <linux/types.h>
> >> >+#include <linux/pkt_sched.h>
> >> >+
> >> >+/* pipeline header */
> >> >+struct p4tcmsg {
> >> >+      __u32 pipeid;
> >> >+      __u32 obj;
> >> >+};
> >>
> >> I don't follow. Is there any sane reason to use header instead of norm=
al
> >> netlink attribute? Moveover, you extend the existing RT netlink with
> >> a huge amout of p4 things. Isn't this the good time to finally introdu=
ce
> >> generic netlink TC family with proper yaml spec with all the benefits =
it
> >> brings and implement p4 tc uapi there? Please?
> >>
> >
> >Several reasons:
> >a) We are similar to current tc messaging with the subheader being
> >there for multiplexing.
>
> Yeah, you don't need to carry 20year old burden in newly introduced
> interface. That's my point.

Having a demux sub header is 20 year old burden? I didnt follow.

>
> >b) Where does this leave iproute2? +Cc David and Stephen. Do other
> >generic netlink conversions get contributed back to iproute2?
>
> There is no conversion afaik, only extensions. And they has to be,
> otherwise the user would not be able to use the newly introduced
> features.

The big question is does the collective who use iproute2 still get to
use the same tooling or now they have to go and learn some new
tooling. I understand the value of the new approach but is it a
revolution or an evolution? We opted to put thing in iproute2 instead
for example because that is widely available (and used).

>
> >c) note: Our API is CRUD-ish instead of RPC(per generic netlink)
> >based. i.e you have:
> > COMMAND <PATH/TO/OBJECT> [optional data]  so we can support arbitrary
> >P4 programs from the control plane.
>
> I'm pretty sure you can achieve the same over genetlink.
>

I think you are right.

>
> >d) we have spent many hours optimizing the control to the kernel so i
> >am not sure what it would buy us to switch to generic netlink..
>
> All the benefits of ynl yaml tooling, at least.
>

Did you pay close attention to what we have? The user space code is
written once into iproute2 and subsequent to that there is no
recompilation  of any iproute2 code. The compiler generates a json
file specific to a P4 program which is then introspected by the
iproute2 code.


cheers,
jamal

>
> >
> >cheers,
> >jamal
> >
> >>
> >> >+
> >> >+#define P4TC_MAXPIPELINE_COUNT 32
> >> >+#define P4TC_MAXTABLES_COUNT 32
> >> >+#define P4TC_MINTABLES_COUNT 0
> >> >+#define P4TC_MSGBATCH_SIZE 16
> >> >+
> >> > #define P4TC_MAX_KEYSZ 512
> >> >
> >> >+#define TEMPLATENAMSZ 32
> >> >+#define PIPELINENAMSIZ TEMPLATENAMSZ
> >>
> >> ugh. A prefix please?
> >>
> >> pw-bot: cr
> >>
> >> [...]

