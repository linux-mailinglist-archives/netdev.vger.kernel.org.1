Return-Path: <netdev+bounces-304258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fRYWBkyyRmpFbwsAu9opvQ
	(envelope-from <netdev+bounces-304258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:47:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AC36FC4A4
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:47:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=FwJfTHwE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304258-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304258-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D85313142048
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 18:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104103A6EF1;
	Thu,  2 Jul 2026 18:27:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042E83A59B1;
	Thu,  2 Jul 2026 18:27:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016829; cv=none; b=CacJnOnM6UCSlBpAOCJIC0lp4G+KjviA2k8XaesFc5paBruyHrWaGg4tc1APGCnuIGMtCUqxV6ehaSLSBM1gzKcvmrm0LEG9WXUwT/rRFWDekU/f5ExmEHjt/abYqDRdri0HRAAU2msD+JzShJRx01OYqaQTYczFaz2Gu9xFCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016829; c=relaxed/simple;
	bh=NeMrv1nWkBCLLNUEg54JNV8fu8oY4LOMjJiLTxtpX8c=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P3YeIJnqI8DVENW8pEucDOCl/dhLbs0ZHKMcVFAynARihW0/lIXw755Kp9hcOHmNGC1QzCcNPvZqSXc74xkvhv+4ECl+HWqdlCneFT0maARnyxgU0Z0OerNbX+54RG4cCC8TuEmKl+dsTKUqgE6qG4AdHNkHb4ij/u8BxXMcmFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FwJfTHwE; arc=none smtp.client-ip=80.241.56.161
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4grlXH0tTbz9tx6;
	Thu,  2 Jul 2026 20:19:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783016367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=384tUyVKGcuexzJQm/Gbh8Apy/SFEokWG8t45DtqO9k=;
	b=FwJfTHwEggHqrODTUm9G5yRboHU/FWJxCiiGONmd96NlrhJBbXgNMrQu1iNOagteulFpWo
	n1iIHjQN204RzY1VpjjIaX/Xo8hslqOlag4iGn9ZjDmI8Pet9LSF0wBTVWi34NIRChgsFW
	H3gkSdR8P2Vlidxev5ZPM/vkKEgJjBXVuZuvg1PATNdBG66urfMNO2LqL2foUxSRTvMCRy
	hYo6okX3fE3pKUTkyispai+z4TKUD5UhU9lqnjmI2Ov3JWaaljLStpNRLQ6w2uO9t+/iBY
	/OBT3vG6FbvaLpNqJN9hEETQvuzcyQkuje8I8bHJlnYGLT4WT4bzn16j4ghfUw==
Message-ID: <ebfe837b7d4ef61442822105c3d71ca306106c14.camel@mailbox.org>
Subject: Re: [PATCH net-next 2/4] net: usb: centralize
 usbnet_cdc_zte_rx_fixup in usbnet
From: Manuel Ebner <manuelebner@mailbox.org>
To: Oliver Neukum <oneukum@suse.com>, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, 	shaoxul@foxmail.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Thu, 02 Jul 2026 20:19:21 +0200
In-Reply-To: <20260702143142.890654-3-oneukum@suse.com>
References: <20260702143142.890654-1-oneukum@suse.com>
	 <20260702143142.890654-3-oneukum@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: yojdsnwtbuix6fubd8wh6scysfssof5k
X-MBO-RS-ID: d1d3bf10343cb94ada5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304258-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:oneukum@suse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shaoxul@foxmail.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[suse.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foxmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[manuelebner@mailbox.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email,vger.kernel.org:from_smtp,mailbox.org:dkim,mailbox.org:mid,mailbox.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66AC36FC4A4

On Thu, 2026-07-02 at 16:25 +0200, Oliver Neukum wrote:
> This helper is used by multiple drivers using usbnet.
> It is better to be provided by usbnet than one of them.
>=20
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
> =C2=A0drivers/net/usb/cdc_ether.c | 19 -------------------
> =C2=A0drivers/net/usb/usbnet.c=C2=A0=C2=A0=C2=A0 | 19 +++++++++++++++++++
> =C2=A02 files changed, 19 insertions(+), 19 deletions(-)
>=20
> ...
>=20
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 5544af1f4aa5..7beea6d0e731 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -2347,6 +2347,25 @@ void usbnet_cdc_status(struct usbnet *dev, struct =
urb *urb)
> =C2=A0	}
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(usbnet_cdc_status);
> +
> +/* Make sure packets have correct destination MAC address
   /*=C2=A0
    * Make sure packets have the correct destination MAC address
> + *
> + * A firmware bug observed on some devices (ZTE MF823/831/910) is that t=
he
> + * device sends packets with a static, bogus, random MAC address (event =
if

 (even if the device ...

> + * device MAC address has been updated). Always set MAC address to that =
of the
> + * device.

Always set the MAC address to the one of your device.

Thanks
 Manuel

> + * device.
> + */
> +int usbnet_cdc_zte_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
> +{
> +	if (skb->len < ETH_HLEN || !(skb->data[0] & 0x02))
> +		return 1;
> +
> +	skb_reset_mac_header(skb);
> +	ether_addr_copy(eth_hdr(skb)->h_dest, dev->net->dev_addr);
> +
> +	return 1;
> +}
> +EXPORT_SYMBOL_GPL(usbnet_cdc_zte_rx_fixup);
> =C2=A0/*-----------------------------------------------------------------=
--------*/
> =C2=A0
> =C2=A0static int __init usbnet_init(void)

