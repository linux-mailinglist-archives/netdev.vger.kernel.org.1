Return-Path: <netdev+bounces-292568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MkgCp3gF2rxTggAu9opvQ
	(envelope-from <netdev+bounces-292568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:28:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CB75ED479
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C84B73077C9F
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 06:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA883368BD;
	Thu, 28 May 2026 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="CKyn5DlS"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B05D331A6D;
	Thu, 28 May 2026 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949711; cv=none; b=gptvW8Z9ppkraxIUsPt4DDjTM4JnaZJ9+NnFRS5sFedKS/sblfVg9ZoKMd/0+Qnq5fEPOCyeMIdOj+8dGCFbnvaJ32mVW9bdlZ0zUyorbbeJ0kzWsV8jbV8KDhERjs6J8CGgu+4c30IYMy2B+XkBM1CKnJxgmF3ev75KRnY/zD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949711; c=relaxed/simple;
	bh=l2v49YmcllRcfHVL5TLGQFYdscegvWaOv8FZyDzTfB8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NQvMpCgm+7bNt2T8z62d3TvqjW1ycTYtewk20IfaZ3I2FjEpEbBhVG4GCcUq3a+WT5Vd1mLCliGNTgAKKIZz4ejCSQpMoOgkstPIZ1JAx50RlfdijQWr/rxdth+iY7qA7zb27ZKfaMuO+V2PEMQQbe60V6MApPsEBsgZJS24JE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=CKyn5DlS; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64S6RjX6016542
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 28 May 2026 07:27:48 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64S6RjX6016542
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779949671; bh=ihRuRsFu6g8bViSLMgUrlEZVaOEOh72i2B5DEottp60=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=CKyn5DlSWOyAAgTpKalRo8ntP0go5goIqo2IAbnWMRQRotJSoUlxSoc2/m5cUyHpU
	 v9m4u1E2Kd7Y6UYK1qU2+Jwue/OoJS++GjgmBuYsCgEAaR5E1xyNsQ7H1wLu62nsTI
	 x9daAtTfU8dItfu8io8RBJvjkKUUi9TeAMM4GXFOSWjPnMxzmyMM6ngg+WkFAesIU3
	 ewJlMgbwJnHKbgKwX4FRmBdV+VQ56MekiFi66L3UUF3ZssBbQnEcHUM/RhMpyf9uPB
	 0m/GzcZoGbI1uMrnajahrbcZ7eiaQ0X4nPXzFHTqH6+lTL5jfJbyd5x6eSFJaNJa0j
	 TPkw4WHR9JNsA==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v3 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260527-net-next-mv88e6xxx-cbs-v3-2-2f387eb5ff63@luminex.be>
Date: Thu, 28 May 2026 16:27:35 +1000
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Cedric Jehasse <cedric.jehasse@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <31F2127F-685B-4409-BF0E-21CB378B2CD6@padl.com>
References: <20260527-net-next-mv88e6xxx-cbs-v3-0-2f387eb5ff63@luminex.be>
 <20260527-net-next-mv88e6xxx-cbs-v3-2-2f387eb5ff63@luminex.be>
To: cedric.jehasse@luminex.be
X-Mailer: Apple Mail (2.3826.700.81)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292568-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	APPLE_MAILER_COMMON(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 98CB75ED479
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Cedric,

One further comment: the Marvell DSDT reference implementation (GPLv2) =
also sets an undocumented register on the 6352 family of switches to =
enable CBS. (This does not apply to the 6390 family.)

My understanding is that you should call =
mv88e6xxx_port_qav_read(MV88E6352_PORT_QAV_CFG) and then set or unset =
MV88E6352_PORT_QAV_CFG_ENABLE accordingly.

The values are given below:

#define MV88E6352_PORT_QAV_CFG                    0x08
#define MV88E6352_PORT_QAV_CFG_ENABLE             0x8000

Apologies that my previous comments were against an older version of =
your patch series; however, I believe they are still relevant.

Cheers,
Luke=

