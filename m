Return-Path: <netdev+bounces-306488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IUn4H4S+UGrj4QIAu9opvQ
	(envelope-from <netdev+bounces-306488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:42:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F21739337
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:42:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306488-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306488-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9017A300EF91
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4870E3F58EF;
	Fri, 10 Jul 2026 09:39:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25CD3CC314;
	Fri, 10 Jul 2026 09:39:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676367; cv=none; b=OwDYcfOGseuwaYvyiOwyXsXCdwpe9xOa7HwjXfyNPjwXy1sbL3+4suMInKEA6hlUNkY5vn90UFaavjwXbQpsWJm27d11+Ztwf9MY/lHhMI34oBUNULGTKLmCoO4SZI0ELov9VkXbA9Va1gpfYYKo2hGecf7Yw+dB4kifL+tdyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676367; c=relaxed/simple;
	bh=lfEvmS0TvmN/PlDpVYAATcTxy/m6FfyvxxRHOSUUGIQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=EF8PQKerebrzBr+ZexYbIf//ToDL9A6B+EIi3fs4xeWb4zTeYbcJVrIgA15Zs+fBiN7DrRfS1NUScgE+SxVW7JPpZuPZvIsoqAjIkg8eUCfOab424lSDp8DCKnuKEmmELtpAYt/Ej7nC7sXSBmiEyW2aJlN3theP24wa4FyrLaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 532F03B7;
	Fri, 10 Jul 2026 11:39:16 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 11:39:16 +0200
Message-Id: <DJUSHXVKZ0OC.1VDMPW228IYHO@kernel.org>
To: "Sean Anderson" <sean.anderson@linux.dev>, "Madalin Bucur"
 <madalin.bucur@nxp.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
Subject: Re: [PATCH net] net: dpaa: always set a valid mode I/F mode
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260706121011.1948906-1-mwalle@kernel.org>
 <cbfa2b2b-0ae8-9c96-f177-b503239edbd0@linux.dev>
In-Reply-To: <cbfa2b2b-0ae8-9c96-f177-b503239edbd0@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306488-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mwalle@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sean.anderson@linux.dev,m:madalin.bucur@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mwalle@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1F21739337

Hi,

On Fri Jul 10, 2026 at 1:45 AM CEST, Sean Anderson wrote:
> On 7/6/26 08:08, Michael Walle wrote:
>> Before converting to the phylink interface, the init function would have
>> set the correct mode in the maccfg2.
>
> So for reference, the old logic is
>
>         if (iface_speed < SPEED_1000)
>                 tmp |=3D MACCFG2_NIBBLE_MODE;
>         else if (iface_speed =3D=3D SPEED_1000)
>                 tmp |=3D MACCFG2_BYTE_MODE;
>
> which changes between nibble/byte mode depending on the max link speed
> (e.g. phylink_interface_max_speed). Notably, neither is set for 2.5G.

Ahh you're right, I totally missed, that the speed parameter was
actually max_speed, which was set by

  priv->speed =3D phy2speed[macdev->phy_if];
  priv->max_speed =3D priv->speed;

FWIW, in the DPAA RM I have, there is no 2.5G speed. Are you sure,
there are DTSEC controllers with 2.5Gbps support? The only board I
found in the device trees is the T1023RDB which is using the memac.

> Can you try moving this write to dtsec_mac_config?

That worked! At least for SGMII. I don't have a board with another
interface to test tough. I'll prepare a new version, making
phylink_interface_max_speed() public and setting the correct value
in .mac_config(). Alternatively, we could move
phylink_interface_max_speed() to the header as static inline, but
that function isn't that small.

> And check in the RM
> whether this is configured based on the interface (in which case we shoul=
d
> remove it from dtsec_link_up) or the link speed. And please also check wh=
at
> the correct behavior for 2.5G should be.

This is an excerpt from the RM:

I/F Mode (bits 22-23):
 This field determines the type of interface to which the MAC is
 connected. Its default is 00.
  00 Reserved
  01 Used for all 10Mbps and 100Mbps speeds
  10 Used for all 1Gbps speeds
  11 Reserved

So you could read it both ways? But since the older driver was using
the maximum interface speed..

> At one point I had the P-series RMs downloaded, but it appears I've mispl=
aced
> them...

FWIW, I think it's freely available as long as you're logged in with
your NXP account.

-michael

>
> --Sean
>
>> After converting, init will just
>> set 0 as the mode. According to the "QorIQ Data Path Acceleration
>> Architecture (DPAA) Reference Manual", this is a reserved value. In
>> fact, this will prevent the PCS to establish a link to a connected SGMII
>> PHY. In turn, mac_link_up() is never called. Fix it by setting a
>> non-reserved mode; mac_link_up() will then set the correct mode later.
>>=20
>> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> ---
>> FWIW, I've tested this with a Marvell 88E1112 PHY.
>>=20
>>   drivers/net/ethernet/freescale/fman/fman_dtsec.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/=
net/ethernet/freescale/fman/fman_dtsec.c
>> index fe35703c509e..566921d3a884 100644
>> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>> @@ -402,7 +402,10 @@ static int init(struct dtsec_regs __iomem *regs, st=
ruct dtsec_cfg *cfg,
>>   	tmp |=3D MACCFG1_TX_FLOW;
>>   	iowrite32be(tmp, &regs->maccfg1);
>>  =20
>> -	tmp =3D 0;
>> +	/* write a non-reserved mode, otherwise the PCS won't establish a link
>> +	 * and .mac_link_up() is never called.
>> +	 */
>> +	tmp =3D MACCFG2_NIBBLE_MODE;
>>  =20
>>   	tmp |=3D (cfg->preamble_len << MACCFG2_PREAMBLE_LENGTH_SHIFT) &
>>   		MACCFG2_PREAMBLE_LENGTH_MASK;


