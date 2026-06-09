Return-Path: <netdev+bounces-296981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tDMKOKzSJ2q12wIAu9opvQ
	(envelope-from <netdev+bounces-296981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:45:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D6265DEC7
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:45:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=wLTFOZob;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296981-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296981-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCC023042E63
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667283EE1F6;
	Tue,  9 Jun 2026 08:39:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3EF3EE1FD;
	Tue,  9 Jun 2026 08:39:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994392; cv=none; b=Qvj9g8V0i6vjjZzBPZEp9ZIf4s9PGUMr8VCl3tJ7f8WpuSIc3ehZS/q+V44uNSmLWkXU6qlhLJqchonO41x3gVrFo1wF9BTJ/FbN9OsdWJ5BgXTI+2zgN4PwY5lwS5lRLNfcsXWWq0ME62Ij8tWl8tbGJniIPC11K0rtGGp1CV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994392; c=relaxed/simple;
	bh=lOP7v9NziUzqOm/hPHeaqONicOIK7Q/Jq5zFuf7qkjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L5PlMRmt4t5hhpJIbLLSTIw/pVPYdBE8FnnWXX/21hL9JYOXg8z0xXjCjtBbb2zi96ig+9aH91Ph9WKmO2EKmejZZ5scnYAxE/LVIblFdB6M9RtTWcZSoFOVEsTeOe+uDEM6wTiW5TOMf0Ee8PVOlK0HGwYuvXjG/2UE+A1Nqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wLTFOZob; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6598dR4L1088503, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780994368; bh=j9FMCAULSJ2VLjB2kPwE9fGP7EvS15eI5fhveW/1CaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=wLTFOZob4QYLWRBV5MFxj4iVRJulJFpbjp+TZQ6LfBltgb7zhPIAG01FL9bLVDUyP
	 R10lU5/bJqO6zogVpRZkubpbwDNvZqK65AwxMTvEpEte+C4rP3HvkdbA8nnNdvbikM
	 JNNjn75ZXzlfUbebdT4th220lthJikvnb8jeCzelSnzlOmFbKqMy154oo1jWEW60jf
	 sHFp6Gx1Np8PLg0lhnN+YIowtq5cCJ01Ael4BxMD2JeYtxc1R4bArAjho824t50czb
	 +c/ygx78MSX/WuxVDP5eSjva/OE4Ke+GehOYRxwjPek1xl8M9lBqp++kbCkhLI8T5P
	 FDyxVK1VuZC/A==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6598dR4L1088503
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jun 2026 16:39:28 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Jun 2026 16:39:27 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Tue, 9 Jun 2026 16:39:27 +0800
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
Thread-Index: AQHc8Y8ydZ9ThmFs6kuJK5zylfdiXbYpKbAAgATsPhD//7BLAIAApasw//+OlwCABp5KUIAAIoyAgAEZ2qA=
Date: Tue, 9 Jun 2026 08:39:27 +0000
Message-ID: <94fd8b1a43e6401bb67e0a1310e212e0@realtek.com>
References: <20260601062341.63981-1-justinlai0215@realtek.com>
	<5c095b26-9720-45b0-a8d5-a8495291e45b@lunn.ch>
	<447c46ad1f654222a8daa423149f0b89@realtek.com>
	<20260604124606.7143581b@pumpkin>
	<1489704deb9844b08848758af95a448e@realtek.com>
	<20260604155308.770b2deb@pumpkin>
	<0758634ad8944162b7de0d915fcfa88e@realtek.com>
 <20260608230053.5c1a7bc5@pumpkin>
In-Reply-To: <20260608230053.5c1a7bc5@pumpkin>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296981-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pkshih@realtek.com,m:larry.chiu@realtek.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[justinlai0215@realtek.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justinlai0215@realtek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22D6265DEC7

David Laight <david.laight.linux@gmail.com> wrote:
>=20
> On Mon, 8 Jun 2026 12:28:28 +0000
> Justin Lai <justinlai0215@realtek.com> wrote:
>=20
> > David Laight <david.laight.linux@gmail.com> wrote:
> > >
> > > On Thu, 4 Jun 2026 13:43:27 +0000
> > > Justin Lai <justinlai0215@realtek.com> wrote:
> > >
> > > > David Laight <david.laight.linux@gmail.com> wrote:
> > > > >
> > > > > On Thu, 4 Jun 2026 08:33:51 +0000 Justin Lai
> > > > > <justinlai0215@realtek.com> wrote:
> > > > >
> > > > > > Andrew Lunn <andrew@lunn.ch> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 01, 2026 at 02:23:41PM +0800, Justin Lai wrote:
> > > > > > > > The hardware parser incorrectly interprets 319/320 in a
> > > > > > > > short IP fragmented UDP packet payload as standard PTP
> > > > > > > > destination ports and treats the fragment as a PTP packet f=
or
> further parsing.
> > > > >
> > > > > Is that a packet that has been segmented by IP, or one where the
> > > > > skb is fragmented enough that the data in the header is too short=
?
> > > > > I thought that IPv4 required an mtu of 128 bytes (ish) and IPv6
> > > > > somewhat larger - so I don't see how that is a problem.
> > > > >
> > > > > If the skb is fragmented then you need to move data into the
> > > > > header not
> > > pad
> > > > > the frame.
> > > > >
> > > > > If the hardware really is broken then I suspect you need to
> > > > > disable the
> > > feature
> > > > > and suffer the consequences.
> > > > >
> > > > > > > >
> > > > > > > > If the transport data is smaller than RTASE_MIN_PAD_LEN,
> > > > > > > > the remaining data is insufficient for further parsing and
> > > > > > > > causes hardware
> > > TX
> > > > > hang.
> > > > > > >
> > > > > > > Where does RTASE_SHORT_PKT_THRESH come into this?
> > > > > > >
> > > > > > > RTASE_MIN_PAD_LEN is 47, so matches all packets which need
> > > > > > > padding up to
> > > > > > > 60 bytes, plus FCS. There are not many such packets, so why
> > > > > > > both this all the complexity and just pad all small packets?
> > > > > > > Do you have any performance numbers which show the complexity
> is worth it?
> > > > > > >
> > > > > > > > Pad these packets so the transport data reaches
> > > RTASE_MIN_PAD_LEN
> > > > > > > > before transmitting to avoid triggering the hardware issue.
> > > > > > > >
> > > > > > > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > > > > > >
> > > > > > > Is this a Fix? Please add a Fixes: tag. And base it on net.
> > > > > > >
> > > > > > >
> > > https://www.kernel.org/doc/html/latest/process/maintainer-netdev.htm
> > > > > > > l
> > > > > > >
> > > > > > >     Andrew
> > > > > > >
> > > > > > > ---
> > > > > > > pw-bot: cr
> > > > > >
> > > > > > Hi Andrew,
> > > > > >
> > > > > > RTASE_MIN_PAD_LEN is not the Ethernet minimum-frame padding
> > > > > threshold.
> > > > > > It is the minimum transport-data length required by the
> > > > > > hardware parser after the packet is incorrectly detected as a P=
TP
> packet.
> > > > > >
> > > > > > Therefore, this workaround needs to pad the packets which can
> > > > > > trigger the hardware issue, rather than just padding packets
> > > > > > to the Ethernet minimum frame size.
> > > > >
> > > > > Is that a longer length?
> > > > > Excessive frame padding (beyond 60+FCS) can be treated as a
> > > > > protocol
> > > error.
> > > > >
> > > > > -- David
> > > > >
> > > > > >
> > > > > > I agree that RTASE_SHORT_PKT_THRESH is not necessary here. I
> > > > > > will remove it in the next revision.
> > > > > >
> > > > > > Yes, this is a fix. I will add a Fixes tag and repost it
> > > > > > against the net tree.
> > > > > >
> > > > > > Thanks,
> > > > > > Justin
> > > > > >
> > > >
> > > > Hi David,
> > > >
> > > > This is an IP fragmented packet, not a fragmented skb.
> > >
> > > Ok, your tests are broken for fragmented skb.
> > > skb_tail_pointer() is the end of the initial fragment, not the end
> > > of the actual data.
> > > So you could be adding padding to a full length packet making it
> > > overlong.
> > > Somewhere you need to be looking at skb->len.
> > > Probably with a fast-path check to ignore long packets.
> > >
> >
> > You're right. skb_tail_pointer() only covers the linear area and can
> > underestimate the transport-data length for non-linear skb.
> >
> > I will change the transport-data length calculation to use:
> > trans_data_len =3D skb->len - skb_transport_offset(skb);
> >
> > > >
> > > > The issue occurs on a non-initial IP fragment whose payload
> > > > contains values matching the PTP event/general destination ports
> > > > (319/320). The hardware parser incorrectly identifies the fragment
> > > > as a PTP packet and attempts further parsing.
> > >
> > > Wait a minute, what stops someone using either of those port numbers
> > > for something else?
> > > There are no hard restrictions on the use of UDP port numbers.
> > > So what does the hardware do with UDP packets to port 319/320 that
> > > are being used for something else entirely?
> > >
> >
> > If the UDP destination port is 319 or 320, the hardware will identify
> > the packet as a PTP packet and perform the corresponding PTP
> > processing.
>=20
> But aren't I allowed to run my 'frobnicate' protocol on those ports?
>
You are correct that UDP ports are not strictly bound to a specific
protocol at the networking layer.

However, 319/320 are the standardized and widely used ports for PTP
(IEEE 1588). Our hardware relies on this common usage for PTP
identification in the parser.
> >
> > > > The workaround does not modify the IP or UDP length fields. The
> > > > original protocol headers still describe the actual packet size.
> > > >
> > > > Therefore, the protocol-defined payload size remains unchanged.
> > > >
> > > > We have tested this workaround and have not observed issues caused
> > > > by the additional padding.
> > >
> > > Have you checked all the systems that might receive such packets?
> > >
> >
> > Could you clarify what kind of protocol error you are referring to?
> >
> > From my understanding, this workaround adds padding at the end of the
> > frame without modifying the IP or UDP length fields. The
> > protocol-defined packet length therefore remains unchanged.
> >
> > This appears similar to Ethernet frame padding, where additional bytes
> > may exist beyond the protocol-defined payload length. Could you
> > elaborate on how this case differs from the padding up to the Ethernet
> > minimum frame size (60 bytes + FCS)?
>=20
> The padding of short packets to 64 bytes (inc FCS) is a special case.
> I don't believe any other packets are expected to be padded.
> There have been issues when packets get extended when hardware switches
> add VLAN headers to padded packets.
> I also think you'll find bug reports caused by one of the VM 'virtual net=
work
> interfaces' adding extra padding to frames before they reach the physical
> network (possibly just making them even length).
> I can't remember the full details, it caused the company I used to work f=
or
> some issues because we had some hardware that rejected frames with
> unexpected padding, a google search showed it was a known problem with th=
at
> VM.
> A quick search showed https://www.virtualbox.org/ticket/18202
> I can't remember if that was the source of the padded packets.
>=20
> David
>=20
Thanks for the detailed feedback.

As you mentioned, some hardware may enforce strict Ethernet frame
length validation or be sensitive to tail padding beyond the
original frame size.

In our case, IP and UDP headers are not modified, and the
protocol-defined length remains unchanged. Therefore, on hardware
without strict L2 length validation, this padding is not expected
to cause issues.

However, on our hardware this workaround is required, as the
known issue can result in TX hang if not applied.

Thanks,
Justin
> >
> > Thanks,
> > Justin
> >
> > > -- David
> > >
> > > >
> > > > Thanks,
> > > > Justin
> >
> >


