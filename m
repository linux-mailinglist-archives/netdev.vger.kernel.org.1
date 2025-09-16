Return-Path: <netdev+bounces-223686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60672B5A0BB
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 20:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F8A07AC72D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7082DBF43;
	Tue, 16 Sep 2025 18:43:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A313747F;
	Tue, 16 Sep 2025 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758048203; cv=none; b=MUe6WWtLRl24KOOzmnbEgdBklioL8ocr8J/ICQI9hyTnGUmAXujJWUjTtBDJig7yuGYCEw1X+etN8igaAdTGnR4DRxaBkgaDSED7jO57/K2duVmBjrGiew5IfqwZE7lchfTg4Zf6sfjXXbnH8Y1sCOsHb5Ya5OdYLNHobjCjRWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758048203; c=relaxed/simple;
	bh=x8/s9p65KvVbq871vZXt6mQCgfo6dYl4V4VkDPobTzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTn5S947DdlOyi8S8+ZiOw2FV3n0OKhpeoQ/Tu+KKAUp8luVEkvpyUHb/SHD9lbHB4D+i1wP6QcCc1SYVJTTQhokM4j6Pg6Fm54jWYSMockfcmfHCPt/VD0OblZ1e7yKyFvYF7gvkgcfON3JyhDS6tcMKWMMSmMJPTHQJct9HG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.98.2)
	(envelope-from <joerg@jo-so.de>)
	id 1uyadZ-00000001Ua7-0cAn;
	Tue, 16 Sep 2025 20:42:45 +0200
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98.2)
	(envelope-from <joerg@jo-so.de>)
	id 1uyadY-000000027FP-26zW;
	Tue, 16 Sep 2025 20:42:44 +0200
Date: Tue, 16 Sep 2025 20:42:44 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, 
	lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be, 
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com, alexanderduyck@fb.com, 
	richardcochran@gmail.com, kees@kernel.org, gustavoars@kernel.org, rdunlap@infradead.org, 
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v12 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <7d4olrtuyagvcma5sspca6urmkjotkjtthbbekkeqltnd6mgq6@pn4smgsdaf4c>
OpenPGP: id=7D2C9A23D1AEA375; url=https://jo-so.de/pgp-key.txt;
 preference=signencrypt
References: <20250916112952.26032-1-dong100@mucse.com>
 <20250916112952.26032-4-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bsa6xqb7tdis7btv"
Content-Disposition: inline
In-Reply-To: <20250916112952.26032-4-dong100@mucse.com>


--bsa6xqb7tdis7btv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v12 3/5] net: rnpgbe: Add basic mbx ops support
MIME-Version: 1.0

Hi,

only some minor suggestions.

Dong Yibo schrieb am Di 16. Sep, 19:29 (+0800):
> Add fundamental mailbox (MBX) communication operations between PF
> (Physical Function) and firmware for n500/n210 chips
>=20
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   4 +-
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  25 ++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  70 +++
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   7 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   5 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 420 ++++++++++++++++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  20 +
>  7 files changed, 550 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
>=20
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/eth=
ernet/mucse/rnpgbe/Makefile
> index 9df536f0d04c..5fc878ada4b1 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
> +++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> @@ -5,4 +5,6 @@
>  #
> =20
>  obj-$(CONFIG_MGBE) +=3D rnpgbe.o
> -rnpgbe-objs :=3D rnpgbe_main.o
> +rnpgbe-objs :=3D rnpgbe_main.o\
> +	       rnpgbe_chip.o\
> +	       rnpgbe_mbx.o
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/eth=
ernet/mucse/rnpgbe/rnpgbe.h
> index 3b122dd508ce..7450bfc5ee98 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> @@ -4,13 +4,36 @@
>  #ifndef _RNPGBE_H
>  #define _RNPGBE_H
> =20
> +#include <linux/types.h>
> +
>  enum rnpgbe_boards {
>  	board_n500,
>  	board_n210
>  };
> =20
> +struct mucse_mbx_stats {
> +	u32 msgs_tx; /* Number of messages sent from PF to fw */
> +	u32 msgs_rx; /* Number of messages received from fw to PF */
> +	u32 acks; /* Number of ACKs received from firmware */
> +	u32 reqs; /* Number of requests sent to firmware */
> +};
> +
> +struct mucse_mbx_info {
> +	struct mucse_mbx_stats stats;
> +	u32 timeout_us;
> +	u32 delay_us;
> +	u16 fw_req;
> +	u16 fw_ack;
> +	/* fw <--> pf mbx */
> +	u32 fwpf_shm_base;
> +	u32 pf2fw_mbx_ctrl;
> +	u32 fwpf_mbx_mask;
> +	u32 fwpf_ctrl_base;
> +};
> +
>  struct mucse_hw {
>  	void __iomem *hw_addr;
> +	struct mucse_mbx_info mbx;
>  };
> =20
>  struct mucse {
> @@ -19,6 +42,8 @@ struct mucse {
>  	struct mucse_hw hw;
>  };
> =20
> +int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
> +
>  /* Device IDs */
>  #define PCI_VENDOR_ID_MUCSE 0x8848
>  #define PCI_DEVICE_ID_N500_QUAD_PORT 0x8308
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/ne=
t/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> new file mode 100644
> index 000000000000..86f1c75796b0
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> +
> +#include <linux/errno.h>
> +
> +#include "rnpgbe.h"
> +#include "rnpgbe_hw.h"
> +#include "rnpgbe_mbx.h"
> +
> +/**
> + * rnpgbe_init_n500 - Setup n500 hw info
> + * @hw: hw information structure
> + *
> + * rnpgbe_init_n500 initializes all private
> + * structure for n500
> + **/
> +static void rnpgbe_init_n500(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx =3D &hw->mbx;
> +
> +	mbx->fwpf_ctrl_base =3D MUCSE_N500_FWPF_CTRL_BASE;
> +	mbx->fwpf_shm_base =3D MUCSE_N500_FWPF_SHM_BASE;
> +}
> +
> +/**
> + * rnpgbe_init_n210 - Setup n210 hw info
> + * @hw: hw information structure
> + *
> + * rnpgbe_init_n210 initializes all private
> + * structure for n210
> + **/
> +static void rnpgbe_init_n210(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx =3D &hw->mbx;
> +
> +	mbx->fwpf_ctrl_base =3D MUCSE_N210_FWPF_CTRL_BASE;
> +	mbx->fwpf_shm_base =3D MUCSE_N210_FWPF_SHM_BASE;
> +}
> +
> +/**
> + * rnpgbe_init_hw - Setup hw info according to board_type
> + * @hw: hw information structure
> + * @board_type: board type
> + *
> + * rnpgbe_init_hw initializes all hw data
> + *
> + * Return: 0 on success, negative errno on failure

Maybe say that -EINVAL is the only error returned.

> + **/
> +int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
> +{
> +	struct mucse_mbx_info *mbx =3D &hw->mbx;
> +
> +	mbx->pf2fw_mbx_ctrl =3D MUCSE_GBE_PFFW_MBX_CTRL_OFFSET;
> +	mbx->fwpf_mbx_mask =3D MUCSE_GBE_FWPF_MBX_MASK_OFFSET;
> +
> +	switch (board_type) {
> +	case board_n500:
> +		rnpgbe_init_n500(hw);
> +		break;
> +	case board_n210:
> +		rnpgbe_init_n210(hw);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	/* init_params with mbx base */
> +	mucse_init_mbx_params_pf(hw);
> +
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/=
ethernet/mucse/rnpgbe/rnpgbe_hw.h
> index 3a779806e8be..aad4cb2f4164 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> @@ -4,5 +4,12 @@
>  #ifndef _RNPGBE_HW_H
>  #define _RNPGBE_HW_H
> =20
> +#define MUCSE_N500_FWPF_CTRL_BASE 0x28b00
> +#define MUCSE_N500_FWPF_SHM_BASE 0x2d000
> +#define MUCSE_GBE_PFFW_MBX_CTRL_OFFSET 0x5500
> +#define MUCSE_GBE_FWPF_MBX_MASK_OFFSET 0x5700
> +#define MUCSE_N210_FWPF_CTRL_BASE 0x29400
> +#define MUCSE_N210_FWPF_SHM_BASE 0x2d900
> +
>  #define RNPGBE_MAX_QUEUES 8
>  #endif /* _RNPGBE_HW_H */
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/ne=
t/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 0afe39621661..c6cfb54f7c59 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> @@ -68,6 +68,11 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
>  	}
> =20
>  	hw->hw_addr =3D hw_addr;
> +	err =3D rnpgbe_init_hw(hw, board_type);
> +	if (err) {
> +		dev_err(&pdev->dev, "Init hw err %d\n", err);
> +		goto err_free_net;
> +	}
> =20
>  	return 0;
> =20
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net=
/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> new file mode 100644
> index 000000000000..7501a55c3134
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> @@ -0,0 +1,420 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2022 - 2025 Mucse Corporation. */
> +
> +#include <linux/errno.h>
> +#include <linux/bitfield.h>
> +#include <linux/iopoll.h>
> +
> +#include "rnpgbe_mbx.h"
> +
> +/**
> + * mbx_data_rd32 - Reads reg with base mbx->fwpf_shm_base
> + * @mbx: pointer to the MBX structure
> + * @reg: register offset
> + *
> + * Return: register value
> + **/
> +static u32 mbx_data_rd32(struct mucse_mbx_info *mbx, u32 reg)
> +{
> +	struct mucse_hw *hw =3D container_of(mbx, struct mucse_hw, mbx);
> +
> +	return readl(hw->hw_addr + mbx->fwpf_shm_base + reg);
> +}
> +
> +/**
> + * mbx_data_wr32 - Writes value to reg with base mbx->fwpf_shm_base
> + * @mbx: pointer to the MBX structure
> + * @reg: register offset
> + * @value: value to be written
> + *
> + **/
> +static void mbx_data_wr32(struct mucse_mbx_info *mbx, u32 reg, u32 value)
> +{
> +	struct mucse_hw *hw =3D container_of(mbx, struct mucse_hw, mbx);
> +
> +	writel(value, hw->hw_addr + mbx->fwpf_shm_base + reg);
> +}
> +
> +/**
> + * mbx_ctrl_rd32 - Reads reg with base mbx->fwpf_ctrl_base
> + * @mbx: pointer to the MBX structure
> + * @reg: register offset
> + *
> + * Return: register value
> + **/
> +static u32 mbx_ctrl_rd32(struct mucse_mbx_info *mbx, u32 reg)
> +{
> +	struct mucse_hw *hw =3D container_of(mbx, struct mucse_hw, mbx);
> +
> +	return readl(hw->hw_addr + mbx->fwpf_ctrl_base + reg);
> +}
> +
> +/**
> + * mbx_ctrl_wr32 - Writes value to reg with base mbx->fwpf_ctrl_base
> + * @mbx: pointer to the MBX structure
> + * @reg: register offset
> + * @value: value to be written
> + *
> + **/
> +static void mbx_ctrl_wr32(struct mucse_mbx_info *mbx, u32 reg, u32 value)
> +{
> +	struct mucse_hw *hw =3D container_of(mbx, struct mucse_hw, mbx);
> +
> +	writel(value, hw->hw_addr + mbx->fwpf_ctrl_base + reg);
> +}
> +
> +/**
> + * mucse_mbx_get_lock_pf - Write ctrl and read back lock status
> + * @hw: pointer to the HW structure
> + *
> + * Return: register value after write
> + **/
> +static u32 mucse_mbx_get_lock_pf(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx =3D &hw->mbx;
> +	u32 reg =3D MUCSE_MBX_PF2FW_CTRL(mbx);
> +
> +	mbx_ctrl_wr32(mbx, reg, MUCSE_MBX_PFU);
> +
> +	return mbx_ctrl_rd32(mbx, reg);
> +}
> +
> +/**
> + * mucse_obtain_mbx_lock_pf - Obtain mailbox lock
> + * @hw: pointer to the HW structure
> + *
> + * Pair with mucse_release_mbx_lock_pf()
> + * This function maybe used in an irq handler.
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx =3D &hw->mbx;
> +	u32 val;
> +
> +	return read_poll_timeout_atomic(mucse_mbx_get_lock_pf,
> +					val, val & MUCSE_MBX_PFU,
> +					mbx->delay_us,
> +					mbx->timeout_us,
> +					false, hw);
> +}
> +
> +/**
> + * mucse_release_mbx_lock_pf - Release mailbox lock
> + * @hw: pointer to the HW structure
> + * @req: send a request or not
> + *
> + * Pair with mucse_obtain_mbx_lock_pf():
> + * - Releases the mailbox lock by clearing MUCSE_MBX_PFU bit
> + * - Simultaneously sends the request by setting MUCSE_MBX_REQ bit
> + *   if req is true
> + * (Both bits are in the same mailbox control register,
> + * so operations are combined)
> + **/
> +static void mucse_release_mbx_lock_pf(struct mucse_hw *hw, bool req)
> +{
> +	struct mucse_mbx_info *mbx =3D &hw->mbx;
> +	u32 reg =3D MUCSE_MBX_PF2FW_CTRL(mbx);
> +
> +	if (req)
> +		mbx_ctrl_wr32(mbx, reg, MUCSE_MBX_REQ);
> +	else
> +		mbx_ctrl_wr32(mbx, reg, 0);

Maybe combine this to:

mbx_ctrl_wr32(mbx, reg, req ? MUCSE_MBX_REQ : 0);

or also inlining reg:

mbx_ctrl_wr32(mbx, MUCSE_MBX_PF2FW_CTRL(mbx), req ? MUCSE_MBX_REQ : 0);

> +}
> +
> +/**
> + * mucse_mbx_get_fwreq - Read fw req from reg
> + * @mbx: pointer to the mbx structure
> + *
> + * Return: the fwreq value
> + **/
> +static u16 mucse_mbx_get_fwreq(struct mucse_mbx_info *mbx)
> +{
> +	u32 val =3D mbx_data_rd32(mbx, MUCSE_MBX_FW2PF_CNT);
> +
> +	return FIELD_GET(GENMASK_U32(15, 0), val);
> +}
> +
> +/**
> + * mucse_mbx_inc_pf_ack - Increase ack
> + * @hw: pointer to the HW structure
> + *
> + * mucse_mbx_inc_pf_ack reads pf_ack from hw, then writes
> + * new value back after increase
> + **/
> +static void mucse_mbx_inc_pf_ack(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx =3D &hw->mbx;
> +	u16 ack;
> +	u32 val;
> +
> +	val =3D mbx_data_rd32(mbx, MUCSE_MBX_PF2FW_CNT);
> +	ack =3D FIELD_GET(GENMASK_U32(31, 16), val);
> +	ack++;
> +	val &=3D ~GENMASK_U32(31, 16);
> +	val |=3D FIELD_PREP(GENMASK_U32(31, 16), ack);
> +	mbx_data_wr32(mbx, MUCSE_MBX_PF2FW_CNT, val);
> +	hw->mbx.stats.msgs_rx++;
> +}
> +
> +/**
> + * mucse_read_mbx_pf - Read a message from the mailbox
> + * @hw: pointer to the HW structure
> + * @msg: the message buffer
> + * @size: length of buffer
> + *
> + * mucse_read_mbx_pf copies a message from the mbx buffer to the caller's
> + * memory buffer. The presumption is that the caller knows that there was
> + * a message due to a fw request so no polling for message is needed.
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +static int mucse_read_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
> +{
> +	struct mucse_mbx_info *mbx =3D &hw->mbx;
> +	int size_in_words =3D size / 4;

* Make this `const int` or I'm in favour of inlining, because it's used only
  once.

* Maybe `size / sizeof(*msg)` makes it more clearly where the 4 is coming
  from.

> +	int ret;
> +	int i;

Because this variable is only used in the for-loop, I would narrow its scope
and write `for (int i =3D 0;`

> +
> +	ret =3D mucse_obtain_mbx_lock_pf(hw);
> +	if (ret)
> +		return ret;
> +
> +	for (i =3D 0; i < size_in_words; i++)
> +		msg[i] =3D mbx_data_rd32(mbx, MUCSE_MBX_FWPF_SHM + 4 * i);
> +	/* Hw needs write data_reg at last */
> +	mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM, 0);
> +	/* flush reqs as we have read this request data */
> +	hw->mbx.fw_req =3D mucse_mbx_get_fwreq(mbx);
> +	mucse_mbx_inc_pf_ack(hw);
> +	mucse_release_mbx_lock_pf(hw, false);
> +
> +	return 0;
> +}
> +
> +/**
> + * mucse_check_for_msg_pf - Check to see if the fw has sent mail
> + * @hw: pointer to the HW structure
> + *
> + * Return: 0 if the fw has set the Status bit or else -EIO
> + **/
> +static int mucse_check_for_msg_pf(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx =3D &hw->mbx;
> +	u16 fw_req;
> +
> +	fw_req =3D mucse_mbx_get_fwreq(mbx);
> +	/* chip's register is reset to 0 when rc send reset
> +	 * mbx command. This causes 'fw_req !=3D hw->mbx.fw_req'
> +	 * be TRUE before fw really reply. Driver must wait fw reset
> +	 * done reply before using chip, we must check no-zero.
> +	 **/

If I get this right, fw_req =3D=3D 0 means that the request was send, but
nothing returned so far. Would not be -EAGAIN a better return value in this
case?

And fw_req =3D=3D hw->mbx.fw_req means that we've got the old fw_req again =
which
means there was an error (-EIO).

> +	if (fw_req !=3D 0 && fw_req !=3D hw->mbx.fw_req) {
> +		hw->mbx.stats.reqs++;
> +		return 0;
> +	}
> +
> +	return -EIO;

Only a suggestion: Might it be clearer to flip the cases and handle the if
as error case and continue with the success case?

if (fw_req =3D=3D 0 || fw_req =3D=3D hw->mbx.fw_req)
	return -EIO;

hw->mbx.stats.reqs++;
return 0;

> +}
> +
> +/**
> + * mucse_poll_for_msg - Wait for message notification
> + * @hw: pointer to the HW structure
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +static int mucse_poll_for_msg(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx =3D &hw->mbx;
> +	int val;
> +
> +	return read_poll_timeout(mucse_check_for_msg_pf,
> +				 val, !val, mbx->delay_us,
> +				 mbx->timeout_us,
> +				 false, hw);
> +}
> +
> +/**
> + * mucse_poll_and_read_mbx - Wait for message notification and receive m=
essage
> + * @hw: pointer to the HW structure
> + * @msg: the message buffer
> + * @size: length of buffer
> + *
> + * Return: 0 if it successfully received a message notification and
> + * copied it into the receive buffer, negative errno on failure
> + **/
> +int mucse_poll_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
> +{
> +	int ret;
> +
> +	ret =3D mucse_poll_for_msg(hw);
> +	if (ret)
> +		return ret;
> +
> +	return mucse_read_mbx_pf(hw, msg, size);
> +}
> +
> +/**
> + * mucse_mbx_get_fwack - Read fw ack from reg
> + * @mbx: pointer to the MBX structure
> + *
> + * Return: the fwack value
> + **/
> +static u16 mucse_mbx_get_fwack(struct mucse_mbx_info *mbx)
> +{
> +	u32 val =3D mbx_data_rd32(mbx, MUCSE_MBX_FW2PF_CNT);
> +
> +	return FIELD_GET(GENMASK_U32(31, 16), val);
> +}
> +
> +/**
> + * mucse_mbx_inc_pf_req - Increase req
> + * @hw: pointer to the HW structure
> + *
> + * mucse_mbx_inc_pf_req reads pf_req from hw, then writes
> + * new value back after increase
> + **/
> +static void mucse_mbx_inc_pf_req(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx =3D &hw->mbx;
> +	u16 req;
> +	u32 val;
> +
> +	val =3D mbx_data_rd32(mbx, MUCSE_MBX_PF2FW_CNT);
> +	req =3D FIELD_GET(GENMASK_U32(15, 0), val);

Why not assign the values in the declaration like done with mbx?

> +	req++;
> +	val &=3D ~GENMASK_U32(15, 0);
> +	val |=3D FIELD_PREP(GENMASK_U32(15, 0), req);
> +	mbx_data_wr32(mbx, MUCSE_MBX_PF2FW_CNT, val);
> +	hw->mbx.stats.msgs_tx++;
> +}
> +
> +/**
> + * mucse_write_mbx_pf - Place a message in the mailbox
> + * @hw: pointer to the HW structure
> + * @msg: the message buffer
> + * @size: length of buffer
> + *
> + * Return: 0 if it successfully copied message into the buffer

=2E.. "otherwise the error from obtaining the lock" or something better.

> + **/
> +static int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
> +{
> +	struct mucse_mbx_info *mbx =3D &hw->mbx;
> +	int size_in_words =3D size / 4;
> +	int ret;
> +	int i;
> +
> +	ret =3D mucse_obtain_mbx_lock_pf(hw);
> +	if (ret)
> +		return ret;
> +
> +	for (i =3D 0; i < size_in_words; i++)
> +		mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM + i * 4, msg[i]);
> +
> +	/* flush acks as we are overwriting the message buffer */
> +	hw->mbx.fw_ack =3D mucse_mbx_get_fwack(mbx);
> +	mucse_mbx_inc_pf_req(hw);
> +	mucse_release_mbx_lock_pf(hw, true);
> +
> +	return 0;
> +}
> +
> +/**
> + * mucse_check_for_ack_pf - Check to see if the fw has ACKed
> + * @hw: pointer to the HW structure
> + *
> + * Return: 0 if the fw has set the Status bit or else -EIO
> + **/
> +static int mucse_check_for_ack_pf(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx =3D &hw->mbx;
> +	u16 fw_ack;
> +
> +	fw_ack =3D mucse_mbx_get_fwack(mbx);
> +	/* chip's register is reset to 0 when rc send reset
> +	 * mbx command. This causes 'fw_ack !=3D hw->mbx.fw_ack'
> +	 * be TRUE before fw really reply. Driver must wait fw reset
> +	 * done reply before using chip, we must check no-zero.
> +	 **/
> +	if (fw_ack !=3D 0 && fw_ack !=3D hw->mbx.fw_ack) {
> +		hw->mbx.stats.acks++;
> +		return 0;
> +	}
> +
> +	return -EIO;
> +}
> +
> +/**
> + * mucse_poll_for_ack - Wait for message acknowledgment
> + * @hw: pointer to the HW structure
> + *
> + * Return: 0 if it successfully received a message acknowledgment,
> + * else negative errno
> + **/
> +static int mucse_poll_for_ack(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx =3D &hw->mbx;
> +	int val;
> +
> +	return read_poll_timeout(mucse_check_for_ack_pf,
> +				 val, !val, mbx->delay_us,
> +				 mbx->timeout_us,
> +				 false, hw);
> +}
> +
> +/**
> + * mucse_write_and_wait_ack_mbx - Write a message to the mailbox, wait f=
or ack
> + * @hw: pointer to the HW structure
> + * @msg: the message buffer
> + * @size: length of buffer
> + *
> + * Return: 0 if it successfully copied message into the buffer and
> + * received an ack to that message within delay * timeout_cnt period
> + **/
> +int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
> +{
> +	int ret;
> +
> +	ret =3D mucse_write_mbx_pf(hw, msg, size);

If I see it right, this function is the only user of mucse_write_mbx_pf.

> +	if (ret)
> +		return ret;
> +	return mucse_poll_for_ack(hw);

The same here?

> +}
> +
> +/**
> + * mucse_mbx_reset - Reset mbx info, sync info from regs
> + * @hw: pointer to the HW structure
> + *
> + * mucse_mbx_reset resets all mbx variables to default.
> + **/
> +static void mucse_mbx_reset(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx =3D &hw->mbx;
> +	u32 val;
> +
> +	val =3D mbx_data_rd32(mbx, MUCSE_MBX_FW2PF_CNT);

Because val is assigned only once, you could make it `const u32 val =3D ...`

> +	hw->mbx.fw_req =3D FIELD_GET(GENMASK_U32(15, 0), val);
> +	hw->mbx.fw_ack =3D FIELD_GET(GENMASK_U32(31, 16), val);
> +	mbx_ctrl_wr32(mbx, MUCSE_MBX_PF2FW_CTRL(mbx), 0);
> +	mbx_ctrl_wr32(mbx, MUCSE_MBX_FWPF_MASK(mbx), GENMASK_U32(31, 16));
> +}
> +
> +/**
> + * mucse_init_mbx_params_pf - Set initial values for pf mailbox
> + * @hw: pointer to the HW structure
> + *
> + * Initializes the hw->mbx struct to correct values for pf mailbox
> + */
> +void mucse_init_mbx_params_pf(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx =3D &hw->mbx;
> +
> +	mbx->delay_us =3D 100;
> +	mbx->timeout_us =3D 4 * USEC_PER_SEC;
> +	mbx->stats.msgs_tx =3D 0;
> +	mbx->stats.msgs_rx =3D 0;
> +	mbx->stats.reqs =3D 0;
> +	mbx->stats.acks =3D 0;
> +	mucse_mbx_reset(hw);

Is mucse_init_mbx_params_pf the only user of mucse_mbx_reset? If so, the
function should inlined.

> +}
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net=
/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> new file mode 100644
> index 000000000000..eac99f13b6ff
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> +
> +#ifndef _RNPGBE_MBX_H
> +#define _RNPGBE_MBX_H
> +
> +#include "rnpgbe.h"
> +
> +#define MUCSE_MBX_FW2PF_CNT 0
> +#define MUCSE_MBX_PF2FW_CNT 4
> +#define MUCSE_MBX_FWPF_SHM 8

Are these constants used by other c files or should they be private to
rnpgbe_mbx.c?

> +#define MUCSE_MBX_PF2FW_CTRL(mbx) ((mbx)->pf2fw_mbx_ctrl)
> +#define MUCSE_MBX_FWPF_MASK(mbx) ((mbx)->fwpf_mbx_mask)
> +#define MUCSE_MBX_REQ BIT(0) /* Request a req to mailbox */
> +#define MUCSE_MBX_PFU BIT(3) /* PF owns the mailbox buffer */
> +
> +int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw, u32 *msg, u16 size=
);
> +void mucse_init_mbx_params_pf(struct mucse_hw *hw);
> +int mucse_poll_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
> +#endif /* _RNPGBE_MBX_H */
> --=20
> 2.25.1
>=20
>=20

--=20
=E2=80=9CPerl=E2=80=94the only language that looks the same
 before and after RSA encryption.=E2=80=9D           (Keith Bostic)

--bsa6xqb7tdis7btv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCaMmvogAKCRB9LJoj0a6j
deEiAP9STFP5I/NZpXa1iOufvfaKgzCZVeWfMmXaDFz+qNwEwQD9HHW2Wlsy6RF6
3DpeQ8+XhzakIzeCotRtpvonLqp8rEU=
=Zo+L
-----END PGP SIGNATURE-----

--bsa6xqb7tdis7btv--

