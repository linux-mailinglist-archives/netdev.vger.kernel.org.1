Return-Path: <netdev+bounces-251730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAFQNoI/cGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:52:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63758500C5
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F40C95005A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09AE34EEE0;
	Wed, 21 Jan 2026 02:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV0/cqof"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054F034886F
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 02:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963689; cv=pass; b=ndTEkQojJFlBgp1BtIsE4A9m9SUI2nIkZn33iqb3L8uDY+0P+5rabPfNRTRhiv5y9O65XpU5wq3aAZjzOKbJ+0RNn+eH8waHNJE3EJMrLUqXZ+llqdCmfnp0/x1jrm9OBDAo9cGxwIplPf+r/oFPtlNar2gg0Bq++vouSipbM9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963689; c=relaxed/simple;
	bh=HASu/aVWljMOKHTnmFy3SxkdaCrpBp8Ytm9MgljDIGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqAkDsFzX+lh0Bc+/9NLCxltCPFT/aTja9E9wZ1oNI2Pkk/whtaMP1/sUKbG2xzxEh3SfDbrnTpLYwPPw3I/t2ygsjBCpSzuGjiuCHOSvUSbwj8YwOshrDWL5eIRSpWrP+bw3yZl+sZBrTfcIpkOgE85GxIDHWdRi0EcSR3GUyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NV0/cqof; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38319cbc8fbso46864311fa.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 18:48:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768963686; cv=none;
        d=google.com; s=arc-20240605;
        b=Zne4vMx2It/FZmzNxtxpFoLKJhbMeQ1LsWCxQq0YmBXwxL2HafUcYEDq65XwlQr8aT
         6nh6nk8jPDV3CIDYIQ5qo4TVHIfF2obC/LELEILz420i3uOOdxWNCpgPZTow8KopZgEn
         ITUOwIc5OJHqyowLWQp8lGaathy/V7gqT0unQUqetlxjYxKujDG6vJFwB8vwafM44l1a
         D8aeLdYNUWGFCudcG3sMddbIPv0+N41fl62VM4alB0rMt8IWZ1m4BGZWu55rrtwI1YKa
         bip5qiTEfN2IBJA+Q53RXs/OWkJ+deagqy/jva18Cw1JE6CWjdhgWYaLoTdiqMQQQLBJ
         Svyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V6DhaubytYMggjw4ISb2gEctqG8uHYA+kqEpsAvSCHA=;
        fh=ZNZxJ676gqC1Z+HgPVIWRJR6o5wL5a0dS1kH/8jR4fE=;
        b=g5ABYelb2FOlthrHJmTKIwi8wrTvNN9LgiPHCZkJFMrYro02LA/U2hPhfiSQ1VQ1sW
         Vg8e7MRpBNU+aKbZZtJqL5uffHzMIK69nkqxm+6ZVtSZr92N3B4EKpsDQzqfjbUFp2Y7
         lTz8eA58H5hWY0WHQKSAv5ElSfErhv1FXJ/iqgZkLUHO8HcbL9QfE0J2D3fUAz8sUQMT
         JCL8DAo3oLeDRyHgjTRna+szM0GIobw8QeG3p9WJ7HjPFVZMmXUUjEdLwflDMA9dqVMD
         jRtIuo2P97gdn6+38HWBcv/FXPoW/FQUNjPc/lajEvabE4Kz1BHenn8fvhnnCxsirW1d
         1i/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768963686; x=1769568486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6DhaubytYMggjw4ISb2gEctqG8uHYA+kqEpsAvSCHA=;
        b=NV0/cqofifpAUhqkHiEMxr0e9d7jtkSoV206g3AFaTzYCglugUPfupxwZM5Dglhw3M
         z4dAbOlBluPLhgdTZto2V+bx1ypd9ykp2eDJCVBvAKr0zDPTk6s7oZwc8bQWeuvz6+v3
         u9c9puVnjnMQKE/gbBlOTCmgUlaFibB/xo7bsAWW91uBDvt0INVLowYy37KF3W6b+8UP
         Fy/viWWErPFLz/45m+I6FLp5SzF5AMmCMWVgPzNm3o6a84HaB7kCjzWDhrXz/OcfaM7u
         C5uI0+cH5SALtRhoZS5QPHbPzW9rf195eY8gGLxGXvSHkgwT+3Om9uT8gG7KVN+iOmDj
         YCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768963686; x=1769568486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V6DhaubytYMggjw4ISb2gEctqG8uHYA+kqEpsAvSCHA=;
        b=khpV1n+FbyHwvyRpKYLbBQhmps0ThRuZpvkm9IsF8CtsWeCAQBsl6l7xzNg3Bwiwsi
         +JmNGA08rzXwVSYC7i1M7ITbq4P3pjew4llPJC0f8lRMxSX9TC2dVt98L6dquI4Sn453
         aswnecc/O/almtasHuSrzOrYO2umSY6HIFu+vcl+9n6r00SiJG39IAwanXqsmq9t44cb
         tZyy6Uocf23xjUtwWjD7fvUIcO3kY2+LnfUMKLETm7PPMQzYe52OE73hidc8SYBdoPFc
         vDdbvyohewR8AOjbPDgnUxge8FnZInWO0GUk68q7hHbKq3+4TaodzdZCpN55EqWuv+kP
         j+mw==
X-Forwarded-Encrypted: i=1; AJvYcCUjng4/feMMEqaupgUEkM3zDB2W2twy8BAnMyXT9DdUHFHwEW4GPAhIvxjHrgd3Dmj1ESDOij0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW6nbW43o/q1AfJeuaCv9zsLOorTQutW2aiVtI7ll12xhwBXlw
	UqF1SUyoG+Gij7wPQ86DM2Iszg29JW1Y2DbuFXeO9ik+gYnKgLfQ0dbpROQNhxQgV13eFOxFb6q
	wEq5kkWTIFZ1DBD5c6cn3qwpl+jdYpQk=
X-Gm-Gg: AZuq6aJyY0XRpQXBh4blgjrKH681trqsxe3XTQN0x5CmERR5dJb7OCQvF8N04Z27tJz
	Mxt6R+xkUJ/W/mAb/vPDwgDMx41jd9EOtax0Hk4VUSiWjLOA5ploI9eaDSdQwfGjk84a1aUjzQj
	f3C9R9uOnpMZKr1nbMBPxTCxYvn0o4fK/PTJjOoy78AUTAu/GdsOx8JVGwzXvxIqNdLmxrClbzp
	e6u7ORuQk29LPWMoXSqCbB8pj08ugiAc1+3KoXT2Kr8U3ATQz/fIgDnbXDtQ8kU+f6hZbmY
X-Received: by 2002:a05:651c:3135:b0:37f:d18e:15f8 with SMTP id
 38308e7fff4ca-38386a263aamr48973511fa.22.1768963685890; Tue, 20 Jan 2026
 18:48:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129095740.3338476-1-edumazet@google.com> <CAL+tcoAS9u1A9xpsWaAzSojJ7qepWsvF3imC5LtEhu=zD9AjsQ@mail.gmail.com>
 <87jyxc1wnb.ffs@tglx> <CANn89iLz=syAMbfEdVXVg_tCwvwWhObRDGk29ko9CkQHhAHWhg@mail.gmail.com>
In-Reply-To: <CANn89iLz=syAMbfEdVXVg_tCwvwWhObRDGk29ko9CkQHhAHWhg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 21 Jan 2026 10:47:28 +0800
X-Gm-Features: AZwV_QiWEDWgCMu4YnAVRNsRB_5cgO_ypxBoQQPw9uSeHmKH1_aNpXqEEsQInq8
Message-ID: <CAL+tcoC1HLbes9cO+=GnwBVpW04PDq_CNENF0py_ONr9NWn4Zw@mail.gmail.com>
Subject: Re: [PATCH] time/timecounter: inline timecounter_cyc2time()
To: Eric Dumazet <edumazet@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, Kevin Yang <yyd@google.com>, 
	Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251730-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 63758500C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 5:11=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Jan 20, 2026 at 10:06=E2=80=AFAM Thomas Gleixner <tglx@kernel.org=
> wrote:
> >
> > On Tue, Jan 20 2026 at 16:18, Jason Xing wrote:
> > > On Sat, Nov 29, 2025 at 5:57=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > >
> > > When I'm browsing the modification related to SWIFT, I noticed this
> > > patch seems to have not been merged yet?
> >
> > It's in the tip tree and scheduled for the next merge window.
>
> You beat me to it, thank you
>
> tip tree :
>
> commit 4725344462362e2ce2645f354737a8ea4280fa57
> Author:     Eric Dumazet <edumazet@google.com>
> AuthorDate: Sat Nov 29 09:57:40 2025 +0000
> Commit:     Thomas Gleixner <tglx@kernel.org>
> CommitDate: Mon Dec 15 20:16:49 2025 +0100
>
>     time/timecounter: Inline timecounter_cyc2time()

Thanks, I see now :)

Thanks,
Jason

