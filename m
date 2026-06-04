Return-Path: <netdev+bounces-295254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mhaiKG6BIWprHgEAu9opvQ
	(envelope-from <netdev+bounces-295254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:45:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EDA64074C
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:45:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=T0HENZKj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295254-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295254-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C73C3093E65
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581F747DD65;
	Thu,  4 Jun 2026 13:43:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657347B42F;
	Thu,  4 Jun 2026 13:43:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580634; cv=none; b=pnqD31EwcQvTeQeymHPQGbwp8W8ieHkwsG0KgkVlpO49R0wPq3eu0N/PGbT1OnpTZ/IK1QKSD+Gfi1oF1c+yp8LezNQ0UUjsEoB9rqmfi8g6JahdgQKB/PoGpp5UQn2fCKynxLQMVfbF5AjuT0IowXRlnY7hGpbzVSZPCSIl/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580634; c=relaxed/simple;
	bh=hG3r8htHbfiDt+uEHddzqt17QFqacFYRgXcs1OsJfGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nP6dUEps5SnL+V9QrdNgCc2G2qAo3gpl4kfv5H0wh9B3BnX8ZxYVcVEOLLhYy3LdCFz2VNse0U2kOcsQcO1OkLop1qH5B9U1v+5IZHbGJjgBz6TZ9zqWE4K+5UEqi4vbtntRi+D6gMfQsAsBiCXuSwUEQ7AknjBnRisB8yfJfoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=T0HENZKj; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 654DhQF11402774, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780580606; bh=EEX3ee8jRD5bwP1IqMXXbg12zVubnYeMQXiZtasPp4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=T0HENZKjZBkZIRf9xO+VTJsKWzOyrwElwz5Z4WgvJt4JK0YZOIgtYcmqZyfW2xFAg
	 7I0Ke0rlp/HY6ss1YXN//wVoVTVP7kKdqs+7UHThpInnDzImJmIrpy3fWM1ySsf2M0
	 LqAsw3XKFKJ9jSNRejrGKdnXSdrJzmBsLKJxn3KAE1AWj2xBZUBxeOdAWqlwoMIbZV
	 XCFD8kNrQQAItA1kThqojp2SLsXSwGEyttQHBdCSFnGl9OxpdRSZb3MTvxVfU9E/T5
	 097uP65smpQalkix1yBwahGcIoLn/6Al8/MgjSdWDEJ4XTJEGFE3W2yr4XSaEbieyb
	 q4frWhRJaJ63g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 654DhQF11402774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 21:43:26 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 21:43:27 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Thu, 4 Jun 2026 21:43:27 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: David Laight <david.laight.linux@gmail.com>
CC: Andrew Lunn <andrew@lunn.ch>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu
	<larry.chiu@realtek.com>
Subject: RE: [PATCH] rtase: Workaround for IP fragmented UDP packet hardware
 bug
Thread-Topic: [PATCH] rtase: Workaround for IP fragmented UDP packet hardware
 bug
Thread-Index: AQHc8Y8ydZ9ThmFs6kuJK5zylfdiXbYpKbAAgATsPhD//7BLAIAApasw
Date: Thu, 4 Jun 2026 13:43:27 +0000
Message-ID: <1489704deb9844b08848758af95a448e@realtek.com>
References: <20260601062341.63981-1-justinlai0215@realtek.com>
	<5c095b26-9720-45b0-a8d5-a8495291e45b@lunn.ch>
	<447c46ad1f654222a8daa423149f0b89@realtek.com>
 <20260604124606.7143581b@pumpkin>
In-Reply-To: <20260604124606.7143581b@pumpkin>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295254-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pkshih@realtek.com,m:larry.chiu@realtek.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[justinlai0215@realtek.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justinlai0215@realtek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40EDA64074C

David Laight <david.laight.linux@gmail.com> wrote:
>=20
> On Thu, 4 Jun 2026 08:33:51 +0000
> Justin Lai <justinlai0215@realtek.com> wrote:
>=20
> > Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > On Mon, Jun 01, 2026 at 02:23:41PM +0800, Justin Lai wrote:
> > > > The hardware parser incorrectly interprets 319/320 in a short IP
> > > > fragmented UDP packet payload as standard PTP destination ports
> > > > and treats the fragment as a PTP packet for further parsing.
>=20
> Is that a packet that has been segmented by IP, or one where the skb is
> fragmented enough that the data in the header is too short?
> I thought that IPv4 required an mtu of 128 bytes (ish) and IPv6 somewhat
> larger - so I don't see how that is a problem.
>=20
> If the skb is fragmented then you need to move data into the header not p=
ad
> the frame.
>=20
> If the hardware really is broken then I suspect you need to disable the f=
eature
> and suffer the consequences.
>=20
> > > >
> > > > If the transport data is smaller than RTASE_MIN_PAD_LEN, the
> > > > remaining data is insufficient for further parsing and causes hardw=
are TX
> hang.
> > >
> > > Where does RTASE_SHORT_PKT_THRESH come into this?
> > >
> > > RTASE_MIN_PAD_LEN is 47, so matches all packets which need padding
> > > up to
> > > 60 bytes, plus FCS. There are not many such packets, so why both
> > > this all the complexity and just pad all small packets? Do you have
> > > any performance numbers which show the complexity is worth it?
> > >
> > > > Pad these packets so the transport data reaches RTASE_MIN_PAD_LEN
> > > > before transmitting to avoid triggering the hardware issue.
> > > >
> > > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > >
> > > Is this a Fix? Please add a Fixes: tag. And base it on net.
> > >
> > > https://www.kernel.org/doc/html/latest/process/maintainer-netdev.htm
> > > l
> > >
> > >     Andrew
> > >
> > > ---
> > > pw-bot: cr
> >
> > Hi Andrew,
> >
> > RTASE_MIN_PAD_LEN is not the Ethernet minimum-frame padding
> threshold.
> > It is the minimum transport-data length required by the hardware
> > parser after the packet is incorrectly detected as a PTP packet.
> >
> > Therefore, this workaround needs to pad the packets which can trigger
> > the hardware issue, rather than just padding packets to the Ethernet
> > minimum frame size.
>=20
> Is that a longer length?
> Excessive frame padding (beyond 60+FCS) can be treated as a protocol erro=
r.
>=20
> -- David
>=20
> >
> > I agree that RTASE_SHORT_PKT_THRESH is not necessary here. I will
> > remove it in the next revision.
> >
> > Yes, this is a fix. I will add a Fixes tag and repost it against the
> > net tree.
> >
> > Thanks,
> > Justin
> >

Hi David,
=20
This is an IP fragmented packet, not a fragmented skb.
=20
The issue occurs on a non-initial IP fragment whose payload
contains values matching the PTP event/general destination
ports (319/320). The hardware parser incorrectly identifies the
fragment as a PTP packet and attempts further parsing.
=20
The workaround does not modify the IP or UDP length fields. The
original protocol headers still describe the actual packet size.
=20
Therefore, the protocol-defined payload size remains unchanged.
=20
We have tested this workaround and have not observed issues
caused by the additional padding.
=20
Thanks,
Justin

