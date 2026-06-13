Return-Path: <netdev+bounces-299071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 48ZKMQvVLWrWkwQAu9opvQ
	(envelope-from <netdev+bounces-299071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:09:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A74467FDFF
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:09:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=wgE7Q1Vc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299071-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299071-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BFFA301B902
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD4835CB81;
	Sat, 13 Jun 2026 22:09:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBABA344D88
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 22:09:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388547; cv=pass; b=UJQHXy3G6GXKBnCSeUZYJ32ToizKtjmbvBciul0yhiwFGpyzMXdkdrvjgBVBXH3KEGf3B3JMgqiDZASPxw8+kzUSqQFQGmhO8HV0k7KuwydceNWvJQRpCilBSYFHzpr6qjajXKAPXdTB8mCzT2F/BwYL7CnbOye9qXhScyqFLU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388547; c=relaxed/simple;
	bh=u1HnSCHVThXuBtisnQ9xUVpTnFom1owuSIlE6XNhBOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sv0V/zmOR5/ledQjv3JZC4JzbZHrEFQg5MQ4TbDXFRsVxbwo3CPcFFclTG3mNRxnJf6p1vFEa/4OMzQRqkWz+gCbcHcJz56fXmO/+yJPSLUEjm7AeVDxLfW3H2hJHN75u+yhIuIDD0B8F/Ngh6HQosz0TD2EW3fl155kOSbSW7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgE7Q1Vc; arc=pass smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68d234218bcso3687428a12.2
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 15:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781388543; cv=none;
        d=google.com; s=arc-20240605;
        b=bKUJO1Y72+CK8H29gHuD9R6GNvYWJv5h50hhGk/OC/q/R/R2ut7SEsTsBgUeULxLMe
         os3BUP0dc6mqrQ6U8nUpMCwAEBS7l9bGLHyAUlut8JD1/5B+l3OQG851HGhXrANCX09F
         QIsyOTnbbBsucZnhnJBGNPzGBKDQM4Gu5RSK0lL3a7bzdnPZoParFJKUugy3jkiSglog
         YKrI/mU8MEoknB5RdcYIfTSnsUyigKU+61RDFB+LqAQZv6bQBjeIS6O19VjJT9UYj6aJ
         9cJp9lwpG3ta2kpIOzijfALCxnuxaqPvEJ3/KJdPUJVgffmgXtG7YJ908IZCv3exK0c0
         v+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k6+Vrq96PhkNTNuOuWwoEyF7xtWRs4MqDJ7y2u6EUlw=;
        fh=iqTAibgEq3Gjp4vy8/YnThd0K1n3rkxTtoGesNb7TaY=;
        b=ccT9g3fI9NjCVn0QOB2TQzpz9GDhb5FtUoQ9nkAy4PCCs2XnUju922s1/5UWHmj59m
         iIoK91/GoMW4CxnjIBuLK59S+Vyi/0qXyCV+YtPJ4pLUVct2ICr8RKbOG9qeM4owc8nD
         t6PnstxjlQ2/vReXeNUGVfwPGOesTQmic2GRhMKJ3J3yx9mJ/Tz5ECYBVpcpeZ6/xzit
         8ODQOWI5jaRDJopXZNypzNj1ybYVzonYnPcWQW+v/PLnS06UXFzXI1Wyfzkgjh9U5YT+
         Tgc5eq9rSORkfH+vv1t+x6Mxhu6U7bra3bqskCaa4U2IuZGSlzYpD4dG6bgAxSHjXBBE
         KaUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781388543; x=1781993343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6+Vrq96PhkNTNuOuWwoEyF7xtWRs4MqDJ7y2u6EUlw=;
        b=wgE7Q1VcM19IKuVqMwyqyW1PpcC4m4BCCOfM3r37uuknQIst1SH6YErRsk5UTK9gsV
         LKoVvh+nenWgCwr75oeSaOnPP3cERwb0jCgOZV6TA0zOdZpgf+h0wzd0Bayami2ufZ03
         GYQdPMxBWfbJUYDvBWfdQ/9Gv3gmI1CSsyigCo5LBd/SHdssZgDO7EeCRdwryVtagqIg
         VgcWLH/oV1Hc1dYk4kXXWiJ9VOp/gSIm0yh8gT3XxdOGKab6Cz0mTJIe2yeD38rZh/g8
         blfhaEqeiwS36U3A0bpWYWADlmQDrbVa3ldLgfoxXvlE8ECF+uzZ6gdGmMwPxfSYYlYY
         +WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781388543; x=1781993343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k6+Vrq96PhkNTNuOuWwoEyF7xtWRs4MqDJ7y2u6EUlw=;
        b=KEr4FqCVMsRnnPkkzTC4qYmxJpFE723dGmczm6xKmhTha3DECm3zdUGvk6lu8nzViC
         2u+PPkAzVaNItL6lPbp06dD/XuYcnGz1S4FN7Dwg5oKldIXegG7AQOlUA8TBNz25D8gT
         Cf17AhX2Xdpd7Q3ysi7zGadGcqOamyKxMG8/+DfGp3lGkQ4geXBLFXdoqFAOXcgHBjd0
         wqlt1Yv688bjsZ0RI07g1ClQ3KcK6VVUZxfoVebqnCj4Zv3V/vl69ktJhHdd89P8Rrkm
         BJG0hgPnUAPIpeCFLl15sv8p8Yq7PX/J2UU0CzMPHJ0SpEBkSMG55Kd4UiEq+yKpM8yk
         RmPg==
X-Forwarded-Encrypted: i=1; AFNElJ8Zl39vVTy/PM+BK5xVa+7aFnMnMgSsJYaQlpMwFVsVoO0BGyEUObe6JwFEOzQVQlWv6FwbFqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza91scxqARQRlgt6DVJuPcXdPusgvVWJ1cSSotl1VeRVW0bucv
	AH77ZPUFtbPVdk/ZwSdGodMnQqmP8t23m5ALGxaF2xi7M/ISpayAIi2ew18il66OyuBcasmWPJn
	ci7T+b3TOJIKG3YuE0xxrgBAppyvGXxa5WgEzexSv
X-Gm-Gg: Acq92OGC5sM1BMctKH37c6OIfl8qG3cy7FLA6+BwKrGKyuQ3rOPZmL7P3xaXGKEFHov
	rI0hO0y9k4wQ6aE739RTeBx77aivO3+HjV+faZyyRxY8v8YSOnamoZbpnsmVdTfmwtRpGAKCyHN
	f9JghosHwEJ9pdPoZou2nHT9xf/f40rK/icSEMWIfjq/epT1nws3ur5nv2WYV7kvOqn3VxjRWVw
	Ydq5TQRJjcb0GX02+aQag1+1ctECtinHspWEFt/CStEVeLFts+vPERGBoMpfguU2BB4B2+qEf0i
	kyFJvdTGUI7+0e9gZgwbFPknmiyZXNctZ+KaEGVPs4cALhDjO/8cAOuCjLqRrIvM+Qbv16zm5WH
	USQWkXzgit/cGIGvGUyRAUb+4cD210pU6gAYv4Z+27znven4OFG51
X-Received: by 2002:a05:6402:5d6:b0:687:261a:3391 with SMTP id
 4fb4d7f45d1cf-693c6a0fc25mr1832702a12.6.1781388542833; Sat, 13 Jun 2026
 15:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613010039.1362312-1-kuniyu@google.com> <20260613010039.1362312-6-kuniyu@google.com>
 <DJ7J7GXSJCRS.2FA4LT0RF9GZ5@gmail.com>
In-Reply-To: <DJ7J7GXSJCRS.2FA4LT0RF9GZ5@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 13 Jun 2026 15:08:49 -0700
X-Gm-Features: AVVi8CdakJMzctkrvjodmRckFwRELd3t3VXEyGMSLlrDt2719g-DiXG6dDDAc4E
Message-ID: <CAAVpQUAs+7fGK7GBuFSCfNunL8joGmCDt6aw+HOfsouKKxZBKA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next/net 5/5] selftest: bpf: Add test for hwtstamp proxy.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:memxor@gmail.com,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:kuni1840@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-299071-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A74467FDFF

On Fri, Jun 12, 2026 at 6:31=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri Jun 12, 2026 at 6:00 PM PDT, Kuniyuki Iwashima wrote:
> > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/s=
elftests/bpf/bpf_kfuncs.h
> > index 7dad01439391..8d119b10ed0d 100644
> > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > @@ -92,4 +92,14 @@ extern int bpf_set_dentry_xattr(struct dentry *dentr=
y, const char *name__str,
> >                               const struct bpf_dynptr *value_p, int fla=
gs) __ksym __weak;
> >  extern int bpf_remove_dentry_xattr(struct dentry *dentry, const char *=
name__str) __ksym __weak;
> >
> > +extern int bpf_skb_scrub_tx_tstamp(struct __sk_buff *s) __ksym __weak;
> > +
> > +struct bpf_hwtstamp;
> > +extern int bpf_skb_set_hwtstamp(struct __sk_buff *s,
> > +                             struct bpf_hwtstamp *attrs, int attrs__sz=
) __ksym __weak;
> > +
> > +struct bpf_tx_tstamp_cmpl;
> > +extern int bpf_skb_complete_tx_tstamp(struct __sk_buff *s,
> > +                                   struct bpf_tx_tstamp_cmpl *attrs,
> > +                                   int attrs__sz) __ksym __weak;
>
> ...
>
> > diff --git a/tools/testing/selftests/bpf/progs/proxy_hwtstamp.c b/tools=
/testing/selftests/bpf/progs/proxy_hwtstamp.c
> > new file mode 100644
> > index 000000000000..e13963f2393e
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/proxy_hwtstamp.c
> > @@ -0,0 +1,236 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright 2026 Google LLC */
> > +
> > +#include "vmlinux.h"
>
> Please update your pahole. It must be old, since you had
> the need to add kfuncs defs into bpf_kfuncs.h.
> pahole was improved couple years ago and all kfuncs now
> in vmlinux.h automatically.

Good to know this.  I was able to build selftest without
bpf_kfunc.h change with the latest pahole.

>
> Overall, the set looks good to me, but I would like
> to see an ack for networking bits from somebody.
>
> bpf-next/net was the right subj to use, but this is very late
> into release cycle, so I prefer to land it to bpf-next/master
> and send together with main bpf-next PR.

I'll repost to bpf-next without patch 1.

It's okay to drop patch 1 for now (since SO_TIMESTAMPING
is not tied to device capability, and while it's not ideal, we can
change the application for a while), and I can explore possible
options in the next cycle in net-next.

