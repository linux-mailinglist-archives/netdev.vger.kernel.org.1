Return-Path: <netdev+bounces-282573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFfvGt6s8mn/tQEAu9opvQ
	(envelope-from <netdev+bounces-282573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:14:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 604F049BF4F
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 094D9300609E
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D31242D84;
	Thu, 30 Apr 2026 01:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/PNwpQ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E6F42050
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777511640; cv=pass; b=ZRotZebFNt6DIQMSJcOXwlGFy21482bGFjdz9z1XjyW8WJkyFX5HvVx9LOHtgfmkGhbRyWg6odKxVI5LiZ2lK+JXWmvukvqUH5febUbkCWO4+EmWmUgqygGzRMpg9LDmRTsR3AIah2n24gPwP/ZKMV2nQUiq3eWAgkORDOA6UUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777511640; c=relaxed/simple;
	bh=tqaDce29jr/G7DRTAEhFxC4N7p1PmHs0sEj/V7P6OGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4oXnJxN/SpkBscvx7HUaJL7QHBfPidniM97nMr3fStl0L8BW1KitgKmVlfPzJz6Pyajd/i6fDH1SxiBjKsOvw5Evcm886cfszo7QNFxc0dMVKrWYoj0xRDR0HsDVewFwdJezpMV0KbRPSYryKrBObpjLZJO/BlWp6JXrZ9vV3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/PNwpQ5; arc=pass smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8d65f4073bfso48859185a.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 18:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777511638; cv=none;
        d=google.com; s=arc-20240605;
        b=LeCuXGghPjbFEiNZH0f6japbZ6hz14lYCpyF3sDvT13Oh7bQgS2A6pkPR6iSIQpUXi
         iQjohnqeVyJ1JJcGC1GbsH3zFi2bBYjyqaLyaBQFb1CweBxYGzV3EYXy3Qhcsw4PT3J+
         CIXfTlf+l9Pn0EpOzI0zvpXmXsm536fJu28j2XYsDcrj44DG9jPPN+Vrm2GMEBT473ZF
         9rqgRQ7YsZhDSFX8B7CgFOnrDRGXzTS5KPUQBWXE9O6J0hkQv9y/2vaOPWxPHqVLBctQ
         XtowEBnRXdev0UE/uK1p1K3uL4865CjAYENCNjkdzfTanF9JV9z86wCUVXvI7idwtMW8
         mQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SHnfzzOQ26BJPTjQzYNGFTmRJ+Hsl70GArsyqS+Zp1U=;
        fh=vAlDPZgThCC6etRTHHhmGYq1pRJwYWxyKtIdxCdY4B8=;
        b=d9OTc50evoITAASx/8IMMvrqMlfOaklAZU8HqOGI3DKNHGG48ZXMVgu9jbmPJrEQTS
         OoeC9v/JiwwmdksqxaGJ4tPEnnF/fU/rnXPnjGOQlylCVgLrcMAUfaLJHyTJe1ynXtHQ
         +/wTX/N5wpe/a+iN1CPsz2Wx0KsBFtdgf5Vsn7TtPXTE9DJy0nOwuQ3GRN2Uh6NLtaT4
         WLtXQXWxbRBmdoM0fyuyhIiuNaEIqh4g1saNDgruZcftyD5otHpjip+EvNCEfis+GPDw
         6Hfck+0IMbV42W0nHGLDXVU7XKGm9WEollKQfKlmjy20m9GToVYiqnyjeHY/O73oHUW8
         crqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777511638; x=1778116438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHnfzzOQ26BJPTjQzYNGFTmRJ+Hsl70GArsyqS+Zp1U=;
        b=O/PNwpQ5zrqHYinmxLZo6hYQ+Gt71tWCyga2F/pWkU/AKr/XVW9OXFyJwhcLhd7joG
         Q6pPyM2J9pl4SyWpa2an2h6aciEpTdg1fBvfdGrrJ+iozenF3jHnjk0zyZi1qyFkiq5O
         zuwxv13fwWgp4QIsGuarCy/BXgldahpj0F2ccjwnVg7i9RD6P8Dgsv7pn/AlMcPCpisW
         dz6buLQIUXtMpGkIBWaiXywyQtX5Z7qTuCBnnbhR6z5EUubyBvEM8Z5fSowY+a1jjCYM
         7hhNwLu8AO/oAKivm8k4p+gEkEW2xbB54FrgQX+Mu9TTtVk04orNOUxLSlwYB2p+YffH
         epbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777511638; x=1778116438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SHnfzzOQ26BJPTjQzYNGFTmRJ+Hsl70GArsyqS+Zp1U=;
        b=d+nk7Qrwbubkp3biHi51SYy61QzRr0b3HCMqhspbDHrSQkekbb9g5QVJA/pebMTmFx
         iZmjA1LyqCLYd9QyppI6Mjg+UaQ7in9YA3LZuWcTIfxF1ESmJVERBRQSMs2HUglrSaoL
         cXkba4Or0MZnNLtLtOxxjGEx4XkTTXZucV7Y9aWo5oVyChyywE8RhYVL42V1s8Qpy/1B
         qN8v42G81cGNMsj7kjmqv6Uc7Mx3aedu8Z59Zy9jwyWJmP/UdUqZgIWv/lElArpg7AN3
         iWYpI1o5McaB7iow01+aBL9X1gXAeMqIpGOdwqxB33AnmG/RSw4tjDa/idNHrBdQXo0I
         tp2A==
X-Gm-Message-State: AOJu0YwGEZXwdG/6IuevL5nA4W8dPjLoPPan6865B8gqKcXGfXTojy0S
	PxbqoGNrrgPvzye4n2JAm7c29ZycWsuwhySGlKCceccJZrJPzbAaM2ZwoKW7Tz0IoBYK5B4UVf4
	DE+Ks5/trJ2iC8D7OYffneFnVflPtc0IIJeEDM9o=
X-Gm-Gg: AeBDiesheEv1o4Ar6XjWerZwOk7HaCUgGHS+Xyfd078MInV56pQri/keDL5R8Z4ahUC
	t4p2AIluJbmYPn6jq6U7WDwqrPYxwxLgRDKaHf7nVpNR/zs5SfuoaUXoD2Mnvt/IQ0e5dfFezXO
	EhbZIU4bzTQZBIMPAisopVXiNwztnaE2SrI4XU/fcUg8zw8KzfgwsiGghHd9499VPdavqzTJ1yI
	esDiBmzGtFv5kuj8b2POOVRIRXo8jt3Slm+SW+IlBHYk7LarKs9riNs4AzeegEfIeambrkIKRgR
	Ftl19Wz7PadQhbaocsYk4kJStQTeTX1VqLSZtBD8PFAFP6RukObF8hUWj/fsJcSzh7Aqk/QlCXq
	Urd4=
X-Received: by 2002:a05:620a:1786:b0:8ed:e1d4:1644 with SMTP id
 af79cd13be357-8fa863df4bcmr184203285a.3.1777511638380; Wed, 29 Apr 2026
 18:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428030826.47509-1-enelsonmoore@gmail.com> <20260429175421.014bb28f@kernel.org>
In-Reply-To: <20260429175421.014bb28f@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Wed, 29 Apr 2026 18:13:46 -0700
X-Gm-Features: AVHnY4J1jUYA03pvf-5_5V3JNJphmuZu7BwnIMTt_nc9cAvdILco119uAEfpHjU
Message-ID: <CADkSEUiRwto-14zkER30WJdiQa2b+OGOZ+2S50pq4doJ37X70Q@mail.gmail.com>
Subject: Re: [PATCH v2] net: ethernet: rnpgbe: mark nonfunctional incomplete
 driver as BROKEN
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Yibo Dong <dong100@mucse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, MD Danish Anwar <danishanwar@ti.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 604F049BF4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282573-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]

On Wed, Apr 29, 2026 at 5:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> I'm having second thoughts about this. I'm worried users will come to
> expect that drivers are marked as BROKEN until such time that they
> can be considered a sufficiently complete replacement for an OOT /
> vendor driver. This will be highly subjective.

Hi, Jakub,

I understand your concern, but there is precedent for doing this when
the driver doesn't work at all.

The ntsync driver was marked as broken in commit f5b335dc025c ("misc:
ntsync: mark driver as "broken" to prevent from building") until it
was fully merged. The BROKEN dependency was then removed in commit
c301e1fefc2d ("ntsync: No longer depend on BROKEN.")

If it were my decision, I would remove BROKEN from this driver once it
supports a stable network connection, and perhaps also once it
survives suspends and resumes, since that is expected in modern
desktop use cases. I think that is a fairly objective reading of the
word BROKEN.

It might also be a good idea to agree on expected uses of
CONFIG_BROKEN and document them in init/Kconfig.
Currently it says:
  This option allows you to choose whether you want to try to
  compile (and fix) old drivers that haven't been updated to
  new infrastructure.
which does not fully encompass what it is used for.

Ethan

