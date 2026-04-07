Return-Path: <netdev+bounces-275812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PhtN1tf1Gm6tQcAu9opvQ
	(envelope-from <netdev+bounces-275812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:35:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 456FB3A8BC5
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6562302BEAE
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 01:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ACB221540;
	Tue,  7 Apr 2026 01:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcWLxV+c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D113670830
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525696; cv=pass; b=QVBNNNpv3Pf0KkU+pNqgd01Fg8i5OCyuXDAraLcGJ9wqJ/THUg4QoHa2rwh6OeHyrZdMHR4ZDQzpE9EwLD+SaSauEhnKzWCyHYzupnL8F7nsezuX+i6Xb40DD6yM5tI/P0792Oj5nBdRz/3+QE1TK8e/XFoKkhjg71f+C8Bp/CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525696; c=relaxed/simple;
	bh=CdjNKl6RvdEAH7DQmoeHpr7AGXr1Jb08XVC3ztHNxVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5PsfHigXpf3WVvQA69LLJshEd9omDJUXmX8AzOwJc1O8Tbb0dqgcCWV4nh1cEaeK8fPRkFuq2SWehYVTkDAl1OPIvy6YfgsU4WwdlSjSzlZEf1ktSCn88jV8Emo3x1QyxpFg2Xf8mPnyzzGczqWsvyL2cC2wNjB/VGyjbwiFbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcWLxV+c; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a535e7c00so45323327b3.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 18:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775525694; cv=none;
        d=google.com; s=arc-20240605;
        b=MtfE0dVFE6n+ZVTdmShekETBAf6/s8FHIokOqf3zXrIduEoW7iRVVWl13keVTasVbV
         G2E/ZCxjyLUt73Bg5o5ovx+Z6AuCT0/HeX98fubrPU8z1F+asUNKS3B53GE2UdQN6hH4
         Rftkq9sMiY6GPsKaRmgsIsUTwB5htR6R/MX/46mgVz8VxDr6/zyN1nyRgAKJFHXEB57B
         ode/emaNu+93BzZoj3pZGzcFXfJJYqwavNsMjht0k+fZzWmkw49Brk3iRpfbRco7S0Zs
         H/WU9H8OhmfpNrlLi+zf2+OtLdE8SOywodZqeoXAbS4zjt94fdZ0vGmOtWF5udtxFe7g
         xQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gOQ/7d8DzPMY6Lf5FjM6QVlbxIIMJf+rrNRaxjRBQZo=;
        fh=IraZ6NjzbtjSyhbYh7U288a+aJg+kHGJzP7meyuQgQM=;
        b=WwmmEs2NM8oDL2Zwo56teF1AnD8/cPcwx2lj6Bb/9+fCbv43bd/ymyZK34ABteCRnu
         4JBn6z3hQUIisvkaC9OxKzG4bTcBblnZ/k/KB32Jyeg2oJmyQBPB717kDxvqtYCiI07K
         FEUa2/rcJbQ2P9ew2283byiBYHhec5roCS2+RcF7x/MORHZ1cgSv3KC/N8YMlWHcMqYi
         WHO7L8JvDdAUjqfET3AGLS8+S8XtYLF3vcJeo16vLE5GtmaDSBC5mVgWf1QSh46udmYT
         VvkGDkMmDD34Yyzw7HY3wxbPdbrFm7n+Ua9U3rYvJNb02Wb4jeN5hti1jSDm1KVTsIPO
         x2RA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775525694; x=1776130494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOQ/7d8DzPMY6Lf5FjM6QVlbxIIMJf+rrNRaxjRBQZo=;
        b=dcWLxV+c7sNj1Mt26ZSPDjOh4nvp5U4/4gsLwSnif7FwaixOHnG20msivSBboeTKwI
         sxPtLOwtpFiPHWaAr/MUYqm3pf5MvCNvb2nuTGi7V3uGs7k/BvePNR1MCJOuhP/JD9J2
         W0qqn6ZyKdu25WLmmEF+tL5qrYnNf0fpgeMK9hnqo/RaJMiPzjCeh6fNxfNaDtU6Wr7/
         aw+oV6RBXPeHe3OL9uXev9n448WFQMjyRTTgd9c7JBCHLMLxbJVsvnCf4RH2PXYWsiDv
         8mug6B89myCUQoZJHWXQDGaQUhdll8eRNSWZkZf2oF8eDbT8FppW7JcqNF50Vv1mCzes
         HKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775525694; x=1776130494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gOQ/7d8DzPMY6Lf5FjM6QVlbxIIMJf+rrNRaxjRBQZo=;
        b=eOfDX/LeqjIs+2BIBm+vsBKlof4VuURnfP2lBYssEsP3NOhLMJBrktPNfZoeKQTQ4H
         9iPZ148hO222hOMK+ayd4liIjSXfi3Y2tNWLUD+s893YYPIcPpnz1HyjpHxBO1gLZdEs
         NC0wz8rUc2mR0rn38dI3Lo2WR+PgWiNDtxGdf2+qbe0e8Tpw5c8kjsyMOiSjQaxyvwpN
         ZxoR98iU+3+3hoOQTDj3m0eJpznRjmt+kjJEzu8tm2xPEremi1ekc6ueAZgCQiXSXA9i
         MDEF+1pM3LMXHlzT9MtsaA50Cmcfmj35i0gpuWWWQ/tdEPpvGdNjqdxxgjljVKNxAk2P
         b/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvnP0D+1+BP+Zi8oDIzEUcui41GxE8v3fD4eNs9jLJX6djOtTvM3hsT3ojjvVBScBdBRoKFYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt8v+85hsKQgFK/38Ub6r+2GJRglNBtGx+osHrHxs8lD+JGzmC
	N6KZXt8sOxfAwfCU227aOQctkFPtNhdu6SLHfqJRKBhV4kDuToRn6PPbHYV74BvyT1Vdl8kUe6A
	XHaWoFsTAr123nW0nmCF3X73UkaMz6Hc=
X-Gm-Gg: AeBDietXMqrQnn/a0HMynNiyhSPM5TQV8jL0pz0czZ83Aamoz30qKjvyM20tSCN3mQI
	YpyAuT7CXRNOIdOrxGyqS8G9KhzoLakNBJETV23hU8znJmVkJNRMu1TtXG+0J7LZF0qBURsdYXu
	QuEJk83BZMrVhoMi+T9yi+71eDB+1PiQNm1o7Pe4zGKXEO+21K7Bhl5uf40lvp2c+1ntT0s0Y75
	qW+PeiOV/zfOBkz7p4HsFW5SYGC/+c+ogwrCmpzp2kZg4kOxJPkWXQs/SmjhCh6HHcxx4HpXEu1
	9bFLBQD+/CIjKwZL+ZTG3vRIzT8bYQ7+tZCWV+mJdrM2gWqEtTg=
X-Received: by 2002:a05:690c:4806:b0:79a:7ff5:93c4 with SMTP id
 00721157ae682-7a4d6b311bbmr150352887b3.18.1775525693949; Mon, 06 Apr 2026
 18:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402160147.215499-1-sun.jian.kdev@gmail.com> <202646183934.lJx5.martin.lau@linux.dev>
In-Reply-To: <202646183934.lJx5.martin.lau@linux.dev>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 7 Apr 2026 09:34:44 +0800
X-Gm-Features: AQROBzDEHcZwUn6RnkKIGl5W4d3QSCPFqo_CJP6vIqbrvoH3IIXffE6vzY6oLWQ
Message-ID: <CABFUUZF_CWQZrRk=L9cNxO=8Z4iSgGfXi3J=hpzeyTKDbfE2-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: reject short IPv4/IPv6 inputs in bpf_prog_test_run_skb
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, 
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275812-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,syzkaller.appspotmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 456FB3A8BC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 2:58=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On Fri, Apr 03, 2026 at 12:01:47AM +0800, Sun Jian wrote:
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 178c4738e63b..300e2bfc5a62 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -1120,19 +1120,23 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog=
, const union bpf_attr *kattr,
> >
> >       switch (skb->protocol) {
> >       case htons(ETH_P_IP):
> > -             sk->sk_family =3D AF_INET;
> > -             if (sizeof(struct iphdr) <=3D skb_headlen(skb)) {
> > -                     sk->sk_rcv_saddr =3D ip_hdr(skb)->saddr;
> > -                     sk->sk_daddr =3D ip_hdr(skb)->daddr;
> > +             if (skb_headlen(skb) < sizeof(struct iphdr)) {
> > +                     ret =3D -EINVAL;
> > +                     goto out;
> >               }
> > +             sk->sk_family =3D AF_INET;
> > +             sk->sk_rcv_saddr =3D ip_hdr(skb)->saddr;
> > +             sk->sk_daddr =3D ip_hdr(skb)->daddr;
> >               break;
> >  #if IS_ENABLED(CONFIG_IPV6)
> >       case htons(ETH_P_IPV6):
> > -             sk->sk_family =3D AF_INET6;
> > -             if (sizeof(struct ipv6hdr) <=3D skb_headlen(skb)) {
> > -                     sk->sk_v6_rcv_saddr =3D ipv6_hdr(skb)->saddr;
> > -                     sk->sk_v6_daddr =3D ipv6_hdr(skb)->daddr;
> > +             if (skb_headlen(skb) < sizeof(struct ipv6hdr)) {
> > +                     ret =3D -EINVAL;
> > +                     goto out;
> >               }
> > +             sk->sk_family =3D AF_INET6;
> > +             sk->sk_v6_rcv_saddr =3D ipv6_hdr(skb)->saddr;
> > +             sk->sk_v6_daddr =3D ipv6_hdr(skb)->daddr;
> >               break;
> >  #endif
> >       default:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools=
/testing/selftests/bpf/prog_tests/empty_skb.c
> > index 438583e1f2d1..d53567e9cd77 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/empty_skb.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
> > @@ -12,6 +12,8 @@ void test_empty_skb(void)
> >       struct bpf_program *prog;
> >       char eth_hlen_pp[15];
> >       char eth_hlen[14];
> > +     char ipv4_eth_hlen[14];
> > +     char ipv6_eth_hlen[14];
>
> The eth_hlen_pp and eth_hlen needs to memset zero now.
>
> Instead of adding two more ethhdrs, just reuse the current eth_hlen and
> define it as 'struct ethhdr eth_hlen;' instead of a char array.
> Add 'h_proto' to the anonymous 'struct { } tests[]'.  Initialize
> the eth_hlen.h_proto based on the tests[i].h_proto.
>
> Also, this test does not actually reproduce the reading uninit memeory.
> It needs a bpf prog to actually trigger it by calling bpf_skb_adjust_room=
()
> based on the report in the "Closes" link. The test should be able
> to trigger it without the change in test_run.c
>
> The ai-review has flagged again that it is missing a "Fixes" tag. This
> probably started since the bpf_skb_adjust_room helper was introduced.
>
> The selftests should also be in a separate patch 2 following the patch 1
> changes in test_run.c.
>
> pw-bot: cr

Ack. I'll split this into two patches and rework the selftest accordingly.

