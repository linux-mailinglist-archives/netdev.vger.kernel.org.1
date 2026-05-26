Return-Path: <netdev+bounces-291544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLrmBeUxFWpRTgcAu9opvQ
	(envelope-from <netdev+bounces-291544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:38:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 167125D0E46
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD04030074CC
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 05:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A545530AAA6;
	Tue, 26 May 2026 05:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="GaEAE/Ey"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E82BD59C;
	Tue, 26 May 2026 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779773913; cv=none; b=rLIW2KnsQafsSOgLeeOFtUGfXcmQN1ZrI8cXJM5RspaKEdoVc3z1uaEuHONLVSQU20syxzkKVKMEb2TrsEbxm9CMzzzEUzSSqX7H7syFvGDAL+MuCs8Yu8PX8mxQIQwLmFPE1h/FNVOYqw9cp7I8ocu/xd/ekuQx/Y18N/dG9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779773913; c=relaxed/simple;
	bh=6T1quZ4ZpQjhr0OLtbXlNmgZ0jn9tW909CW5pRYbY7I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=h7383dw7DR35gmHKdbP0bd2uPyojCk9wqO189xYAtsZt9y22GoVh1gfD2/NyIiJg7MQ+4UDhsRqPb/u90MGuEM66ZfmSbwxcHkoam/peE7QXtz6exqybfmwXA/uFQknR2yxKCgccVW4bPHe2SNEclKqh/BIfSt2xUmM2GGL4h4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=GaEAE/Ey; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64Q5bvBJ027725
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 26 May 2026 06:38:01 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64Q5bvBJ027725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779773885; bh=6T1quZ4ZpQjhr0OLtbXlNmgZ0jn9tW909CW5pRYbY7I=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=GaEAE/EymRZhjPN6MpIEdutKeClNNm07rttGf5iESxdHwPBW8A5z2FH7Mpg/z+LyX
	 21g0ClYsuYjZiWG21m2IaewUKXwQBZNovled8vJ4v6kf2NMr1Tuz2rJY5+8+PAoDv5
	 hLUEiaMC9XJgWiuys7LDOvfwcieNPf11Ux68pmw4EuN6MbpvUEfjWeIPAXdrR5kZpL
	 A28PWeWpO/b8tTK+cON4727dH2+G8s+qOSXMTEZOL/iZoJ8n4CSJPrUSH7k250YqLT
	 06zfbZ2uBpJALdOjm8837W8xrVbZfHZ80UGzRxTO4uhznBnj/psumdv0gaTncU/HEx
	 xknMNn6y/BZQA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <C0F865AD-24CD-4EA7-B0AB-16D91914ABAD@padl.com>
Date: Tue, 26 May 2026 15:37:45 +1000
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kieran Tyrrell <kieran@sienda.com>,
        Max Hunter <max@huntershome.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DED39BA6-C627-431F-B406-2C5A19DCE2E4@padl.com>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
 <C0F865AD-24CD-4EA7-B0AB-16D91914ABAD@padl.com>
To: cedric.jehasse@luminex.be
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291544-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,sienda.com,huntershome.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,openwall.net:url]
X-Rspamd-Queue-Id: 167125D0E46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Cedric,

One followup:

I could be missing some patches from you due to netdev volume but, do =
you have a separate patch set for hardware offloaded MQPRIO?

Your example uses hw 0 (software MQPRIO) which doesn=E2=80=99t program =
the switch=E2=80=99s FPri/QPri mapping. For switches excepting the 6390 =
family, this mapping is per-chip, which means one needs to validate it =
is identical for every port on which CBS can be enabled.

Cheers,
Luke

> On 26 May 2026, at 10:32, Luke Howard <lukeh@padl.com> wrote:
>=20
> Hi Cedric,
>=20
> We sent RFC patches for mv88e6xxx support for both MQPRIO [1] and CBS =
[2] last year. (We have since made a few small changes which can be =
found in our working tree at [3].)
>=20
> We have been using these patches successfully for the past year with =
our SRP stack [4] on a custom board with a 88E6352. The CBS and MQPRIO =
patches remain unsubmitted because we also needed extend the Netlink API =
and software bridge with a flag indicating a FDB/MDB entry is managed by =
SRP.
>=20
> I would be happy to work together to harmonise our patches to avoid =
duplicated effort.
>=20
> Cheers,
> Luke
>=20
> [1] https://lists.openwall.net/netdev/2025/09/27/34
> [2] https://lists.openwall.net/netdev/2025/09/27/26
> [3] https://github.com/PADL/linux/tree/rpi-6.18.y-xebros-rmu
> [4] https://github.com/PADL/OpenSRP



