Return-Path: <netdev+bounces-277779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jGdUA9WI22lcDAkAu9opvQ
	(envelope-from <netdev+bounces-277779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 13:58:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4824B3E3B0D
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 13:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B73F300FEF1
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 11:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3017C378D7F;
	Sun, 12 Apr 2026 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="nKTwyJZg"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0470F175A79;
	Sun, 12 Apr 2026 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775995088; cv=none; b=TbRoixGkRDj85OHI+av4k9pnnSxQ355QrA0UZzp58mzECQRjgCv8NjhE1STLPMCqer7nCVosI9adV1urzldfFaHia0Q4o08hPhWS+1pZMuLimQwhFmth9gAZAkmrsryH6jNgk6TSSCzGS0658pP28Vj72BiJqbbFACrwsAsWciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775995088; c=relaxed/simple;
	bh=SbH9qoB5AGg9srxVs2Hm0+LSwVj6bD2tunhEsI1sr8I=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=rCM/KBmY83mTNdDzIuQXcBHy6qrndnhMJeoCdHYuDVSoORowc6ZNiUJUzxwNgMKguNi9d/aXsR2/3A8731UwAXf0vDu0OLrfrBlFMmww3JH6RgCmuRT8pCJP48VvWCZKgHF8r/iHApy5KuGM/DmJbK/1Ax9kUTKPyWjRWkPPJjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=nKTwyJZg; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1775995067; x=1776599867; i=frank-w@public-files.de;
	bh=kz22EaCJFqR2Sh3DIHgGI1UiKlZwsYdIx/mKmPpPpEA=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nKTwyJZgnGbugAWGKUnS23+UUoA1TgH3eEGkmqnqcSFecGqa6w/a5EbU+9xIIhRs
	 qgI5SKrVjpdeztxmGRtqg3Y0ULezao/bXsKKIa4sTRs1+iosk+jPJMfmADcBTkBmq
	 ZqTXWuH1+VuK8DJbeH2ERAQ5h9xYEfT+Ks6C/75NjWxfMfumPpEgZ52AEe10GSb/E
	 c71gx7ey0+rlBUKyK4Fao4OBjK8JDxrEGnC9fbRbi9WPoMEnLlez/3zAjVG9v4OgM
	 fW+KkwH3tEPME51ZfFrw1XASFYuv1efx/mTKnsoHrBemyLfQPYXKJ7wQj5hXIHw2d
	 Y6zCMFzvbhomt+UtzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.78.225] ([80.245.78.225]) by
 trinity-msg-rest-gmx-gmx-live-579dcf886d-nkpds (via HTTP); Sun, 12 Apr 2026
 11:57:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-1304ecb5-9a3f-4e37-b2c6-bcd7f35c2921-1775995067670@trinity-msg-rest-gmx-gmx-live-579dcf886d-nkpds>
From: Frank Wunderlich <frank-w@public-files.de>
To: linux@fw-web.de, nbd@nbd.name, sean.wang@mediatek.com,
 lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux@armlinux.org.uk
Cc: daniel@makrotopia.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Aw: [RFC net-next v5 0/3] Add RSS and LRO support
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Apr 2026 11:57:47 +0000
In-Reply-To: <20251219151219.77115-1-linux@fw-web.de>
References: <20251219151219.77115-1-linux@fw-web.de>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:EoGCU1oP2FpHYa9pnrkOrIyeUnVBHAl52P6LkUqWZGQSZS+p+o7n1mW3IBwicssFtAGTc
 l6Cq/0uJh0foP+KgH37kfWRLZLgYwMVTeOUXmw1OgZilQuvQmPglXVD2cwDw5eUdoz02PTgaNoGn
 WFLzhQ/QYdApFMIBl87UPsvy1IxTXd4K8kRrexRP689ju/3LwKJfgUNN03pLsbBFeEo/Pmat8uLz
 8AEZ93mTeKy3De5i0lr38Tq94rv7I98f3t85Y4s6MUOXuHnLuIGss7GQmuBAKV403RXoRzpD5K33
 Lj6F5lBDR+/FuN/gWfWvHM1a6q29uR+1jf8z7/XFmBgj6YBZF41IBnkM4wCvPmBBTQ=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JYKe4y5Dccs=;ngiIncvC9xIAX9CQy/PeaJAWgjZ
 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
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[public-files.de,quarantine];
	R_DKIM_ALLOW(-0.20)[public-files.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277779-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[fw-web.de,nbd.name,mediatek.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frank-w@public-files.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[public-files.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[public-files.de]
X-Rspamd-Queue-Id: 4824B3E3B0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

some time has passed without a single comment, so i just send a friendly r=
eminder ;)

regards Frank


> Gesendet: Freitag, 19. Dezember 2025 um 16:12
> Von: "Frank Wunderlich" <linux@fw-web.de>
> An: "Felix Fietkau" <nbd@nbd.name>, "Sean Wang" <sean.wang@mediatek.com>=
, "Lorenzo Bianconi" <lorenzo@kernel.org>, "Andrew Lunn" <andrew+netdev@lu=
nn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@=
google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@red=
hat.com>, "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino D=
el Regno" <angelogioacchino.delregno@collabora.com>, "Russell King" <linux=
@armlinux.org.uk>
> CC: "Frank Wunderlich" <frank-w@public-files.de>, "Daniel Golle" <daniel=
@makrotopia.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, li=
nux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
> Betreff: [RFC net-next v5 0/3] Add RSS and LRO support
>
> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> This series add RSS and LRO hardware acceleration for terminating
> traffic on MT798x.
>=20
> It is currently only for discussion to get the upported SDK driver
> changes in a good shape.
>=20
> patches are upported from mtk SDK:
> - https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-f=
eeds/+/refs/heads/master/master/files/target/linux/mediatek/patches-6.12/9=
99-eth-08-mtk_eth_soc-add-register-definitions-for-rss-lro-reg.patch
> - https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-f=
eeds/+/refs/heads/master/master/files/target/linux/mediatek/patches-6.12/9=
99-eth-09-mtk_eth_soc-add-rss-support.patch
> - https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-f=
eeds/+/refs/heads/master/master/files/target/linux/mediatek/patches-6.12/9=
99-eth-10-mtk_eth_soc-add-hw-lro-support.patch
> with additional fixes
>=20
> changes:
> v5:
> - fix too long lines after macro changes reported by checkpatch
>=20
> v4:
> - drop unrelated file
> - rss-changes suggested by andrew
>   - fix MTK_HW_LRO_RING_NUM macro (add eth)
>   - fix MTK_LRO_CTRL_DW[123]_CFG (add reg_map param)
>   - fix MTK_RX_DONE_INT (add eth param)
> - fix lro reverse christmas tree and LRO params suggested by andrew
> - drop mtk_hwlro_stats_ebl and unused IS_HW_LRO_RING (only used in
>   properitary debugfs)
>=20
> v3:
> - readded the change dropped in v2 because it was a fix
>   for getting RSS working on mt7986
> - changes requested by jakub
> - reworked coverletter (dropped instructions for configuration)
> - name all PDMA-IRQ the same way
> - retested on
>   - BPI-R3/mt7986 (RSS needs to be enabled)
>   - BPI-R4/mt7988
>   - BPI-R64/mt7622 and BPI-R2/mt7623 for not breaking network functional=
ity
>=20
> v2:
> - drop wrong change (MTK_CDMP_IG_CTRL is only netsys v1)
> - Fix immutable string IRQ setup (thx to Emilia Schotte)
> - drop links to 6.6 patches/commits in sdk in comments
>=20
> Mason Chang (3):
>   net: ethernet: mtk_eth_soc: Add register definitions for RSS and LRO
>   net: ethernet: mtk_eth_soc: Add RSS support
>   net: ethernet: mtk_eth_soc: Add LRO support
>=20
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 812 ++++++++++++++++----
>  drivers/net/ethernet/mediatek/mtk_eth_soc.h | 173 +++--
>  2 files changed, 778 insertions(+), 207 deletions(-)
>=20
> --=20
> 2.43.0</frank-w@public-files.de>

