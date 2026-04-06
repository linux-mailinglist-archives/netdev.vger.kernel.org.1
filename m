Return-Path: <netdev+bounces-275590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHmnFOSz02kdkgcAu9opvQ
	(envelope-from <netdev+bounces-275590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:23:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6586F3A385F
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2F773005318
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE00C2F531B;
	Mon,  6 Apr 2026 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="ZqR2baLN"
X-Original-To: netdev@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8366D371D1A
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775481787; cv=none; b=PPBqJmLYglhf844n5PowSwC9RBIC8q4KFc2dVrF3DbyjmAYVzDk0asUSPJaFFhtRlzswTe7BoNWCIYcnJK4OpAPMrndP9Jzs8EFh8SelOxJ7dTOz/HvDpCXp9960kaa6m1rKnf1c6bkiVa7Ui7SWsKNaYHYG56j4s/XGPf0qOTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775481787; c=relaxed/simple;
	bh=eIysREziS+Z6ZktwVPCra+zstcqqIw9PDpiZoFiwJAk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=V7xQLWfddHk9gHtefn2H+SB9dRbKD5mKQj7r2KLkOOG47Lovtem8A6PKr9FP/dy78dQT2rXVqx7EdyZS/nAonzcLUAJXR2Otkbm2HVZkDaKGw3IWD6wRebsyvXGfmLIgFedILhRezm4BWzp/y9L5MpcY+PQzniqUseFCuK7S30E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=ZqR2baLN; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 50AD2240028
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 15:23:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1775481783; bh=7aSDB0rCj3VJPTXpV1SoJgYv3fvkoU7OgVQ37kGBo/Q=;
	h=Content-Type:Mime-Version:Subject:From:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:To:From;
	b=ZqR2baLNzQ+SKhUQLBzOxMbt7D5GWFkvk8JiKvXdqDlZ28ZuG3fv4Knzz30KKaBfB
	 K86FGWIewAXnd7hKuaGT3IFr/Qo65dpUjq824bG9em8RNx9rFiU0HixirPZcm5vSUQ
	 CoEgGFOUPxMkcAlR5tuVkUl2nHqpDXOzus5F5TVEz3p8oNywnA9r7i8j8P1ZvdObRV
	 4obhGT+RDzQjQEcRX0mJ9Qg2YPvQkaYYw1bq135+eFywwsKOpkpc/s8elAN5exlM1N
	 zQqgUsxyzljHhS0wJ8f+xgNx+tHpQns3JXYpv8jUfT4Q6GsUY9Xdr0L8wSNjsKZF8T
	 6J/FoTMKEhIWA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fq94L1QL7z9rxB;
	Mon,  6 Apr 2026 15:22:57 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] net: sfp: add quirks for GPON ONT SFP sticks
From: John Pavlick <jspavlick@posteo.net>
In-Reply-To: <adOri4VEQl8ezm24@makrotopia.org>
Date: Mon, 06 Apr 2026 13:23:02 +0000
Cc: linux@armlinux.org.uk,
 andrew@lunn.ch,
 hkallweit1@gmail.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A72A9AFE-1424-436B-A019-2D7EFC496847@posteo.net>
References: <20260406114352.69168-1-jspavlick@posteo.net>
 <adOri4VEQl8ezm24@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=2017];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[posteo.net:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-275590-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jspavlick@posteo.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,posteo.net:dkim,posteo.net:mid]
X-Rspamd-Queue-Id: 6586F3A385F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  Thank you for the review.

  You are correct that the commit message was inaccurate =E2=80=94 the =
Banana Pi R3 / MT7986 SerDes is not fixed at 2500base-X and does support =
1000base-X and SGMII as well. I apologize for the
  misleading description. I will send a v3 with a corrected commit =
message.

  Regarding the concern about breaking 1G support on boards that do not =
support 2500base-X: sfp_quirk_2500basex only adds 2500base-X to the =
module's advertised capabilities via
  linkmode_set_bit =E2=80=94 it does not remove the 1000BASE-LX =
capability reported by the EEPROM. The kernel should still be able to =
negotiate 1G on boards that do not support 2500base-X. That
  said, I do not have access to older MikroTik QCA9xxx-based hardware to =
test this, so I welcome any additional guidance.

> On 6 Apr 2026, at 14:48, Daniel Golle <daniel@makrotopia.org> wrote:
>=20
> On Mon, Apr 06, 2026 at 11:44:05AM +0000, John Pavlick wrote:
>> Several GPON ONT SFP sticks based on Realtek RTL960x report
>> 1000BASE-LX at 1300MBd in their EEPROM but can operate at 2500base-X.
>> On hosts with serdes fixed at 2.5Gbase-X (e.g. Banana Pi R3 / =
MT7986),
>> the kernel rejects them with 'no common interface modes'.
>=20
> While the quirks themselves may be correct, the statement above is =
wrong.
> The BananaPi R3 (and all MediaTek router SoCs) *do* support also
> 1000Base-X and SGMII, the SerDes is *not* "fixed at 2.5GBase-X". This
> can easily be verified by plugging a random 1Gbps SFP module into the
> board (eg. ubiquitous copper modules based on Marvell 88E1111 PHY).
>=20
> Also you have to make sure to not break support for those modules on
> boards which do not support 2500Base-X and need the module to operate
> at 1000Base-X (eg. older MikroTik QCA9xxx-based MIPS boards).


