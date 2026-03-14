Return-Path: <netdev+bounces-267748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KgnbEop9tWlz1AAAu9opvQ
	(envelope-from <netdev+bounces-267748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:23:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA2328DA6F
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3ED7A30048D2
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE116218592;
	Sat, 14 Mar 2026 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GtC/VnuI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AFF1DED63
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773501830; cv=pass; b=lWwwMzriacBGB6/h+sPNB+4iG5zb9AiRbrFsvxqpobPmFKr8RMtmrJqZG7Qy/56LffHVLC8th4tTUEwXY8f3a+SAwTA7br+zw/fYNIXOAK0mp636W+KJgHmgnt2o1ZYtWCUh0joh7xZYV+2PIJj8mT4Z6q33jjHcU+JOiBihhmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773501830; c=relaxed/simple;
	bh=oqzGKFlZbh8vf6fcvdrUYq+x2S8siRkPvmdosGzWMNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcioBGqOI1fU1OPG2wWTSFwpjzqUBUaTg6Atm64mdKiJCJwd/IBrCR/RS/3sPJKd6oYGqE/dFnJnB/z1fwxNtzuKxwhzqtMe1FSm6pPKKV5jOcm5gcImlhvXnRNfBorQv3X3uQG12NxwXL9nhoAZeTZ9FM7ie4QMC4oKUVdgXSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=GtC/VnuI; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7987531082aso33230457b3.3
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 08:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773501828; cv=none;
        d=google.com; s=arc-20240605;
        b=cqCZ/Lfj/LLxPBYRghGOm5/AXnewGsuOynullcgOqJfwBowBzO47oZf9W5L0yV0RWc
         zsNL4E1EDC8gyRpGwoqGJe9qhbZF92NSGYdG+xdQQdbPJ7eYJWTsO1Nys96xLyTUMSC1
         1gxAEI6gTaKyhQHA0MlOO3HfMpueoVDkKhzrAhctOkNR52RyYtXX9qaJDb7eHhH/15iJ
         S7fO1v/U2OiORbmerJe3vdDwLuiiTMyAG5W1blNailKgQKTAdaX3YJ4VyPW3x5FBpvGZ
         WXHThN2/eneAC8CO/za8bsYau3AjHqvRn6G4WEKg8UH9L1fHp5uhXNoi4rNshwCm2ZZe
         tncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q800A9K7N6LOYkRj6l8QOJ4JvmeVO/efRXnzUZVYODM=;
        fh=bVmfaq8CHRxJrk/7PB2bOSLebyUe8qYNmPUt2fwGnC4=;
        b=iXEEfylomjVejcJdGiC2g5TLYi1VNB7a9ZfpTdZuWYcd0ln7FveeXqj18uH9cWYW2d
         mGPqqPL+1ncnNXDokb8NQg8KKGviMBycK39EY6zNWQOYJxpabXGbEn6cZ0ZT0YomHSQc
         TbLGfgF1EDgUUZBUsxDixzUoBzcqYD8mCGoUEnYX/lazM+4zNznd/YoWNj3ZBLjpW5Rq
         q5sS9DvFcv7ez60YqTEXGuIXJlOaw1m+R+p9p5ALsNt+Ex/bWpQ06V0ST2Dlq0sxL+UU
         phivJthmCXhGHzLFJvf18NC+6EqQlTYMbgh94c2hRGz/Dd0Olp+zNKDMWhq5moKNd4A3
         Txhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773501828; x=1774106628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q800A9K7N6LOYkRj6l8QOJ4JvmeVO/efRXnzUZVYODM=;
        b=GtC/VnuIIaNZvvzAanFIPADPjTiZnRuY5RmFkuoGzrxQHMeEkOxDsm0GBBv3lYmT0v
         wdxfQK+Wg3qogenTSUF7GUlO3WbHUH49Z00d/OZktNIE4y/YCY4/iZTR5OQR1ci2ehAM
         Ob/7UzG0bKmliuGCP5Ar7tmb5J1NRZ9/b516Y5OtRPQsal9nCmxU4B9L1dXcKIEzXNC4
         lJNPHDDPiwfXWhTtfdYkPGCWGeFe7xzopVDO/iH9FhrtZ2cyvL2OjJdqplLmMPqaN4jl
         Ocv2m2YEa23sSxq/6J5ktkxMIH/flIsvqYUi1AuVL2ZuCcMFbp7GrpnKrIuiFHW51jS6
         fVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773501828; x=1774106628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q800A9K7N6LOYkRj6l8QOJ4JvmeVO/efRXnzUZVYODM=;
        b=ESYZjZ4ly3vtHqSfabFPO16OU7jLWApWApvuJViDRtygwzEcfYEIq2lgxhPWeOZGdN
         T1FhM/fuqLzFoCv82fKDhMBPu17Po5NI9J+CjNnGrB0URysmr0JbTjyhj6pkdpqxU7Be
         hjh+Kk0oCZb7Dm1fz3UXlcmyiGFozS6NIMrdoOj0aiEAbQ7wfUcqJQP6cin939iCHcFp
         8Xirgyj1WOeGzEzpmOVjuIzUOl2bFm4pwd5SlMV9Fe9AFma9h7ey05b10EBstSBtc/aD
         6sw10hp1AAPxMcKiF7n3IkqsP/ee9ebC2qkmfvySYIatPUDJE+MkhVLQvoXPiUkemvtI
         h0jg==
X-Forwarded-Encrypted: i=1; AJvYcCVBORoPDPZ1R4AyQcgPAcQ8bKg1wT/ysEGNbOlpdBGJNcvtqGi+Iw5bcKJD4babSdLiRQ5WBVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg7Md0IvC+w/yrzx1Z/zRQnCYT1bEgCfcfQ69CpgmMHs7rLbzw
	xn3Z6bBMtQ4efmZM951DkgLxvccsyDcov1VZLI7Z7F0S6u8PX+LCVAALbiWE2nIhNP/GLYsP9mK
	rPu1KZjRtlaYxHIqlDlk9J+8aDMfOelBawx8ehHP1
X-Gm-Gg: ATEYQzwQSTVVQalC+6XOGVkXbQRfKdAAy5AgMAICf5JtkfcTg+uHNy8/9dmcfo+rR/T
	SMle+9oYm30VZqTKM3xvkXdt3rG99xJVIuUBWmOiMfjQ8i+dc8R/1VrJC3LTmuSlPtlNVL4eHgq
	nyY6cfXa8eguWOfUP4a7lZ9j+8dTxLE+9Q3rlE/YF7zoHeACC4Vt2EoukH8qxOia/Qu3gr57G62
	Lu/YZA2ycNHO3i0ZaSGVJ+TZ1+dTiO0lhJWQzNsL7C3vGJfe77huTDvp9wsC/156d354FDFCn1e
	RuiLpR67dSw0JzPmSZb9QSFVSlOeQEwr
X-Received: by 2002:a05:690c:38b:b0:79a:38a2:d8d4 with SMTP id
 00721157ae682-79a38a2e33bmr10551667b3.49.1773501828257; Sat, 14 Mar 2026
 08:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773411667.git.dcaratti@redhat.com> <20260313151113.4b405c8f@kernel.org>
 <CA+NMeC_UfwGxSH8kVsQ2GGHEWOmUjMCG9wR_czk3NYs732jC_g@mail.gmail.com>
In-Reply-To: <CA+NMeC_UfwGxSH8kVsQ2GGHEWOmUjMCG9wR_czk3NYs732jC_g@mail.gmail.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Sat, 14 Mar 2026 12:23:37 -0300
X-Gm-Features: AaiRm53lkY8eywpJRDILcutvsepRYRPY8JMLfPPhokPLN_LKJZ1cVvasyeNkbVc
Message-ID: <CA+NMeC8pNHAg2NSUqX2kNumniG8No9XK64arGGtYvimcWd_4uw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/3] netdevsim: support ETS offload
To: Jakub Kicinski <kuba@kernel.org>
Cc: Davide Caratti <dcaratti@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267748-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: 9BA2328DA6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 7:47=E2=80=AFPM Victor Nogueira <victor@mojatatu.co=
m> wrote:
>
> On Fri, Mar 13, 2026 at 7:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Fri, 13 Mar 2026 18:23:55 +0100 Davide Caratti wrote:
> > >  - patch 1 moves netdevsim tc offloads to a dedicated file
> > >  - patch 2 enables ETS offload on netdevsim
> > >  - patch 3 is a tdc test for ets offload on netdevsim
> >
> > Looks like this is failing in TC CI
> > Is it possible that the system / container doesn't have ethtool
> > installed?  Adding Victor
> >
> > I'll drop this from PW for now LMK if it's a TDC thing I'll restore
> > it once fixed.
>
> It seems to be a TDC issue [...]
> I will ping you once this is resolved

Should be safe to restore the patch now.

cheers,
Victor

