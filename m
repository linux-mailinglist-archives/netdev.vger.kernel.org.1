Return-Path: <netdev+bounces-291488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHwkMsHuFGofRgcAu9opvQ
	(envelope-from <netdev+bounces-291488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 02:52:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A82F5CF537
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 02:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDF0C302615A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 00:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07D4270EC3;
	Tue, 26 May 2026 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="IzRZelCz"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79D1891A9;
	Tue, 26 May 2026 00:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779756698; cv=none; b=RJ0UlQYEz/9HUkqdxjrjqYhYyisir244IlgAV/RUPfRpYCzTt2cqPr33F2/Zbn8ZY3E02VZDMO7kNfQe4vKBx3fvGLYfcCti4sDr4qF12R8t/FAmBd9gw08giwKBqZua4nespBYvlnCJ3MTv2zVsflFJVk/oJKpecTMmHMHxVgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779756698; c=relaxed/simple;
	bh=1/mRtAfnThR/ietuCPCQaBu1XXZ1WZiTekhYE29qjmo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Buh6TVjh8D7ODZsnVg6mcFN8F1fifrnWdYt4hONrdOu9e411HiISg8N+xJjpUNf2Flm4JY//fbRHDjVqAp6F2H94U5m4vgzJlFxhWKE7ETj34lkeMxySnijtuD6y8LhndrBIbx9PJ+DnM810xdygXdLYoVQaRCgNkkPzung7KK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=IzRZelCz; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64Q0WgjH006850
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 26 May 2026 01:32:46 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64Q0WgjH006850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779755575; bh=1/mRtAfnThR/ietuCPCQaBu1XXZ1WZiTekhYE29qjmo=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=IzRZelCzUYBlyszIxRx+zHW7cffEloToKERb7iixZhcaIpkOhTqo33fxXnZyqqp3P
	 ezrESRioEDz0HupflIx2c3hREAdrjlahcLYyGCPz36/Kmz7ujQdKKZNSQLcNSHm8k6
	 tFmOZK3dmDR7yDgA2W1WmJQj5WH7T0GVSap36DhOi7a5q7L+ftAQz6HaGnbaLUi1b3
	 yQo/MxofZGh8yUqgri853ToqOJlKnMRNvxKbhSU6ZJGP2Wa5pdRvr7/H764Gc9NjsQ
	 ltaIKnQJtS9IBwKSZyr7W6I3RCgN8maSMDLJxMI0nEufyXpV5vH6GavbQ/py57JQuD
	 4bB3QMhMeOF7Q==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
Date: Tue, 26 May 2026 10:32:32 +1000
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kieran Tyrrell <kieran@sienda.com>,
        Max Hunter <max@huntershome.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C0F865AD-24CD-4EA7-B0AB-16D91914ABAD@padl.com>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
To: cedric.jehasse@luminex.be
X-Mailer: Apple Mail (2.3826.700.81)
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,sienda.com,huntershome.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:?];
	TAGGED_FROM(0.00)[bounces-291488-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DMARC_DNSFAIL(0.00)[padl.com : SPF/DKIM temp error,reject];
	TAGGED_RCPT(0.00)[netdev];
	APPLE_MAILER_COMMON(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[padl.com:s=default];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2A82F5CF537
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Cedric,

We sent RFC patches for mv88e6xxx support for both MQPRIO [1] and CBS =
[2] last year. (We have since made a few small changes which can be =
found in our working tree at [3].)

We have been using these patches successfully for the past year with our =
SRP stack [4] on a custom board with a 88E6352. The CBS and MQPRIO =
patches remain unsubmitted because we also needed extend the Netlink API =
and software bridge with a flag indicating a FDB/MDB entry is managed by =
SRP.

I would be happy to work together to harmonise our patches to avoid =
duplicated effort.

Cheers,
Luke

[1] https://lists.openwall.net/netdev/2025/09/27/34
[2] https://lists.openwall.net/netdev/2025/09/27/26
[3] https://github.com/PADL/linux/tree/rpi-6.18.y-xebros-rmu
[4] https://github.com/PADL/OpenSRP=

