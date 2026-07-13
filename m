Return-Path: <netdev+bounces-307536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LmFVFNNzVmph5wAAu9opvQ
	(envelope-from <netdev+bounces-307536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:37:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2C9757845
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:37:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307536-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307536-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DF8331EE947
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E5F2F747A;
	Tue, 14 Jul 2026 17:32:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ursule.remlab.net (vps-a2bccee9.vps.ovh.net [51.75.19.47])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EF930214B
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 17:31:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050321; cv=none; b=gukjWi2m93JiOWEQ1rddvYnVged1BNXd1F4pP3pnemKHf0snMsFRFH/bkA1C173TN+T+YOvrPNWp3pAwlvJoXF69cwBeAmPVTwiJCjdQPxUrSVs9pDBgYkfUocawi47KxXUJ+Olq5nblzywtxpSCG3SjH8RqqhQdphZ/6f21I28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050321; c=relaxed/simple;
	bh=6gsQE7uclDyJ/8N7gnovSfU1Qx7ihfB3bfFds1vXw2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V53TE6ei7NWJ7+uTLHP9LlMTmCm5nF8InJUSbvEuSHou6CxPS4VxpoRCrK3JL0CnvTONRgTQsWjuJVCroqNB4W+ekAIAlkTFEITeTeDoT3xsuOXU5y7VGB7frNoLB6GICIAxbpo2k0t2PoFt5wPo5AOQhXxB15hPtzUlanyTvDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=51.75.19.47
Received: from ursule.remlab.net (localhost [IPv6:::1])
	by ursule.remlab.net (Postfix) with ESMTP id 077DBC0137;
	Tue, 14 Jul 2026 20:26:33 +0300 (EEST)
Received: from basile.remlab.net ([2001:14ba:a082:6301:c5d2:3c3d:3f09:1404])
	by ursule.remlab.net with ESMTPSA
	id uaCgN0lxVmqiWAEAwZXkwQ
	(envelope-from <remi@remlab.net>); Tue, 14 Jul 2026 20:26:33 +0300
From: =?UTF-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>
To: netdev@vger.kernel.org
Cc: Minhong He <heminhong@kylinos.cn>
Subject:
 Re: [PATCH] phonet: check register_netdevice_notifier() error in
 phonet_device_init()
Date: Mon, 13 Jul 2026 22:22:56 +0300
Message-ID: <3425812.44csPzL39Z@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20260713075212.431455-1-heminhong@kylinos.cn>
References: <20260713075212.431455-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[remlab.net];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:heminhong@kylinos.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307536-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[remi@remlab.net,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[remi@remlab.net,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,remlab.net:from_mime,remlab.net:url,basile.remlab.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE2C9757845

Le maanantaina 13. hein=C3=A4kuuta 2026, 10.52.12 It=C3=A4-Euroopan kes=C3=
=A4aika Minhong He=20
a =C3=A9crit :
> phonet_device_init() registers a netdevice notifier before calling
> phonet_netlink_register(), but does not check whether notifier
> registration succeeded. On failure, netlink setup still proceeds and
> init may return success without the notifier in place.

> Check the notifier registration error and unwind through
> phonet_device_exit() on failure.

That will unregister a notifier that is not registered. While I believe tha=
t=20
would fail safe, I am not sure if that is really considered proper by=20
contemporary kernel coding standards.

=2D-=20
R=C3=A9mi Denis-Courmont
https://www.remlab.net/




