Return-Path: <netdev+bounces-301584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rbKnMWqgO2oVaggAu9opvQ
	(envelope-from <netdev+bounces-301584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:16:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1AF6BCDAA
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:16:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=siemens.com header.s=fm2 header.b=WOD+7mbc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301584-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301584-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=siemens.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A913E3002B62
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEAD399000;
	Wed, 24 Jun 2026 09:16:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FE2FFDCB
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 09:16:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292579; cv=none; b=oVaATiZLNnK+MmS//LHJi8PusAr17zH3z/DPqVRnpyOyipqzaJJEXw46Wkcs9fTdpxI2ibslOJ32fjgTOKjcOsnKo/FeVeG4rUyBqccRDULzt8CndL9rMXZnsY2u+bO5LmLkBl4yWtcKnSefvwuMhAGxJMPNzuzkgWIBau2hoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292579; c=relaxed/simple;
	bh=QiWIjcMfepogTQ8m3dZSNpdDaUNEGUThKgp20EEM0aU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=su78+acIiIaLrlcxHXTxKOuG7lsOkb5GyQG2QZ0WHNGvFCp12SMGKP3lm/fZfuG0cfwQjo1cI1i3gpvgERVPgVLPa/taU/m0a4Lloc1mJxyoEjLPU+adDRwEA+Ian8dCRvX4h9CCNrRaPtVHnTF52KhSD01gXEa2uaJNnVDSwM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=WOD+7mbc; arc=none smtp.client-ip=185.136.64.225
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260624090548b83a4b199f0002071c
        for <netdev@vger.kernel.org>;
        Wed, 24 Jun 2026 11:05:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vaGEfv49Djl7XHA+73D3Wb5KsXWur6bTFEQS2FZ+C7s=;
 b=WOD+7mbcMXGo8W/tbSW9q6lm68GGIhbjhsH/RzXQlMMZWqPPgiwT52thc4GmWTX8IxMXiq
 5foW8l0aaVV/SbWotttfe3W3pmkfyX70rTEIHKLNIARIUHYnilWMgqFe/js+Llne+PoX5dUw
 0HTJ574wQMznPRpMR5Bz/axqYdCvXPeivrnsAyiN7jvCCdjOep8qcJWetpR0Oh6TZYaDbJbC
 8wL1v3WMYsy+wGh24bNJTFT8DfuGwkY5iV0URrO03L1Ymgxfo6GqvbH8JqpKYuJGHzejcJYY
 4WYV0x07tGIFeJHvLFD737euqgPiBE+JVOaYXtq+QZXqxyiOtMcP99rQ==;
Message-ID: <d058b0fa9ad923514084a44f51c78ae8355c4ebb.camel@siemens.com>
Subject: Re: [Intel-wired-lan] [PATCH net] igc: Fix RX HW timestamp
 reporting when NET_RX_BUSY_POLL is disabled
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>, Ding Meng	
 <meng.ding@siemens.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"	
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
 "kuba@kernel.org"	 <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "Kiszka, Jan"	 <jan.kiszka@siemens.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, "wq.wang@siemens.com" <wq.wang@siemens.com>
Date: Wed, 24 Jun 2026 11:05:47 +0200
In-Reply-To: <BL1PR11MB59796B99C5A7709B07000D68F3EE2@BL1PR11MB5979.namprd11.prod.outlook.com>
References: <20260622041718.6106-1-meng.ding@siemens.com>
	 <BL1PR11MB59796B99C5A7709B07000D68F3EE2@BL1PR11MB5979.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301584-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:piotr.kwapulinski@intel.com,m:meng.ding@siemens.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jan.kiszka@siemens.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:wq.wang@siemens.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[florian.bezdeka@siemens.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[siemens.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.bezdeka@siemens.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:dkim,siemens.com:email,siemens.com:mid,siemens.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB1AF6BCDAA

On Tue, 2026-06-23 at 09:46 +0000, Kwapulinski, Piotr wrote:
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of=
 Ding Meng via Intel-wired-lan
> > Sent: Monday, June 22, 2026 6:13 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw=
 <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch; davem@davemloft.net=
; edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Kiszka, Jan <jan=
.kiszka@siemens.com>; Bezdeka, Florian <florian.bezdeka@siemens.com>
> > Cc: intel-wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org; net=
dev@vger.kernel.org; meng.ding@siemens.com; wq.wang@siemens.com
> > Subject: [Intel-wired-lan] [PATCH net] igc: Fix RX HW timestamp reporti=
ng when NET_RX_BUSY_POLL is disabled
> >=20
> > When CONFIG_NET_RX_BUSY_POLL is deactivated, fetching RX HW timestamps =
from the NIC no longer works as expected.
> >=20
> > This occurs because disabling CONFIG_NET_RX_BUSY_POLL disables the SKB =
NAPI mapping in __skb_mark_napi_id(). Consequently, get_timestamp() fails t=
o perform its driver lookup, and the igc driver's struct net_device_ops::nd=
o_get_tstamp is never invoked.
> >=20
> > Instead, get_timestamp() falls back to use shhwtstamps(skb)->hwtstamp, =
a field that the driver has not populated.
> >=20
> > Fix this by populating the hwtstamp field with the correct timestamp in=
 the default timer when CONFIG_NET_RX_BUSY_POLL is disabled.
> >=20
> > Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
> > Co-developed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > Signed-off-by: Ding Meng <meng.ding@siemens.com>
> > ---
> > drivers/net/ethernet/intel/igc/igc_main.c | 38 ++++++++++++++++-------
> > 1 file changed, 26 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/et=
hernet/intel/igc/igc_main.c
> > index 8ac16808023..1da8d7aa76d 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -1992,7 +1992,26 @@ static struct sk_buff *igc_build_skb(struct igc_=
ring *rx_ring,
> > 	return skb;
> > }
> >=20
> > -static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
> > +static void igc_construct_skb_timestamps(struct igc_adapter *adapter,
> > +					 struct sk_buff *skb,
> > +					 struct igc_xdp_buff *ctx)
> > +{
> > +	if (!ctx->rx_ts)
> > +		return;
> > +#ifdef CONFIG_NET_RX_BUSY_POLL
> > +	skb_shinfo(skb)->tx_flags |=3D SKBTX_HW_TSTAMP_NETDEV;
> > +	skb_hwtstamps(skb)->netdev_data =3D ctx->rx_ts; #else
> > +	struct igc_inline_rx_tstamps *tstamps;
> Please move at the top of the function and add:

That would trigger a "unused variable" warning in the
CONFIG_NET_RX_BUSY_POLL case.

Btw: I was really confused that the #else statement moved to the end of
the previous line. Might someone be using a wrongly configured mail
client here?

Florian

> Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com
>=20
> > +
> > +	tstamps =3D ctx->rx_ts;
> > +	skb_hwtstamps(skb)->hwtstamp =3D igc_ptp_rx_pktstamp(adapter,
> > +							   tstamps->timer0);
> > +#endif
> > +}
> > +

[snip]

