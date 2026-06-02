Return-Path: <netdev+bounces-294146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DxSENOzHmr7JAAAu9opvQ
	(envelope-from <netdev+bounces-294146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:43:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF90562CCD6
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E9683004F35
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 10:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4393D6473;
	Tue,  2 Jun 2026 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="CS+WmPha"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F2346FB3
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397008; cv=none; b=IlhLiZ22ajiGjToFTmvq2iGnH4B1kfuIYXsKsb3e5dbP4sW33JmNZoQQAS7FM3pGLM7un3XdBHzQPcs+8qiBqns7YlAkPvMKPTphlGT6EW798PvZP4oQcZgayjQuxiABWjzb0ZB9bMEl3szViz4dDl7f14MV9EsqszbD6I6j1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397008; c=relaxed/simple;
	bh=Fa1I9iHLkXmpQldR04kb+uGba86+Bmm0StyNWUksdKA=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=tZ3rocGlUAo+DrtC/F8QGrHV/xmgZ+ovU3EzaW9HIdz2bMjKCnftv88ldFbNsilZ1chHEjattejOdjwHLWymLUETK0/etUf7NDI5HnHBpv6SSZE5O+0OJGva6AnvWwoyo0hYzSVc/tc/Ntomd8MFvGEwL1ftQYRSeiSh4OYbpXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=CS+WmPha; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780396972; x=1781001772;
	i=markus.stockhausen@gmx.de;
	bh=yj66YVTz0K14afl+Wd9ElsilBQeIoygz+Ne/xrqDMBw=;
	h=X-UI-Sender-Class:From:To:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CS+WmPhaOqqyrNDV2w7f+kI1GtJb/FA+p4/dF7ouBGKEkmG4W15mEliUNqXZra+c
	 8l3PYH8ZJL2yvxfJ3VfUbjLRvXyGhjlXXLsCYNnsy303vM9+IurTf9Nozr4BpL62l
	 vHAB686K9TEPq+/787pW01C7nzaL4m8FrwEsLENaYQgcUdeMhuq4wb1S62hf6dNPO
	 79Xf8Q2wGjgG/xWuMRwm5EX5jMondtAk4urhFmdU/8wo7gNBiEGwR62zq9ZW1EVEe
	 Z6Uz5mfzfv3jGgsKaS1t/im/PaNE1/YyGCt76sfb9GvIj/uzrx4JN+ZleSttXORob
	 ifPdmI0VvPXe8Jm9HQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDkm-1xETzP3Fyi-012dPB; Tue, 02
 Jun 2026 12:42:51 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Jagielski, Jedrzej'" <jedrzej.jagielski@intel.com>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	<mensi@mensi.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de> <20260602052640.93083-4-markus.stockhausen@gmx.de> <PH0PR11MB5902AC16692DAAC68542A76EF0122@PH0PR11MB5902.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5902AC16692DAAC68542A76EF0122@PH0PR11MB5902.namprd11.prod.outlook.com>
Subject: AW: [PATCH net-next 3/8] net: mdio: realtek-rtl9300: harden otto_emdio_map_ports()
Date: Tue, 2 Jun 2026 12:42:47 +0200
Message-ID: <013401dcf27c$8fe15cd0$afa41670$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQCd5JwkUMOmloq9EQ3T8rs5/ndXAgJ3Cz4UAlk/OA+4gqi9oA==
Content-Language: de
X-Provags-ID: V03:K1:YTlCv8DBJpj+ldbyH+DBztrbS4RTcmQ64pj8DHBS/MUoytnyfPA
 C+OWwVCKBYrs3ar4rkRc/oR4GzTRbrhdl6SptQiEFAwNu5VY0lwMa77hNUz2L1BZjASPPsQ
 8NsFqMAh4SLlndxVxSYTLq+eISg2SUgwvcfdyMXrJpUDQytDW/ClRjOZuht5+QO4dxMd/xo
 DgWl3i7FngEDSPaSfX1CQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QO4cNh92YhI=;L9higxuLL1WoJdicNZrjXIZb11N
 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
X-Rspamd-Queue-Id: DF90562CCD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[intel.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-294146-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,gmx.de:dkim,gmx.de:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bootlin.com:url]
X-Rspamd-Action: no action

> Von: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>=20
> Gesendet: Dienstag, 2. Juni 2026 11:38
> Betreff: RE: [PATCH net-next 3/8] net: mdio: realtek-rtl9300: harden
otto_emdio_map_ports()
> ...
> >+		if (addr >=3D PHY_MAX_ADDR)
> >+			return dev_err_probe(dev, -EINVAL, "illegal smi
address %d\n",=20
> >+addr);
>
> Could we have more meaningful error code than EINVAL; EFAULT perhaps if
that's bad addr case?
> what do you think?

EFAULT seems to be the most unusal error code here.
But looking at other implementations there is no clear
guidance.

- phy package uses -EINVAL [1]
- ax88172a uses -ENODEV [2]
- altera uses -ENODEV [3]

> Also - is %d convenient for printing address value?

Will take that as it matches the other MDIO outputs.=20

Markus

[1]
https://elixir.bootlin.com/linux/v6.18.1/source/drivers/net/phy/phy_packag=
e.
c#L215=20
[2]
https://elixir.bootlin.com/linux/v6.18.1/source/drivers/net/usb/ax88172a.c=
#L
213
[3]
https://elixir.bootlin.com/linux/v6.18.1/source/drivers/net/ethernet/alter=
a/
altera_tse_main.c#L625=20


