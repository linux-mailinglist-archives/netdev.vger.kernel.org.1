Return-Path: <netdev+bounces-232006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF12BFFD1B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDF23A54E5
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 08:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A58272E41;
	Thu, 23 Oct 2025 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bizartis.pl header.i=@bizartis.pl header.b="jFbgJPAz"
X-Original-To: netdev@vger.kernel.org
Received: from mail.bizartis.pl (mail.bizartis.pl [51.195.90.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C0C1D63C2
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.195.90.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207292; cv=none; b=c2CvSdL3OKSaSdb6eHupKpPkfJizWW4hV5EzR2Ahs2Z00KYXcB37Qae8z7GQM9wwX/CtrKXmC0CWX7LSlbOP3x4QwpadwJbvBLKKmnpAChf5X/zcoUGUYbhfsa87Ac7gVYkNnJBul/vzIVA4cBgfCq8BkuLyOscM1YlTgCxk7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207292; c=relaxed/simple;
	bh=V0mwJEXgEvS72123R98YXAUcemIGcSSLQKhFRqkmnxA=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=PJ1ZN3r8R24zO14R01SoijfEfVfjFeK0OVQsaYkp40IBBCSBSFdEmwvRAzP+B7kmO8RdXcrafiNRXN5DK5sNjpELpz9v2sPhSSPkUlQcZNN4PMrmDjEafRfBxW4opUCknsgUZSjNsOHdUbMwm/KHbH4Asz5RQwirJb8SYIKUO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bizartis.pl; spf=pass smtp.mailfrom=bizartis.pl; dkim=pass (2048-bit key) header.d=bizartis.pl header.i=@bizartis.pl header.b=jFbgJPAz; arc=none smtp.client-ip=51.195.90.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bizartis.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bizartis.pl
Received: by mail.bizartis.pl (Postfix, from userid 1002)
	id 90DDAA4844; Thu, 23 Oct 2025 10:05:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bizartis.pl; s=mail;
	t=1761206755; bh=V0mwJEXgEvS72123R98YXAUcemIGcSSLQKhFRqkmnxA=;
	h=Date:From:To:Subject:From;
	b=jFbgJPAzShhX+shTkZOKA9mCCA639KixYwvjP4D4SErbQQfM9yrtfQ3KfUHwdBoyn
	 3BI6HLqG/tcnJAKWAzWS+hx6Vuv8+VLuji565so2m829QJlMf6RWm1AoGJ1xnRmWQi
	 sUKEWnDB8dqSDWFCcQ7wsSaNtYvwRSBaEe9f2Dx9I3VmXKkv70SmrIkv9qZGqi8Ict
	 MClxmLYT/QzykzqBnIo0pg57fWsoXhPNoSSSh/Z86T9S0KZeuequdAOtpTYws+wcZ5
	 8/X51d7u7Qrk2ypneNAskp+/ZsI+jNsRy3FrN5vqlSRAiFnV6myZDBdc04gZvCv5mM
	 pfLJlkac2KwxQ==
Received: by mail.bizartis.pl for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 08:05:24 GMT
Message-ID: <20251023084500-0.1.p4.5sjky.0.ck1w0ef3t3@bizartis.pl>
Date: Thu, 23 Oct 2025 08:05:24 GMT
From: "Tomek Jaros" <tomek.jaros@bizartis.pl>
To: <netdev@vger.kernel.org>
Subject: =?UTF-8?Q?Przesy=C5=82ka?=
X-Mailer: mail.bizartis.pl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Szanowni Pa=C5=84stwo,

w imieniu polskiego operatora logistycznego pragn=C4=99 zaproponowa=C4=87=
 kompleksow=C4=85 obs=C5=82ug=C4=99 przesy=C5=82ek dla Pa=C5=84stwa firmy=
=2E

Niezale=C5=BCnie od tego, czy wysy=C5=82acie Pa=C5=84stwo dokumenty, prod=
ukty dla klient=C3=B3w czy materia=C5=82y dla kontrahent=C3=B3w =E2=80=93=
 zapewniamy wygodne i oszcz=C4=99dne zarz=C4=85dzanie wysy=C5=82kami przy=
 sta=C5=82ych, transparentnych kosztach.

Jeden dostawca, jedno rozwi=C4=85zanie =C5=82=C4=85cz=C4=85ce pe=C5=82n=C4=
=85 gam=C4=99 us=C5=82ug =E2=80=93 od automat=C3=B3w 24/7, przez kuriera =
standardowego, a=C5=BC po Kuriera Manager Paczek.

Czy interesuje Pa=C5=84stwa sta=C5=82a obs=C5=82uga przewozu paczek z gwa=
rancj=C4=85 sta=C5=82ych koszt=C3=B3w?


Pozdrawiam
Tomek Jaros

