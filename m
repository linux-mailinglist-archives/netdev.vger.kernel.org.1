Return-Path: <netdev+bounces-292608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJlpLGcGGGrGaQgAu9opvQ
	(envelope-from <netdev+bounces-292608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:09:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C004F5EF421
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE8F6311F85E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6EE38F248;
	Thu, 28 May 2026 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="np1WoxzE"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A725338BF62;
	Thu, 28 May 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958595; cv=none; b=nuZm/rUdFiFgA0y/qF6izNX3EbbSYMI9E/KTgHzIvvFac08F5xAVzq96rQ/bGhjldOF8Sn3C3ppydj41HHIR+Kmy8SS/w1Sem/0dUNkhMur97S1P8LjQJNPgXLB3Zw2jNbanYSeco0ri5k+FvskgNFl9tptrON2TGyGr0UQmXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958595; c=relaxed/simple;
	bh=SmxFgDcI/v6/xkm9F3YWF305NRN4UmKkSt7RMgLzEi4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qWotGFBNM9KAo4NusO7Y8NP5DaAHdRVEFVyFe7o0EFxgyL1Gf5GODOej5zQsTc47jB8JjTFUr8n7SehAEVVWgdS3Y0EgAbs/4CHSZRifBKZGNiDeEOoNaqDwohWxhSfXeWsxoRxh14Ewrr3ia1k+78tuoK2Z73nLvcHi///Tk+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=np1WoxzE; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64S8u3rR009388
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 28 May 2026 09:56:05 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64S8u3rR009388
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779958569; bh=hXtRWVI145ytDHAHC39FCYRxSo5K5Prh7tjOgP4k3XA=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=np1WoxzEvNlLvKrxcNraWzOGPLYGeY0RAelikzs08T6b0qDgxVLnGL43e2l70Umgf
	 nmMGnE7vazIx1nPVuYegGEggAjSchGLKcY4yxfkwvDJgKN/IML1jUUUKdf9Nsccs/Q
	 ho84IYnf2+mIU+bpHpkV7KG6edDIFfPRiq4oJTGFqE+bbobJjW2uQ4APB6clwKtzW6
	 KyhVqdubee2bv/GQ+twQUS/hNqA89imFChHXM5QAQThI+ZIoYPeFyGMPkGJ3LGA/fW
	 /Cpa0bW/D8Ynnb8VdVf36MujJZb1wvEX52a3jMCn6GXX0BmBwYNpIlXfNpG53nW2G2
	 1d0pCTtpUI7KA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next v3 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <CABvLYuBGAL7zWZhs0L5eqyzVBGqr=zbA-NGs2_ELptND4LiJLA@mail.gmail.com>
Date: Thu, 28 May 2026 18:56:00 +1000
Cc: cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DD0BD62B-C3A5-41D7-A969-72B91D9555AB@padl.com>
References: <20260527-net-next-mv88e6xxx-cbs-v3-0-2f387eb5ff63@luminex.be>
 <20260527-net-next-mv88e6xxx-cbs-v3-2-2f387eb5ff63@luminex.be>
 <31F2127F-685B-4409-BF0E-21CB378B2CD6@padl.com>
 <CABvLYuBGAL7zWZhs0L5eqyzVBGqr=zbA-NGs2_ELptND4LiJLA@mail.gmail.com>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292608-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[padl.com:email,padl.com:mid,padl.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C004F5EF421
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On 28 May 2026, at 5:55=E2=80=AFpm, Cedric Jehasse =
<cedric.jehasse@gmail.com> wrote:
>=20
> On Thu, May 28, 2026 at 8:28=E2=80=AFAM Luke Howard <lukeh@padl.com> =
wrote:
>>=20
>> Hi Cedric,
>>=20
>> One further comment: the Marvell DSDT reference implementation =
(GPLv2) also sets an undocumented register on the 6352 family of =
switches to enable CBS. (This does not apply to the 6390 family.)
>>=20
>> My understanding is that you should call =
mv88e6xxx_port_qav_read(MV88E6352_PORT_QAV_CFG) and then set or unset =
MV88E6352_PORT_QAV_CFG_ENABLE accordingly.
>>=20
>> The values are given below:
>>=20
>> #define MV88E6352_PORT_QAV_CFG                    0x08
>> #define MV88E6352_PORT_QAV_CFG_ENABLE             0x8000
>>=20
>=20
> I'm wondering if this is needed.
> I can't find this in the UMSD, which is newer than the DSDT. Why was =
this
> removed by Marvell? And the register is undocumented.

That=E2=80=99s a strong argument it is not required. I=E2=80=99ll test =
tomorrow.

Luke=

