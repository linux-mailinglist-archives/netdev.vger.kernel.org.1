Return-Path: <netdev+bounces-307204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id czP9LZb4VGrRiAAAu9opvQ
	(envelope-from <netdev+bounces-307204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:39:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FC174C7E9
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:39:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=flOucNVq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307204-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307204-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CACF3048ADD
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A39438004;
	Mon, 13 Jul 2026 14:33:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41A437467;
	Mon, 13 Jul 2026 14:33:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953191; cv=none; b=hsJ1KQ6RJBFhjpN2FO8qXZdzFRLHfkHY1GnZUVQuNePDhRiu0SxVVKVbvdfJt/fcwf8bFKOUouEWA534E2rDUY7tfreM+5kW3IFclcy9jyGdSBUbcv2WibsTFCpl3HB21G2W26cM8jTYsa+YnfA3n+ou8isWz/8zVEi08Bt8fM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953191; c=relaxed/simple;
	bh=6C2aQ3OVzfFeWOqmuyUxDSSpH4CnsC/zaQWSXxLFvJQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E0Mbxk67cFKvw6lJya5BD2gzcEbTfoAE2H8PV0pG8+oNBGLTj8ABTI6noDDuOwBnbjyQrPFkMqDf/C96L9CQvjrtRj17wDL1yKGtbFW2dJ/1A7JpaIieQmwYKpCGXG5ardrRVrW2fBvJqiXiS8iQpxVrR6IuFj4O4gVmvYIQ71g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=flOucNVq; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783953181;
	bh=DxJjoWdah3u6q21ag1mMWsH7fK1mx2/2QlQVzyTxgLE=;
	h=From:Subject:Date:To:Cc;
	b=flOucNVqfl/hEQ3v9C9dpPzKGXcNU7sVMB7w1eEVPgYgkmkDeBh5eRzHvROt2CVBz
	 dN3aEP1x0lnKRJmlAE7MPUyoa2NdsABR/Tnsx5OS6J2dpLfQ+8rFiOWrulkmix/GQ1
	 qQavF9RXGi3kpkVWgXjWBZOQvAsX7vlzPUvstZ5h08GJzYDRB7UFtvSwykBEGNN8u1
	 soJjT4wP4hKDclUiWFMh06XbobcbAmva9shCNecDvneeG0M39Ba8ukhG7ugUNdqGt2
	 yOnISIyojJxG925uQWfgCFIlc3bdEX6t1btD973h7/TvScBDfM2dB6FbiVb5aQ5r0t
	 AU7ZYRgBDKMTg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 02E1D608EF; Mon, 13 Jul 2026 22:33:01 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net-next v4 00/12] net: mctp: usb: Add support for
 MCTP-over-USB v1.1
Date: Mon, 13 Jul 2026 22:32:53 +0800
Message-Id: <20260713-dev-mctp-usb-1-1-v4-0-4ae8de764a01@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABX3VGoC/33OzU7DMAwH8FeZciZTXLdp2In3QByaxGVBWjLyp
 aGp707WIoHEQD5Ztn9/X1mi6Cixw+7KIlWXXPCt6R92zBwn/0rc2dazTnRSSNFzS5WfTD7zkjS
 HVnK2augnC0iKtbNzpNldVvKZecrc0yWzl22Sin4jk2/i126k99JS83ZwWzu6lEP8WF+qsDJbO
 orf6RW44EpOCDAbOerxyQRLJviUYzF5b8JpP5U1vnbf1ijwjtU1SwpsjJKgEf+x8Kel7ljYrEc
 aQcAwGKvnP6xlWT4BbI2gK4QBAAA=
X-Change-ID: 20260604-dev-mctp-usb-1-1-6fd854ad13e8
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307204-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,codeconstruct.com.au:from_mime,codeconstruct.com.au:mid,codeconstruct.com.au:email,codeconstruct.com.au:dkim,linuxfoundation.org:email,lunn.ch:email,davemloft.net:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03FC174C7E9

Version 1.1.0 of DSP0283 (MCTP over USB transport binding) has been
released, this patch series updates our current v1.0.1 support for the
changes in v1.1.x.

The major change in v1.1 is the introduction of "packet spanning" mode,
where a single MCTP packet may be split over multiple USB packets
(themselves forming a single USB bulk transfer). This relaxes the
requirement for USB high-speed mode, as we can now send MCTP packets
contained over multiple 64-byte full-speed USB bulk transfers, and gives
us an increase in the maximum MCTP packet size - we now have 13 bits of
packet length (previously 8) in the transport header.

Handling packet spanning introduces some complexity in the transmit and
receive paths, as we lose some constraints on where packet boundaries
may correspond to USB transfer boundaries, and may need to retain state
across separate transfers. To contain this complexity, we introduce a
new library for the transfer packing- and unpacking implementations,
"mctp-usblib". The host driver is a consumer of this library, and a
future gadget driver can use the same implementations. We can now also
implement tests on the API boundary of the library.

The series implements an incremental shift to mctp-usblib, then
implements packet spanning mode in the new library. We have a few
changes to prepare for this, in altering a few constants and
behaviours as v1.0-specific. Once packet spanning is implemented in
mctp-usblib, we enable it in the host-side driver.

To: Matt Johnston <matt@codeconstruct.com.au>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Changes in v4:
- fix missing rx cancel on IN urb EPIPE
- add retries for usb_clear_halt
- validate wMaxPacketSize before using for alignment
- don't KUNIT_ASSERT in test cleanup
- Link to v3: https://patch.msgid.link/20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au

Changes in v3:
- split rx urb status handling to a separate change, handle stalls
- merge tx anchor usage into initial usblib implementation
- add skb drop reasons
- prevent unnecessary skb reallocation
- Link to v2: https://patch.msgid.link/20260703-dev-mctp-usb-1-1-v2-0-60367b861b33@codeconstruct.com.au

Changes in v2:
- address sashiko reviews:
  - rx mac_header correction
  - rx/tx stats fixes
  - limit non-spanned packets (where we have no ZLP) to max size
  - handle transient rx urb error status
  - set skb_drop_reasons
  - kunit early-exit cleanups, take rntl lock where needed
- rework tx_qmem locking and anchor handling (we don't need to unanchor
  on completion)
- Link to v1: https://patch.msgid.link/20260630-dev-mctp-usb-1-1-v1-0-86a311fc67b7@codeconstruct.com.au

---
Jeremy Kerr (12):
      net: mctp: usb: Include version indicator in max packet size defines
      net: mctp: usb: Use packet-length max for maximum packet-size check
      net: mctp: usblib: Move RX transfer processing to a new mctp-usblib
      net: mctp: usb: Improve IN endpoint status handling
      net: mctp: usblib: Move TX transfer processing to mctp-usblib
      net: mctp: usblib: Add support for multi-packet transmit
      net: mctp: usb: Accommodate DSP0283 v1.1 header format
      net: mctp: usblib: Implement receive-side packet spanning
      net: mctp: usblib: Implement transmit-side packet spanning
      net: mctp: usblib: Add initial kunit tests
      net: mctp: usb: enable v1.1 packet spanning
      net: mctp: usb: Allow multiple urbs in flight

 drivers/net/mctp/Kconfig            |  16 +
 drivers/net/mctp/Makefile           |   1 +
 drivers/net/mctp/mctp-usb.c         | 347 +++++++++++---------
 drivers/net/mctp/mctp-usblib-test.c | 412 ++++++++++++++++++++++++
 drivers/net/mctp/mctp-usblib.c      | 625 ++++++++++++++++++++++++++++++++++++
 include/linux/usb/mctp-usb.h        |  88 ++++-
 6 files changed, 1335 insertions(+), 154 deletions(-)
---
base-commit: b85966adbf5de0668a815c6e3527f87e0c387fb4
change-id: 20260604-dev-mctp-usb-1-1-6fd854ad13e8

Best regards,
--  
Jeremy Kerr <jk@codeconstruct.com.au>


