Return-Path: <netdev+bounces-306957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mau+OVW2U2pYeAMAu9opvQ
	(envelope-from <netdev+bounces-306957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 17:44:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD657453B3
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 17:44:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=uCo6Ean0;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306957-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306957-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF03C3003345
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 15:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5D73033F8;
	Sun, 12 Jul 2026 15:44:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF08262FD0;
	Sun, 12 Jul 2026 15:44:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783871059; cv=none; b=Js38EvonoD0wVOROSK/eggKabRRLCKcBvOR1wJYM1pLcQxAxhNyGj4+I+LYD5epdjCjjTEhvtDkXI1JV07gNEbSI/7o5bCSm1enB6GBRGyAOnpOhlZsxL0f2K8NFpmH07wEs1jl6XT5QYEV+/dShxYaVWkUGHCB1073FQuSZXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783871059; c=relaxed/simple;
	bh=U7Cp4g+nEoFszk4NXghXxVxx5a6xpFYnr/1iXQlnVTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPjyRX86+nsOLxeoVpGN4VwFAL+WBHvP+NDtETtpyMNRKh9v4UqZogdzKXX4abCE6ghxuYvIRMoZSos1qnQeI9si9C/22O5BL7vbt1ztT1NLTpUFV2o6iqqj/HdTVIirafkTaqNh7YocJQs2419q4VEHwqZWJEz54dxiBX5qEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b=uCo6Ean0; arc=none smtp.client-ip=212.227.15.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783871049; x=1784475849; i=linosanfilippo@gmx.de;
	bh=feWn3ejG0FAEiQdhZbxZIzL3jhDN9n7FiQUy7I0z35Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uCo6Ean0XVGg85Tm8+q4wvIiJ/1CIiVfYzx91xW69N39NpEoI7L/lzmYw2OUFx9C
	 3gSNu1RJzyr3Zn5HroYhBSn9yrH7Cwd3qu546tP5HHl6gcqBWxobUI+sIvohieXMW
	 mjPdJ0ecME1JSTlWq9TfvyKtRdAnn+U/B2gD4g6QRheh3VER5Rt7gy5oOL94wW5Cq
	 YCfyvZMI6itsLDi0buKmzzkLoYbnHcfIeKBPHo0Ckkkzm7QBnRH7PZj0yrv5BUzt6
	 5q+NG442K/E3wtsmp4NGh7fCm/U60PpPtS3dYoADR0hwSlZgwUEnQ40vIhHoB3bhk
	 4rENh+i43Lc5gS88VQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzfv-1wXh0D2Bgn-00JFkY; Sun, 12
 Jul 2026 17:44:09 +0200
Message-ID: <9000b1b0-8993-461b-bad9-f012f9fa8605@gmx.de>
Date: Sun, 12 Jul 2026 17:43:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: alacritech: add missing MODULE_DEVICE_TABLE()
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260704152053.49780-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <20260704152053.49780-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8RJpY7kzFsY9rgmlFPaLnFNKazilZn+/VfGwccg44FHmLcNHbJn
 aJ9+hoxMbZnY4a9ZCetnsjDTer/kKvcSgQJZbsnU+vA7rue2HnF3GN5fSbNR9MSBCZSxMzt
 7YC2zpp+UJWIte5Ats+exEKjsUM7D2l7IPjkHzWBvLWnIW8hwnAHcqCoMPnM1b5FjTymh9N
 ixrNOd2Wm49D21/F5kBmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ohbvZL4CMsI=;3tROoFD2RgNjWh+z9M1KTca9jWe
 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
 DSbflo/vZXCTOM15Zwf3R
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306957-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[LinoSanfilippo@gmx.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[LinoSanfilippo@gmx.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmx.de];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FD657453B3

Hi,

On 04.07.26 17:20, Pengpeng Hou wrote:
> The driver has a match table for the pci bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
>=20
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
>=20
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.
>=20
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/net/ethernet/alacritech/slicoss.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/alacritech/slicoss.c b/drivers/net/eth=
ernet/alacritech/slicoss.c
> index c1949ca060ca..14b74c09233e 100644
> --- a/drivers/net/ethernet/alacritech/slicoss.c
> +++ b/drivers/net/ethernet/alacritech/slicoss.c
> @@ -34,6 +34,7 @@ static const struct pci_device_id slic_id_tbl[] =3D {
>  		     PCI_DEVICE_ID_ALACRITECH_OASIS) },
>  	{ 0 }
>  };
> +MODULE_DEVICE_TABLE(pci, slic_id_tbl);
> =20
>  static const char slic_stats_strings[][ETH_GSTRING_LEN] =3D {
>  	"rx_packets",

Reviewed-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>

