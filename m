Return-Path: <netdev+bounces-107777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7FB91C4D8
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6B61F245D3
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 17:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C8B1CCCA6;
	Fri, 28 Jun 2024 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdbkcKzr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EE71C230B;
	Fri, 28 Jun 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595670; cv=none; b=WUSUoQ8hgucMAgDmj9FivABX5fQW6Ab1P3hdjXRhMRVhS1qFi7qar6TdRiMrgYNo9B8Zx3gUSicKqNDCY2wKIcYnmnwLcgzT++dZL9ZD7L8zHGIcJcYqWGxRg5DUYRAnen+SoQCl6BQyOao94oUGFSCaLubkUcueSYQf3miCwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595670; c=relaxed/simple;
	bh=lBJ+V/WP7/c1CrV2xu7wL2q0aSyrJyvTu2qPUtu18Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcAXabh275eCaOeBlTIwIj5WSnys1By4V4sAx49xsPvsOW1bKPmHiXOMsPuRxAoI2vWmWLldA9XOK+1Tfm29TE2x61l1q0i0w63YNFybJMoLWbIxSTdy15Tz5yMSIJj1XsOCtmCh5d9qTWzotAlAGV7w02Y5gaG6Z1yJcT0Cv+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdbkcKzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FBEC116B1;
	Fri, 28 Jun 2024 17:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719595669;
	bh=lBJ+V/WP7/c1CrV2xu7wL2q0aSyrJyvTu2qPUtu18Wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdbkcKzrCJJMsPQHLelcCjB/Xx9Cz8zcrgMcf/2Pk6X0MpzNdevHfJhlrlHX/x9Vx
	 +rGrowUCcCYUx4wk/qiRnFGtwotlnMl8ZLST0NfaX8hJHsRjqfcy/XxSCbbSTPHI5o
	 iLyrQHtjTg+wFLOYbF5g/2Agx5j5gnim/EzG6FEiMCOazC/N7cHBEVWOhH9QazsLfH
	 BbyzRk2+n5rllmC7a5+ySfiaeAhkoCcl/CzENBWvg/LURrIURgjbdFrPAJXncR7gTt
	 DDi9ruNwWmaJQIQZQ9dKdAKLeBRYozU4I/dH9N7DYjGnObLzTSE70v0viBVaXt1IUm
	 YZY2JAI2d9/4g==
Date: Fri, 28 Jun 2024 19:27:45 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Netdev <netdev@vger.kernel.org>, Felix Fietkau <nbd@nbd.name>,
	lorenzo.bianconi83@gmail.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, upstream@airoha.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	benjamin.larsson@genexis.eu, linux-clk@vger.kernel.org,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <Zn7ykZeBWXN3cObh@lore-desk>
References: <cover.1718696209.git.lorenzo@kernel.org>
 <f146a6f58492394a77f7d159f3c650a268fbe489.1718696209.git.lorenzo@kernel.org>
 <2d74f9c1-2b46-4544-a9c2-aa470ce36f80@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bMeKq3pp0ZgKPQdb"
Content-Disposition: inline
In-Reply-To: <2d74f9c1-2b46-4544-a9c2-aa470ce36f80@app.fastmail.com>


--bMeKq3pp0ZgKPQdb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Jun 18, 2024, at 09:49, Lorenzo Bianconi wrote:
> > Add airoha_eth driver in order to introduce ethernet support for
> > Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
> > en7581-evb networking architecture is composed by airoha_eth as mac
> > controller (cpu port) and a mt7530 dsa based switch.
> > EN7581 mac controller is mainly composed by Frame Engine (FE) and
> > QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
> > functionalities are supported now) while QDMA is used for DMA operation
> > and QOS functionalities between mac layer and the dsa switch (hw QoS is
> > not available yet and it will be added in the future).
> > Currently only hw lan features are available, hw wan will be added with
> > subsequent patches.
> >
> > Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> I noticed a few small things that you may want to improve:

Hi Arnd,

thx for the review.

>=20
> > +static void airoha_qdma_set_irqmask(struct airoha_eth *eth, int index,
> > +				    u32 clear, u32 set)
> > +{
> > +	unsigned long flags;
> > +
> > +	if (WARN_ON_ONCE(index >=3D ARRAY_SIZE(eth->irqmask)))
> > +		return;
> > +
> > +	spin_lock_irqsave(&eth->irq_lock, flags);
> > +
> > +	eth->irqmask[index] &=3D ~clear;
> > +	eth->irqmask[index] |=3D set;
> > +	airoha_qdma_wr(eth, REG_INT_ENABLE(index), eth->irqmask[index]);
> > +
> > +	spin_unlock_irqrestore(&eth->irq_lock, flags);
> > +}
>=20
> spin_lock_irqsave() is fairly expensive here, and it doesn't
> actually protect the register write since that is posted
> and can leak out of the spinlock.
>=20
> You can probably just remove the lock and instead do the mask
> with atomic_cmpxchg() here.

I did not get what you mean here. I guess the spin_lock is used to avoid
concurrent irq registers updates from user/bh context or irq handler.
Am I missing something?

>=20
> > +
> > +		dma_sync_single_for_device(dev, e->dma_addr, e->dma_len, dir);
> > +
> > +		val =3D FIELD_PREP(QDMA_DESC_LEN_MASK, e->dma_len);
> > +		WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
> > +		WRITE_ONCE(desc->addr, cpu_to_le32(e->dma_addr));
> > +		val =3D FIELD_PREP(QDMA_DESC_NEXT_ID_MASK, q->head);
> > +		WRITE_ONCE(desc->data, cpu_to_le32(val));
> > +		WRITE_ONCE(desc->msg0, 0);
> > +		WRITE_ONCE(desc->msg1, 0);
> > +		WRITE_ONCE(desc->msg2, 0);
> > +		WRITE_ONCE(desc->msg3, 0);
> > +
> > +		wmb();
> > +		airoha_qdma_rmw(eth, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
> > +				FIELD_PREP(RX_RING_CPU_IDX_MASK, q->head));
>=20
> The wmb() between the descriptor write and the MMIO does nothing
> and can probably just be removed here, a writel() already contains
> all the barriers you need to make DMA memory visible before the
> MMIO write.
>=20
> If there is a chance that the device might read the descriptor
> while it is being updated by you have not written to the
> register, there should be a barrier before the last store to
> the descriptor that sets a 'valid' bit. That one can be a
> cheaper dma_wmb() then.

ack, I will fix it in v4.

>=20
> > +static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
> > +{
> > +	struct airoha_eth *eth =3D dev_instance;
> > +	u32 intr[ARRAY_SIZE(eth->irqmask)];
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(eth->irqmask); i++) {
> > +		intr[i] =3D airoha_qdma_rr(eth, REG_INT_STATUS(i));
> > +		intr[i] &=3D eth->irqmask[i];
> > +		airoha_qdma_wr(eth, REG_INT_STATUS(i), intr[i]);
> > +	}
>=20
> This looks like you send an interrupt Ack to each
> interrupt in order to re-arm it, but then you disable
> it again. Would it be possible to leave the interrupt enabled
> but defer the Ack until the napi poll function is completed?

I guess doing so we are not using NAPIs as expected since they are
supposed to run with interrupt disabled. Agree?

>=20
> > +	if (!test_bit(DEV_STATE_INITIALIZED, &eth->state))
> > +		return IRQ_NONE;
> > +
> > +	if (intr[1] & RX_DONE_INT_MASK) {
> > +		airoha_qdma_irq_disable(eth, QDMA_INT_REG_IDX1,
> > +					RX_DONE_INT_MASK);
> > +		airoha_qdma_for_each_q_rx(eth, i) {
> > +			if (intr[1] & BIT(i))
> > +				napi_schedule(&eth->q_rx[i].napi);
> > +		}
> > +	}
>=20
> Something seems wrong here, but that's probably just me
> misunderstanding the design: if all queues are signaled
> through the same interrupt handler, and you then do
> napi_schedule() for each queue, I would expect them to
> just all get run on the same CPU.
>=20
> If you have separate queues, doesn't that mean you also need
> separate irq numbers here so they can be distributed to the
> available CPUs?

Actually I missed to mark the NAPI as threaded. Doing so, even if we have a
single irq line shared by all Rx queues, the scheduler can run the NAPIs in
parallel on different CPUs. I will fix it in v4.

>=20
> > +		val =3D FIELD_PREP(QDMA_DESC_LEN_MASK, len);
> > +		if (i < nr_frags - 1)
> > +			val |=3D FIELD_PREP(QDMA_DESC_MORE_MASK, 1);
> > +		WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
> > +		WRITE_ONCE(desc->addr, cpu_to_le32(addr));
> > +		val =3D FIELD_PREP(QDMA_DESC_NEXT_ID_MASK, index);
> > +		WRITE_ONCE(desc->data, cpu_to_le32(val));
> > +		WRITE_ONCE(desc->msg0, cpu_to_le32(msg0));
> > +		WRITE_ONCE(desc->msg1, cpu_to_le32(msg1));
> > +		WRITE_ONCE(desc->msg2, cpu_to_le32(0xffff));
> > +
> > +		e->skb =3D i ? NULL : skb;
> > +		e->dma_addr =3D addr;
> > +		e->dma_len =3D len;
> > +
> > +		wmb();
> > +		airoha_qdma_rmw(eth, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
> > +				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
>=20
> Same as above with the wmb().

ack, I will fix it in v4.

>=20
> > +static int airoha_rx_queues_show(struct seq_file *s, void *data)
> > +{
> > +	struct airoha_eth *eth =3D s->private;
> > +	int i;
> > +
> ...
> > +static int airoha_xmit_queues_show(struct seq_file *s, void *data)
> > +{
> > +	struct airoha_eth *eth =3D s->private;
> > +	int i;
> > +
>=20
> Isn't this information available through ethtool already?

I guess we can get rid of this debugfs since it was just for debugging.

>=20
> > b/drivers/net/ethernet/mediatek/airoha_eth.h
> > new file mode 100644
> > index 000000000000..fcd684e1418a
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mediatek/airoha_eth.h
> > @@ -0,0 +1,793 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2024 Lorenzo Bianconi <lorenzo@kernel.org>
> > + */
> > +
> > +#define AIROHA_MAX_NUM_RSTS		3
> > +#define AIROHA_MAX_NUM_XSI_RSTS		4
>=20
> If your driver only has a single .c file, I would suggest moving all the
> contents of the .h file into that as well for better readability.

I do not have a strong opinion about it but since we will extend the driver
in the future, keeping .c and .h in different files, seems a bit more tidy.
What do you think?

Regards,
Lorenzo

>=20
>       Arnd=20

--bMeKq3pp0ZgKPQdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZn7ykQAKCRA6cBh0uS2t
rM9CAQCiagTiOXfG6lOuuAmsCt3qGVZIIDLSfcOb+VChPh5bAgD/ROl7fEb/iugs
RcHNy+AlLKCbxagsGTgZtDTKz4eC6AE=
=nayO
-----END PGP SIGNATURE-----

--bMeKq3pp0ZgKPQdb--

