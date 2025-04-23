Return-Path: <netdev+bounces-185016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFA4A98354
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 10:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7F61B64CB1
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 08:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D59A26AAAB;
	Wed, 23 Apr 2025 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="RZ56arMH"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB816DCE1;
	Wed, 23 Apr 2025 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396464; cv=pass; b=iLf13MOe22gxO/DiXyOjvljjv2qxiMWucR5PPMmRm/L/pc3DlRQUzIO8yfPtK1T4sIwEj4N8TuFvTaPIMXIpymbn0jRLm6jInvePCXHP08xjpt2/xE3XuXtsDl6Bjv26erv1PFxfjdYnsoTBzP5vCT7dS6grNZVcBUZ5iTk29J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396464; c=relaxed/simple;
	bh=z/VFE68McJikREOj00utWmBcPu+wN/7Ot0NDbMCTCEU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ETKvG4E3U+IaNUGffhKaEe43+yJEWwG26c+vPL3WwWIH5U722FLEniQ8C+cKkyzTDFe34ilnquctPR8oQWdkbf1zbWGxcWJ6ngvXzlfxkIDxutqMMKUBXBl8MqP/DAed6rSf+QhZFS9lXvfN8+FFdOFIs/6UuzryoIpmKrTk7EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=RZ56arMH; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745396424; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YpNkN/pgf05gdme5+SmEoxgIpTRcwbXhKWK7mhcpVskQoM8Sq8/FJry5KcIip0QNC6Iz75imDO0NKmWUCYVt2SbZykmh7qMlHWQVBpHkcBXo7HXACFed2Oq3mNrNMLkxdhb/1mwdTkncyuodkJ2OWVnOxI1vEYJmxq0m4TqY2CU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745396424; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=G1j8PYHcrNhQFqwI+btrCagt/+/2s6uq2LXIr8341kM=; 
	b=lCfjYTHbja/eTRgBlQwBC/4w/1KOq0DjHRYJK5mZLDDuaNKhzP+zhNqECX9Ha/0unqOcGP+ywF2PBcqnjrEqJWAIqEA3NRwfslvZEtCj190T/lfmXbKdAzzQsVEQb9vygCVREx6iLt9tZEZnfL3223J3j4/jsnxAKHVsCwLBrAo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745396424;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=G1j8PYHcrNhQFqwI+btrCagt/+/2s6uq2LXIr8341kM=;
	b=RZ56arMHO8C8+mqDRUiyaCnAOcOnoC5BNhsvBbXBIcQcVJHW8MAirtsFs5yQbP8g
	1QZNnexv+YodMsp9qqZoCNiyMLNsHwfHaq7QjvvqYSNdyvex0ftAlzISAWs2a1kyfPJ
	1ttsYrrQ9O6HtYFOEUMp/BzreXoaMXMqH36BIdWY=
Received: by mx.zohomail.com with SMTPS id 1745396422848172.7246656316138;
	Wed, 23 Apr 2025 01:20:22 -0700 (PDT)
Message-ID: <11d6b91a73b69924e954defe613eef7c4af45c56.camel@collabora.com>
Subject: Re: [PATCH 1/2] net: ethernet: mtk-star-emac: fix spinlock
 recursion issues on rx/tx poll
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>,  Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,  Biao
 Huang <biao.huang@mediatek.com>, Yinghua Pan <ot_yinghua.pan@mediatek.com>,
 kernel@collabora.com, 	netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Date: Wed, 23 Apr 2025 10:20:17 +0200
In-Reply-To: <20250422160046.73aa854a@fedora.home>
References: 
	<20250422-mtk_star_emac-fix-spinlock-recursion-issue-v1-0-1e94ea430360@collabora.com>
		<20250422-mtk_star_emac-fix-spinlock-recursion-issue-v1-1-1e94ea430360@collabora.com>
	 <20250422160046.73aa854a@fedora.home>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi Maxime,

On Tue, 2025-04-22 at 16:00 +0200, Maxime Chevallier wrote:
> Hi Louis-Alexis :)
>=20
> On Tue, 22 Apr 2025 15:03:38 +0200
> Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com> wrote:
>=20
> > Use spin_lock_irqsave and spin_unlock_irqrestore instead of
> > spin_lock
> > and spin_unlock in mtk_star_emac driver to avoid spinlock recursion
> > occurrence that can happen when enabling the DMA interrupts again
> > in
> > rx/tx poll.
> >=20
> > ```
> > BUG: spinlock recursion on CPU#0, swapper/0/0
> > =C2=A0lock: 0xffff00000db9cf20, .magic: dead4ead, .owner: swapper/0/0,
> > =C2=A0=C2=A0=C2=A0 .owner_cpu: 0
> > CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
> > =C2=A0=C2=A0=C2=A0 6.15.0-rc2-next-20250417-00001-gf6a27738686c-dirty #=
28 PREEMPT
> > Hardware name: MediaTek MT8365 Open Platform EVK (DT)
> > Call trace:
> > =C2=A0show_stack+0x18/0x24 (C)
> > =C2=A0dump_stack_lvl+0x60/0x80
> > =C2=A0dump_stack+0x18/0x24
> > =C2=A0spin_dump+0x78/0x88
> > =C2=A0do_raw_spin_lock+0x11c/0x120
> > =C2=A0_raw_spin_lock+0x20/0x2c
> > =C2=A0mtk_star_handle_irq+0xc0/0x22c [mtk_star_emac]
> > =C2=A0__handle_irq_event_percpu+0x48/0x140
> > =C2=A0handle_irq_event+0x4c/0xb0
> > =C2=A0handle_fasteoi_irq+0xa0/0x1bc
> > =C2=A0handle_irq_desc+0x34/0x58
> > =C2=A0generic_handle_domain_irq+0x1c/0x28
> > =C2=A0gic_handle_irq+0x4c/0x120
> > =C2=A0do_interrupt_handler+0x50/0x84
> > =C2=A0el1_interrupt+0x34/0x68
> > =C2=A0el1h_64_irq_handler+0x18/0x24
> > =C2=A0el1h_64_irq+0x6c/0x70
> > =C2=A0regmap_mmio_read32le+0xc/0x20 (P)
> > =C2=A0_regmap_bus_reg_read+0x6c/0xac
> > =C2=A0_regmap_read+0x60/0xdc
> > =C2=A0regmap_read+0x4c/0x80
> > =C2=A0mtk_star_rx_poll+0x2f4/0x39c [mtk_star_emac]
> > =C2=A0__napi_poll+0x38/0x188
> > =C2=A0net_rx_action+0x164/0x2c0
> > =C2=A0handle_softirqs+0x100/0x244
> > =C2=A0__do_softirq+0x14/0x20
> > =C2=A0____do_softirq+0x10/0x20
> > =C2=A0call_on_irq_stack+0x24/0x64
> > =C2=A0do_softirq_own_stack+0x1c/0x40
> > =C2=A0__irq_exit_rcu+0xd4/0x10c
> > =C2=A0irq_exit_rcu+0x10/0x1c
> > =C2=A0el1_interrupt+0x38/0x68
> > =C2=A0el1h_64_irq_handler+0x18/0x24
> > =C2=A0el1h_64_irq+0x6c/0x70
> > =C2=A0cpuidle_enter_state+0xac/0x320 (P)
> > =C2=A0cpuidle_enter+0x38/0x50
> > =C2=A0do_idle+0x1e4/0x260
> > =C2=A0cpu_startup_entry+0x34/0x3c
> > =C2=A0rest_init+0xdc/0xe0
> > =C2=A0console_on_rootfs+0x0/0x6c
> > =C2=A0__primary_switched+0x88/0x90
> > ```
> >=20
> > Fixes: 0a8bd81fd6aa ("net: ethernet: mtk-star-emac: separate tx/rx
> > handling with two NAPIs")
> > Signed-off-by: Louis-Alexis Eyraud
> > <louisalexis.eyraud@collabora.com>
>=20
> As this is a fix, you need to indicate in your subject that you're
> targetting the "net" tree, something like :
>=20
> [PATCH net 1/2] net: ethernet: mtk-star-emac: fix spinlock recursion
> issues on rx/tx poll
>=20
> > ---
> > =C2=A0drivers/net/ethernet/mediatek/mtk_star_emac.c | 10 ++++++----
> > =C2=A01 file changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c
> > b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> > index
> > 76f202d7f05537642ec294811ace2ad4a7eae383..41d6af31027f4d827dbfdfecd
> > b7de44326bb3de1 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> > @@ -1163,6 +1163,7 @@ static int mtk_star_tx_poll(struct
> > napi_struct *napi, int budget)
> > =C2=A0	struct net_device *ndev =3D priv->ndev;
> > =C2=A0	unsigned int head =3D ring->head;
> > =C2=A0	unsigned int entry =3D ring->tail;
> > +	unsigned long flags =3D 0;
>=20
> You don't need to init flags to 0
>=20
> > =C2=A0
> > =C2=A0	while (entry !=3D head && count < (MTK_STAR_RING_NUM_DESCS -
> > 1)) {
> > =C2=A0		ret =3D mtk_star_tx_complete_one(priv);
> > @@ -1182,9 +1183,9 @@ static int mtk_star_tx_poll(struct
> > napi_struct *napi, int budget)
> > =C2=A0		netif_wake_queue(ndev);
> > =C2=A0
> > =C2=A0	if (napi_complete(napi)) {
> > -		spin_lock(&priv->lock);
> > +		spin_lock_irqsave(&priv->lock, flags);
> > =C2=A0		mtk_star_enable_dma_irq(priv, false, true);
> > -		spin_unlock(&priv->lock);
> > +		spin_unlock_irqrestore(&priv->lock, flags);
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	return 0;
> > @@ -1342,15 +1343,16 @@ static int mtk_star_rx_poll(struct
> > napi_struct *napi, int budget)
> > =C2=A0{
> > =C2=A0	struct mtk_star_priv *priv;
> > =C2=A0	int work_done =3D 0;
> > +	unsigned long flags =3D 0;
>=20
> There's a rule in netdev that definitions must be ordered from
> longest
> to shortest lines (reverse xmas tree, or RCT), so you should have in
> the end :
>=20
> struct mtk_star_priv *priv;
> unsigned long flags;
> int work_done =3D 0;
>=20
> > =C2=A0
> > =C2=A0	priv =3D container_of(napi, struct mtk_star_priv, rx_napi);
> > =C2=A0
> > =C2=A0	work_done =3D mtk_star_rx(priv, budget);
> > =C2=A0	if (work_done < budget) {
> > =C2=A0		napi_complete_done(napi, work_done);
> > -		spin_lock(&priv->lock);
> > +		spin_lock_irqsave(&priv->lock, flags);
> > =C2=A0		mtk_star_enable_dma_irq(priv, true, false);
> > -		spin_unlock(&priv->lock);
> > +		spin_unlock_irqrestore(&priv->lock, flags);
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	return work_done;
> >=20
>=20
> Besides these small comments, the patch looks correct to me :)
>=20
> Regards,
>=20
> Maxime

Thanks for the review, Maxime.
I'll add the missing subject prefix and fix the other issues in the v2
patchset.

Regards,
Louis-Alexis


