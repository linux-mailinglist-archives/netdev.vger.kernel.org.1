Return-Path: <netdev+bounces-287059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKTWOXP8AmpOzQEAu9opvQ
	(envelope-from <netdev+bounces-287059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:09:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3D351E4B8
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D703B300F5D9
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBED83ACF0F;
	Tue, 12 May 2026 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="GEf9Sz8o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wDkhbfqI"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691F6346AC4
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580590; cv=none; b=nfiPq/7a2kas61ID4zKd+xCfof0J9MEm28dRSTnl5s1SPuDZ/Fuj7sl76VIhcy1hYHxIFvnztu16b9wZ2VmjTye37r0Nw4b28PLdXDzDw9NXwqklGn/QBLQVa5m/iTK5mYK//ekAahLqKXAuSNCGBfRuf7g+OQjMYTxVfpZaB5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580590; c=relaxed/simple;
	bh=s/EiGHmA1kXYEYZTPbvn9RBRpzHx0SBN2njw95bBPT0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=dZ1TfQjg3EDJFT7YW55GIZ3jJZB+SEusr9+082l7Oz4siKouzaNzrz2HV4x4uNgDiD1GlFrSVSunfPUH+P8MHBXW2mJl9pC058J4mapLqYLQhZO9sNa8faYn3zUrV36uq5TnYyEcdqCvpwntwyQlKAkFD/dE2sr44lQ31Dq9+yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=GEf9Sz8o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wDkhbfqI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 414ED14001DD;
	Tue, 12 May 2026 06:09:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 12 May 2026 06:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1778580587; x=1778666987; bh=ew+1aIxJtUB8dQ5dcedVw
	soD9yV2OQYgBG/3IC3/Heg=; b=GEf9Sz8o9vnBb8Y7ki9H3lz+lTeAUB+0bFiD/
	6OhNKFOne9yIFtNoEyADEKWlu9AzxhyrXIxXEnhvNYbsfElcrthdLVEoZixNZ1Ig
	1OOVGhggTO9rXP2abGWjHpxk6ATouTce+js6HGqKJJhiGcDf2Z7HuLVIf0NFN4zz
	sVUovxRImNEbLGLNZkCXwzYqLWh0iQis6K2lqEOwpx6HwkVJVHmaTbavbkYD8jlb
	uVhJIKdt4TFXvCSyJNsxE9BcgYqpaIzlCA80sgJvB9bPhVt04wTOqQVBn637Zd0Y
	siJ7Kz58Xbgc1EN3+msCqQmSzAZl8NWWh9kijJOupxFb1vvWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778580587; x=1778666987; bh=ew+1aIxJtUB8dQ5dcedVwsoD9yV2OQYgBG/
	3IC3/Heg=; b=wDkhbfqIhhh4An5/xm+Z4lNTFLvodE/yHjsyw3HbFg2TQSrfsuF
	KFZLXKdXDeMWMV5meI2tCkeJMl0yA/deiwlt+ixEt5WchI0ifLJGMkSRONsOMUuA
	Lgtj5QEsen9iWqIv9ud06sO2EC8pbtCI+czp1rnFp56EdZdFZKrjfYqkNpC3KszN
	SNFnr4npycPxcRJBj8a5SaSYz8Ol6ZHTROdWm2b0IoTcGPHAIl7ZZCbbnwc5GQ/V
	lykzzW6VZK+9WGP2IVyrvAizRIdE1pfWbMpU+NmpF71BSFbL5VsBR/EWmSXgHABp
	vDu31Znb97xdnpaHh9pvwkKFbYT480D74VQ==
X-ME-Sender: <xms:avwCapZIKMZ4Drs0ajWaMecJZd14AoYblzXmDtoN8pVBCfgfjq7haw>
    <xme:avwCaom8F1GYMzVBJqrST9FdNC0k9J5Fic6aZBOciEHtZ8gdOt3Ml1vuYE2yb4cL3
    TLenwB4nCGEX7rTTUsJ5l71R2dUhEbAv0xQ-JdtZyJVQKbrvsrMbgo>
X-ME-Received: <xmr:avwCangeRQBKqPyu6tE5DumQBXBBZhl3u7bL-VjJabmG0T23ra_00zR7uU9p4ZrWGj7AnhOabQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdduhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveelffduvdevfedtheffffetfeff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheplhhouhhishdrshgtrghlsggvrhhtseeifihinhgurdgtoh
    hmpdhrtghpthhtohepjhhonhgrshdrghhorhhskhhisehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmrghhvg
    hshhgssehgohhoghhlvgdrtghomhdprhgtphhtthhopegrnhguhiesghhrvgihhhhouhhs
    vgdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehfsghlsehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:a_wCaiRP5r_IoTKAjdG4ufa6rIuz8HSKHMakLOY23G7F5deEhaJwTw>
    <xmx:a_wCagZOqMSDDmZV2VjbTUmjFRHzVGrMag80dmYTpuRT1VGyiOXjKQ>
    <xmx:a_wCanRvLwqBjU9OPl-tthiIKAWyLhRyMQsvH9CsSHFTEEBWIgIwHg>
    <xmx:a_wCan_HDxv3x-xT7SWELVqzkQKlWGON7a9E9CWsD3F8Le31ztjKNA>
    <xmx:a_wCamStpJAD1hdussc8MEEzvLhJPc2-Plvn4ThXOeDIuLzz6lsupTcq>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 06:09:46 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 19D911C0379; Tue, 12 May 2026 03:09:45 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 190B51C0369;
	Tue, 12 May 2026 12:09:45 +0200 (CEST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Louis Scalbert <louis.scalbert@6wind.com>
cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
    andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com,
    jonas.gorski@gmail.com
Subject: Re: [PATCH net v5 3/4] bonding: 3ad: fix mux port state on oper down
In-reply-to: <20260506161144.465485-4-louis.scalbert@6wind.com>
References: <20260506161144.465485-1-louis.scalbert@6wind.com> <20260506161144.465485-4-louis.scalbert@6wind.com>
Comments: In-reply-to Louis Scalbert <louis.scalbert@6wind.com>
   message dated "Wed, 06 May 2026 18:11:43 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <150322.1778580585.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 12:09:45 +0200
Message-ID: <150323.1778580585@vermin>
X-Rspamd-Queue-Id: EB3D351E4B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287059-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Louis Scalbert <louis.scalbert@6wind.com> wrote:

>When the bonding interface has carrier down due to the absence of
>usable slaves and a slave transitions from down to up, the bonding
>interface briefly goes carrier up, then down again, and finally up
>once LACP negotiates collecting and distributing on the port.
>
>When lacp_strict mode is on, the interface should not transition to
>carrier up until LACP negotiation is complete.
>
>This happens because the actor and partner port states remain in
>Collecting_Distributing when the port goes down. When the port
>comes back up, it temporarily remains in this state until LACP
>renegotiation occurs.
>
>Previously this was mostly cosmetic, but since the bonding carrier
>state may depend on the LACP negotiation state, it causes the
>interface to flap.
>
>Move an operationally down port to the Mux WAITING state and clear the
>Synchronization, Collecting, and Distributing states, in accordance with
>the 802.1AX Mux state machine diagram.
>
>Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
>Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
>---
> drivers/net/bonding/bond_3ad.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index 1247a1e048df..b531f68a24b0 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -1055,6 +1055,8 @@ static void ad_mux_machine(struct port *port, bool =
*update_slave_arr)
> 	aggregator =3D rcu_dereference(port->aggregator);
> 	if (port->sm_vars & AD_PORT_BEGIN) {
> 		port->sm_mux_state =3D AD_MUX_DETACHED;
>+	} else if (!port->is_enabled && port->sm_mux_state !=3D AD_MUX_DETACHED=
) {
>+		port->sm_mux_state =3D AD_MUX_WAITING;

	Repeating my comment here from the prior version of the patch
series, that this doesn't seem to comply with the standard.  Bonding
should comply with IEEE 802.1AX-2014, and I do not want to mix and match
from different versions of the standard.  The state machines differ
between versions, and I don't know if a half-and-half implementation
will function correctly.  The 2020 edition of the standard diverges
significantly from prior versions, and bonding is very close to the 2014
standard.

	-J



> 	} else {
> 		switch (port->sm_mux_state) {
> 		case AD_MUX_DETACHED:
>@@ -1202,6 +1204,11 @@ static void ad_mux_machine(struct port *port, bool=
 *update_slave_arr)
> 			break;
> 		case AD_MUX_WAITING:
> 			port->sm_mux_timer_counter =3D __ad_timer_to_ticks(AD_WAIT_WHILE_TIME=
R, 0);
>+			port->actor_oper_port_state &=3D ~LACP_STATE_SYNCHRONIZATION;
>+			ad_disable_collecting_distributing(port,
>+							   update_slave_arr);
>+			port->actor_oper_port_state &=3D ~LACP_STATE_COLLECTING;
>+			port->actor_oper_port_state &=3D ~LACP_STATE_DISTRIBUTING;
> 			break;
> 		case AD_MUX_ATTACHED:
> 			if (aggregator->is_active)
>-- =

>2.39.2
>

---
	-Jay Vosburgh, jv@jvosburgh.net

