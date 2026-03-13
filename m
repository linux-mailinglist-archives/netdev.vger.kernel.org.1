Return-Path: <netdev+bounces-267567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCq6NZBntGnxnQAAu9opvQ
	(envelope-from <netdev+bounces-267567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:37:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 398CD28958E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D9E8320EF5C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B108E3CCFD1;
	Fri, 13 Mar 2026 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="P3jkVOxO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D313E1217
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430608; cv=pass; b=EauIQdY9S5yRXM4jzpyzlwDfyGOqo3AP+kXUA8ar9JjiEdnDm3owJnnANzcAjN1K4lYQlsT/Gq7J/wsN16t2TfapuwWIezo0c6qPsRikWmN1w9AJXJorjnhzeMc1l40WsY1gbFimxeLXqnJbWnfR5fB/8TJNA1n2xojjsziFJa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430608; c=relaxed/simple;
	bh=ezLX4GQ2UZd5Q26qdT5MGScrIcB8+Te5OvetRMpXoXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAKvUjQCvGTaUWWJZFdBfU/og1V0NsKyu0qOSkYIBKhxtw/i+oKr2LNbMPvoVVibt+TtB/fjH/1zD7Rl8FNogqkXY0sIRnEzsKh+JOaCqcf6f2+iwwWRTZNOoNWVGh6sojyuH/U3sJdojXr2gDrf0dt6oerw5Y5JjVW1JUFIQSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=P3jkVOxO; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8296d553142so1225785b3a.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 12:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773430600; cv=none;
        d=google.com; s=arc-20240605;
        b=P99Rt1aoZ5tMZOLwrp5KLzAZ13S26KqmN96jX4pt0yCG07vHyv3HORXeknzM6bDed6
         y4iKm31SL1W5TxferymxW4MviWKBBKQplFACj7HmDEb/kS+Rjngb0ZBjM/XAemGGGHBj
         A6uWjlCCbJOo1HIA4z/nCS9unVzYBFc3OwVTkThGvT0geWGd9PSHzB7Lp5lEBHHHpxgH
         STdpaESwGoDWQP+P6CqTn8hS5S99a4yvhFYrIz2BShHVv/VyJVjEHibFDrt65+ZDnlee
         PE49gIbaRxEAY5wDnBDCaL2ddl81yEGTxUMtuZVpVUU1zTRHabVKKWmC2umActXMTI4m
         S8Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7SZBQxP659/1Vz18iP/TaSiFqht3yaJrXilwyHpy4Uc=;
        fh=Mp2hs9P3BP/QKqpP8CsYi+NLBnHRzFu06/7QBJ/Qy/k=;
        b=lAgvT6KpSJ20ICaizf2fvv0xrVpCg0E1my4ft3Npf66tbFyZbaZjIBEPuIiC98sZRF
         gesFpR+/n4KjvXPD1D2n56B8d3saX8u/TdtQHzEKTU7L+p6B0V5ZFSgxHNl1n8CqFYus
         T8BXj/WSYE1/yPUQeuuYbxFdj/gFwFUAyiH9/6/jvst0XQJnvJeet+qT0qcpJCpH8wzD
         K3Qf9TtFC8Nby2NAEGjWF7DzCmyit0CtIVeWIGzSQpnTjs5itjOLxunJtpOvi6mJG8FZ
         wjRjGGl81+v6jlmY3ZJcCgiYqPngCIAUH+mI4/1EZs4c2YsjQY5sXCk8AgM1nWSJIk9k
         RrEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773430600; x=1774035400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SZBQxP659/1Vz18iP/TaSiFqht3yaJrXilwyHpy4Uc=;
        b=P3jkVOxOHslCjq5kN5VLSwGw2DsvprYjkFPWKc9GB2Cr7X7BqL9v9zwu9axnixiuXF
         nBu8Rx+Y4gg6u5AC4Cfro3uP4Pg89ZUvORouBk3mFbS7NLCkea83iBbINvVQJSIbj5ao
         PaxDGc7bkYNuh49t+GrSWih8t1zWmHcPWPQUlI7g2emwxhUa9TqStNe3XemN3TF3zRED
         SICbQ4lLYiR1gblEZx1iiuJ7ruo6PPZqDC/hVYjjlZGRTSbS3SFgusr5+zNlKPj4X46Q
         oLmylLduhQpQue5yTynvtMsIs3y2z7MN/sV0jL6qaKg3hUH8n7QxOfPWxqWS6yHHeTBJ
         2XZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773430600; x=1774035400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7SZBQxP659/1Vz18iP/TaSiFqht3yaJrXilwyHpy4Uc=;
        b=TcQnlHNcTW+ZXykNAbjaSM5ZJn7Cr5/wjMTqeCzH2BXGNmoCz379AyNxJv1rQ9dIE3
         ZW0g2oXM13gUqsIHeE1DfA2uOClHRf9AIm2G9Fi2BK0WAb7gvnbn2U2ykKwduUEji+He
         aQR7ieuaXuZwd3SscZS1pOnr13wajQtPx/Ya+vN0H52eHj1d6aE5ufIxBy7iAjWu4Iih
         8r3HXgAK4t+9HZVMOgG4TwuoXVQTXF/+7oCKI+L536fmWH3GWfgv3D4wX8KFyZcx8tSz
         SfAa+zQOe7SCp8MGsTfDw8s6+RIpHbTa22QXIMkbEFTr0C7umk9tfKGDSjvjcq+voVol
         xcvw==
X-Gm-Message-State: AOJu0YyemJS2/jrU5ZS0v/qcG1gdB1/Cn+FsIvid3zT5P7qP2xoZo454
	F+hzrpIys8kJPUrmg/VYvm6huO544IBH6zvgccPIAJq2yTuBi19aRT9IWTAFBERt3YEOypa3CjZ
	/KmQYv12358I6BV9MkQW0EwBEoZY/x+wGssJL/HRl
X-Gm-Gg: ATEYQzyAvY77o/gJBGunVO0ofUcxqRNSlaqf+h6Q4X27QRNep8/sknOV9O2H/Ulggqw
	M2vC6hgtdtp8oIl4zfnp5XWFpsx6PnKLQERITl+aS1hFRcS0qWDCtDv4XA9Zm9A3QoxcWkPodwR
	8Vgx7uV+rGcxc3/FkuU+fTK+Hmr85o25Gu9LgETksKODNcjFQB3r6TwG6VvjpCn1U4WiDvvQxXy
	3q7sfTTwzcihDjQzPhuy9ujdl439NhMYH4UbeFP6vMmFwWgcRznrepZECUqlkDNJf1tRb3JrRea
	+PAJNt4x1AiJhKc=
X-Received: by 2002:a05:6a00:1388:b0:829:7ee0:1a44 with SMTP id
 d2e1a72fcca58-82a197046dfmr4186054b3a.4.1773430599837; Fri, 13 Mar 2026
 12:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307212058.169511-1-jhs@mojatatu.com> <20260310184713.7e810431@kernel.org>
 <CAM0EoM=TAAfwZc3q1=RKWPrS778R_B8uM18ev_jYYz8oj4YiBA@mail.gmail.com>
 <20260311175249.54abe1b6@kernel.org> <CAM0EoMnv14pSaJWW3ZQuegkbQEqqye0zp0-_tCaOEWEg=C3xCQ@mail.gmail.com>
 <20260312165113.773a5f44@kernel.org> <CAM0EoMm0dMRKJyfCH80G=q4PnnTzzKVRvSrAU204FFKMn9NOtQ@mail.gmail.com>
In-Reply-To: <CAM0EoMm0dMRKJyfCH80G=q4PnnTzzKVRvSrAU204FFKMn9NOtQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 13 Mar 2026 15:36:28 -0400
X-Gm-Features: AaiRm51FzVPEj5x8-7UQwBJ_H90URykuqOW7BBLFDfVKu8idWAvLsU3tRRb1ky8
Message-ID: <CAM0EoM=KinOanha9nKJ=GyT2FU_o3Hg-tY5fWDfFO+PBuQfXpA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Mark qdisc for deletion if graft cannot delete
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, toke@toke.dk, 
	vinicius.gomes@intel.com, stephen@networkplumber.org, vladbu@nvidia.com, 
	cake@lists.bufferbloat.net, bpf@vger.kernel.org, ghandatmanas@gmail.com, 
	km.kim1503@gmail.com, security@kernel.org, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267567-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,toke.dk,intel.com,networkplumber.org,nvidia.com,lists.bufferbloat.net,gmail.com,mojatatu.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 398CD28958E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 11:56=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Thu, Mar 12, 2026 at 7:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 12 Mar 2026 16:36:48 -0400 Jamal Hadi Salim wrote:
> > > > > Two of the several (I think 4!) patches we had took a similar pat=
h. I
> > > > > am trying to remember at least one variant was bad for performanc=
e and
> > > > > the other was unstable. Let's see if we can revive it and take a
> > > > > closer look. BTW - none were pretty, it was maybe half the lines =
of
> > > > > code but touched many things.
> > > >
> > > > FWIW / of course, we have to apply similar change to all(?) callers=
 of
> > > > __tcf_qdisc_find in cls_api. So LOC-wise it may end up also pretty =
long.
> > > > And it's not going to help the already spaghetti-looking locking. B=
ut
> > > > even if it's more LoC I quite like the idea of containing the poopy
> > > > code to where problems originate which is the lockless filter handl=
ing.
> > > > Fingers crossed..
> > >
> > > Something like attached.
> > > Unfortunately after running it for a few hours it reproduced.
> > > The action code path (entered by virtue of filter code path execution=
)
> > > releases the rtnl when attempting to load an action module. A paralle=
l
> > > qdisc operation waiting for the lock then grabs it and we hit the sam=
e
> > > issue...
> > >
> > > So now we have to be more invasive and start coordinating the action
> > > code etc, which is not appealing. Thoughts?
> >
> > I see. Doesn't seem entirely crazy to let tcf_proto_lookup_ops()
> > return -EAGAIN without actually loading the module, and have it's
> > call path (of which there are only 2?) do the module loading once
> > all the locks are released. The call paths handle the EAGAIN and
> > retry already they just assume tcf_proto_lookup_ops() has loaded
> > the module so they don't have to.
>
> I might not be entirely following what you are saying. The core issue
> is not module loading perse. We can avoid module loading in
> tcf_proto_lookup_ops while the rtnl lock is released and the qdisc
> refcnt is greater than 1 (which is what the patch i sent attempted).
> The new quark is when we have actions associated with the filter.
>
> I will send you a much lengthier description of the issue in an hour
> or two  to get us on the same page.

Note, i am going to describe the scenario we saw with the action quark
where "filter add" enters before "qdisc del"; the one described in the
commit is the reverse order. We see the issue in both scenarios.

Sorry, this is a lot of text ;->

Let me explain the "expected" behavior
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

time x:   On cpu1: "filter add" enters increments refcnt to 2 after
          finding the root qdisc (see __tcf_qdisc_find)
time x+1: On cpu1: "filter add" in the action code releases the rtnl_lock
          before calling request_module.
time x+1: On cpu2: "qdisc del" enters for root qdisc, holding rtnl
          (example refcnt =3D 1), see tc_get_qdisc().
time x+2: On cpu2: "qdisc del" calls graft which calls qdisc_put() which
          decrements refcnt to 1 and cant delete qdisc because refcnt is no=
t 0;
          "qdisc del" exits
          ***We are in an inconsistent state at this point - IOW, the qdisc
          needs to be deleted but cant because of the refcnt !=3D0.
time x+3: On cpu1: "filter add" acquires the rtnl_lock again in the action
          code (see time x+1).
time x+4: On cpu1: "filter add" eventually completes; see tcf_block_release=
()
          invocation in tc_new_tfilter() which eventually calls qdisc_put()
          which manages to decrement refcnt to 0. Qdisc is deleted..

To reproduce the issue requires 3 threads - which is what the repro does.
Note: sequence time x to x+2 is the same as "expected" flow above.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

time x:   On cpu1: "filter add" enters increments refcnt to 2 after
          finding the root qdisc (see __tcf_qdisc_find)
time x+1: On cpu1: "filter add" in the action code releases the rtnl_lock
          before calling request_module. Note: the action code path will be
          momentarily rescheduled because of request_module call.
time x+1: On cpu2: "qdisc del" enters for root qdisc, holding rtnl
          (example refcnt =3D 1), see tc_get_qdisc().
time x+2: On cpu2: "qdisc del" calls graft which calls qdisc_put() which
          decrements refcnt to 1 and cant delete qdisc because refcnt is no=
t 0;
          "qdisc del" exits
          ***We are in an inconsistent state at this point- IOW, the qdisc
          needs to be deleted but cant because of the refcnt !=3D0.
time x+3: On cpu3: "qdisc add" comes in and finds the deleted qdisc still
          on the qdisc hash table since it hasnt been deleted (see inconsit=
ent
          state in time x+2). And then shit hits the fan (as described in t=
he
          commit, qdisc_tree_reduce_backlog() etc).

In this specific example, the issue is that the classifier code path
can't release the rtnl_lock while the qdisc's refcnt is bigger than 1.

Does this make more sense?
The reason we went with the "mark for delete" approach is at time x+3
the "qdisc add" wont be able to find this qdisc. This is the common
observed pattern - for example described in the commit message where
we get have a slightly different flow with "qdisc del" before "filter
add".

cheers,
jamal

