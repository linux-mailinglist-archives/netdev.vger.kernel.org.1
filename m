Return-Path: <netdev+bounces-300902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C+HPMTFXOGr+bAcAu9opvQ
	(envelope-from <netdev+bounces-300902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 23:27:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB1D6AB984
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 23:27:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QXQsycIo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300902-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300902-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C75923018D75
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 21:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB179370D49;
	Sun, 21 Jun 2026 21:27:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F840D588
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 21:27:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782077229; cv=none; b=U5SbFiCRAexphRegKnWs/synwVpOu1uHhjPU+WOOBnNUoN48hrsTxeJVMKeGJZOkeTaxfYTthmGqtmsiggO91FUBilGMLJIqBMYsHQw8whM2cMXBFKIM04U20NaD/lsUeSPJz/GqwtBnlUvB3cXcMt6DnpeWR1dOoagwKjEfFmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782077229; c=relaxed/simple;
	bh=526F1KvQO3Mut0dFOLt8cGSnjb8xmlNtdZcn5SLW7QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTbWsHYs2s1g6wvu/Ws/EiF0//6FEsk1uPzMmmHFUIxsV34ujnwzPt5JhLRRjLQ7OHIT5CZ24P6/lYJ69zSUf6HWNvJHxS5iKiPPa1MSxjGWtjOsDTkA6Ms128gpm4m6/YmUMPYZITFxovAyi6qxbJxCZ/GRsW2oRhfaLi58iBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXQsycIo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDAA1F000E9;
	Sun, 21 Jun 2026 21:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782077228;
	bh=flpt6FA9/2PLqKaiTA12PHqetWmdZ2xWAk/dnpP6Yio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QXQsycIob4WzkVoy6kRPUggnkQnFkUosVXynk1wEdezq1tYDVYCMRCeok4PMcr/gW
	 wyHCmzNgUHJFyt8hd6yQb45voFOPPXoAeBAOElskh8mk7tsD1L8cHRA28RGdjPZz0T
	 VWyyKjs4mqKw313VTo50buF/E7tuGouXI5rc1FEm14akbhZyYn8LfLY74YrMMi7LC/
	 fdyvhPgQGCKviH1WcluWHnsli/CwecE1guHbbWi1Df6RtGNWqAKzhKTRw7hQ/++joz
	 5JojhUB7FpBxdod2uT43Ts9ReOGWMtnBMvmm+QmEZvO1lz+SpbfjLf1JEVLN/3Xlqi
	 Um3tRQWnj72aQ==
From: Jakub Kicinski <kuba@kernel.org>
To: linusw@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	hauke@hauke-m.de,
	kurt@linutronix.de,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com,
	clement.leger@bootlin.com,
	george.mccollister@gmail.com,
	mmyangfl@gmail.com,
	netdev@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3] net: dsa: Fix skb ownership in taggers
Date: Sun, 21 Jun 2026 14:27:04 -0700
Message-ID: <20260621212704.606595-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617-dsa-fix-free-skb-v3-1-cdd4e0778a39@kernel.org>
References: <20260617-dsa-fix-free-skb-v3-1-cdd4e0778a39@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300902-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:kuba@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:hauke@hauke-m.de,m:kurt@linutronix.de,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:wei.fang@nxp.com,m:xiaoning.wang@nxp.com,m:clement.leger@bootlin.com,m:george.mccollister@gmail.com,m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,m:jonasgorski@gmail.com,m:matthiasbgg@gmail.com,m:georgemccollister@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,broadcom.com,hauke-m.de,linutronix.de,microchip.com,arinc9.com,makrotopia.org,collabora.com,nxp.com,bootlin.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BB1D6AB984

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: Fix skb ownership in taggers

This patch moves SKB drop responsibility from dsa_user_xmit() and
dsa_switch_rcv() into the per-tagger ->xmit() and ->rcv() callbacks, so
that taggers consume the skb on their own error paths and the call sites
no longer free a returned NULL skb.

Closes: https://lore.kernel.org/r/20260610153952.1685895-1-kuba@kernel.org/

> diff --git a/net/dsa/tag.c b/net/dsa/tag.c
> index 79ad105902d9..cfc8f5a0cbd9 100644
> --- a/net/dsa/tag.c
> +++ b/net/dsa/tag.c
> @@ -84,10 +84,8 @@ static int dsa_switch_rcv(struct sk_buff *skb, struct net_device *dev,
>  		nskb = cpu_dp->rcv(skb, dev);
>  	}
>  
> -	if (!nskb) {
> -		kfree_skb(skb);
> +	if (!nskb)
>  		return 0;
> -	}
>  
>  	skb = nskb;
>  	skb_push(skb, ETH_HLEN);

[High]
Does the new contract that taggers consume the skb on error cover the
inline METADATA_HW_PORT_MUX branch in dsa_switch_rcv() as well?  That
branch is not a tagger callback, it is open-coded in dsa_switch_rcv():

	if (md_dst && md_dst->type == METADATA_HW_PORT_MUX) {
		unsigned int port = md_dst->u.port_info.port_id;

		skb_dst_drop(skb);
		if (!skb_has_extensions(skb))
			skb->slow_gro = 0;

		skb->dev = dsa_conduit_find_user(dev, 0, port);
		if (likely(skb->dev)) {
			dsa_default_offload_fwd_mark(skb);
			nskb = skb;
		}
	} else {
		nskb = cpu_dp->rcv(skb, dev);
	}

	if (!nskb)
		return 0;

When dsa_conduit_find_user() returns NULL (for example a port_id that
does not match any registered DSA user, such as the CPU port index, an
invalid id from the conduit driver, or a port being torn down), nskb
stays NULL and skb is not freed anywhere, so the new

	if (!nskb)
		return 0;

path looks like it leaks the skb on every such packet.

Pre-patch, the removed kfree_skb(skb) at the !nskb site covered this
case.  Should the metadata-mux branch free the skb itself when
skb->dev is NULL, or should the unconditional kfree_skb(skb) at the
!nskb site be kept for this path?

[ ... ]
-- 
pw-bot: cr

