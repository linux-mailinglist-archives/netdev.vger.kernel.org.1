Return-Path: <netdev+bounces-254163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIobM87UeWm6zwEAu9opvQ
	(envelope-from <netdev+bounces-254163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:20:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AA99EBBB
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA8A5300CC0F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9A5344D93;
	Wed, 28 Jan 2026 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUOt2t5A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D93446C2
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592010; cv=pass; b=CcI+S4DeOMfuAuKrcou3DHP263EjhkRqBSJghAbuFxEu3XVJaW4Z4gMxWz/u+E5QyFB7+wJogcxfmt2wAiRj29WdS16uSSwM2woy6psV+WmulpBi/xh0jbJiQzEt39gAjdyq80qCFcMyM7LbcRvGmGDO3sSV+H8ecqe6YRFUpoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592010; c=relaxed/simple;
	bh=WTjdizy0L7AQzzyijgEvT1vsbT/lj9HTIYJktJcR0jI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nm8PAIlRmCSUIfgmAYiXu/ZSqPTKDW5mCJh+INzwMEBHfXg3lJpF/DtWnrkwX/hpf8gvlYzX6NROhqdOix+1kE8kAC1Y3LrT/Qa3bnl6u4UyVN19OtTM1zUyHiIkPFl1Ks1E28pmDGlCn8Ka+FZX6Do7fB60KtcJCx2ALkM2GEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUOt2t5A; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fb6c7874cso62557267b3.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 01:20:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769592006; cv=none;
        d=google.com; s=arc-20240605;
        b=j2fEoL9aaWDjqJLMxVxUm501nwQ8PiFeI7lYfTmjUZ9yK8tBtRc1nZJGkkIH7zx0c+
         wah8b96vQn7wzNjxVQ+JRhF29UWxlmMxTs5gnXk6X9ipYMeTgdkYCD2MY8nMs21i1++5
         CPfH0PQ2HYqd2dslHV/vmRt5OCxHYsBxd3hWsAgVuoEI4eknBYD004GES4vNATRaYkkN
         Fr3C9S5sJfgkMQo1IQpo9MICLdm/piQBnVxhRtdpeRHdtmE4FPLDMVTxhkGaULihC33s
         gunWUhs684FUIz84bg8o+AISJtAcWtCNi5VFTZrCbuP1gOzbnFx+N9T/rnzALv9y6agF
         RfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WTjdizy0L7AQzzyijgEvT1vsbT/lj9HTIYJktJcR0jI=;
        fh=xj+d+KNlFFAbpOSyWSTu5CGb24mpID3m27l+w4vRCQg=;
        b=M88W2K2dKj/IoHHa46RBCEa76//2L/5MuPfpmA1VdLI1pW5yMRogLr4YAcofDU3II5
         g4F8p5j2n7nXrqrLzEgBbzp/al1Ae15HFv4XYSUzp3fzjiZ7MGyBzO8/xoegAG2nmC9N
         fIRCx9iYu1185sC3kX7yjGLLLLTwj78SQKSB9DUGTFmbJA9TDXdApG4mYc5Wl7BEGX0K
         DexK/4yWBip4GVNW7W6qrCLJst/wJhpCUMeVZO3zN6w3tLMByxTB4DwQMR2KB6D2Pbpa
         Xt4jvpOXjwFH3myNjHW6al+z8YlHsJx6gFLTR+PNSEIPBNBsfE5fe/r8munO/vsGS1uv
         H4mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769592006; x=1770196806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTjdizy0L7AQzzyijgEvT1vsbT/lj9HTIYJktJcR0jI=;
        b=VUOt2t5A5JXzlsHBSosjwhzHKWHoOc+d4faz2Ll5EEKaPs+uStDshvuVBj2DfhUUFg
         4kRj1GUCy+X2DoV15M5LWeOXGZ7cXEESyCQzxGdibIXUNVwv/VYJSJR+UqaOfpC0BNVQ
         Nhe/m7kmPCzE517QfTEMGKyFhg4C5mhOYQ8tmxnQF8SfsapcyTFX2omvyVRe33Hd1jHu
         J0FVu0ZS/bgDdBrveC19hZHp2YeFS5v/XlBRP/EKey6BYI6J6zsKsifx7qY7orcCTzMD
         BxUy6J8D9NWomP1o1u4oYYvewMCELTHC2T5M9zpTeGZwaDmQMGFH6lieYi4s3l3gZh+s
         OItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769592006; x=1770196806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WTjdizy0L7AQzzyijgEvT1vsbT/lj9HTIYJktJcR0jI=;
        b=pGBtUSPI655opwxIkZrqe2i9kwj+m1OcGUb3rySmSRJzDcm0b+ctyvtl/b6s7R66MD
         eLY/1yCEFHSzv1VUmvCAbDzcBANJf5b3rAOnMRZBJznahSRwssIO634ZPls0OpLnfFR3
         aHJrGFCKi1y71IW8uCPZ4dC0VNXOa27wEMf/7vVnWNAFvJlMG+1hv03bG8GmOtTC8pzO
         a6diKW6O4pEsZqLjFGjKOTrxwyxOBD0ODxKiDeGAT0Me6UGq13boiahMYVkNEo1s0CQB
         6GKVVOBkTPkZjDezY/LXHPzyQX4xOGeFftj/RG0U5brTLNIzvdXSRlfCBgFAeROQP+oY
         1hyw==
X-Forwarded-Encrypted: i=1; AJvYcCVIiZwR1090bSaLyHtvCo6S2rvLZX+ZmAfup96Twm25GLfQHsdwaZ9GsMeyPvCuDLxIB+qmGEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIivu1SEd0V++3KMUyVplrqQaTHE04iESz8/eElsoWPRGpOAq2
	zkuog1DaJ53AWrR0UByz4U7CBqgQSpueYYxO7s39emciKJ/bb53C17yICcY1F26Whbcn9CdYPWq
	i6aIlvBX8UxbXfypCVGrPLQve/zjWmPc=
X-Gm-Gg: AZuq6aIiugm0V9T/RjYYY9q8TsDPGFtA3fLcaa2N6n5rmoYSPQzoy5mdxPTvHuZbbgw
	tG8rzbEmDkY6NuCyOey1wRAyR/asNdWduQFGSaBr18DbBdQ6QoqsTJwCEhRb1QuyavLs3z4PBuY
	Oe+eptXqgxOoR4+TdDQGuN8l3PLFjx1HwT/ib2nECKxELZkVo98pBH8H92hZZPuNdgfGfuOCiXv
	ztATC9n2XnC1CWArrnQ2J0fHcWTedgwxpNJIHA4Lx1uvZlDla60JHvnLz6dmzccPIGftrCyLyxn
	qMNOd1X89Ud1uetO9xOQqm4i
X-Received: by 2002:a05:690c:c1a:b0:794:7131:3dc4 with SMTP id
 00721157ae682-7947ac5da1fmr36070537b3.58.1769592006179; Wed, 28 Jan 2026
 01:20:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123014214.225278-1-dqfext@gmail.com> <a957214d-62dc-40cd-a422-73b317bc1827@redhat.com>
 <CALW65jYb0prfB-KpxdcNVHB1tBjN3tW286BsvQkCFoXwTu2QKw@mail.gmail.com> <53ce393d-7071-40d8-b57e-df14405066ca@redhat.com>
In-Reply-To: <53ce393d-7071-40d8-b57e-df14405066ca@redhat.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Wed, 28 Jan 2026 17:19:54 +0800
X-Gm-Features: AZwV_Qjqpy2atw73QbxauN0Dth6WeSZUzvKosbHrYjpvy6yCHSAlOUmu7PQzwKk
Message-ID: <CALW65jZVB=+Q89Q7CjfngUyski1F5dCfbdGZdxe3no76Stv0_A@mail.gmail.com>
Subject: Re: [PATCH net-next v3] ppp: enable TX scatter-gather
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254163-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 38AA99EBBB
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 5:05=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
> > On Tue, Jan 27, 2026 at 8:34=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> I spent a little time trying to understanding the logic here and I thi=
nk
> >> that enabling features depending on IFF_NO_QUEUE is fragile at best.
> >>
> >> It looks like that the IFF_NO_QUEUE bit is an inconsistent state for
> >> multilink devices using different type of channels.
> >> Moreover the user-space could attaching a qdisc to the ppp device afte=
r
> >> channel initialization.
> >>
> >> Instead you could always expose the features and linearize as needed
> >> when transmitting on !direct_xmit channel; no need to touch the
> >> individual channel implementation, you could do such check before
> >> calling the ops->start_xmit() calls (possibly creating a new
> >> wrapper/helper for that).
> >
> > Attaching a new qdisc won't clear the IFF_NO_QUEUE bit. (The flag
> > means the interface _can_ run without a qdisc).
>
> Correct.
>
> > As for multilink devices, one is not supposed to bundle channels with
> > inconsistent direct_xmit (for example, mix ppp_synctty with pptp) and
> > expect better results. But as the driver does not reject that, I may
> > add a skb_linearize() to ppp_mp_explode(), or add a check for
> > SC_MULTILINK flag in ppp_fix_features().
> >
> > What do you think?
>
> AFAICS nothing prevent the user-space from creating multiple channels
> with different type even without SC_MULTILINK, so ppp_fix_features()
> should likely check the whole channel list.
>
> Also packets could be being transmitted after channel creation and
> before the features are updated, so ppp_start_xmit could observe
> transient mismatching features and skb layout.
>
> It's not a matter of bad performances: if skb is not linear and the
> channel start_xmit assumes linear layout bad things will happen. I think
> that even with a correct ppp_fix_features() you will need to check for
> linearization in the datapath (as an unlikely condition).

Fair enough. I'll send v4 with your proposed changes.

Regards,
Qingfang

