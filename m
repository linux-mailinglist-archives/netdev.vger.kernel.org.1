Return-Path: <netdev+bounces-274336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMBjLYHazWmliQYAu9opvQ
	(envelope-from <netdev+bounces-274336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:54:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEBC382DF5
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 638B6304FA31
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 02:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EA534EF08;
	Thu,  2 Apr 2026 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgcHKj3X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620F934B697
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 02:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098493; cv=pass; b=oiRb+2D2QiFs5CimUlGOkN/oJGjz3mHcXsxirT55TPyIOJlEB0GHtNV1GnFknWo0OZOdU8Y+8dLP0Z56jvVYc7YyXaeWyLALYg1uXA4Fxibu1t/5dSQIkgFj7XZ+RPMOf3yG8s4m75vsu9+3VkyvBgBJGfSMexvtm+XP7j6nlCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098493; c=relaxed/simple;
	bh=N2jjn2t64EAUCLmA/1DSxhfdfO4oB3BlnGRBEtIBjzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SO211DkNUjPTu7dHwyLu1zabW0gXjd/a2OAoOTQ7twErIbCgb2ORsS1O94YEuQz8ILjtKv4z2Rcve8OegJxN26hh2WSC9Mc1REpCzRuzhnjvuoeLgYS33DupHi4Ch5Ct4INGgZ5uSMHVQD/3MvWitYf/3WY6PXt1OhE3p7Wk8iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rgcHKj3X; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a2ee65171so6030197b3.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 19:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775098491; cv=none;
        d=google.com; s=arc-20240605;
        b=alsvk/YDW7GGjJMOnhqC2y1GQjpaAuOABHrZwEEReDEwBD8obv93ofT+c5Uk2z86lo
         Mo9mo6GHbJvgONfp3hKYqRJIkRuL7LPcGcFKhB1UuxDtsSaU4z1G6kZBQ8cOArPKn3r9
         CFqzOz+aeJ41Vf84RGPqgHStAjLWloQLqqz/XVle0m6HFzskXW2DmVwcgnlhjU02iIWh
         c0GbmjweNzN/a7GmEh7724N+eIEnGKv4CnLgN4B/Z6Q7JVJlR9ZSIiJpeqdUp4706etf
         JMK3JJxiyYDSQwDBDPDvA7KoR2nsCzIoe/AfMkr9AIHY1tv6k7StWhUe8ZE11KBSgNWz
         whNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RBLKEoxArr3r3hHSZ/mzm798kMhORMb914/bPyz8K5Q=;
        fh=6VWXEq4ETQxU3S9ateLd9TE+Ml3Kllc1ya9jHUJ7D8U=;
        b=Z6ddQKwuLMWiTCInjPbaSA6suagEVpD9Xj8c1V2VJnW7Nj768aIA3CnjzF2tnPJP+K
         pV91rFP3Yfk/Jxa0aqULBtAR3A3OthKvNvaru1Wuj/0z6nWIfduB+cmUqIqiC+9OBo5J
         6QG1PKQb+vN0uwOP06tZVgDJD03JmFKlM5Jwk/AhOqJCwBhmAHZGXSY0cQP0bao7tTfv
         QqBHcX7upAvIdOSV/UnONaYLXWbCTzEFp47LldIbFV/ugPFzE5JAEgH8f85WpAbfF1Tn
         KU9DM2D9DDYJKNo+p7kH2CvM9gN1Go8bfT4sYGANrol+K8oU08ewzHdjLAUTxXDFTQQD
         BKrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775098491; x=1775703291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBLKEoxArr3r3hHSZ/mzm798kMhORMb914/bPyz8K5Q=;
        b=rgcHKj3XOQoxUz2sxtla6VQgbusrN5eILsiFS+xzbdPmVMiPlX72t69xueucKOw9b1
         vvE3s6CrMsxmoUiintFqi69XbxJf7IIJ2u1rsDvrbfivwBMc3o0N2OsoAkoVxsZlpoTl
         0nR5uklGtldjyZdmkv3C0gEgmoeeKbvVfMs0tlO8jWLrCa4jt4THtu9/454F2kOJReGe
         jgkSdtEMWJ5uoYstfKGpXeQ3sxQVjTcA8uTilQTz7RExj5T1IqrTg1tRppFgF7Kr0CXf
         RtYUCEqdo4FFtaJJi76L6TRfCE+MgxY0F6AdmLimeK3xFPvCPiDa+6IyzLF86LMR/3/I
         IFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775098491; x=1775703291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RBLKEoxArr3r3hHSZ/mzm798kMhORMb914/bPyz8K5Q=;
        b=JDN44nQ7EFAilTPTPx/BH5oXidoGwO+RY00Re0U+JU8QNIrY8VISxuHQCMkLvobna2
         H+DFUHELAaX6nmuRotHSLLPQjDDgsrUCRZti4kX7hUcM2H0TXrG0SHje1/98A5V3OVLc
         G+GGsQWQ3c1dAj1qoSArrwXEkn3F4rHvIOygWDBAGF5ZjPVwHPuAIXg8ekVGeAtPU0Xo
         uLOxexo/FYlru/AN3fBIMUzUbGrsPfoUqGuURml0hUiX5OgSsQchtc5dsfz5NnmrNxC/
         w2u6RYT+uqemGon1sq4fE6bwrN8R3qrq0GHz8ine/8HzAS35AFldq2qM+nVGpWLZ13N0
         /veA==
X-Forwarded-Encrypted: i=1; AJvYcCXg5sBr8iZkgno8PHe+ZIqLJLq+UAobZbAAv8GY5OpkVhtgPeO6r42KEV44Q5GSWhFKHHvBkIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5l2B97VhLIgO3IvA346RC/emi04LnOcsJijPA64RKTEet9UB
	2Ot1zCmE12kOKSNGP7OEzRP9pFTZkfUg/y0ytErhabSqPQOmTWplrqfcuh/yeRaAwHAPm5d/Ice
	poz15tngjqOAZwBW1wp2X5kEcjhHP1iE=
X-Gm-Gg: AeBDietrHoOI6Swu9O4udVg8gkx4mOZCgzC81PMWNQ79UQ7a8jqStyBKfNTYYaQlcx7
	VzfZ6t6wyGxdNQRvySMoa2US4e38A4gObg8+rBp/BLFKQuWi3XCvAhqjA0UnCAsXzFnHH3CMjpz
	+m4RTKhm6XE6arNjCxnG7w7rJSxRcTbu4ZwhXBUNYq2I8iExyM1c3701qvfsC8OEjipB0Hliz62
	h3kFaobMfKrLhVZZJPYsFV/wRcLU9uzAFyiULX2WrOaU0B4T7oiL8oj/8R8Q5uS8lcYMtZq3aXn
	u3qhSSHn3r7X8X1uoYyoi9X6uo+0RGIpCKLivAMQ7bY0K5xzj1agF8hJy+g=
X-Received: by 2002:a05:690c:ec5:b0:79b:ccb6:a845 with SMTP id
 00721157ae682-7a212241ce6mr65808557b3.49.1775098491382; Wed, 01 Apr 2026
 19:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329161751.1914272-1-sun.jian.kdev@gmail.com> <ac2ccb5NBAB3Zq1D@devbig1721.ftw5.facebook.com>
In-Reply-To: <ac2ccb5NBAB3Zq1D@devbig1721.ftw5.facebook.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 2 Apr 2026 10:54:41 +0800
X-Gm-Features: AQROBzD2dbb8_qvFgH9tNuLfsL9X5Kv1gH8lsxfzbJgix1U0X99QhIEV3SVVCzo
Message-ID: <CABFUUZEdh2-bpYG+inQeUwxs9UC7D-xm5tR4RtAsPHrG58WBSg@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Reject malformed IPv4/IPv6 skb test input
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274336-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 2EEBC382DF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 10:17=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On Mon, Mar 30, 2026 at 12:17:51AM +0800, Sun Jian wrote:
> > bpf_prog_test_run_skb() derives skb->protocol from the Ethernet header
> > through eth_type_trans(), but it does not verify that the provided
> > linear input is long enough to contain the corresponding L3 base header=
.
> >
> > This can result in an inconsistent skb being passed to test_run helpers
> > such as bpf_skb_adjust_room(), where inferred protocol offsets can lead
> > to operating on uninitialized memory, triggering KMSAN errors.
> >
> > To reject such malformed test input, we check that the linear head is
> > sufficiently large to contain the corresponding L3 base header (IPv4
> > or IPv6) before running the program.
> >
> > Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D619b9ef527f510a57cfc
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> > v2:
> >  - Ensured that the linear head is large enough to accommodate the corr=
esponding L3 base header (IPv4 or IPv6), before running the program.
> >
> > Link: <https://lore.kernel.org/bpf/129d235b04aca276c0a57c7c3646ce486444=
58cdc85d9b92b25f405e2d58a9ae@mail.kernel.org/>
> >
> >  net/bpf/test_run.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 178c4738e63b..4790bee535b9 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -1118,6 +1118,25 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog,=
 const union bpf_attr *kattr,
> >       skb->protocol =3D eth_type_trans(skb, dev);
> >       skb_reset_network_header(skb);
> >
> > +     switch (skb->protocol) {
>
> The implementation is poor.
>
> > +     case htons(ETH_P_IP):
> > +             if (skb_headlen(skb) < sizeof(struct iphdr)) {
> > +                     ret =3D -EINVAL;
> > +                     goto out;
> > +             }
> > +             break;
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +     case htons(ETH_P_IPV6):
> > +             if (skb_headlen(skb) < sizeof(struct ipv6hdr)) {
> > +                     ret =3D -EINVAL;
> > +                     goto out;
> > +             }
> > +             break;
> > +#endif
> > +     default:
> > +             break;
> > +     }
> > +
> >       switch (skb->protocol) {
>
> There is an exact same switch and it has the same check
> on skb_headlen(skb).
>
> A selftest is needed. Check if the tests in empty_skb.c need to be
> changed also. imo, This can be bpf-next.
>
> pw-bot: cr
>
> >       case htons(ETH_P_IP):
> >               sk->sk_family =3D AF_INET;
> >
> > base-commit: cbfffcca2bf0622b601b7eaf477aa29035169184
> > --
> > 2.43.0
> >

Ack, I'll respin a v2.

BTW, v1 was mainly meant as a minimal proof of the fix, so I
kept the existing structure intact.

Sun Jian

