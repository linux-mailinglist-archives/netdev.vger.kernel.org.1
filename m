Return-Path: <netdev+bounces-294487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +Z2qJWlzH2o0mAAAu9opvQ
	(envelope-from <netdev+bounces-294487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 02:20:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1151A6332C0
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 02:20:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=SGH5zm9F;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294487-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294487-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E074730DC154
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 00:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063A3238C0A;
	Wed,  3 Jun 2026 00:16:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E29238C2A;
	Wed,  3 Jun 2026 00:16:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445788; cv=none; b=rXLcNNSZtM8JFpJfMgOMN4oJ9ctxiO7075chy7uA2lozY55ok935SxxbzfvSP17MPbHv8qP0wQzN7/NEIQy8t2GTnCZ1Aj0W7xPKay6jB2BMgbpvshbOZXB5vvHgZfcb6ECY65pHRsvk/hdSDJ8ZDR5edkSKywb5yYzrDMfKuew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445788; c=relaxed/simple;
	bh=LVAztwwvwVTuW1CFjVXsItGMpJmHC2uv3ruQzgYn1fM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LVXm/WpltmOnH5d+p0euT7O1zOES2ODSHGR5Y5y8kNsslWUnXpOkdHNuhfyV6e9f1cbExeSR/L0iJi61lB7HVX3/rOtT7pFhuex59yHS4xqvqiHu60nVnsmQhwSo5JsT+2RwBhJy/55M0ywQ8q2IW4SRS5m7d6HH1WsaQjAwA/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=SGH5zm9F; arc=none smtp.client-ip=216.154.215.154
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 6530FlGu015207
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 01:15:50 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 6530FlGu015207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780445762; bh=LVAztwwvwVTuW1CFjVXsItGMpJmHC2uv3ruQzgYn1fM=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=SGH5zm9FfO+VgmI9KfnzrYlkK1zWS8U0bRuqXQatH7CNiilZS2+NFlgAujKpYELXI
	 fPcpfhzT7cbSU7y6XvV6YgIznvSWnK4qaYQ64LPUWUIOoebEcfk3yBjLGM0N7dSIFp
	 bGQR3g2n0xC7KXW7nvy15iQSzgAijWSd0DNnHwgNXFD3JmMEWST1d/t9c9/vzjqsBW
	 0scX4W1mXDRmB6PXZDGgSF9iFfFVOO3e0qJQnaN4dzNRtVk3b7fKPcPORd5qUXNRHl
	 F6bdpTa1UtTFUHj7XwhANR9GyhImJz1zrJx74LMn6C8Av9IvDdQE734cQxQ4kKgd+j
	 1Gp2QZMSdDZEA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v2 5/6] net: dsa: mv88e6xxx: MQPRIO support
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <29c09316-c911-456e-acc5-e18402da4bd4@lunn.ch>
Date: Wed, 3 Jun 2026 10:15:37 +1000
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
        Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
        linux-kselftest@vger.kernel.org, Max Hunter <max@huntershome.org>,
        Kieran Tyrrell <kieran@sienda.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0402DFFF-634A-40C4-BC1E-B038F20926FF@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
 <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
 <8C6AD966-2C28-4BEF-95C4-1B2AC3751513@padl.com>
 <29c09316-c911-456e-acc5-e18402da4bd4@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.700.81)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294487-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:cedric.jehasse@gmail.com,m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:andrew@lunn.ch,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,blackwall.org,nvidia.com,lunn.ch,vger.kernel.org,lists.linux.dev,huntershome.org,sienda.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	APPLE_MAILER_COMMON(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,padl.com:mid,padl.com:from_mime,padl.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1151A6332C0



> On 3 Jun 2026, at 9:55=E2=80=AFam, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
>> But there=E2=80=99s an alternative, more invasive, solution where the =
MQPRIO
>> configuration is attached to the bridge itself.
>=20
> What about ports which are not attached to a bridge? They are just
> standalone, have an IP address of their own, etc.

That is a good point. So, barring a switch feature I=E2=80=99ve not yet =
found, I think the only options are either to drop MQPRIO offload, or to =
accept that ports with no MQPRIO mapping inherit the per-switch mapping. =
Arguably that=E2=80=99s the case today anyway (each chip has its own =
default frame priority to queue mapping), so the user should have no =
expectation of queue assignment on a port that hasn=E2=80=99t been =
configured.

Luke=

