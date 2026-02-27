Return-Path: <netdev+bounces-261724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DajMeggoWn8qQQAu9opvQ
	(envelope-from <netdev+bounces-261724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 05:43:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 755531B2BCC
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 05:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DECE730BA38D
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C44E361678;
	Fri, 27 Feb 2026 04:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="LQzQ5yp6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CkjBL2Fp"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D696B1A9FB0;
	Fri, 27 Feb 2026 04:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772167353; cv=none; b=I9zRbln9rfrYQr5K6uAY57XSdL8FXdz3EjLB3n+1oWLNYI9+eLo1PTS3s6BcleyHDprzzUUH9chqieCmAVzKE4XCEyak1Z7ynKRkZgGiEUk3QUoHJytzCRZtpXx8ck7qwyJs1src2nOJzYdiKxPPsM9DC7eMwqnROsgAXqkAtVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772167353; c=relaxed/simple;
	bh=7y3RMMyAYG/EKWdMMTly4iL0SkcifOpP8P6zLcM8vRE=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=KMeyE18qSA1TvpvCf83E/fd0NDk28hLtKQZzbjEhI9QL2OY0UPV/rYH9gk3srodYOdMWBOgClz/5tmvKpG9pf3eikX1cMvje3fyC/+kBiEnXnRwEMSdJpsSlmQUiuzywSwvwxkJmnc7sG5+rwgQbfOjQI4hEL5w6S3jFHhVZUco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=LQzQ5yp6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CkjBL2Fp; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A252C7A019E;
	Thu, 26 Feb 2026 23:42:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 26 Feb 2026 23:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1772167349; x=1772253749; bh=JyTv8Fv1CdXDKBbiR7U/2YmgszUN6Acy
	NlfJRrAbLFU=; b=LQzQ5yp6Vgnt29VyNhtuc8EON/Bh8rAxW8fCNHcAWshBSOiT
	Ak4EjSjFPd02lsvFR+fgVKLa3hWjIaYE9HPiregWRGB+Do/ID9+MbKtvZOStfnnG
	jUEgD/QPOoamPkMo9CWZB48jg/qyFvqceKnSpZUr+lB4B8KwyJ+tK8kXeZDvRtXz
	4DXGm8X8GzF6x8qsGEseH/3jC8M4uRwd2NR03tX44Ss4kWZIBq96NP4qHcEkYU+1
	TTiY6f8hieQ8g9bwrrOVniIVHKFuyUYDFUt06n4mqdu0Xx9yfTBAKsDnx/caL0Le
	g5My6+VEX2uPZvktkH/wCK0xK395XXz4A/zh9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772167349; x=
	1772253749; bh=JyTv8Fv1CdXDKBbiR7U/2YmgszUN6AcyNlfJRrAbLFU=; b=C
	kjBL2FpG3dqpKWzMmQTZ2Tjpz7AqITKotuxaxQX2nFT6YNNp84ZqMhnKROFRNJq+
	Fnsv0V0f52nI+Wj2QcmpVFavt5I/3Ie79QSCuFJbipS55mXiODFZiBaE7I2k8nVd
	yaKNk75RtGID/jqVQysOqHwsc3PZcStJP2jN0viEgh8XKdaWwXqOE/y9hGfvcKw3
	j2zfT0/wxhBQ2nyafof6UphNJqv85UxNhyFaW9/c4q3iCo+KrGJW0ysGV8LiyCRs
	aer2hyeC1XBVcruGXyCXbplt7ge+sCh9B5xRmdrNBAFxiJTN3dqHJ7fWzT1eiO24
	lMnpMu06q9QiMKCl+M2uQ==
X-ME-Sender: <xms:tCChaYxRpTvIrzNCsQO-JRBgecYafpoDTZU8MDoGvUnLQ4c44L_K5Q>
    <xme:tCChaUZStqwSH8ySc264kw9kLjSo0Pb5PPprxuAYXKhcbahA1-NSJ3cy333xpOGuX
    fUzvp_JqPAxibfZUgKxm1KYLiCqyKTApI7Ytt3vzjruNJqoD0zi67k>
X-ME-Received: <xmr:tCChaZ35rK3uMA1eSqEKVCrb9jLHBy9nIesHlnia3OuN4gbBI17OHmZMo8YlsMpVJJgUwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeektdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertdejnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepgeefgffhgffhhfejgfevkefhueekvefftefhgfdtuddtfeffueehleegleeiuefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrghdprhgtph
    htthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheplhhiuhhh
    rghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehmrghhvghshhgssehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhu
    nhhnrdgthhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:tCChaWfUD_CPDtqVowSrmD9HFGoWzAufbbWTYsFAhhL-VNIvbCis5g>
    <xmx:tCChaWIbdg1iKKneFO7qwb2QFDfZ1PpmneS0dOldX3BzQPgNqdcYgw>
    <xmx:tCChaUpUqXdDxV5AiiZyKhrYuuoV_Deo4UlIwqBf3FaSWOg8HrE2yw>
    <xmx:tCChaUtq9Y3ouEfKxsVeV-KjSUSRyJyXps_punLtZqh6IlgybbAklg>
    <xmx:tSChaalHtglhi6r6eMxClpKKv08Dt2V2iHtXdveeBWttmX57P8Mb0CXC>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 23:42:28 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id A3CF29FCB1; Thu, 26 Feb 2026 20:42:27 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id A2D089FC39;
	Thu, 26 Feb 2026 20:42:27 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Mahesh Bandewar <maheshb@google.com>, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net 1/3] bonding: set AD_RX_PORT_DISABLED when disabling a port
In-reply-to: <aaEB6X6WPs7EBM33@fedora>
References: <20260226125331.28147-1-liuhangbin@gmail.com> <20260226125331.28147-2-liuhangbin@gmail.com> <942584.1772155015@famine> <aaEB6X6WPs7EBM33@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Fri, 27 Feb 2026 02:31:05 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Feb 2026 20:42:27 -0800
Message-ID: <949695.1772167347@famine>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261724-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jvosburgh.net:email,jvosburgh.net:dkim,messagingengine.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 755531B2BCC
X-Rspamd-Action: no action

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Thu, Feb 26, 2026 at 05:16:55PM -0800, Jay Vosburgh wrote:
>> Hangbin Liu <liuhangbin@gmail.com> wrote:
>>=20
>> >When disabling a port=E2=80=99s collecting and distributing states, upd=
ating only
>> >rx_disabled is not sufficient. We also need to set AD_RX_PORT_DISABLED
>> >so that the rx_machine transitions into the AD_RX_EXPIRED state.
>> >
>> >One example is in ad_agg_selection_logic(): when a new aggregator is
>> >selected and old active aggregator is disabled, if AD_RX_PORT_DISABLED =
is
>> >not set, the disabled port may remain stuck in AD_RX_CURRENT due to
>> >continuing to receive partner LACP messages.
>>=20
>> 	I'm not sure I'm seeing the problem here, is there an actual
>> misbehavior being fixed here?  The port is receiving LACPDUs, and from
>> the receive state machine point of view (Figure 6-18) there's no issue.
>> The "port_enabled" variable (6.4.7) also informs the state machine
>> behavior, but that's not the same as what's changed by bonding's
>> __disable_port function.
>
>Yes, the reason I do it here is we select another aggregator and called
>__disable_port() for the old one. If we don't update sm_rx_state, the port
>will be keep in collecting/distributing state, and the partner will also
>keep in the c/d state.
>
>Here we entered a logical paradox, on one hand we want to disable the port,
>on the other hand we keep the port in collecting/distributing state.

	"disable" the port here really means from bonding's perspective,
so, generally equivalent to the backup interface of an active-backup
mode bond.

	Such a backup interface is typically carrier up and able to send
or receive packets.  The peer generally won't send packets to the backup
interface, however, as no traffic is sent from the backup, and the MAC
for the bond uses a different interface, so no forwarding entries will
direct to the backup interface.

	There are a couple of special cases, like LLDP, that are handled
as an exception, but in general, if a peer does send packets to the
backup interface (due to a switch flood, for example), they're dropped.

>> 	Where I'm going with this is that, when multiple aggregator
>> support was originally implemented, the theory was to keep aggregators
>> other than the active agg in a state such that they could be put into
>> service immediately, without having to do LACPDU exchanges in order to
>> transition into the appropriate state.  A hot standby, basically,
>> analogous to an active-backup mode backup interface with link state up.
>
>This sounds good. But without LACPDU exchange, the hot standby actor and
>partner should be in collecting/distributing state. What should we do when
>partner start send packets to us?

	Did you mean "should not be in c/d state" above?  I.e., without
LACPDU exchage, ... not in c/d state?

	Regardless, as above, the situation is generally equivalent to a
backup interface in active-backup mode: incoming traffic that isn't a
special case is dropped.  Normal traffic (bearing the bond source MAC)
isn't sent, as that would update the peer's forwarding table.

	Nothing in the standard prohibits us from having multiple
aggregators in c/d state simultaneously.  A configuration with two
separate bonds, each with interfaces successfully aggregated together
with their respective peers, wherein those two bonds are placed into a
third bond in active-backup mode is essentially the same thing as what
we're discussing.

	-J

>> 	I haven't tested this in some time, though, so my question is
>> whether this change affects the failover time when an active aggregator
>> is de-selected in favor of another aggregator.  By "failover time," I
>> mean how long transmission and/or reception are interrupted when
>> changing from one aggregator to another.  I presume that if aggregator
>> failover ater this change requires LACPDU exchanges, etc, it will take
>> longer to fail over.
>
>I haven't tested it yet. I think the failover time should be in 1 second.
>Let me do some testing today.
>
>Thanks
>Hangbin

---
	-Jay Vosburgh, jv@jvosburgh.net


