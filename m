Return-Path: <netdev+bounces-289609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG7DOSLLDGrAlwUAu9opvQ
	(envelope-from <netdev+bounces-289609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:42:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2E2584CC2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41341301224B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D324E3BE155;
	Tue, 19 May 2026 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="Uyxht8u+"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0174023393E
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223250; cv=none; b=sapBVehLJrgBZmUmwZ6uoH7zua5Ba42SzMAfysDaXW6KMybGVtyzZqr4k1U+2OJUm1Qr2Y1MSgsMRohx7qgE3t/Vb5KKqgX0FCIucbAxC8LT9Lae2g7egoEs69n12/e1E5vd6d9PQDkTqEsRh8Mxz0fV7XPEVt005sTEiHU87mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223250; c=relaxed/simple;
	bh=SbbP0N9H3bBRPl/dRFrrSXnZqCC3H6I791vcEbzQ8dc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=GU50XqZPR4eUwYNHjrSr+4sv03FdbcHqNELrBt4/mGZZ/lVckkqMMhtpXvZAdgmhKaLsUF2rWjs0SufQBQl7bJ84ZFM210CuTpvnhTVLK2t5vIUXQItGatt66mmBDi/UTZFdTU0SFx4uGMRUi5JX1R1ROB3w/68S71Z4vqlD9kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Uyxht8u+; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779223247; x=1779828047;
	i=markus.stockhausen@gmx.de;
	bh=fd0SrpXXoOOlzquAy14M16W+z+KVfmurRDIERA3Hyz8=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Uyxht8u+8vKBkuqs307gih8fq2x6tOceW546bjK0f1tsdMD8+7s8/Ro5rBXf+J58
	 56V5H9eSZGEClhrdfnv41cT1/sQZhkD5sEqgAC7/JpKk2BlXAS9zo+kOT0KodOfNL
	 Z9nWbQuqrHM9KcpGKF9FDyETHv/rv6I9RdFlPf5e2AtTJN+J80ohA7FsIHyU1rT4/
	 4Q7B7xt0MFei+XwV+pyJffClkYkGoOEA58BQhO7bG+WbLsesuaQBZrhwu+ue+dhPG
	 N2ihqf5MSaqRs2L2LezQ19rwhrCE/srzB97eYKLoipKm/N/vRZJJ5XUry6jgmhluS
	 KYh4vHhaZEL0A8GSig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1wpFph09Ty-00Z9dz; Tue, 19
 May 2026 22:40:47 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de> <20260519165747.1288903-10-markus.stockhausen@gmx.de> <e4a1cd96-ff7a-49e7-add1-353a24b9aa08@lunn.ch> <021a01dce7c5$450cc2b0$cf264810$@gmx.de> <c7eee96c-02fa-4e6b-abc9-ea6ba9a46106@lunn.ch>
In-Reply-To: <c7eee96c-02fa-4e6b-abc9-ea6ba9a46106@lunn.ch>
Subject: AW: [PATCH 9/9] net: mdio: realtek-rtl9300: Link I/O functions in info structure
Date: Tue, 19 May 2026 22:40:40 +0200
Message-ID: <02a301dce7cf$c55ac8e0$50105aa0$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGwSt0WOf381P4OW8TiHCSlUsVjdQJgmcywAlNqeNoBsrpDAwGtXLTmti5n1pA=
Content-Language: de
X-Provags-ID: V03:K1:1D6ni9VXQfZQgzYNq1EVn/ppu7SPH1CMsSvqFg2ZAxy9+3khRZp
 GAYejX7OhqU2zyDlg7XDdKVYv2+qomf3BS3Yi1viQjl+UzUkmg+SL4lPuF3lJRsZwFUxjv/
 9b9eoEnIPqQBWv8VfIr7/mi12qRCHyUFzVI1IfdmrKProaSsV9OWC3oYvVUKd7P0y8pABei
 Ze6P5HKgsJsfdQcasocYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1LesNPIgLV8=;xEE47pI2JE9z8cFrZ+XNBh0ETRb
 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
 r8AuSw==
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289609-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmx.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmx.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: 4B2E2584CC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Dienstag, 19. Mai 2026 22:17
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH 9/9] net: mdio: realtek-rtl9300: Link I/O functions =
in
info structure
> ...=20
> > Patch 5 tries to explain the sharing concept:
> >=20
> > - A generic access function will always run the same way
> > - The info structure tells it where to write (registers)
> > - The indidivual access function tells it what to write (data)=20
>
> What to write is a u16. What else is there, given this is MDIO?

With what I meant all required register data to write.=20
E.g. see downstream

static int rtmd_930x_write_c45(struct mii_bus *bus, u32 pn, u32 devnum, u3=
2
regnum, u32 val)
{
	struct rtmd_command_data cmd_data =3D {
		.c45_data =3D RTMD_C45_DATA(devnum, regnum),
		.io_data =3D val,
		.port_mask_low =3D BIT(pn),
	};

	return rtmd_run_cmd(bus, RTMD_930X_CMD_WRITE_C45, &cmd_data, NULL);
}

Markus


