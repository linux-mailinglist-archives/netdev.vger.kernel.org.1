Return-Path: <netdev+bounces-280293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGJUFos46GkbHAIAu9opvQ
	(envelope-from <netdev+bounces-280293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:55:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8D9441A55
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4ACE2301385B
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 02:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967D939A7FA;
	Wed, 22 Apr 2026 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/dtEV60"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF2039280D
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776826502; cv=pass; b=hCGm/0qmo/LB0Lj6+/s+37zgmzaDHoNQwzse9zGIlK6UQs8+Wr6P1Icv2XlWrmmIlMAOrzKo4401mzLLHORuX2H8jsXMf5PyvFnX3t9BSE5CYFbkHL3al1RHKWRNiK/Op67lbVRZiIiFfcsUxFLGLHQUizEwLIxRc0sjN6bA90Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776826502; c=relaxed/simple;
	bh=5B8p+QDUxXae132Fq/olL0Df/Jc61502WZG8qooebxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X15OfoN4YA0546ziEFNK+FS1FP1o9C8jTu9IhKSY7KFBKonUzkzGV7pa5h8jeitmOBn91oFYDEYLV3FE7bNNiTVsAaMqAcyjhBUHS3totJqLCO5KKbwF0/gLBCTjUQpH/yykLiNJoapxRBkwdoxoCQJ732S+o06ZJHaXVQY/Y/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/dtEV60; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38ce0ab821cso41625411fa.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 19:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776826494; cv=none;
        d=google.com; s=arc-20240605;
        b=fMdqn5PrsDS6rXZuGp6rN+uUGbohz395qC1DkXuHE/vO9iIfG8OkVRmixGB9hlW8tD
         cZJ+OpVJAflZM542bjwDFatRv5xWvO2px6zvGmJKZ01RGRzz1oPfbRaSgKbZ+MT8NWtf
         pJyp8RxoZyKFTUKCKIru0t38ZY/8tXyr22CduqXLQXykZAjZSu9sd9Sk8CwYtF5aPuGk
         rfhXSeEkPUHwICaqH/n5TL9TXT+moiEa9PP6COBOxLk0XN1FgnzTmBGrgIAC9vF2rocF
         iS0zYz2pnM0OsoOP73EY+Lb/O/cuKICfpn7gKxEDBoC7y+b9So2vq0gQ0V8StSK2J8xJ
         PPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OG7eT7g8H7j0h83hkzwInJ6CPJnFxfvuaf/IIwu8WPE=;
        fh=3vOABN1mpvyCOgC5bNmWmS0as6nFmYy+BrfcC01rnl0=;
        b=KC//ke+p65e8QVR/jbeivXi8i08QPPVt9soggVvkX0rPf8VGpzf1mzAnCOSB2daJ7g
         CmDE1gOyQODpiKducwanlq/iU50jR2LpZWTVsn9Um2SEYCyZIrrRoVP36tfxi/FEIPL9
         dVln5P5xMRB874BUD0dmwycR1vuB62W1V78Toz6MJ7duQiF6eqaiG6838SJR3rQJl6Zd
         7masGslYWo+hOVQzJUcJNQ568290unEZi0w8SYP1Uejbuf+19eGVGHIm0slAOs4dNuVa
         6cm8/E9V0evMOTejrMgJ0Ly/06IWIT09sxxsCrsodY/BOc8UTJSq5Tr4sMMbVwnEW83P
         s3ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776826494; x=1777431294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OG7eT7g8H7j0h83hkzwInJ6CPJnFxfvuaf/IIwu8WPE=;
        b=D/dtEV60ZtyfzKCFbJV1Rz5c782y6UMxQu4J/EMDtymOw1ihuX4HQoVXVsnL0vwUyv
         D7VWXLxRQqIa0/DUJy7shZ596s0anxAJ7wyMoURxDwHwYuvf2na5VjkdfhhV6LJo0lCo
         QmZYB/iVwSfltbsFLNDFFKFFzIeETXEOfq/ivTAPTSoKIotLvA4v4cKkONJpa6USzCxD
         x1pmgLGigOtBA/SvnISjoO4c5OPpAUt5mA77q5TdPtFhnZYzdARsoxSVHU/lPs82/uS0
         q1ZlY/7RPvP7Qm8zsBwle9XJwfvZ1gYPER8sAV4U0wrbAQz6uKZIc5PyPA3EKsjdSSOX
         8p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776826494; x=1777431294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OG7eT7g8H7j0h83hkzwInJ6CPJnFxfvuaf/IIwu8WPE=;
        b=GOdf87xoPG2fg6YXQ4ibj0Q1jFxpBQ1OvLUNCRKFGpXrpNZRep8NlvOnJBTzVhbf5d
         VfG7weOiv6sVTJ0xa/85h5lzgOY7YGCIzDV2PoWBVLZHdkl3oFVlnBn4STW5+Sl7d9Gc
         5Qhc1d1f4SQkbgo1fyVIMmw5cIjmVJO8LoS1xjbfXCMngWswiawD4WCidlrD5bCsrZuq
         PyVb/gDZEn6Dq7uRqsY87dju3Mu5r4Lyp/UVJp0vn0Z3R9mYEj0xNzJaMXhsUwaT3V+x
         ils7ihttKiqUrYtlZUIYo6xrgFX7JQxlXo3ZogfGDAu4CYP/SbrHHrCbZhFcYTeYwYXs
         8EJA==
X-Forwarded-Encrypted: i=1; AFNElJ+tZdHI+TkPgzB9uLKGqLbr+wugsGHtuD1Dfb3snxSF//VTZhP8DLgPV8pn40LCaW/dSNUYFKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydsKSMtfe7VPgitcc7f0zL9HmG6U5ETXJTiJTXlnsv3iAzvIuc
	tIn3pFdfNDUWfUieUavP5wNlYwBYo/AFsWeGNagjG70u6eFHfWwCIAUmlzIdgxO8jWYC64ziAJ+
	mFHsWnjmH/Rj6lntHooalpFeFn1bJZsI=
X-Gm-Gg: AeBDiesaqzlUJQczrFRWBTohW7ELd4iSyBFd0O+qG0Ce41l66a+r3ad4Yy3Yg8bxAxn
	K2mNb4xl+MEuTZzYdSX+sWg5oBoh1Mqhzl2xqkk3C5w3WmB7CIT90ZNiWDBTh7tnwPbv6xZcepA
	yhf2LcbLc8ojUYF/RDrp9qXAr5KYFkZ5w3yxW0cJyoFxASWOG6h3w9feGHn+LpxRYr6no7hO7Hb
	fc0S6XZTjj37FptKMDOl+oMhh1W7H9++wvFUdHDtxw0ZKIm+zboPcKOyqMoC1uzHr8/ilHqAKF+
	RjPsHve976NxMQUtN/v2g0vmRFEPHg==
X-Received: by 2002:a05:6512:108d:b0:5a4:6dd:87 with SMTP id
 2adb3069b0e04-5a4172ca7f0mr5866475e87.2.1776826494007; Tue, 21 Apr 2026
 19:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
 <20260420082805.14844-9-kerneljasonxing@gmail.com> <aeaCzchKwsp_LWyA@devvm17672.vll0.facebook.com>
 <CAL+tcoCxQ8cU+wr7eJsMH+FPMcp+vQ4J4BdSdsVqyTRqN8q9LQ@mail.gmail.com> <aef4XHnqR2cs5U1O@devvm17672.vll0.facebook.com>
In-Reply-To: <aef4XHnqR2cs5U1O@devvm17672.vll0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 22 Apr 2026 10:54:16 +0800
X-Gm-Features: AQROBzDfQhIVaSKFF0sXfFlijZMZ5nryThbH6nQqDrBrxgUtb9-hDG926vitTvQ
Message-ID: <CAL+tcoArQEuVPGGKEg5f82W=Ar35PxDDCtKso_O+RTogK=LT3g@mail.gmail.com>
Subject: Re: [PATCH net v2 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280293-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EB8D9441A55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 6:23=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 04/21, Jason Xing wrote:
> > On Tue, Apr 21, 2026 at 3:49=E2=80=AFAM Stanislav Fomichev <sdf.kernel@=
gmail.com> wrote:
> > >
> > > On 04/20, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > > > descriptor address into skb_shinfo(skb)->destructor_arg (void *) vi=
a a
> > > > uintptr_t cast:
> > > >
> > > >     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | =
0x1UL);
> > > >
> > > > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits =
of
> > > > the descriptor address are silently dropped. In XDP_ZEROCOPY unalig=
ned
> > > > mode the chunk offset is encoded in bits 48-63 of the descriptor
> > > > address (XSK_UNALIGNED_BUF_OFFSET_SHIFT =3D 48), meaning the offset=
 is
> > > > lost entirely. The completion queue then returns a truncated addres=
s to
> > > > userspace, making buffer recycling impossible.
> > > >
> > > > Fix this by handling the 32-bit case directly in
> > > > xsk_skb_destructor_set_addr(): when !CONFIG_64BIT, allocate an xsk_=
addrs
> > > > struct (the same path already used for multi-descriptor SKBs) to st=
ore
> > > > the full u64 address.
> > >
> > > Is it easier to make XSK `depends on 64BIT` to avoid dealing with tha=
t? Does
> >
> > Of course, it would be super easy. Actually the initial version looks
> > like this. One line of coder is simply enough.
> >
> > > anybody seriously run af_xdp on 32 bit systems?
> >
> > But my worry as you guess is if there exists a 32 bit system? I doubt
> > it. That's why I put some effort into adding the compatibility code to
> > cover the case. Good news is that it doesn't add any side effects of
> > the 64 bit system since they are protected under IS_ENABLED condition.
>
> If someone complains, we can follow up? af_xdp is all u64 everywhere,
> including uapi, I doubt someone is using it on 32 bit systems. We don't
> test this part on 32 bit systems on nipa either..

Great! Then it saves me some time :)

Thanks,
Jason

