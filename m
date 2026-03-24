Return-Path: <netdev+bounces-270926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PGqLv5JwmnvbAQAu9opvQ
	(envelope-from <netdev+bounces-270926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:23:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 056D9304874
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AE66321E47E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF93D34BE;
	Tue, 24 Mar 2026 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="YFpASAOe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA983CEB8B
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339799; cv=pass; b=pkBcG/CnakWwe2X3y/TtPKCU5slfOGaoTWqQL13U+XL9fhsbWrDG3v2PeMdLTb8BpWonruVkv300gf+5h6AGGXqz24rLG/d25DC859uzTh3GaMLCtUyI77aqbVhVp1+7Tp0YL3D+k5unCdw5uaw48Lyz8k7wOwDZsnmO8dWef7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339799; c=relaxed/simple;
	bh=MwDMuPiIcqGddS4RomYMgXO9AZM9m7utZrTmSBo4Kqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKbpo2Do1eEOc4Cv6CJsrNxBw1yikBbAJRj7vGPS7Zu5I421G8yp3FJ06qiJF3rrrTC6cSavGp0bDtNTTEOfVhMB2ZEVmNXqqmS6o8vLwrYkfnka9MTCkmVALzQyNm8n7aqyz+G05GdKJ/VbSf9DzaheBwXC3iT5sE28ejAHX0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=YFpASAOe; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b97ba4c2be2so138028566b.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 01:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774339791; cv=none;
        d=google.com; s=arc-20240605;
        b=W+c1if06KwqRNqgfFdl9wogpBdjH/Drva80MyZYVcy1wcYA6lZIqChIMRj++s9/OL4
         eUWDY3qFEbtVhpNrPthpggKexMzkVx3VTB9qEweBjEo0ZolonXlEmpFpt+/KJKxPSA2G
         rq+7I192wCEXb55FFqLc92kipxwAKHyZi7NJikBcxPjhP27KEehVzZX5aKASe0MtrKKW
         NZTXnbUceBIyJH03/qCGR6Gss4Uf3H0q3Yj4TwcHSIQRBX6x9jfof68KMdKu6TS9FxXn
         N9474sg1PTT3iTfbz/wH369N3P92HSp3lw3VcBCy6d24fXaESnbxNK8eXHa/oUPNa7Tq
         wqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AA/zaM7Qo33FM3sUVdHeHfUA+zjPIWNI8Tvvb0zNQ+8=;
        fh=WmGJ5Wv0oZ/VfCHyCENBRQA+/IPLFT0xziHw1QD06gc=;
        b=ecRqo5YFIZU18Qfa04XCzAhZDdXITXS8srjrsXcv9QRK+D5R5uFIMuxlsCvPfInVBZ
         NRXAPWLXGOKlu6LFlDF+ZW88a0qXNl/i2ds5uZNUISwb2DpR1CzyY5bwYQXL9UDDlEnV
         xAc2cWXL2LJQXul73JVWXVdKIA0p8fMqLD5gGHAsPjO9bY/KOWXAlVRD3RJ33Y7oDaZf
         umWToYrnKJfNsjfu4Mw/ICijyRbkT7Z6u3brA+ZzrlUB8gut867TZWVqSNcMccLhG560
         Y+JvwYGMvhuRfS7BqRi9QIAMVAxz/8MRIMjUkZ1SUl8oJjbCr2O5WD/35zkyZB1kVycf
         uY7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774339791; x=1774944591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AA/zaM7Qo33FM3sUVdHeHfUA+zjPIWNI8Tvvb0zNQ+8=;
        b=YFpASAOerIeSYaKKsyP+12Cz/aeJeOTmGZjSe0m63hZQT9h4HGFyRhIfFdwVZoE+Px
         tNBCvbelWgAqWzZrpSN1H/sMHEn8XjO4qYz2IMC6X6cKk0hDvUzbipiwTdUHpA/RGFuf
         OEzEYN6QZy6SkrLs6qcG48Ux4hcVrex0V8cLbzza2+d7iKL9GG9F/wGOXnOZVac6mnZc
         gXLN2YiQTNfc2S3R6nfKx1xTDkyNtUnJdwmv9hnrkxUfUxF2Qd41nD8WYYTV0yxIID/J
         D8VwUn50ZmVjH+hesONMQAqUUjtqFX0K/mWr2z3b56pnbihMXGLXOO8oiSOwLxNLtVKo
         52Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774339791; x=1774944591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AA/zaM7Qo33FM3sUVdHeHfUA+zjPIWNI8Tvvb0zNQ+8=;
        b=m4db2lRU0FR73y3K3EK3/WqBwJzrQ4SOAOdB1Kk7RufbWQhMxxK7fhMmnKgPFh67Hx
         rbUMEA78qRgiVmtXr95aPuVmurTMpaGJML37glsB49JFPNWNvoAb0DHmseAfz2z5P3os
         QSns0WIHgA2ii5wYQwzaWVwV4HGhWmNmMXsL8Tb4eTTo+DF55mGqMkVZ+KdNiOsqfM+S
         faDBZemvnfPedlcC7Zr65skakVWWgUf8Cd0Vad4iR9RRjRH4u0CZddT9dsjyCU8eEtD3
         Rvsxlb3P9Dvn9ped+yHsWYbF4X0MmiUxzKl8jyoz0Hs/0xPWuVNoyJt5g+vKzFkErb3n
         9hAw==
X-Gm-Message-State: AOJu0YzktI6XIm5rOuToL03yMs0iNELdxldzuT/VBNBU474w6oaNIXVm
	+kpghMAiDB7OT4C676l6mszTsvjo9fXP5Qz5L7m817gmwQsPZW/PG184hng12MzfLka9fjqT8N6
	wBdY+m23zI+LtDiacOrGnQAcd9OKXuf4dDPTxNWE30g==
X-Gm-Gg: ATEYQzxCOM7JUsWqs8Oumip0pbAkUaFZLxgDOzyp3pLOoMNjNuUYOuHnHJoRcDzVHiY
	eSu/ZT4nWv2KR4SYBRnudicbtePDYKJfwTZCoVesHTltn8Zksz9bklR3EwEu7gPeiUgrWfX9vFB
	8e/WJG+Hp+m4OYzmLgId/5AdeQdlmUoMMgUH3ZAxJupg1k0XFN6z9O55D/qtNunLN3X8aMmtTLN
	rZkMVMF6KNI7j++VtrJ4kOwaQxms4WAwjqiILBx31Yp31nDve6OuML2eTXJ/smsatIYHT6CGPvU
	DoPXq4O4Qr/zvqYU9baNuKapQjhaQ4q1q0MyXfRGlA==
X-Received: by 2002:a17:907:da4:b0:b98:44b3:7e95 with SMTP id
 a640c23a62f3a-b9844b38052mr810937366b.40.1774339790570; Tue, 24 Mar 2026
 01:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320135909.1729313-1-justin.iurman@6wind.com>
 <20260320135909.1729313-3-justin.iurman@6wind.com> <20260323042742.1097eb845dba645864e3f84c@uniroma2.it>
In-Reply-To: <20260323042742.1097eb845dba645864e3f84c@uniroma2.it>
From: Justin Iurman <justin.iurman@6wind.com>
Date: Tue, 24 Mar 2026 08:09:38 +0000
X-Gm-Features: AQROBzAJoWPj-IDcbEWKkS9pLM294esnuC3ZcbRrYNyG3hbvqpcWRujXu2qY01g
Message-ID: <CAOY2BqwALJh4T=gbm_6bheWeTpngarBkU5p=jiPT8vGnhdDmcA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] selftests: add check for seg6 tunsrc
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, justin.iurman@gmail.com, 
	nicolas.dichtel@6wind.com, stefano.salsano@uniroma2.it, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270926-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,uniroma2.it];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 056D9304874
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 3:27=E2=80=AFAM Andrea Mayer <andrea.mayer@uniroma2=
.it> wrote:
>
> On Fri, 20 Mar 2026 14:59:09 +0100
> Justin Iurman <justin.iurman@6wind.com> wrote:
>
> > Extend srv6_hencap_red_l3vpn_test.sh to include checks for the new
> > "tunsrc" feature. If there is no support for tunsrc, it silently
> > falls back to the encap config without tunsrc.
> >
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: linux-kselftest@vger.kernel.org
> > Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
> > ---
> >  .../net/srv6_hencap_red_l3vpn_test.sh         | 95 ++++++++++++++++---
> >  1 file changed, 82 insertions(+), 13 deletions(-)
> >
>
> Hi Justin,
>
> Thanks for the v4. Good job on the fallback logic.
>
> However, while reviewing and testing this v4 on a mixed setup (older
> kernel, newer iproute2), I noticed a specific case that slips through,
> unfortunately causing the baseline SRv6 tunnel tests to fail.
>
> Kernels that do not support tunsrc simply ignore the SEG6_IPTUNNEL_SRC
> attribute. If iproute2 sends it, the kernel installs the route without
> the tunsrc and returns 0 (success). As a result, check_tunsrc_support()
> ends up setting HAS_TUNSRC=3Dtrue and installs DROP rules that block the
> baseline SRv6 traffic (please see below).

Hi Andrea,

Good catch! I'll send v5 to fix the above, as well as the nits you mentione=
d.

Thanks again,
Justin

