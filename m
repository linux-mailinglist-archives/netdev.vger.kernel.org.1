Return-Path: <netdev+bounces-267739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QX4DNqt2tWlG0wAAu9opvQ
	(envelope-from <netdev+bounces-267739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:54:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F20E28D8CE
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A34A300D4C6
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F137437CD3D;
	Sat, 14 Mar 2026 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAiVPEmR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBEB37A496;
	Sat, 14 Mar 2026 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773500069; cv=none; b=p2z+BbTA/RZ9uhvoh/Ovo/gotEESCjtUdZn83Kc6vxElhEBMVSGbKZkBYc4H+jcX4IVyksE2izUahaXYfgR21Fr51EtPvTiqx5QVMa2vXo81pN0el0jH3YEyxzFPPYQu8plxId051Uef6npPElUDhq2QTUAu178aO1IURNG8sE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773500069; c=relaxed/simple;
	bh=n/MAAqP1dF+2l52/HtTuluFsqwaDChdXW23orPwVa58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XoJnnZ3K7qSd9X6AmBMW9F8BNC2/VE9ZzH4AG9za7GzUdqdQb700PI+rfGKWOb5lx6Xjm+TFZJbYjG5a42Pwb8TncT6fs0YtKAk9GASnH/uwEC/E8u21AJRjEyqSUAQVxwvqPoPLe+Kfd8tSnsMt8HvdoclXW2a6vl9nDnxdU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAiVPEmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82CBC116C6;
	Sat, 14 Mar 2026 14:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773500069;
	bh=n/MAAqP1dF+2l52/HtTuluFsqwaDChdXW23orPwVa58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZAiVPEmRXtnKh6Xw1DrND0U0kKrh5mwv28vBax4PTyDlS8BQ+RY2xw+FtM7Y6ahvN
	 poZWPhzITK7CI7JXflsof+D2oJYb6neJ1KlNQnYmFDh4Mo2nJbzuoeq8GiDwG4IPJI
	 FWLVkbaB6deUznBC046EfYITh5h0WAezejLza4cdgDscuElPaeaBGBe7aUIxTpxxNq
	 z6LYQ+xqiGiGyZF1e4zNoF3UyppbSbqYsWfGZPV2jJgZRacp0I7ftsbaMIOWMyq8BV
	 bWxNEeLgyM1dPjgpLGSmZ4KULyKZnpwzzqKJxPVmqglEt7omi6tYMPQ61+7Xv+cG7K
	 jCOiO5K1iJKTg==
Date: Sat, 14 Mar 2026 07:54:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Paolo Valerio"
 <pvalerio@redhat.com>
Subject: Re: [PATCH net-next v2 1/2] net: macb: implement
 ethtool_ops.get|set_channels()
Message-ID: <20260314075427.034097b2@kernel.org>
In-Reply-To: <DH1R3P9TTPS7.1YE0XC8RTNTIJ@bootlin.com>
References: <20260311-macb-set-channels-v2-0-982693a1f5fc@bootlin.com>
	<20260311-macb-set-channels-v2-1-982693a1f5fc@bootlin.com>
	<20260312182624.35ab61c8@kernel.org>
	<DH1R3P9TTPS7.1YE0XC8RTNTIJ@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267739-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5F20E28D8CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 16:14:23 +0100 Th=C3=A9o Lebrun wrote:
> > should we reorder this with the running() check? =20
>=20
> I don't agree. For example when an operation is not supported, we start
> by checking that and returning EOPNOTSUPP. Then we validate the input
> data. Then we act.
>=20
> Here it is the same. When netif_running(), we never reply to any
> request even if it happens to be a no-op.
>=20
> I'll go ahead and send V3. Seeing how this was only a question I'll make
> the guess you don't care much about it and are fine either way.
> Same for me.

Sorry for the delay. This code can only be reached from the IOCTL path.
The Netlink path will check that params haven't changed in
ethnl_set_channels() (look at the @mod variable) and return 0 directly.
So you're basically adding a discrepancy between ioctl and Netlink.
Not a huge deal but I don't envy any user having to debug this..

