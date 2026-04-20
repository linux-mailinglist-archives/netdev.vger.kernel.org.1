Return-Path: <netdev+bounces-279828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ3mOntS5mkDuwEAu9opvQ
	(envelope-from <netdev+bounces-279828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:21:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2A342F580
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8FE530862A9
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6129E3D6697;
	Mon, 20 Apr 2026 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6gO40bB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070A93D16E4
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692347; cv=pass; b=OjMwy9MTbQ2MhqHGzTgCwyEKRwFpgEg28sBU1l+g7SbRGFqOHAcPMsZyqQ7qYyQNYEUEHcDP6JAtbo92krXP5jtvsmKq5wXgXWz2uECSKdSJE6cbSYRSZ2o12/rvJd+ca2T7J3HDeXLQ+/QWOx6N+CPxnOlN44MglmXGEe/WUo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692347; c=relaxed/simple;
	bh=/K9UOf5uqT2sQnqLd2oKoclnHJwSG4aPabyxOCos+4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HT2AJRlX9TMJ0KQOU6HuadmvM4pRPaHPxvYEalAIsyPH0iEcX2NufUPT9+kE+8mbz9szAJ4w8fOdCsIulOQhRevgOhVgESYiC3iqiGNvqXCYdP0MKLGjB/yaqd2bu8zy+/VpoNEC1Lbe+jfNr31gWSD3nlE9GbPIDtrsRCwKrks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6gO40bB; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38e7d984096so32529251fa.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 06:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776692344; cv=none;
        d=google.com; s=arc-20240605;
        b=GE7+mtEtiHb7svVY1soRjO0IhIlCCJvh5nLVKeP5TNgdNdf0NxwNcikd8NeZr50lyD
         /nQbiL7FitvlHpf+C0FbF/Z3QwR+nldFsNnMNBFDnIBvIMasPfJ+5NCxoUxsN7yck8Gd
         sYYVVivvHlPh4LxhrmYRoo4lzKG1TVVn3JJpHwTaNWaMS1Lq95SbbEDUUXRb8Z25FCQR
         9nXL8HPGV0H6696tIjTvtnB4MDW4E/br2HdARkJ9mHOLaiDWmCd+PFY3sXGw04glyYL3
         CW17F3QGYJ+5L9FKOc/J7ej85NVcDgQQJc3ebb/6QZz7u6ajXghuyZzsb4mgo/O8wQyj
         Fk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G8DASL1EiWTXednHDBiz8AtRSsNePlCWQ5TEGU5yhf0=;
        fh=dl/VDu+1D+6DrwWgRvv1G9ljrItkkNi6HVrZRrXak/w=;
        b=Xa8TLFmmV+INQKuKmwnKxkV6lkTTod5qk8VzdhPy3sJ7BEobYpfcporflpszzPeYJa
         pasTu5UjSfoUpNqag6XAhTMelAo3dWqIdHV+qXr82U4nAKbTauxxH1RVBEgMCp84vAPF
         E1AmXZ87vhiFAM5jvDd/YITXS4PcKu96PvmKbiChUYrw+8SFEeZpjRO9UmOmVoG/+0BB
         cJ337LlZv0G4eyfIHkgiYASEgKU4rBnMGCRdbXmwjv/MYuK5KRYV8E9/4k4xBcHyMIxp
         v1pZz42eUso6044bBJZehbel/EVP87vNyvB2qkJH1NKqLzTh3Y288EY01UpWK9EGwd+N
         /LxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776692344; x=1777297144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8DASL1EiWTXednHDBiz8AtRSsNePlCWQ5TEGU5yhf0=;
        b=M6gO40bB9Yu14z9hBzVzmDeUAxkuDY8H3OhMvcv9NRGIWhphybdIno5XKNstnMMVa8
         EHCGGoSsU0yyU+2PXbYGBKnG3GOq3x0D2As/UVmAgFFgnNqlBOXV3Iwn52XrwNgqhqSI
         SZWuSA9Qts5+TWU68iEjV0UeYBhoawpbiEeBgRKOEt7HUpJrBhIbBXyiP8gShJZb8MQu
         IN1TR0QVZux3Lpu5QgmECV+jun7/eW+V4fxQigKZp2kY8yWRDEjK/l+0rIoomsMrTMCa
         hdSTqI25HTs2MXAHzldpoYwy6kKEbqXyMlhVXsC4G6XhzaPZvEvvXFII3gcelDfzJhA8
         zmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776692344; x=1777297144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G8DASL1EiWTXednHDBiz8AtRSsNePlCWQ5TEGU5yhf0=;
        b=N8fgRJjp4XTvWyD2qA42YYrY5INJpv3AptCxGnSVXnIJvm5A8u/lDWBIx2R+N+EVv2
         PpeBPYurA94APevbdORbenp1VwTmKVLl8HRCRvgW5V0gvbh5tbdUnBg7gX6/n4oWizEg
         WBnRVaeUlp6j0RGZ0fiEVWElsj1CwE7kSJ/rVeJo5t6zI7v60GalhABukZYvBlV5dxSG
         9QuZw72DQrONCeymvQr31zdLcZTOM/WhqqOyIIeaeoUkHOywC+Y6AqfmXCGBGNBd2B7x
         tnes7+kPTSDPbc2s3XYmmlbHppe0SjlOunFCPI+Z48q2gR1QSes+SWZD0u8EFtlUQzRz
         4gag==
X-Forwarded-Encrypted: i=1; AFNElJ/RJ6Z21YqgYWn5A2TRR3yLySbBiwQdfL+C9hqjUv8N6bLKKfoejJjwVcm11fy2i7woLfu2xV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOBTeMhosqLbduzDsBBOhPfbKg0e+x2W3L4tY+mI8PepM4bsT1
	OVNd7iPaY3+O64BGlJvxBdsgUO+iuhZnR5GNG8hTZPvd0hXnaAQY2/9E0NDVgur4r2tkc9n/zWi
	QZ9V2Y1ho08+W2kahMKTTyQC68ze+r88=
X-Gm-Gg: AeBDietPO2ifbmJjnfZKQEg/oFYSj8VENpQ51HKmZWswJCAy+h9DGoC4jNK5JwR+/35
	IWdKv9q7NXE6XDY5VPDnrcngWtCKV9MlpZV8Hs47AOaeRJkG38NtIoHfVgqvh+E2ohjgjQpRHMU
	3MYhso8bYs3P0FxpiK95wMNGWZl2ZTbjfrPPL0Jxy490ZzJ6A6CpORSC25PwcoYPx0g6TORKtcc
	f3PUXbl2SYnQ2b5g7jpiZktBDxN2547Q6uRfM7GonojeaBrXN+L67TEj/gqPCAogJz3UqYKvwea
	5pYBVctqgyXbd6TZ
X-Received: by 2002:a05:651c:4208:b0:38e:7ed2:b63 with SMTP id
 38308e7fff4ca-38ec7acfd31mr36038541fa.22.1776692343742; Mon, 20 Apr 2026
 06:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f9e9d4e-8083-4297-91d3-10d0f614c87c@redhat.com>
 <20260408125333.38489-1-xiaoguai0992@gmail.com> <20260412135743.GK469338@kernel.org>
 <255224dc-0a55-4a0c-95f3-b84d4c6b3897@redhat.com> <20260414112951.GD469338@kernel.org>
 <CAKvcANPEa91paujTQjpW2hZhpXEhwfOjjy6CsN=OJ32iXYXdTA@mail.gmail.com> <85ec14af-bdd5-45ea-8c06-ebd769499bd1@app.fastmail.com>
In-Reply-To: <85ec14af-bdd5-45ea-8c06-ebd769499bd1@app.fastmail.com>
From: Kangzheng Gu <xiaoguai0992@gmail.com>
Date: Mon, 20 Apr 2026 21:38:50 +0800
X-Gm-Features: AQROBzBrhMAvRHsvT_Uh3_bh_6PBMT7vbMlO9R2BKmmLDZimLRkGEVK80HjiNtE
Message-ID: <CAKvcANNyS=itNKW6LBAHb+iOV7v7fNt=rsbuLug8_cgfS85Eng@mail.gmail.com>
Subject: Re: [PATCH v5] net: caif: fix stack out-of-bounds write in cfctrl_link_setup()
To: Arnd Bergmann <arnd@arndb.de>
Cc: Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, sjur.brandeland@stericsson.com, 
	Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279828-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoguai0992@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,arndb.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E2A342F580
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ok, I would like to wait. I am just researching for security.

Arnd Bergmann <arnd@arndb.de> =E4=BA=8E2026=E5=B9=B44=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=B8=80 16:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Apr 20, 2026, at 10:09, Kangzheng Gu wrote:
> > Thanks for all of your advice, I am preparing a new version of patch no=
w.
>
> If you are actively using CAIF, please chime in at
>
> https://lore.kernel.org/all/20260416182829.1440262-1-kuba@kernel.org/
>
> If you are not actually using CAIF, maybe wait a little bit before
> spending more time on it because the patches may no longer
> apply if it gets removed due to lack of users.
>
>      Arnd

