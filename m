Return-Path: <netdev+bounces-286766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BIVEq4UAmrangEAu9opvQ
	(envelope-from <netdev+bounces-286766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:41:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A56EB513A2F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8E6830531F2
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7E44534A8;
	Mon, 11 May 2026 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc4Hyq64"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A04508FF
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520944; cv=pass; b=gAhVKP6rX5L02w4AqIgdCBqZSi8T8zIQNA3WHLBDwqrYMY/TZ4AxxKE42V/t6Mr+VJqj1Fjrld0sDmCmjd4XO+pNwieEhvCO3klPUg5WPKv1ltH6SPqFkl3fBq+YC3GvwGVb+u3oLaQYkqb3Ji53zjuSynOh1rTKco+0CK5/KOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520944; c=relaxed/simple;
	bh=PrHitHZsoYkpOMvbmxI3GoouXwZw7Mpx8RnnPHK+sF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exY8IG9+Y/5UfBVUcGV9zuua9qVcQ74b35an3F+nBIK9XATpu5Pg+7wqJJ4gR2q0Uh/NrW3L3Y+fiZjp7am1eCc8IHLKQzZOuv5ee9kGtYyZUpyZIrGFYQVWmqaWCivEyvsjtGgPHOOgdoOXdIciQA/XwLl3cFmgiTjFoFXd8/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc4Hyq64; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65c21049dafso4177854d50.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 10:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778520942; cv=none;
        d=google.com; s=arc-20240605;
        b=WAgvgLT5UT5Gmck5cWblqc+EQcB8nKIaWOQJIo9IDYWsI9x7ZtkHT3e6Tt815BdaEU
         cD2PalsBnrgTamY2lUGJc0+rk9UdaO+LWaeJgINk6ZJCS4gY9kqK6TsruuFTwEBwbfhb
         UkxCCX2/d6cdqrG4uHcIlMmVErz9KT7tm+RypxIK6zZr+lSHXxU0LI8LY7NJojRA5kCi
         gpMiM1cr3D7okWCiQX4OPeX5bBhQhuifOpGy3UwVlqxeu1cguzYd1gAxenfi1tk9IT93
         nAlFzoh4CpCc19e9LCaXHKrXdfr7gp7ng8IV27dV/gExSGWtK58ubhe3pJPH+TRz9oM4
         Ns1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dlz/dzPv3rXYhFqA+0mmgm8FDTZKSNmwOlN+ACRup7M=;
        fh=C3a3FArx9bqvc/hEL5BTPeytxx5oYtfCY9+ajks/kTM=;
        b=XfMu2au8a3sH8EIxidncl/+mpOosVqULxrNdG5T0XC1l/+hl8gjyKN+cfPj9zrrFlb
         s0LFD9txfom52eH4gC6fO5YE6AIoGJpqZ5OWMn6FZfj8k+OvPdRd57zIWMbKlI4+mwrZ
         YFlcrXhDko16hNROotNYRPG4bZcyyqZ3DqQ3wLbP2uLU3RQNc40DN3Zye5qeKRlT1vgR
         tpvTCAosg5LgsATp2xVspytYiVpYXTA67BEqUgqavRi1TvwqolxvAdw3ti/LS1mJiMlM
         U8oerVSlDfBnyGfgmnf/q2tzsv63oHLgAxFjepGqZdgbymREtLJfkyGx5M51VALruxvg
         Xr5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778520942; x=1779125742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlz/dzPv3rXYhFqA+0mmgm8FDTZKSNmwOlN+ACRup7M=;
        b=bc4Hyq6422T08nEavjrv0nDDz85pVXB3eTqJKoNwnpdT8bP8Bcl4KiEc2T32rsGCnR
         rQBiLxpofKw27UTTEer8HxQMuuFQTNtybfmTHLOUcjFC01b2futXIZnJkpAf/SxRAe5T
         4IEBJR4+6A0JQ3lmblaixA6Xavv2Su0YfU2Rxoiszu/K1wy8M1QdSJGMbIRL5xLuddKT
         olhNLsqOa2ZxCDocaVSA3GDhEbP3Axifd2YAiQnkt5xF2MReURk6aZ9vftmjn0Zt5k5k
         WnR9mEMats8f+i9zBxTrDwuT/CA4g0+RXlEeN+f5nGBaitZynX1AK+/iRbTkWQEqi6Lk
         hCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778520942; x=1779125742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dlz/dzPv3rXYhFqA+0mmgm8FDTZKSNmwOlN+ACRup7M=;
        b=a/1zxfD8VhWEGnr983QFttoaorjUUJTdO7l/vgrEkn9rEJ16+LzRpF294HyNfv96wu
         16C2DedUrl9gXqoIyhvzsn3k3L7C6tmluWi21WnVaegcATEak9lzJEbjL2DaGASEVgSc
         +O4sjJgfyTyDqRGfNbWJfNcyZaJdC/I/CJQuaRWQrpWI6EYdZndIJBZZar36xrQ4j33J
         cxoedNffqrjlZ2lUOVxFlOLU2cezJNItsph7QxukBl+O1cyU0l9CfhkOtZsf3Q6ypI3F
         WoRWpe0f6gFGBqVvGVTR1MRxZleD4P+LxtEmxWK0rPOsjEOhscKnnD1JkQPoKlHh52eU
         Bi7g==
X-Forwarded-Encrypted: i=1; AFNElJ/T5fc3DJP4pSs9CFyxQMhmYfLQga0bZHM142dLXPn6BM2jBfZJx9TlkhNQsJ/R/ONwaKS5Qxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybgogkdEBy9ERjDFxJUqDnBRN2RuDn6mzRlPgo8K4/ByWGVYnN
	bob/plQnh3qXPEGaOFDrIUC2Vt7vaho4zh2Kra4O3JCELbv3Xlf0JXF3Z3DP7UhBGuOFAgv8kjI
	P9HAexcdB8lL1AFghUhJIqa1P0Z+AJXg=
X-Gm-Gg: Acq92OHl3b/zBifOFEi6OM7ueIgxgmN34cs0Dwr/m+QQ0NTs7hDIXaUpQivgF1aygwW
	hxffyKzQbXXQNU/RUUou/rIVnJrGjBTF3Cnvc82OTfiVZjo5Ntxahux5lL3ezD7ZmKCr2C5LQqD
	0zZFkMAazFtPZNlsCRTLIChlnBJYy61kIpdFHJ/luNSRJBIdKHt0nJzNGMwB0OH9mHvlqifYm/h
	MrqicPBhD8s9J4rklHYeI4P8AmygC29+OTZ0iH1OURZD6fnL8FtRtoErGxMjdi+qbBMVTJeWx5R
	u6KeG1EAIRnNdLYWhbJZVP8ABuVALMnYW7myDm5bkcI4YoBIxkzpHVLPjYz01aa2x/evZg==
X-Received: by 2002:a05:690e:120d:b0:65d:8123:25e5 with SMTP id
 956f58d0204a3-65d94afdef1mr13964872d50.7.1778520942181; Mon, 11 May 2026
 10:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778506829.git.michael.bommarito@gmail.com>
 <490e228dd02983fb1530fb114d4174148f810261.1778506829.git.michael.bommarito@gmail.com>
 <CABBYNZL-f+AzFWdhvLcxdf0oCXbgr3AXqM1W2npOPZEv0gRA6w@mail.gmail.com> <CAJJ9bXxdm6LRW-5a4a1eDyZSQjNkJ4PNF+aERHkHe9EMQFX8oA@mail.gmail.com>
In-Reply-To: <CAJJ9bXxdm6LRW-5a4a1eDyZSQjNkJ4PNF+aERHkHe9EMQFX8oA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 11 May 2026 13:35:30 -0400
X-Gm-Features: AVHnY4L-7jwHCz-ogOtNC6Z8VESGLPAPWW1nNwcsCVS7lrb7wnAJ7aIMYilRan0
Message-ID: <CABBYNZ+nyk+hZ498373bLJ0dOkDbNqP0PyoH5MWsPerHhBSfLA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: hci_sync: pin conn across hci_le_create_conn_sync
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Pauli Virtanen <pav@iki.fi>, Aaron Esau <git@aaronesau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A56EB513A2F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286766-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Michael,

On Mon, May 11, 2026 at 1:01=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Mon, May 11, 2026 at 10:53=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Id suggest we dropped the once at the end so just hci_cmd_sync_queue_co=
nn.
> >
> > > +                                       hci_cmd_sync_work_func_t func=
,
> > > +                                       struct hci_conn *conn,
> > > +                                       hci_cmd_sync_work_destroy_t d=
estroy)
> > > +{
> > > +       int err;
> > > +
> > > +       err =3D hci_cmd_sync_queue_once(hdev, func, hci_conn_get(conn=
), destroy);
> > > +       if (err)
> > > +               hci_conn_put(conn);
> > > +
> > > +       return err;
> >
> > Then we incorporate return (err =3D=3D -EEXIST) ? 0 : err; logic above,=
 so
> > I don't think any caller should require queuing multiple procedures
> > for the same conn.
>
> OK, good call.  I checked the other 10 callers for
> hci_cmd_sync_queue_once and there isn't any variation today, so that
> seems safe.
>
> Do you want me to wait another 24-48 for others to weigh in or ship v2 no=
w?

Just create a v2, anyone with comments can add them there as well.

--=20
Luiz Augusto von Dentz

