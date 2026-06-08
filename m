Return-Path: <netdev+bounces-296527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g60+BUy3JmrubgIAu9opvQ
	(envelope-from <netdev+bounces-296527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:36:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AB86563B6
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:36:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=SS5f8jJ5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296527-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296527-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7A13304A928
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 12:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D7337B3FE;
	Mon,  8 Jun 2026 12:28:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D2379C58;
	Mon,  8 Jun 2026 12:28:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921733; cv=none; b=CciU+TVblzd0hNqcIjfwo8xzIr+j0txAqJeSNbhGJXb/y9I0w27xDIbF0VcwIMBylVHmNfdHirxyWGFZFuhsx8AyOXIainiL2V/deQRh7ZtqJftQA9177fOk3eRWU5SXLfLmHBzKd8UuAIqfCRLFhn22SQIcMEmkb1iPxrmEJy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921733; c=relaxed/simple;
	bh=hhCgifHx+p/UolaWdFdxrVFdRFynZWQm19sImxXBEVY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RdznJr9Vwhu0vzrivCC3CEZ1bq7FEh6KvgX9ohANdKj57GDm4lHxQgUqQGPAppXbG3rsbt//rE/4bD8kF0TywRRkhevXRM6Vvq14G2n8MqlbleXic7ek6SJN47i41oHrDTDSVeq2RB0T5pGEOKBk0YHJKv/yB65XLWtuDN4ut/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SS5f8jJ5; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 658CSSo743683102, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780921708; bh=oNkhPiG/mPVYB1Rr1dy3YgrrsdkA7y2cEZIitCzpR2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=SS5f8jJ5lOmaSD5ivvlvLcEes3SLp4ieyTmWakyo53cyDWXiiD0Ro3+EGH6oDkFJo
	 0ozDoOzn+dkSrgSC2bgaLamsx0ArHOuepka6CTsU1dCxQEeGySZvXue41+Fa8wjBaD
	 oAzBqMqpadoW1aGMhfDh0R8szf/CvAuRx10bJxerd5OAeKyxUARb4SfRvmSdG+ceie
	 p5NxiAnT0J60grzv6QPmg8PkKQxGx84uueGgWca7SA63Vbo8/deJPqpQ9mkBZdLhSX
	 MlXYqDR2x8Hm5VXxYJjN2dq+OoIh87z3n6mjXoBCkpzXgBQsIivNFapKCWYby9Aqh9
	 JZaxI0UIrF0pA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 658CSSo743683102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Jun 2026 20:28:28 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Jun 2026 20:28:28 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Mon, 8 Jun 2026 20:28:28 +0800
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
Thread-Index: AQHc8Y8ydZ9ThmFs6kuJK5zylfdiXbYpKbAAgATsPhD//7BLAIAApasw//+OlwCABp5KUA==
Date: Mon, 8 Jun 2026 12:28:28 +0000
Message-ID: <0758634ad8944162b7de0d915fcfa88e@realtek.com>
References: <20260601062341.63981-1-justinlai0215@realtek.com>
	<5c095b26-9720-45b0-a8d5-a8495291e45b@lunn.ch>
	<447c46ad1f654222a8daa423149f0b89@realtek.com>
	<20260604124606.7143581b@pumpkin>
	<1489704deb9844b08848758af95a448e@realtek.com>
 <20260604155308.770b2deb@pumpkin>
In-Reply-To: <20260604155308.770b2deb@pumpkin>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296527-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim,realtek.com:from_mime,realtek.com:email,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65AB86563B6

David Laight <david.laight.linux@gmail.com> wrote:
>=20
> On Thu, 4 Jun 2026 13:43:27 +0000
> Justin Lai <justinlai0215@realtek.com> wrote:
>=20
> > David Laight <david.laight.linux@gmail.com> wrote:
> > >
> > > On Thu, 4 Jun 2026 08:33:51 +0000
> > > Justin Lai <justinlai0215@realtek.com> wrote:
> > >
> > > > Andrew Lunn <andrew@lunn.ch> wrote:
> > > > >
> > > > > On Mon, Jun 01, 2026 at 02:23:41PM +0800, Justin Lai wrote:
> > > > > > The hardware parser incorrectly interprets 319/320 in a short I=
P
> > > > > > fragmented UDP packet payload as standard PTP destination ports
> > > > > > and treats the fragment as a PTP packet for further parsing.
> > >
> > > Is that a packet that has been segmented by IP, or one where the skb =
is
> > > fragmented enough that the data in the header is too short?
> > > I thought that IPv4 required an mtu of 128 bytes (ish) and IPv6 somew=
hat
> > > larger - so I don't see how that is a problem.
> > >
> > > If the skb is fragmented then you need to move data into the header n=
ot
> pad
> > > the frame.
> > >
> > > If the hardware really is broken then I suspect you need to disable t=
he
> feature
> > > and suffer the consequences.
> > >
> > > > > >
> > > > > > If the transport data is smaller than RTASE_MIN_PAD_LEN, the
> > > > > > remaining data is insufficient for further parsing and causes h=
ardware
> TX
> > > hang.
> > > > >
> > > > > Where does RTASE_SHORT_PKT_THRESH come into this?
> > > > >
> > > > > RTASE_MIN_PAD_LEN is 47, so matches all packets which need paddin=
g
> > > > > up to
> > > > > 60 bytes, plus FCS. There are not many such packets, so why both
> > > > > this all the complexity and just pad all small packets? Do you ha=
ve
> > > > > any performance numbers which show the complexity is worth it?
> > > > >
> > > > > > Pad these packets so the transport data reaches
> RTASE_MIN_PAD_LEN
> > > > > > before transmitting to avoid triggering the hardware issue.
> > > > > >
> > > > > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > > > >
> > > > > Is this a Fix? Please add a Fixes: tag. And base it on net.
> > > > >
> > > > >
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.htm
> > > > > l
> > > > >
> > > > >     Andrew
> > > > >
> > > > > ---
> > > > > pw-bot: cr
> > > >
> > > > Hi Andrew,
> > > >
> > > > RTASE_MIN_PAD_LEN is not the Ethernet minimum-frame padding
> > > threshold.
> > > > It is the minimum transport-data length required by the hardware
> > > > parser after the packet is incorrectly detected as a PTP packet.
> > > >
> > > > Therefore, this workaround needs to pad the packets which can trigg=
er
> > > > the hardware issue, rather than just padding packets to the Etherne=
t
> > > > minimum frame size.
> > >
> > > Is that a longer length?
> > > Excessive frame padding (beyond 60+FCS) can be treated as a protocol
> error.
> > >
> > > -- David
> > >
> > > >
> > > > I agree that RTASE_SHORT_PKT_THRESH is not necessary here. I will
> > > > remove it in the next revision.
> > > >
> > > > Yes, this is a fix. I will add a Fixes tag and repost it against th=
e
> > > > net tree.
> > > >
> > > > Thanks,
> > > > Justin
> > > >
> >
> > Hi David,
> >
> > This is an IP fragmented packet, not a fragmented skb.
>=20
> Ok, your tests are broken for fragmented skb.
> skb_tail_pointer() is the end of the initial fragment, not the
> end of the actual data.
> So you could be adding padding to a full length packet making
> it overlong.
> Somewhere you need to be looking at skb->len.
> Probably with a fast-path check to ignore long packets.
>=20

You're right. skb_tail_pointer() only covers the linear area and can
underestimate the transport-data length for non-linear skb.

I will change the transport-data length calculation to use:
trans_data_len =3D skb->len - skb_transport_offset(skb);

> >
> > The issue occurs on a non-initial IP fragment whose payload
> > contains values matching the PTP event/general destination
> > ports (319/320). The hardware parser incorrectly identifies the
> > fragment as a PTP packet and attempts further parsing.
>=20
> Wait a minute, what stops someone using either of those port numbers
> for something else?
> There are no hard restrictions on the use of UDP port numbers.
> So what does the hardware do with UDP packets to port 319/320 that
> are being used for something else entirely?
>=20

If the UDP destination port is 319 or 320, the hardware will identify
the packet as a PTP packet and perform the corresponding PTP
processing.

> > The workaround does not modify the IP or UDP length fields. The
> > original protocol headers still describe the actual packet size.
> >
> > Therefore, the protocol-defined payload size remains unchanged.
> >
> > We have tested this workaround and have not observed issues
> > caused by the additional padding.
>=20
> Have you checked all the systems that might receive such packets?
>=20

Could you clarify what kind of protocol error you are referring to?

From my understanding, this workaround adds padding at the end of the
frame without modifying the IP or UDP length fields. The
protocol-defined packet length therefore remains unchanged.

This appears similar to Ethernet frame padding, where additional bytes
may exist beyond the protocol-defined payload length. Could you
elaborate on how this case differs from the padding up to the Ethernet
minimum frame size (60 bytes + FCS)?

Thanks,
Justin

> -- David
>=20
> >
> > Thanks,
> > Justin


