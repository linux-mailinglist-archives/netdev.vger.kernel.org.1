Return-Path: <netdev+bounces-278137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HXgFjMj3WkYaQkAu9opvQ
	(envelope-from <netdev+bounces-278137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:09:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C573F0D70
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36BE1309C6FE
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2289E340A6A;
	Mon, 13 Apr 2026 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="RiVbdnDm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K1hsHPrr"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4633F5B9
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099711; cv=none; b=stwKeQBEtQS5e79Nx2J/P0ac6AVogO0ZGS4sao75vD/1IV+7zRD/NmwhsC9DoeHVG9TRlmIUivCNTlJTvR/Jj0bClPMQ8VkRHYgPYuM1nie/+TChkhCyJfPlNekvJxaD/cSjeRBs6RM6JG+u57BpqL8dywK7BN8vy1bcIF9urvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099711; c=relaxed/simple;
	bh=TSwlAxL3NIy7mLB+6aUnVA8Iz5kB692n3v2BWl6dU08=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=DJuv2Zesz9OYxx7q2VvXWek4936MAyxtGYWuPYQj9esU8Dk7Of2tOr3o9lsxtochZwhB5lNX+vXmcAf2D5XdoRLMajpAuDQF+IG/nb/aECV0nU2y2fc0zgyhqePHFSCsAKMWMgV7X1/54OO5bXYACwCp0RB0l+rni+t8h6cgsAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=RiVbdnDm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K1hsHPrr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AD7C9EC04BC;
	Mon, 13 Apr 2026 13:01:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 13:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1776099708; x=1776186108; bh=9bzSv8ANBPRBYyxxhF6AW
	01Hs9b9FGc45068WeohEuo=; b=RiVbdnDm06VoZLwqnO/jZAyQ77QIvZha8LG0C
	+9rO4qMzf/x0Pa4SEiO01f8DywECqfMPrGfUdfYNE/7rge5dEwuV2949fGn6M+x0
	CANAfv1hh0GvvFG1bZ8fLzOM6uiBasbSllRUUreyyluM7aDborzNArz57CjXSwP8
	tlVXsLUsTQqYwOF9VrEfQAXCBImezfcm+5jE/pTUHUU+3eA84eIwkhEbpmULC0Gl
	JMARw/IdPAJhUQiGeIgh8m9VlCjrFPDlQ1VDfMb2ZhrqobxgyV81PuQ9zuo0NHPN
	9I4xHAB0Cj1hCEwhMsNrgs0pEMGCaETm60OFqWzkBpcmYOcog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776099708; x=1776186108; bh=9bzSv8ANBPRBYyxxhF6AW01Hs9b9FGc4506
	8WeohEuo=; b=K1hsHPrr3e0J9gwbc9QfPOLMkIOjOU+pKKVw2094zgzbu7EjVaG
	Y1zCOFei0B86QVkhSdhyvXAlrBO8PubtrRou3FJUjNiBEaJd2EokPGCVzcWITmae
	Gh5LSv/Hf1OgTOmJO880SHgv+T+Eba3JaNxA2mhkMsdxs2GbpkbBa3x2QdRxukFx
	e9bbwDYzByu33ceLay7i9qKraHXjMxbbFZK5OWyCVLIfe1xW6tpx8RitJuZFntJY
	aUpfh5y9/y06znr4JUdEksai2yfe1d1kx/XnMd5AhhR+3PbVHa0MqJnZ2O5auhTx
	TmUE/OzoRFYHvwrQt/c3YHYRbXQF7DjFmJA==
X-ME-Sender: <xms:fCHdaQyNV3uZUH3fYPY6VcdUFcWddGm_M_1FhHZ6zYv5qh2MkpZ7Mg>
    <xme:fCHdaQ292xOzQ28CKdkiLtzHHpdYqH4JTqBy-FV_r_NA_ZEHtTiwK_bYdgCmMlRQe
    SmRf7UbGg5k2nyKIJUzC_pCb67hPPd-MVHJ43zJWDAqfsd8-bLNbfs>
X-ME-Received: <xmr:fCHdaWxlC-IcL0irtJihbuwh0iuop1866beg9gdAwzKb1nLWFlcKhtsRAjdTtDd2t-8kgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeejkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:fCHdaVU4_tMiKF_uhiMmGsypA_ElDvFV5URbRId2La4AtMU-iyx7lw>
    <xmx:fCHdaS8yVKpCTM0LY5Nh56P-3sJ4_AVKQNYK3X6rjK7P8Wmpvm1byA>
    <xmx:fCHdaYsPRglwSYlBYpOTHBJp83yA59MpIo3qJ6MFtSvI2FnC_v3wOQ>
    <xmx:fCHdaS3pr1b3-IGFI9hYFaK3kWTmDRi9-Q2mCuOOuaB0043IppFfpg>
    <xmx:fCHdaY4Zs30YQCIBsadlvmFSUUThUKZuLzhCtILnUfsCzqcXIoIYF_Ij>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 13:01:48 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 37BBD9FB3D; Mon, 13 Apr 2026 10:01:47 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 34B519FB3C;
	Mon, 13 Apr 2026 10:01:47 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Louis Scalbert <louis.scalbert@6wind.com>
cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
    andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com
Subject: Re: [PATCH net v3 2/5] bonding: 3ad: fix carrier when no valid slaves
In-reply-to: <20260408152353.276204-3-louis.scalbert@6wind.com>
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
 <20260408152353.276204-3-louis.scalbert@6wind.com>
Comments: In-reply-to Louis Scalbert <louis.scalbert@6wind.com>
   message dated "Wed, 08 Apr 2026 17:23:50 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <707938.1776099707.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 10:01:47 -0700
Message-ID: <707939.1776099707@famine>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278137-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,6wind.com:email,messagingengine.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E9C573F0D70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Louis Scalbert <louis.scalbert@6wind.com> wrote:

>Apply the "lacp_fallback" configuration from the previous commit.
>
>"lacp_fallback" mode "strict" asserts that the bonding master carrier
>only when at least 'min_links' slaves are in the collecting/distributing
>state (or collecting only if the coupled_control default behavior is
>disabled).
>
>Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
>Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
>---
> drivers/net/bonding/bond_3ad.c     | 26 ++++++++++++++++++++++++--
> drivers/net/bonding/bond_options.c |  1 +
> 2 files changed, 25 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index af7f74cfdc08..b79a76296966 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -745,6 +745,22 @@ static void __set_agg_ports_ready(struct aggregator =
*aggregator, int val)
> 	}
> }
> =

>+static int __agg_valid_ports(struct aggregator *agg)
>+{
>+	struct port *port;
>+	int valid =3D 0;
>+
>+	for (port =3D agg->lag_ports; port;
>+	     port =3D port->next_port_in_aggregator) {
>+		if (port->actor_oper_port_state & LACP_STATE_COLLECTING &&
>+		    (!port->slave->bond->params.coupled_control ||
>+		     port->actor_oper_port_state & LACP_STATE_DISTRIBUTING))
>+			valid++;

	Do we need to test coupled_control?  I.e., can the test be

		if ((port->actor_oper_port_state & LACP_STATE_COLLECTING) &&
		    (port->actor_oper_port_state & LACP_STATE_DISTRIBUTING))

	To my reading, ad_mux_machine will set _COLLECTING and
_DISTRIBUTING appropriately regardless of the coupled_control selection.

>+	}
>+
>+	return valid;
>+}
>+
> static int __agg_active_ports(struct aggregator *agg)
> {
> 	struct port *port;
>@@ -2120,6 +2136,7 @@ static void ad_enable_collecting_distributing(struc=
t port *port,
> 			  port->actor_port_number,
> 			  port->aggregator->aggregator_identifier);
> 		__enable_port(port);
>+		bond_3ad_set_carrier(port->slave->bond);
> 		/* Slave array needs update */
> 		*update_slave_arr =3D true;
> 		/* Should notify peers if possible */
>@@ -2141,6 +2158,7 @@ static void ad_disable_collecting_distributing(stru=
ct port *port,
> 			  port->actor_port_number,
> 			  port->aggregator->aggregator_identifier);
> 		__disable_port(port);
>+		bond_3ad_set_carrier(port->slave->bond);
> 		/* Slave array needs an update */
> 		*update_slave_arr =3D true;
> 	}
>@@ -2819,8 +2837,12 @@ int bond_3ad_set_carrier(struct bonding *bond)
> 	}
> 	active =3D __get_active_agg(&(SLAVE_AD_INFO(first_slave)->aggregator));
> 	if (active) {
>-		/* are enough slaves available to consider link up? */
>-		if (__agg_active_ports(active) < bond->params.min_links) {
>+		/* are enough slaves in collecting (and distributing) state to conside=
r
>+		 * link up?
>+		 */
>+		if ((bond->params.lacp_fallback ? __agg_valid_ports(active)
>+					: __agg_active_ports(active)) <
>+		    bond->params.min_links) {

	I think the original comment is better; if the new option is
off, it doesn't require collecting / distributing state.

	-J

> 			if (netif_carrier_ok(bond->dev)) {
> 				netif_carrier_off(bond->dev);
> 				goto out;
>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bon=
d_options.c
>index b672b8a881bb..d64a5d2f80b6 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -1706,6 +1706,7 @@ static int bond_option_lacp_fallback_set(struct bon=
ding *bond,
> 	netdev_dbg(bond->dev, "Setting LACP fallback to %s (%llu)\n",
> 		   newval->string, newval->value);
> 	bond->params.lacp_fallback =3D newval->value;
>+	bond_3ad_set_carrier(bond);
> =

> 	return 0;
> }
>-- =

>2.39.2
>

---
	-Jay Vosburgh, jv@jvosburgh.net

