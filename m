Return-Path: <netdev+bounces-278179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLsvBI443Wk3awkAu9opvQ
	(envelope-from <netdev+bounces-278179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:40:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1831C3F22B1
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 085F730160C1
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E5C38C2A4;
	Mon, 13 Apr 2026 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="RUpaAz/O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fURx7+dd"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85E23264FD
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776105597; cv=none; b=EOKjUua7Tzw8Nonh/teHrMNPe5r3NDto0TvotscAMH0Pyp0vSIFrQZIBuPMgGvg9/EUkPcPhrxb7uTDqCkIFTdsOaRGQ+/WsNz4s1fdNSgqa64BzaWWYraQKbTPfSrEaBF4CZ+9TxMZPXa3IZmWaBU/xRG6N4ubKoxKKI41oTe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776105597; c=relaxed/simple;
	bh=rl7zRYx8B9DrK07mJpQKm7OYgr8gvfeXh+87Ok+qE6o=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=sQBzAMP81qQl2qxI0sS9ZsCBoJ1xbPK7IfhE0ezIqes7H+pq5OdMm5bmKggbBzdrP1w0drNhBL+My3Sa1f89Bborg2dskOn8OJaWHsZM/1mTC17ZDNoJEgQKf3VgtCgSxdR3VzIv+7LnMgog8IYMrN/rEZ9n3z07HINkV8utfIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=RUpaAz/O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fURx7+dd; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BBED41400057;
	Mon, 13 Apr 2026 14:39:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 14:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1776105590; x=1776191990; bh=6LD3YFTK7K77B/ulNguuD
	hs9cmDF5i881u9BF5Ps/38=; b=RUpaAz/OFXSKv4TtfvhxWgaC0IfMDRavuf3bH
	C2NT4b3WYAu0kR+ulxzulNjCO/iojEygm+wIcizclcikgpyO8UWOvF5mRQBY7y2/
	z5XjIMZiBW77nnGsGDZZtIt4/Ap3sW+6ZwbFp5IeBMXojAAZ2GBqYwyitU+iBKCw
	kobNHgGYEK/cWUpkr0kfFNU+uM4JShWK97PN8MDUUXuSA46UprpoHikvedogqQKp
	qUWukdw5RGFD5jMosHqaIguG+IT0IPovMbZFVSTDZXVdC1svtELT3TfSu6JtwP8r
	o4VA6qOTZFDw0IwuJW/sycMaAfo8CzCEjUUamqZgNKwLsns2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776105590; x=1776191990; bh=6LD3YFTK7K77B/ulNguuDhs9cmDF5i881u9
	BF5Ps/38=; b=fURx7+ddfWb7jGjw50a1Nm08GbHpJRcm4axMFZY8GF0QCpY0ywy
	rpjM7SXh/oOwHJPpmAbMPFMgQuway3WhaRJGUIeVMeEqWZS+/+iYcSg9dj4sdUW3
	bBaEUTSySBINlDXfOx1Z8rrqFyID5ENrhOzzX2sVnJvdVrS33TKWMwh4DY8aNAw+
	ZZbBOzy1T07VDPNz1tnHaYKPrPm2vIdwIf8LcFKXH0W8n/w5dM65h0Pz2StGzW+k
	w/S03Z6fU41v092xpksSQiUErMEAw2jn4vK94TcnGspywJbN+Q/FzLwlwFs4xGHn
	Ompu6VXfUZLXTuYrW+mORwXtw1ns0uz4ETQ==
X-ME-Sender: <xms:djjdaWIKFRhEXgXzf4F7SzpLEB8TCOl1q66XAmlrrvIKwny-idSXkQ>
    <xme:djjdaatebS6-MpiE1cj7s8W7mtRiBMlUYEetTOo65ZZ9z3jGOndeL-t5SGm1rF-kX
    pGGFlxqDNjWgLfKy7UwigJGzyO612bQBn_c_07DBh0mWTI7noKFVAw>
X-ME-Received: <xmr:djjdabIp6QqJZuHN23Vnb9BKflenJh1lrHaN_N4vLN7qZR8I1fdpZ_-d-Ty0gRdt5s5_Xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvdenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeifedvleefleejveethfefieduueeivdefieevleffuddvveeftdehffffteefffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlohhuihhsrdhstggrlhgsvghrthesieifihhnugdrtghomh
    dprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    mhgrhhgvshhhsgesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghnugihsehgrhgvhi
    hhohhushgvrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepfh
    gslhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:djjdaSOuSR3H3RmUei8wd3PO6SSVB9pGo593QafwBLqEq6SkM0q9IA>
    <xmx:djjdaeVuNOlxXnOjrs-JgTkp2zWNAdG3WHUExtgGs2LwH4OhMNt1ww>
    <xmx:djjdaQltExExOCBjizHsUYvVnw3dxYjayJspJ1Rx2WbsycI0QH7Rpg>
    <xmx:djjdadPrR58s7mC_AToCzi7DRJrDvnF9_mU-ONotUxeoVBZzFU2Bow>
    <xmx:djjdabSyFNqOQJKmglhF9H03IsshUwQIDy0jYat5y3Sdb6eeVfsMDtSi>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 14:39:49 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id EA07E9FB3D; Mon, 13 Apr 2026 11:39:48 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id E91BD9FB3C;
	Mon, 13 Apr 2026 11:39:48 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Louis Scalbert <louis.scalbert@6wind.com>
cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
    andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com
Subject: Re: [PATCH net v3 4/5] bonding: 3ad: fix stuck negotiation on
 recovery
In-reply-to: <20260408152353.276204-5-louis.scalbert@6wind.com>
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
 <20260408152353.276204-5-louis.scalbert@6wind.com>
Comments: In-reply-to Louis Scalbert <louis.scalbert@6wind.com>
   message dated "Wed, 08 Apr 2026 17:23:52 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <710786.1776105588.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 11:39:48 -0700
Message-ID: <710787.1776105588@famine>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278179-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1831C3F22B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Louis Scalbert <louis.scalbert@6wind.com> wrote:

>The previous commit introduced a side effect caused by clearing the
>SELECTED flag on disabled ports. After all ports in an aggregator go
>down, if only a subset of ports comes back up, those ports can no
>longer renegotiate LACP unless all aggregator ports come back up.
>
>1. All aggregator ports go down
>  - The SELECTED flag is cleared on all of them.
>2. One port comes back up
>  - Its SELECTED flag is set again.
>  - It enters the WAITING state and gets its READY_N flag.
>  - The remaining ports stay UNSELECTED. Because of that, they cannot
>  enter the WAITING state and therefore never get READY_N.

	This is the part that I think we may be doing something else
incorrectly.  If the port is UNSELECTED, then that means that no
aggregator is currently selected for that port, and therefore it
shouldn't be assigned to an aggregator with other ports (per
802.1AX-2014 6.4.8, "Selected").

	I'm not seeing anything in the 6.4.14 Selection Logic that makes
me think a port that is down (port_enabled =3D=3D FALSE) is disallowed fro=
m
being SELECTED.

	Looking at the Receive machine state diagram (Figure 6-18), I
tend to think that in this case the port would transition to
PORT_DISABLED state, as we're not asserting a BEGIN (reinitialization of
the LACP protocol entity), so the port variables can remain unchanged.
There's even some language that suggests this is intentional:

	"If the Aggregation Port becomes inoperable and the BEGIN
	variable is not asserted, the state machine enters the
	PORT_DISABLED state. [...] This state allows the current
	Selection state to remain undisturbed, so that, in the event
	that the Aggregation Port is still connected to the same Partner
	and Partner Aggregation Port when it becomes operable again,
	there will be no disturbance caused to higher layers by
	unnecessary re-configuration.

	So, perhaps the actual bug is that these ports are attached to
the aggregator but not SELECTED.

	-J


>  - __agg_ports_are_ready() returns 0 because it finds a port without
>  READY_N.
>  - As a result, __set_agg_ports_ready() keeps the READY flag cleared on
>  all ports.
>  - The port that came back up is therefore not marked READY and cannot
>  transition to ATTACHED.
>  - LACP negotiation becomes stuck, and the port cannot be used.
>3. All aggregator ports come back up
>  - They all regain SELECTED and READY_N.
>  - __agg_ports_are_ready() now returns 1.
>  - __set_agg_ports_ready() sets READY on all ports.
>  - They can then transition to ATTACHED.
>  - Negotiation resumes and the aggregator becomes operational again.
>
>Consider only ports currently in the WAITING mux state for READY_N in
>order to avoid __agg_ports_are_ready() to return 0 because of a disabled
>port. That matches 802.3ad, which states: "The Selection Logic asserts
>Ready TRUE when the values of Ready_N for all ports that are waiting to
>attach to a given Aggregator are TRUE.".
>
>Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
>Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
>---
> drivers/net/bonding/bond_3ad.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index 3a94fbcbf721..3f56d892b101 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -700,7 +700,8 @@ static void __update_ntt(struct lacpdu *lacpdu, struc=
t port *port)
> }
> =

> /**
>- * __agg_ports_are_ready - check if all ports in an aggregator are ready
>+ * __agg_ports_are_ready - check if all ports in an aggregator that are =
in
>+ * the WAITING state are ready
>  * @aggregator: the aggregator we're looking at
>  *
>  */
>@@ -716,6 +717,8 @@ static int __agg_ports_are_ready(struct aggregator *a=
ggregator)
> 		for (port =3D aggregator->lag_ports;
> 		     port;
> 		     port =3D port->next_port_in_aggregator) {
>+			if (port->sm_mux_state !=3D AD_MUX_WAITING)
>+				continue;
> 			if (!(port->sm_vars & AD_PORT_READY_N)) {
> 				retval =3D 0;
> 				break;
>-- =

>2.39.2
>

---
	-Jay Vosburgh, jv@jvosburgh.net

