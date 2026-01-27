Return-Path: <netdev+bounces-253747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CO6OGhzeGnEpwEAu9opvQ
	(envelope-from <netdev+bounces-253747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:12:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4932590F6E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67A19301175D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0568D2874E0;
	Tue, 27 Jan 2026 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SigK0a9S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E93287245
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769501518; cv=pass; b=ZebSqHlZRm/6DWbjHfIwxDYzDbayRX5d2zs3c9ku9oAqRDqmqsHnt4+IwkS+XCWin0skAc1oHynznF9iyc1m2OEm0iMkKCVJQVr9pToAuu8VH+gemQfQ8fbp9YBBG298LUzVL7ZJ+MEuu6bZiMYYsNGPNfzAO9CY2uSlRzZIuMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769501518; c=relaxed/simple;
	bh=NwXA0OTBs27VDff1T+R2KAZDQFhgjpbppqbLy0e4PjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvuImRhTRoHf7pVtI4wHbLiXvjrpRico+sp3ZA+xRkI5oI/ND+pKgQWIludyMYkM9U1Sp/GFg9DHWLK9PhYvtMKLtZ76wKCcD8R7kHJYMwgKfa4uarI2QPMD8FFFOLk/5nOg2e9tyEDL+kHagFNuu+gD4DBFPUjKxz4oLLn7+Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SigK0a9S; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-124566b6693so11986337c88.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 00:11:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769501517; cv=none;
        d=google.com; s=arc-20240605;
        b=gf1ZwejnPCo/sHp4zo/u9l+xIFFoN5or4tqtrE7SRbM4y5avqdaoP83sxMbPi+G4mi
         4LXQURzPHODWasTsB4Q1EnzvqYPPxzPvIjdkDDHDA4RQjx/PAAkQZzrCDLwkscTyeYgy
         JJChJkYBaCAFgCKvqs0tLPw9uTvFkXd4wEdwMv6j3WA0dfBUhFOu5gjskmJjW0ajxM7y
         ELoq5KHW3S64EHJABusMKvKjEggRoMreYURzQmacZyzj3tilUdIFfkHgxIV5HKA+LUH+
         m0LvoySxsLOxknziZXNREuFQzrH/OG3C/jGMP4EFVjYCa04niDoVdSPOm3aytjQ2pu6C
         L1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TVBzi9tNoEWRtga9+XRsGvF3eq7us9iWbo3OMFydNYU=;
        fh=5AIRZ/EV9AB7CumvlWqlaFZJTkd3dHuVmCfxpGsyDkk=;
        b=Sz727Ltk/I/zhZTe6Z7R5kDfwHUZ6PtM+7ubOhWIWJ0VWs8EVTPvm4IMCiqjlCXf3j
         +FbyTm+3T8aH9+AD294kq5lYUXW4TRoVtmbWsFMlx4YjGIamqWBsqEsYM+orsbp9on8D
         cWeR0uHtNGV05YobyNYTL1U1SuC82ZOD0VpWIH+qecBfkta80G6ewrN/dx6rA/cDeH2I
         V6tPyamwjbL1Rq0Xj/+0GyP8T2up1jRBwsNUJnxlz2r+M71NY+eB80jCi7KNc3dW2e9V
         DRqoFs1i7Ni6ITlqRNBqEAGYeVDH4cUnwPfz0Uk3ssS1jFsIzyzIhjYiuKULQuCbjVbC
         HSGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769501517; x=1770106317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVBzi9tNoEWRtga9+XRsGvF3eq7us9iWbo3OMFydNYU=;
        b=SigK0a9S0BRfvZ/6Om3FqD76JAGS3EprpOsJgUHzvwxxh3CBhNEJitGR+bm76+1jVB
         xw9DK0eWM9B3Lz2cBZQFLiU2v+5XgT5KWBwG9Ey+SjQeqcREIttcJTdIgEsPXu8AvECq
         drvLZSoMGwVubjFVbqOueew4lcfbr+mxdc2ZBYSe17pDadcfn1amZSqHS3U4LDGcsiXz
         ZQU7ZLIdzR3qcEH4gUAsMH8GmDtrW6Urc8xSfJPdZGNmvDbWjczO1ci4cot0Q7hB5E/N
         60Jhh77IOtnlQn1thauBmvCEWY7iCMmAj5ORVAuT58v+9i+CBWc41C7krmXWYx+9Pi/m
         16+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769501517; x=1770106317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TVBzi9tNoEWRtga9+XRsGvF3eq7us9iWbo3OMFydNYU=;
        b=I9uDut6H9Zck47V9/4lyMJTnfIHdOTYivxqosiYmqFxca15iIi+bcySG1kQAdJYH/N
         rM+9R4DkGZYpvyT9lz0XsWu6W+W47kh9o8upMU4pKyDZdYXTkPWP3uBmMg2ZRceBD+/Z
         1CTE6Aj00mhv77ffi1z5E9G5eVZr0UiC4bCiEu47Kzdq5mIZVQHrr/fzNBHFSPvQbxzB
         5ATgS0SiYoZopTECfr23FDAi1pdJQOofPAxfdbQe5iIOde6+tEGLNs3SvbaELBZ/j34F
         KUInk1DXpJ6E5r/PNYJ/nvaKenBXhpSyRsFNxTc2NAlhfly1QFvCwkSmmyROhmGN1qG9
         p2kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZmoH918qRQAG+nl2NHuMLIxnknTrd2IrgrFVT4vPY+ixBcs36Hkd4IJ7r3YSBYAeFv/cRgDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyz2PLrAVN3bXyuAmY6pP+bw100ApSmve/s2tQfJcVeXuF2WLM
	RM+oqKnlbOJzLzT4xDljH7PsvdH1R6N8ryeCVovr1leUTmrtAgZgMuDM+MER+3fLII+pTzaLhDD
	wdEO89dhwZgTRkz6EZWsUc4V+q9MOjDuOF1xbKMFS
X-Gm-Gg: AZuq6aKPILUnXCMv0kmq48VRdZ0hA2CDBjsvrBW0mr4GeNby/GKn+t6ENP3F6u/ie4s
	xqj7PBWBpPZ+aXypujzq+2zU5FwIYhg5PjbWgzNHdOC/Um54sHjMAPzRpWNDNa7zUkNZD3H92sX
	irNzjjq9yr4eLEjoi/pMz3CBdbc8RCcuyukoblGgWD0EtaT8gv/QUvwpYvzLhQaJZY6MM/kUchG
	ozjO9e3Iatq7nB1Ra62AWvsucR0/gaH/Z1AF4qpHswA5DoUFLrYkOX15QLvX84+gnqnVR8VfWbd
	JzI94VLws4ttFUqlEjyDjTrKwpQ5+GzW0Nudt2Ve0Oc6EIFudQm7+lXoMZuy
X-Received: by 2002:a05:7022:49b:b0:123:330b:390 with SMTP id
 a92af1059eb24-124a00ae9e2mr606703c88.20.1769501516455; Tue, 27 Jan 2026
 00:11:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123170412.906280-1-skorodumov.dmitry@huawei.com>
 <20260123170412.906280-3-skorodumov.dmitry@huawei.com> <CAAVpQUBGAitiYbXjGoU7ByaXuU9oYF3nfywu43susMHi8mSy8g@mail.gmail.com>
 <a4a16ead-a534-47e6-8468-58898350415c@huawei.com> <CANn89iLQ2tDcWq-aLe-FhQU2cX8txF5L9SewiB1ssJh+7ds46Q@mail.gmail.com>
 <acb923ce-82f0-4a0a-bcfc-aadf00b746b6@huawei.com>
In-Reply-To: <acb923ce-82f0-4a0a-bcfc-aadf00b746b6@huawei.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 27 Jan 2026 00:11:45 -0800
X-Gm-Features: AZwV_QiZy0_aElKkm862-e-iaV6jYL9ffJc7vhUkUSpfUOdurxZcjXEVVvNfcBE
Message-ID: <CAAVpQUCRN-bS-=5wAB+S_bCQ-hYY1kp6XpjX6cKGoC2LhYLwyQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/3] ipvlan: Common code from v6/v4 validator_event
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: Eric Dumazet <edumazet@google.com>, Dmitry Skorodumov <dskr99@gmail.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org,kernel.org,fomichev.me,lunn.ch,davemloft.net,redhat.com];
	TAGGED_FROM(0.00)[bounces-253747-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4932590F6E
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 11:54=E2=80=AFPM Dmitry Skorodumov
<skorodumov.dmitry@huawei.com> wrote:
>
> On 1/27/2026 10:37 AM, Eric Dumazet wrote:
> > On Tue, Jan 27, 2026 at 6:56=E2=80=AFAM Dmitry Skorodumov
> > <skorodumov.dmitry@huawei.com> wrote:
> >> It even might be a good idea to replace wherever possible preprocessor
> >> checks with runtime checks. Use
> >> if (IS_ENABLED(CONFIG_IPV6)) { ... }
> >>
> >> instead of #if IS_ENABLED(CONFIG_IPV6) ... #endif
> >>
> >> --
> >>
> >> I'm ok with both approaches (though i tend to like runtime checks) - b=
ut
> >> unsure what is a common practice in bpf-net
> >
> > What you call runtime checks is in reality the same : C compiler is
> > able to optimize constant boolean expressions
>
> Should I fix patches to be something like
>
> if (nblock =3D=3D &ipvlan_addr4_vtor_notifier_block) {
> } else if (IS_ENABLED(CONFIG_IPV6)) {
>    ...
> }
>
> but still with __maybe_unused for ipvlan_addr6_vtor_notifier_block ?

If IS_ENABLED() or #if is used properly, __maybe_unused
should be unnecessary.  Actually the patch moved
ipvlan_addr6_vtor_notifier_block out of the existing #if guard.

Also, ipvlan_main.c already has such #if guards.

>
> I see that this __maybe_unused is used quite often in linux-kernel in
> similar way

but not that under net/.

$ grep -rnI __maybe_unused | wc -l
4827
$ grep -rnI __maybe_unused net | wc -l
33

