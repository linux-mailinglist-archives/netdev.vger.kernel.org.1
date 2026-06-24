Return-Path: <netdev+bounces-301704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SzN+CAP8O2oDhggAu9opvQ
	(envelope-from <netdev+bounces-301704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:47:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4558F6BFC45
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:47:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kcxXEc95;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301704-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301704-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C9FC3011BD9
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88903C8716;
	Wed, 24 Jun 2026 15:47:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055453CC7EA
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:47:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316026; cv=pass; b=Pyvqdob8QuOzLb2ZtJVEmbuGrN+PVRWN7f2ROuzUOw6ydDR10hqPHYw1Gi5XaW38tL9N3cZ52KDsC1Wy/7eHlQXANiS0HyI6suGHUOK5W5qzODf+BuhV2M3dWRLVPq9qvm4cSVrpYYBFq1FJc8n3c82/NwrQ4MISPouc1YNHIZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316026; c=relaxed/simple;
	bh=znUxrD+rX+i/jcgUUcYUF+WyNVpxg3869R1rpe5nPjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDf37FmKDb/MMXmtA3V4VhdqRZUkIdA1J02At1P5zDGlUpgW6hbWpn1eqHpsNjIdURfKqt5XQRv+XYfA0sGAOEIPXzIOP3RIKZM6LOYrWys7jynXdsD1SDEFq6ruRu0PgdzYhVrhkqup94BwLBYGaEveA9Pu6RcbWw71okr8YsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcxXEc95; arc=pass smtp.client-ip=209.85.215.171
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c891d27b10eso714355a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 08:47:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782316022; cv=none;
        d=google.com; s=arc-20240605;
        b=PgzbCgjZKACf3bnBrEUBMkuPUKAqq1rLk/mc2xJAI5SAjioMSTTuJEUtkhsad5Kc6k
         uAQv5oQcDnsIsBXTnJ/Alq/WMhZXXazkE6wne51haL7BHzzeiMHO7DunZfaQ95KNOnqi
         t4jaNrw6Q3zGTFIXKtJ9DxDjRxtAIMKZdp2UVZ6UlXzMGTV0HTSUblesvT3DizseJVb8
         daGaTZJjH8ibXDUp5E62/4RNrR8f4qsmXn8vWi1BJzTDaGQ4ZNWEhL/Iy0XWWOEiCm2j
         d8JBie9vrwpSVWk2zVdYRrOIkmYCuBccaLsf6JQ1vjvzq+QqguPXutDTjVGqbxpO/39Z
         lRGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8d/r44UUrv5OQGX8QnhBsaeNXrdn7O0arE90X+fL80s=;
        fh=OBHI+JIEoV86mph6Ys87VZX8lDkkUod3CbQAPyhuOLI=;
        b=DH27zRXEbCNdI87/tQf5LF9CwjhyRn5ds6UXcylxiK6szJaPIiYq2pfT7hne6wv7ZL
         fjYv5riOjFCpWxJk7EiZ4ASSnTyV/aP/7wREFc0OmyxiXV07PZb0r2k8/XEkb73w++oi
         8jd0sr7Owb12b9tOnzWFOruDlVO78mnaGUzHDmSnN3eCEtjNY77ps1R7lBRwN0W527vd
         aufJAyBCaCE+BNZyDfT7GROYa/5LVwTRfrmD/qKFpMYVGEdrm0qgJeQVZyt61Jiz5Qr3
         d6lO2EljkucaQCtSfzO2+UKtpzdvJvqM3XRhPq9siGaPFLCAoLnDXTwclE/LxaAVPj59
         orQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782316022; x=1782920822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8d/r44UUrv5OQGX8QnhBsaeNXrdn7O0arE90X+fL80s=;
        b=kcxXEc95NLLp8KsrKMWU+POlguXr6cFInNmY5G6UforbDFASoqOPb7/FxnWMR0frJy
         sRNgzOMPPWQyx1SlApBJ7cmBRFm4/EzvlNsp+/yX7Z6T32Z871Z5SfqOCxQTDcx5ByAp
         f+tIweHGmU6jJX3Wae40z5nQ3UXZWr8gHb1MpEwv4baTcIn6ZnXCw0FEZHAY1HFxGS86
         8OsGcph5SjswZuk2rGOPNeFpRhYtXbDu5s3bjdY6H4gFh/72fJf376iTVLbZjkaY4Fao
         8em1wB4GCanZunELRts6lOLyas5Vofkdiir51eNMomkCBijE1YX22wZEbrlsGPcoyQdM
         19Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782316022; x=1782920822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8d/r44UUrv5OQGX8QnhBsaeNXrdn7O0arE90X+fL80s=;
        b=sIunRFZ0DNtFyU2yR3R2ky90cu3noTFlDtqNS8dGn73/8dOstFSwjuwg95YkQjP+oD
         mSx4sUrcBPk4KVyat+GKopGlrI2FtWpXHd2tI3y/GsB4ze+RYqaVGH/gpnO9v6Brjpl8
         Wae9r86yqO/jkMIjQM7gS4RqoEJoj7N7t4pnqPafHPMDcqiLyRzOzs6gMwZAZHjYiEkE
         hmCGn9078KovLUQDVne/iNso37FrkWB5NiB/XUrmqAa7R4vohXCHT65ac8u764QrFPfR
         hkHC3OR7owSTmZmpUuxf9s7FxzRymiFT4mmZmT7TkkMIwgMO6PC/5NDwC6XTZbE8Ty/9
         Oauw==
X-Gm-Message-State: AOJu0YyjgivROP2yQO1zrjp0bzSzWN9moIrzQwbWJSE9653tpw1gu2M6
	pYz6KZV9cHojtMDBDN8pCDb4jdFHzU753SSYOnpCeYN4RtDFEvsM+VqYqRf4eNJ5tBpOy5LBm1y
	v4Pvh73E1e5xq3gEd5Pk0KXNm5lUx+r3JLyoQ
X-Gm-Gg: AfdE7ck5vkb+fro2L/N2wwqolFUXZoIUge5NVPd/pbqzeZBjvVW4juP3HAy7M/qVYw1
	WupsmGD07VkarmlbigPXYOsc7l8EK8ODTEWnUxaMCaAr7pcEoSJpdVjtYvlS6GAkhYR8+zRH2F6
	jpFo5w0FO/Yh2H+J2WzNRDuKk/uSz0opLcPR80i/2I5PdfKMkACXC/AO09TFSJmzi+gVZKYewMH
	QGbQRWvBowDT8bwrpUJNbIxY1E95SqBCRGfa782d1q2jwxUTgYCPIIWaDJlme9ie/4rcKeVAxaN
	0BHXwPf9P9Xf1sQ6Mo73DcsnzBb/NyFPHhgiPifnVhyqE87S/qeZ+MsYauGrw9ZMfOnjNVT8MB8
	ilcTD
X-Received: by 2002:a05:6a00:e88:b0:842:459b:d61b with SMTP id
 d2e1a72fcca58-845a2794eb8mr5393941b3a.32.1782316021875; Wed, 24 Jun 2026
 08:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781968162.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1781968162.git.lucien.xin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 24 Jun 2026 11:46:49 -0400
X-Gm-Features: AVVi8Cc8PzO46k6yEZ6LLOuvoH5XLopWZO-tuRx__W0v_vZgFLXs5tHhAMxdpIk
Message-ID: <CADvbK_e7806edOZ7xxV-JBdK4hTeFUPwf4=Vt7k=OZF7PWauEA@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] sctp: validate INIT in COOKIE-ECHO when auth disabled
To: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301704-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4558F6BFC45

On Sat, Jun 20, 2026 at 11:10=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> This series fixes a security gap in SCTP's COOKIE-ECHO handling when
> cookie authentication is disabled.
>
> Currently, INIT chunks embedded in cookies are not re-verified after
> unpacking, creating a vulnerability when cookie_auth_enable=3D0. This
> series first refactors error handling, then adds the missing validation.
>
> Changes in v2: see individual patch changelogs for details.
>
> Xin Long (2):
>   sctp: factor out INIT verification failure handling
>   sctp: add INIT verification after cookie unpacking
>
I will drop Patch 1/2, and call sctp_sf_pdiscard() for err path in Patch
2/2 on v3, as it makes more sense to discard the packet if embedded INIT
chunk validation fails, consistent with malformed cookie handling.

>  net/sctp/sm_make_chunk.c |   3 +-
>  net/sctp/sm_statefuns.c  | 220 ++++++++++++++++++++-------------------
>  2 files changed, 117 insertions(+), 106 deletions(-)
>
> --
> 2.47.1
>

