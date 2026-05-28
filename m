Return-Path: <netdev+bounces-292483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDbKFq2JF2riIQgAu9opvQ
	(envelope-from <netdev+bounces-292483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:17:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5090B5EB341
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 398AE30069AE
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227E5128395;
	Thu, 28 May 2026 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="SZkeAmLD"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9115635898;
	Thu, 28 May 2026 00:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927463; cv=none; b=bRnpcoPe+GEPIEBT4tOntc3s1RFT0y76q8LxYbDFpKrIn9M2oUdQuyQ18qMaHvgd9BRW0E9rGXaxJuc/jOHWLV4YSEOr5mO9XFDROy6sEbwMhHq+QH+/ItZFiBcRiGUqgWLOmUYQdbG0zJozcwvtk1ozaCSQy2QRHazKODoDqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927463; c=relaxed/simple;
	bh=iMkZh9+jTBlqBlgm0lpAXt+Gwj9J1LmyL52HOOTvlAE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jyvWH+HVkcAtyMpwDaengXFGN6gtJkylOnS+Od1YwXSwhF5YM/ltfoikADYNpHL1m3dlMVc7ct9lkBeDbu0MpfQIPClt79CzaE8/OMSgrCW4EXjfom82erTEHvXxLNtyqSro64JhZwmwYwu+r4GofrgXf3l40lBTqA0V+Fjufvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=SZkeAmLD; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64S0HKRD016947
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 28 May 2026 01:17:22 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64S0HKRD016947
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779927446; bh=iMkZh9+jTBlqBlgm0lpAXt+Gwj9J1LmyL52HOOTvlAE=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=SZkeAmLDvSsF/xyCTK8xEUQ8zRQReoyLSrTiI6v1Z7QyB76jAMFOEUtnShLTlkHIU
	 wEoH7AiPUT8h/RTGN7FZHXhUJPMjzz42OXoUS9Uo3WVbKPtKKZopObLJzmxIQrCKFD
	 m9oMgJFegcQN2qfH93jRxpw1Z6iVmrKAUl054e7jqdFjl/3d2Q1HdeFuskadS2jUxY
	 Pi4icrhYPvGn1bzy2ja+6gFHROyW3T62XFUMxYPivrWG2BbTZphiSueFKl2/fV4zwJ
	 T8pcw2+tCeT44x0RydYMuHSAKxdwHCcM7sky7Jdj2wEWjLTjRmKfC/QYf7pz3Qs+3d
	 kPHyTKJOaz/bQ==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <PR3P194MB1505960E42BBFB9AD9E8B18DEA0B2@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
Date: Thu, 28 May 2026 10:17:09 +1000
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kieran Tyrrell <kieran@sienda.com>, Max Hunter <max@huntershome.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <885A5B11-A34A-4F69-9E9F-ABF10159B789@padl.com>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
 <C0F865AD-24CD-4EA7-B0AB-16D91914ABAD@padl.com>
 <PR3P194MB1505960E42BBFB9AD9E8B18DEA0B2@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
To: Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: Apple Mail (2.3826.700.81)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,sienda.com,huntershome.org];
	TAGGED_FROM(0.00)[bounces-292483-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[padl.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5090B5EB341
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Cedric,

> On 26 May 2026, at 9:28=E2=80=AFpm, Cedric Jehasse =
<cedric.jehasse@luminex.be> wrote:
>=20
> I don't use MQPRIO hw offload, which i think is a big part of your =
changes. So it didn't make sense to continue on those patches. This also =
answers your other question: i haven't submitted another patch set for =
hardware offloaded MQPRIO.=20
> I'm trying to upstream changes one topic at a time. Eg. this CBS patch =
is only for configuring the shaper. How traffic ends up in a certain =
queue is not relevant for this patch.

This actually makes more sense also now that you pointed out that AVB =
mode is set on the ingress, not egress, port: configuring CBS should =
stay out of setting any of the AVB mode bits. Are you planning to submit =
a MQPRIO patch? If not, shall I just wait for your CBS patch to land, =
and then rebase my AVB patch series on top of net-next?

We have different use cases: yours (as I understand it) is =
host-initiated traffic with as many queues as the hardware supports, and =
mine is hardware offloaded AVB switching with (essentially) three TCs =
(one queue per AVB TC). It would be great to find a solution that can =
support both.

Cheers,
Luke=

