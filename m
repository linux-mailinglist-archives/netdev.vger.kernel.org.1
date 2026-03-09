Return-Path: <netdev+bounces-265479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAOzL/OqrmntHQIAu9opvQ
	(envelope-from <netdev+bounces-265479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 12:11:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37645237AA1
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 12:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DED43050D52
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 11:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0D6395DBD;
	Mon,  9 Mar 2026 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4BsQHMc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36C395DA8
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054461; cv=pass; b=ESXGHf9kphOu792TAU1lIJFCUEHwRsG8+f+Hwf7CeSKV4yi3XszyeoJ3AO1BNazIi8IJ7Fy5SRi77bzNQ9wOUh4g4/P7oYnhYv88FwG1RwJ63T1Ml33WrhgafDfhRnXnqb3KX2hZ22ok1L36y72JAjXGrH+ck2WRZJjShGKrLwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054461; c=relaxed/simple;
	bh=5x8Cn6nrleiWoZ2+q5HIVPtZadEi/4ysLOLJc31G+vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRqf/tpdCcEy11/x40Jm1vVYc4JqjxuxvkrQpSpjRZ4E/XnnGTt87Z/kzKH8rbKQfGyaPV9hAh15htfzFdhwXpIOucTOmSKSvZqr+l94BkteL01CuZgVygUdU++SEY/8Mr8eflP0yRxUdXgLDToUocacjxIQLXIl9y3tgx86RYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4BsQHMc; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79901821bb0so4490177b3.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 04:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773054460; cv=none;
        d=google.com; s=arc-20240605;
        b=dx9y+TBjFuBBJKE0sH2BEa9Hzyva7lXauycO6JU/XyHCFhBH7enaDgZCdYvDVuOAUN
         vZicZyB+eikwXccYN//viVHW1zQUpo26TDG5t2IQHZN2qwafK4t6INEHwW9EebCB9JGa
         XQXNC5xO1HTM2uu6MWd9gzQ4O+DrBs1I6qd6IAYAfNEymrQd8/7YQByDUIVP9dAXifMA
         OJew8okLuyD3dAUnBPoDWYqwSswyUv2szdtD5RP6LsE4poLOT+5ELjiG48vWrSSMKY5R
         TvLXKrOL4++CHDUrLZGmeTKFFY67al+zVA7bw90LQ/KM8/hnxVjcp2n4iu6qBL9XZrhs
         JpwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5x8Cn6nrleiWoZ2+q5HIVPtZadEi/4ysLOLJc31G+vg=;
        fh=mA5qfpiuSn2zg4we2UnPx8PrHqIuUlf+X/Yohj39unA=;
        b=bX9N/K7+646jU7gOCSg4nTY4KQt4bCbkdSZVLYhLZ1XOP8wufJbm3dFUavaQpd9NJB
         8tVBL0BHqIczcjM8WEsbCr08qMgOtVxpafjaPHeMqjgiSD1Yfspwbcdfksz9gK0zjc6W
         e0xBBaGiozdoLmJVFdwLu28BI6bfrnXMkqSaSHxd1imq7izPZ+rHs8NS8Fu5H8Fclc2D
         d29aN3xa/enSRjti2LB/l2q7QHvPAzNUcHNK6m87HpC4iPCS1dPQXs7/yaFXEXsN5WUC
         48Hp4NtEAYWUujCuwFaTfV1AVW9dOzy3bmaiaUKIZk6cuEZyWZFtdESwDZj2kcmYSBcI
         kUdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773054460; x=1773659260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5x8Cn6nrleiWoZ2+q5HIVPtZadEi/4ysLOLJc31G+vg=;
        b=V4BsQHMcO/kx9KH42/fajmYRjyuhYFqJq719VszfK1CY0qWwi+0+usZfW7kDRK00+1
         dzZwy72CCZWsT6Q1H0Dga9mQAqEKwfRGZT4DVLqGBqYoeBfh4pQDZ/LWj4TfdW5xxVnk
         ahMxk30wj8RFU1caJioGDKFu3q2Pwd0B0E/XqBvsdjcyS4rjLIwiIZBYkPTgINkM0sho
         0diIs37WfwcarOaHNl4WoVmAUiGgqTvRiweLbmtfmsXAbY5dMC41rJbS3MJHEHqMfWaA
         vZ16EPkUbaI8tPUlkRoQWlh/weljyvqLpKx/R/7TYp9quGhGPOdVgnXqBIbMEqk05Q57
         btwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773054460; x=1773659260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5x8Cn6nrleiWoZ2+q5HIVPtZadEi/4ysLOLJc31G+vg=;
        b=ha/IrNJ6lDGoWrbDdY3Ja8f0an4XtC1mwEbriVRhI7PNwqovhfzDdDa8L22n3US7OR
         q12uDadJe+wF8+0PP5lYOvBswdeja/x9OHuKenLKDFWm2+2+LFnfGD9QDmlI07nuD0B5
         9oHfz9eygfzwU+bW2EKaqvq/6V/COnZjEBbIuH9XPc4kZDr8lCaiqBCwkZRlsV2YissA
         1vE3VQ4eTEAEtlZOdxLFtnfnM2KjjKXOweQTCFXSFU83sthcAyrDPCG3RIKRdov9/Ek3
         QM+HQDxwC9rHL2NaaXKKgLOMmpd967D/2xJv11z8nn3v4wDtutc82qvSL92IkcLdZFpn
         lhqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEdSTvFRjknPE2pZZf+BM1LrqSSGCSrBALbgI63ioaaQioW462WUNOYtY94PN38e3YVDIme34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSjQ5ir2+2XsQFV3O3I/z6inFCZg8IYqTg4kjI/5regacDcV02
	jNPWyFQox7g/01u2UbRYb6mmigetPzvp83h1kBG3DdtMK0OFiKLnq27jgNn3lXHsOthc7M4iNWO
	M/WAJN43cS5y/J2SKzb9EwE31SENm9fE=
X-Gm-Gg: ATEYQzxS8T78ykBs9A86uFT1Vpw0MSblKLGNJRC0lV2EQt+1MgMa7GdvuS5x77kFwF7
	kidxGvQbzlQY3TzzUGiOHb2fccq5K8s6Mzy1ii5gBhvGqfXC5Nu8/ZyPeZDItouLkRDbMBGfmZ8
	WAFo8gNscRXFohTF2U3fj1lX8lb7NeQjNlTF4UMwkkmpuXGHytATQutXGA0bKYI64LpYitNzq+L
	hB7qZeWeq83IYhdsOEgFcyxAhpoJPwYfUkrziRBwZOJh/E5AGa1B2uuRLYS7cmbIk3n2dNHvHLl
	EV0C8np3pUiD2UIKORxYXp5AtrKypgh5Yve70PFXF4HTpblPs+JJtmnIqhoyNV0MwTXdf9vA
X-Received: by 2002:a05:690c:650e:b0:797:dd13:c34 with SMTP id
 00721157ae682-798dd79681fmr108573507b3.60.1773054459910; Mon, 09 Mar 2026
 04:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309093614.502094-1-kartikey406@gmail.com>
 <CANn89i+pYiuKdtqU-kBvD2e8BaDfYzAtzLZJ88SgSD_D9CDL+Q@mail.gmail.com>
 <CANn89iL9-MyJ2fmtWRXTYG_56wEjK+ptOpYRjtRJjKtw3xv+2w@mail.gmail.com>
 <CADhLXY767VTS0ac0UBhCrzKnh=GPkMXM3yrEbiS7ETcfHzfo8A@mail.gmail.com> <CANn89iL_-FMpLET0qWz9ASa6M5E3EYbfpkQnM2tREV7Vru7Vqg@mail.gmail.com>
In-Reply-To: <CANn89iL_-FMpLET0qWz9ASa6M5E3EYbfpkQnM2tREV7Vru7Vqg@mail.gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 9 Mar 2026 16:37:28 +0530
X-Gm-Features: AaiRm53F-aQ99tKzL8gmDRGsbuHLweyVd4dVOv3NhV5bxXIDRYZUKHSyj0BKsAs
Message-ID: <CADhLXY4VVWO6eohDFfwJ=RAkcC4-hrX9WTdFmQHuJ7g7-JoVMw@mail.gmail.com>
Subject: Re: [PATCH] atm: lec: fix use-after-free in sock_def_readable()
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kees@kernel.org, mingo@kernel.org, tglx@kernel.org, jiayuan.chen@shopee.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 37645237AA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265479-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.944];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,f50072212ab792c86925];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 4:32=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>

> This would be good, make sure lec_atm_close() is allowed to sleep.
>
> If this is vcc_destroy_socket(), maybe sk_receive_queue purging
> already happens there.



Thank you for the suggestion Eric.


I will send a v2 patch based on these findings.

Deepanshu Kartikey

