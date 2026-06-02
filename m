Return-Path: <netdev+bounces-294138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAAxFaSyHmr7JAAAu9opvQ
	(envelope-from <netdev+bounces-294138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:38:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F1562CB99
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 911BD30AC45D
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC003D45CF;
	Tue,  2 Jun 2026 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="FtK4X+ka"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE763D5C3E
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395551; cv=none; b=bL5cNXhj1f7+ghJx+SGqim9rqorDOh8gYdeb4nTfyYqKKth6IRPMkZm3AdU3lpmIRZ6UV6JB8UiTQzeP9PejjoAagaEzT21DVKCwRZZUcETAQrbtx6o5yUad80tRU4mCczNdpSUoon6ZEJu9+rM8JwgtRnLSjEZm4680BNl4fe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395551; c=relaxed/simple;
	bh=lg/WObSpzODe2B93qAt/vOiM1n9bzfemGCwSCxoCSQQ=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=XDOQgA7yJCn9Z7hqV5VPHnzu1gq4qwyGBVJw5enq1Yo4rrlP09gg3q6UD+W5y7/1wSoqZrQpM1QBSP1qIS2ZFQZC5gSCLYwA7jOb0eI699s4WJRzXRGvm/Uioa87Ziq+NODsSTQ0AgI9/A6rt9cd7EjRDo0USaMqaklnUE+akac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=FtK4X+ka; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780395523; x=1781000323;
	i=markus.stockhausen@gmx.de;
	bh=lg/WObSpzODe2B93qAt/vOiM1n9bzfemGCwSCxoCSQQ=;
	h=X-UI-Sender-Class:From:To:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FtK4X+ka9uQxGEQTLMCSJG2tHJQBwqOOte4Wn/yHeO0iEnmTIQVCIeFoYV6HHHaI
	 pWvF7U23zUlIQlmmBX4tZ0abVyBtQUvgRBfSnvqatQL+kLMsFs9sjbwPOW35MpQLy
	 SBMRwQ2cosFSwvZe442YWh+wnP890VdFfNxlZMW0kaWH68TeybPZ4x03ISc+SHu6s
	 OZ0TfE7XIttu63APnNRD0BzJdNBOn49+bkhz5eMlzUoez7vh44LtU8yE6N0tAOdqH
	 OQ7EpIoxa5iBWXsCQp9dZursNNnGR9fhLm0SO3IRFJHSGQ7pc2ZsOWPLSSJVKDa6J
	 e5q88rS7H0tclYWPOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXQF-1wke2P3QKV-00YAwp; Tue, 02
 Jun 2026 12:18:42 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Jagielski, Jedrzej'" <jedrzej.jagielski@intel.com>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	<mensi@mensi.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de> <20260602052640.93083-6-markus.stockhausen@gmx.de> <PH0PR11MB5902B7C4C07107C3288500ABF0122@PH0PR11MB5902.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5902B7C4C07107C3288500ABF0122@PH0PR11MB5902.namprd11.prod.outlook.com>
Subject: AW: [PATCH net-next 5/8] net: mdio: realtek-rtl9300: adapt spaces for defines
Date: Tue, 2 Jun 2026 12:18:37 +0200
Message-ID: <00f301dcf279$303e5bf0$90bb13d0$@gmx.de>
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
Thread-Index: AQCd5JwkUMOmloq9EQ3T8rs5/ndXAgJvpEddAf74Ll24hbM0cA==
Content-Language: de
X-Provags-ID: V03:K1:B+8FOnmCQ0rurFjHxp+NFvVa9SrP2Y9yRaoLYDqXTsIauY6ngeh
 byoZ89UZJv8L93w41elzxRT7Z5y9sPTGdTQA2kT+j6mqMz1VojJr0rKGi1Ynwj+IBFfTGJy
 Xs9JHu+7Hknj6gayZmNVr/Vhlntegi2e3LNyzlGALQUl9Jtg/yV3rcNBkCE/pyPPf15CCfQ
 bEJVYAwKKeqOfhZOPl/Lw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X5hJilUn62g=;jIBFtA6+tZeoWCpVSFw08532y72
 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
X-Rspamd-Queue-Id: B0F1562CB99
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[intel.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-294138-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,gmx.de:mid,gmx.de:dkim,gmx.de:email]
X-Rspamd-Action: no action

> Von: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>=20
> Gesendet: Dienstag, 2. Juni 2026 11:43
> Betreff: RE: [PATCH net-next 5/8] net: mdio: realtek-rtl9300: adapt spac=
es
for defines
>=20
> From: Markus Stockhausen <markus.stockhausen@gmx.de>=20
> Sent: Tuesday, June 2, 2026 7:27 AM
>=20
> >Register and fields will get longer prefixes in the future.
>
> I don't get the reason for touching it again in the future;
> cannot it be renamed with adding prefix right now?

All remaining field defines will get an RTL9300 prefix. As there
are some inconsistencies regarding the spacing (tabs on the top,
spaces on the bottom) I gave it a separate commit. If it is
accepted I will make ths a combined "Change defines prefixes=20
and spacing" commit.

Markus




