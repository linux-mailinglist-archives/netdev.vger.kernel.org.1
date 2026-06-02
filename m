Return-Path: <netdev+bounces-293946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFAPJwEyHmpahwkAu9opvQ
	(envelope-from <netdev+bounces-293946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 03:29:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4145F626D99
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 03:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD7B7301DE00
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 01:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CA03382C5;
	Tue,  2 Jun 2026 01:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="HzcBvWx3"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D34C2C234A;
	Tue,  2 Jun 2026 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780363773; cv=none; b=cNJrgFnJvaEbn/XR7ACO09F/JfI75M6cBC46qb69eWgeyxfLh6s5N6XIPb6B3HdtCGLG+px5TEJajl1muITfr9HCOa8qvA8pheNMRm7V48rtmjlc1BoLJQEhZ6pKfmYQwZLDQBcHkwGP8BFI2kWoP74N8zCKrS+nxr2zg134e2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780363773; c=relaxed/simple;
	bh=XYVybQ4AGpWqrfVXbsCVHv210k/jVff/IzDdIvxFR7w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MBCjE/X576InUaWLTts+erbRiHyv0HgjzDJdUaXg3QUuLS56ql2p9/kwTbnHxS5T8SRz5zoK0U3oiGX9LDsj4rtuRxydaip0yFicPYDCqrQbOgd/JUxJpYnChHgGb4H5JNFdCTGgRciwhCanRTYdrw5WemqLZlAGLXMTTL1Rn2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=HzcBvWx3; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 6521SvdB005973
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 2 Jun 2026 02:29:07 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 6521SvdB005973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780363757; bh=XYVybQ4AGpWqrfVXbsCVHv210k/jVff/IzDdIvxFR7w=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=HzcBvWx3p+WEIFaub6tBDLFIxeQTCMR/DJC0X6u37TTgLrfN1Q2+RUWpBr3szSF0o
	 6q66HRK2dOLj03w42HcD3ROPfsg9fxpt4ohI3xRk9m5ENem4RTNUXnspGIY40a8nYT
	 KPnBRedsEOuaVLrjsSMO1A4cESLGmYQ/hJhchu3DxKxiAT4V/v/yL7pTPpm1uZIdMh
	 Yt0r5VBy/OIOsdA5QMJpN5vcfL3GX8GaZmjuZWdU6ee5wsqVbk+VEgZvBbAFSWhxn7
	 Yc+dZ5asdYjeg6bSKdEadR47+vifaT6rX4EKs995On/kd4A8v9Yz+1LW4+n8A1MNez
	 kjGwG3CzgNbpQ==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v2 3/6] net: bridge: add 802.1Qat stream
 reservation admission control
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
Date: Tue, 2 Jun 2026 11:28:47 +1000
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Max Hunter <max@huntershome.org>, Kieran Tyrrell <kieran@sienda.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <08F7FD60-0628-4973-B778-5B925181B232@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
To: Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293946-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,blackwall.org,nvidia.com,lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,padl.com:email,padl.com:mid,padl.com:dkim]
X-Rspamd-Queue-Id: 4145F626D99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On 2 Jun 2026, at 10:43=E2=80=AFam, Luke Howard <lukeh@padl.com> =
wrote:
>=20
> + if (mdst->flags & BRIDGE_MDBE_F_HOST_STREAM_RESERVED)
> + return false;

This flag should not have appeared until patch 4/6 (allow =
MDB_FLAGS_STREAM_RESERVED on host groups).

Will be fixed in the next revision.=

