Return-Path: <netdev+bounces-288283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GuqHfAFB2pNqwIAu9opvQ
	(envelope-from <netdev+bounces-288283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:39:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6F354E9B3
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FA89314108C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE743CE4BA;
	Fri, 15 May 2026 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OaF/xShM"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3637478843
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778843609; cv=none; b=u9BW1cBgJfnb+gOuaHm7gL74Og+xyAXHXssmks/pJXWBXxisUQNqdDRO5A3lEAOAhbXoAc4qeOyJsBWXXwtYO+oh4xOnR9HLrzomeHFgwvZB1InGKwfSdwUfMUJHV359BaXnmNuhs6G2PG7Vz1CaPuvBXZqDKHSVeMw0qiyDmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778843609; c=relaxed/simple;
	bh=kag9haX792QrajYmaATaIoZvrsAiqPWws8ASbmeKluU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=d2jii6cQMsN6PouvcCFXLiYlAkow5xrd7QygwT+xLFmcazsnMVdGPakmNsE0n0li7upfoAjMNZm4yquZOt8d2FEQTSJ87i8yw5C/sryaw3aveKDcLDenEs7KCouBbIloGR1SB6Xjeq+b+Ienmg5+2awMS7B5rkVOjyfm/tBJGEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OaF/xShM; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778843595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xY+E/upLJxEjmvM3j7C4ks+xfWlSY3E/fLSmuAvnhNI=;
	b=OaF/xShMio5pJ01/fel5DMXE3YdlVSumEvuZa6aNn7Uw9tp/Z2OdB1rsusp8RHJiyyZ902
	JGsr6f2ap+f4Hdsp637l3HEhTcuEjc0TP1tskvJ/pGVqoUisBO2ugLoqT8yY3ovM4ArsZZ
	+mjHogAd+q2BkujTSSCy1GoKAvIacKw=
Date: Fri, 15 May 2026 11:13:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Frank Wunderlich" <frank.wunderlich@linux.dev>
Message-ID: <935a73a6e458b2d4fed2e59192e725483ca62126@linux.dev>
TLS-Required: No
Subject: Re: [net-next v8 2/3] net: ethernet: mtk_eth_soc: Add RSS support
To: "Jakub Kicinski" <kuba@kernel.org>, "Mason Chang"
 <mason-cw.chang@mediatek.com>
Cc: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, "Russell King" <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Eric Dumazet" <edumazet@google.com>, linux-mediatek@lists.infradead.org,
 "Daniel Golle" <daniel@makrotopia.org>, "Matthias Brugger"
 <matthias.bgg@gmail.com>, "Paolo Abeni" <pabeni@redhat.com>, "Lorenzo
 Bianconi" <lorenzo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, "Felix Fietkau" <nbd@nbd.name>,
 "Frank Wunderlich" <linux@fw-web.de>
In-Reply-To: <20260513185625.48e69837@kernel.org>
References: <20260509190938.169290-1-linux@fw-web.de>
 <20260509190938.169290-3-linux@fw-web.de>
 <20260513185625.48e69837@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: CC6F354E9B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288283-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,vger.kernel.org,armlinux.org.uk,lunn.ch,google.com,lists.infradead.org,makrotopia.org,gmail.com,redhat.com,kernel.org,davemloft.net,nbd.name,fw-web.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frank.wunderlich@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

Hi Jakub,

thanks for your review, i have to discuss the previous parts (AI-review)
with MTK on how to make it better. The changes there seem not trivial for
me and this will take some time.

Am 14. Mai 2026 um 03:56 schrieb "Jakub Kicinski" <kuba@kernel.org>:
>=20
>=20On Sat, 9 May 2026 21:09:31 +0200 Frank Wunderlich wrote:
>=20
>=20>=20
>=20> From: Mason Chang <mason-cw.chang@mediatek.com>
> >=20=20
>=20>  Add support for Receive Side Scaling.
> >=20=20
>=20>  We can adjust SMP affinity with the following command:
> >  echo [CPU bitmap num] > /proc/irq/[virtual IRQ ID]/smp_affinity,
> >  with interrupts evenly assigned to 4 CPUs, we were able to measure
> >  an RX throughput of 7.3Gbps using iperf3 on the MT7988. Further
> >  optimizations will be carried out in the future.
> >=20
>=20Would be great to split this up a little more for ease of review.

you mean splitting the code into more separate patches or the commit desc=
ription?

> >=20
>=20> +static int mtk_rss_init(struct mtk_eth *eth)
> >  +{
> >  + const struct mtk_soc_data *soc =3D eth->soc;
> >  + const struct mtk_reg_map *reg_map =3D eth->soc->reg_map;
> >  + struct mtk_rss_params *rss_params =3D &eth->rss_params;
> >=20
>=20reverse xmas tree should be followed, please fix everywhere in this
> submission=20

will=20check again when we have the fixed flow (AI-review).

> >=20
>=20>  +/* struct mtk_rss_params - This is the structure holding paramete=
rs
> >  + * for the RSS ring
> >  + * @hash_key The element is used to record the
> >  + * secret key for the RSS ring
> >  + * indirection_table The element is used to record the
> >  + * indirection table for the RSS ring
> >  + */
> >=20
>=20Quite odd looking comment. Having the right side aligned like that
> makes it header to correlate where doc for fields start.
> And there's @ missing for indirection_table.

dito

@Mason: have you found some time for looking into the AI suggestions?
Maybe it is better discussing changes here if they match upstream
requirements as i did only up-port the SDK-patches with some small
changes and made tests :)
As a note: i have not activated RSS/LRO on other mt798x because it was
not clear, if RSS or LRO is better for them and only mt7988 can do both
simultanously. AI also complained about it. And this decision causes
changes in code too.
It would be great if you can use the actual state here as base for
changes so that i do not miss anything when upporting the SDK state again=
.

regards Frank

