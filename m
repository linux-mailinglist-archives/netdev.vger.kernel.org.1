Return-Path: <netdev+bounces-294416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id du/XNJVHH2o0jgAAu9opvQ
	(envelope-from <netdev+bounces-294416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:13:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F74632090
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:13:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=leG9Z8FI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294416-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294416-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCF02300939E
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 21:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FB039D6E8;
	Tue,  2 Jun 2026 21:13:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF8F243367;
	Tue,  2 Jun 2026 21:13:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434800; cv=none; b=oGe748h16tq+v9duntL1oDVFgaQh/gcaERJklKNPQZF/5GYuurUyTv32s4UEj/jXn9H3oWOrJQ/83h0mmxhhXaES+krXlmix8HC272ibbRYxMAjgFH/mYVdppS+cHRrEslYpz8SeImH9UeJ6XPgL3xMScPhpMM3gwlXY4C0MJCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434800; c=relaxed/simple;
	bh=HtE+CUeOQe9K5828UtNu62LtqQ103MigfZnxhbdVnDk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MmpGZLsGwUOP0iemaNi9G41XMEHlgYwri7IHo7Mmb5qFT+TE4qmfreqjf49LsUY2vv/hNrRkx+hOZM27laNAF08QZ2l7aI/V6ueDazezf0CBpBUpU5j4Hzf7lqDb3+xRm2TLpDKpf3vBhxtn02vLAgvMQlJ7j1plEwrU7A39PyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=leG9Z8FI; arc=none smtp.client-ip=216.154.215.154
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 652LCNev015764
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 2 Jun 2026 22:12:25 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 652LCNev015764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780434768; bh=HtE+CUeOQe9K5828UtNu62LtqQ103MigfZnxhbdVnDk=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=leG9Z8FIM3pJZ4l6nIiMqriryyD81HF1WcqASUuCAQC8YfQnmGHBXnHR5AcsC0Jrq
	 gSqqwc7tYZzHhwa2HhW62nORQsr6432wwfL8PK6DaY1cayHxN86pW/bM/HUZO/pK7m
	 nleseDQe6n0C+CHprDUyKRtdYjFjCVezsm/+DG4MRDHmhD2SLKIjGpH5THZ7Gh8B63
	 4zU3b21yxROV26YPWKFd85WM4/0H8Oa2DEmZRw8XwDvQqDMZIpD1+gf1JCRvs7KtYj
	 so1tCNwj9CwPQDYR+Kgjni5Zw1fwzKeSTqUSRYG0mA9lKZYHvTQ6cTINnN0Dz9wpB5
	 jTOqOPufiACwQ==
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
In-Reply-To: <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
Date: Wed, 3 Jun 2026 07:12:12 +1000
Cc: Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Max Hunter <max@huntershome.org>, Kieran Tyrrell <kieran@sienda.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:cedric.jehasse@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294416-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,blackwall.org,nvidia.com,lunn.ch,gmail.com,vger.kernel.org,lists.linux.dev,huntershome.org,sienda.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,padl.com:mid,padl.com:from_mime,padl.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4F74632090

> In case of per port priority mapping, i don't know if this is working =
as
> expected, as the IEEE priority mapping is done at ingress.
> Eg. i think if MQPRIO channel mode is used to configure a pcp to queue =
mapping
> on port 1 and a different mapping on port 2. Traffic received on port =
1 that
> gets forwarded to port 2 and egresses port 2 will end up in the queue
> configured by the mapping on port 1. As mqprio is an egress qdisc, i =
don't
> think that's expected.

Good point, it=E2=80=99s interesting there is egress mapping on the 6390 =
but only for FPri to DSCP. The Frame Priority Table set ordinal one =
would expect for egress QPri mapping is =E2=80=9Creserved for future =
use=E2=80=9D. (Be nice if it were an undocumented feature.)

I will remove the per-port mapping for the 6390 so all ports share the =
same mapping as they do on the 6352.

> I have a patch that hasn't been submitted to the mailing list yet =
which
> implements support for the dcb app pcp-prio command. This is also done =
by
> configuring the IEEE priority mapping table.

Definitely happy to take a look if and when you submit, but I do plan to =
continue with this patch series (originally proposed as an RFC in =
September 2025).

Cheers,
Luke=

