Return-Path: <netdev+bounces-199667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7837AE1564
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB38718976FB
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 08:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F4622A1F1;
	Fri, 20 Jun 2025 08:04:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E930E824
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750406660; cv=none; b=HgzRRBUWLzAzO82HRH4VOwV0ADz0FTjO42nywjRx4fHHskd7ceSMJfxnyrmqb+bbldwb2wN8ZL6oanxOLz9VTSC8BLHOoMWcLgkFzJIxUfH57WLGKLMTXzarSUPwhSZxfa4S6swVjxgqP8BBTPqbebH6HkpbC0uq7jZ686f534A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750406660; c=relaxed/simple;
	bh=VcChRwKGymS3J7cA3hKB9/5y3dW6bcPgUdD9AT858B0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hvVXuUhPs1YUKZGiOjrXtqmRKH/fqlkRVNrh3EcWKBf8Z2cb1DVYpnNYgvaVun56pXBsxuZofxK6lDFcxoqeEnAzQWoDdO/lnu3MQRXAioHIviggP+IXHr8pBfRwV/vSmHSBXjWH87SvVftEEoZtvM5uksvbRBHTvEx+qAM8PQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz6t1750406573ta352bc56
X-QQ-Originating-IP: gUvcgkI+eJRUn8Ex8pF6+cDK+kDYspuRkhZDdzEhvO0=
Received: from smtpclient.apple ( [60.176.0.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Jun 2025 16:02:50 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3173724028426425825
EX-QQ-RecipientCnt: 8
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH net-next 03/12] net: libwx: add wangxun vf common api
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20250617151150.GL5000@horms.kernel.org>
Date: Fri, 20 Jun 2025 16:02:39 +0800
Cc: netdev@vger.kernel.org,
 kuba@kernel.org,
 pabeni@redhat.com,
 andrew+netdev@lunn.ch,
 duanqiangwen@net-swift.com,
 linglingzhang@trustnetic.com,
 jiawenwu@net-swift.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9543F07F-5CC1-4DCA-A4C7-D9809EE2759B@net-swift.com>
References: <20250611083559.14175-1-mengyuanlou@net-swift.com>
 <20250611083559.14175-4-mengyuanlou@net-swift.com>
 <20250617151150.GL5000@horms.kernel.org>
To: Simon Horman <horms@kernel.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OWB1VFSrYnJuYmJSxajNLKHMQZHPFCUNA65bqFB+d3gh/rbdPLxnZQSi
	k/B2dSSLIlgIA5ZiKVFWfRO6liGWcH8ThcP7cX4hxbXhq7CB6HuALs8SeHUhzXJ56I7GGC8
	ygZmx0F8fZ5rw5obkWqaaSicCBRkkWvgZb3cPcd55z/5MgzdyB3PCWIvlqcwEB16wXlMzvJ
	4JqwcSM6qCplcxu+drCZW7e/MSd4UylYfXN87TkxEMx4uya9umxLIXAYqz37ORXf/Bzo4E/
	ZbrxNbxzZmpq3sYDOyt3a8aWamZuXTIoe+1c7VMkw0nzcmNZWzg5OBIc0/uCJk6A72uV5OA
	uCEdpkSOsoA+/nSdY2ecfCIMlX0zNS/IpL6sTV8iC7D06OjoNoRYmgtqLuQExuwf+4XeOCt
	LQy4quojGlU6kuA5/K3CZLi5Ntnt21s77lgqnwA50JIj280tNtl1cGFw/RGnRlVbyqMgbn7
	+uFlNqcoY/o4rSKJ/PpAJ+gQKMBkizWd2Bzlp3FfK6D4RMZvAQDq9/a/YLR4R8ru6izZCVK
	gcncTzvgCEtfUwRhe74P2n9sFxMyFTSlG333K/S92QW6ATnxtqtYjpz4o8KGvteAcIOgl3y
	CKh/hpvkA+rk4r4LfDwY3d6dK4LO19CBNOWIJpbSJwFZOEiZF4uJ3YA2aJPq/BgKIW6BWwp
	IKLZqghKMLlBYUVmscr8yuPlYbWrfm2M42AyyoXy+PyTcDn0QbAPadVPKvznWm31IP3f8xK
	/qaG5anAVSGlArPGb/BlejSfTKXy9Pe02M/FnLce3OKRgJTt9EeeG6T9oxJJb3DtxAl8KTI
	pVwiaDGPA/LaYHAyPKCfCyrAV9zxAkMHyDZ4Z9iGQfCjOMlw+l1ssGlvWf2o8aNy2sWftG8
	sNUWIkPV0lwpJv6oA/DR1XjXOk6I5abqWkNZcTksMik7yNU1EwSPXMM+ogdnEgJiz3FK9De
	W9OswrE5prsOWoJK4AofIsVRMIgG4YYlor3sRj7L2u0+gJayvonU+zdzrO6yeqXNkaAzfOT
	CMUuFteX7IumD7SzE0bNqbM3pF/WhjiIJev3E+ErGwQxWBeykU
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B46=E6=9C=8817=E6=97=A5 23:11=EF=BC=8CSimon Horman =
<horms@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jun 11, 2025 at 04:35:50PM +0800, Mengyuan Lou wrote:
>> Add common wx_configure_vf and wx_set_mac_vf for
>> ngbevf and txgbevf.
>>=20
>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>=20
> ...
>=20
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.h =
b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
>=20
> ...
>=20
>> +#define WX_VXMRQC_PSR(f)         FIELD_PREP(GENMASK(5, 1), f)
>> +#define WX_VXMRQC_PSR_MASK       GENMASK(5, 1)
>> +#define WX_VXMRQC_PSR_L4HDR      BIT(0)
>> +#define WX_VXMRQC_PSR_L3HDR      BIT(1)
>> +#define WX_VXMRQC_PSR_L2HDR      BIT(2)
>> +#define WX_VXMRQC_PSR_TUNHDR     BIT(3)
>> +#define WX_VXMRQC_PSR_TUNMAC     BIT(4)
>=20
> ...
>=20
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c =
b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
>=20
> ...
>=20
>> +/**
>> + * wx_configure_tx_ring_vf - Configure Tx ring after Reset
>> + * @wx: board private structure
>> + * @ring: structure containing ring specific data
>> + *
>> + * Configure the Tx descriptor ring after a reset.
>> + **/
>> +static void wx_configure_tx_ring_vf(struct wx *wx, struct wx_ring =
*ring)
>> +{
>> + u8 reg_idx =3D ring->reg_idx;
>> + u64 tdba =3D ring->dma;
>> + u32 txdctl =3D 0;
>> + int ret;
>> +
>> + /* disable queue to avoid issues while updating state */
>> + wr32(wx, WX_VXTXDCTL(reg_idx), WX_VXTXDCTL_FLUSH);
>> + wr32(wx, WX_VXTDBAL(reg_idx), tdba & DMA_BIT_MASK(32));
>> + wr32(wx, WX_VXTDBAH(reg_idx), tdba >> 32);
>> +
>> + /* enable relaxed ordering */
>> + pcie_capability_clear_and_set_word(wx->pdev, PCI_EXP_DEVCTL,
>> +    0, PCI_EXP_DEVCTL_RELAX_EN);
>> +
>> + /* reset head and tail pointers */
>> + wr32(wx, WX_VXTDH(reg_idx), 0);
>> + wr32(wx, WX_VXTDT(reg_idx), 0);
>> + ring->tail =3D wx->hw_addr + WX_VXTDT(reg_idx);
>> +
>> + /* reset ntu and ntc to place SW in sync with hardwdare */
>=20
> nit: hardware
>=20
>> + ring->next_to_clean =3D 0;
>> + ring->next_to_use =3D 0;
>> +
>> + txdctl |=3D WX_VXTXDCTL_BUFLEN(wx_buf_len(ring->count));
>> + txdctl |=3D WX_VXTXDCTL_ENABLE;
>> +
>> + /* set WTHRESH to encourage burst writeback, it should not be set
>> +  * higher than 1 when ITR is 0 as it could cause false TX hangs
>> +  *
>> +  * In order to avoid issues WTHRESH + PTHRESH should always be =
equal
>> +  * to or less than the number of on chip descriptors, which is
>> +  * currently 40.
>> +  */
>> + /* reinitialize tx_buffer_info */
>> + memset(ring->tx_buffer_info, 0,
>> +        sizeof(struct wx_tx_buffer) * ring->count);
>> +
>> + wr32(wx, WX_VXTXDCTL(reg_idx), txdctl);
>> + /* poll to verify queue is enabled */
>> + ret =3D read_poll_timeout(rd32, txdctl, txdctl & =
WX_VXTXDCTL_ENABLE,
>> + 1000, 10000, true, wx, WX_VXTXDCTL(reg_idx));
>> + if (ret =3D=3D -ETIMEDOUT)
>> + wx_err(wx, "Could not enable Tx Queue %d\n", reg_idx);
>> +}
>=20
> ...
>=20
>> +void wx_setup_psrtype_vf(struct wx *wx)
>> +{
>> + /* PSRTYPE must be initialized */
>> + u32 psrtype =3D WX_VXMRQC_PSR_L2HDR |
>> +       WX_VXMRQC_PSR_L3HDR |
>> +       WX_VXMRQC_PSR_L4HDR |
>> +       WX_VXMRQC_PSR_TUNHDR |
>> +       WX_VXMRQC_PSR_TUNMAC;
>> +
>> + if (wx->num_rx_queues > 1)
>> + psrtype |=3D BIT(14);
>=20
> Here bit 14 of psrtype may be set (what is bit 14?).

There is indeed no need to set this bit here.

>=20
>> +
>> + wr32m(wx, WX_VXMRQC, WX_VXMRQC_PSR_MASK, WX_VXMRQC_PSR(psrtype));
>=20
> But WX_VXMRQC_PSR() uses a mask that limits psrtype to 5 bits.
>=20
> This is flagged by W=3D1 builds with gcc-8.5.0 on x86_64
> (but curiously not gcc-15.1.0 builds). It is flagged like this:

Thanks!
When I compiled locally, I set C=3D1 and W=3D1. I'm curious as to why =
this error hasn't been reported locally.

>=20
>  CC [M]  drivers/net/ethernet/wangxun/libwx/wx_vf_lib.o
> In file included from <command-line>:
> drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c: In function =
'wx_setup_psrtype_vf':
> ././include/linux/compiler_types.h:568:38: error: call to =
'__compiletime_assert_1833' declared with attribute error: FIELD_PREP: =
value too large for the field
>  _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
>                                      ^
> ././include/linux/compiler_types.h:549:4: note: in definition of macro =
'__compiletime_assert'
>    prefix ## suffix();    \
>    ^~~~~~
> ././include/linux/compiler_types.h:568:2: note: in expansion of macro =
'_compiletime_assert'
>  _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
>  ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro =
'compiletime_assert'
> #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                     ^~~~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:68:3: note: in expansion of macro =
'BUILD_BUG_ON_MSG'
>   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
>   ^~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:115:3: note: in expansion of macro =
'__BF_FIELD_CHECK'
>   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
>   ^~~~~~~~~~~~~~~~
> drivers/net/ethernet/wangxun/libwx/wx_vf.h:73:34: note: in expansion =
of macro 'FIELD_PREP'
> #define WX_VXMRQC_PSR(f)         FIELD_PREP(GENMASK(5, 1), f)
>                                  ^~~~~~~~~~
> drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c:195:43: note: in =
expansion of macro 'WX_VXMRQC_PSR'
>  wr32m(wx, WX_VXMRQC, WX_VXMRQC_PSR_MASK, WX_VXMRQC_PSR(psrtype));
>                                           ^~~~~~~~~~~~~
> make[7]: *** [scripts/Makefile.build:203:
> drivers/net/ethernet/wangxun/libwx/wx_vf_lib.o] Error 1:
>=20
>> +}
>=20
> ...
>=20
>> +void wx_configure_rx_ring_vf(struct wx *wx, struct wx_ring *ring)
>> +{
>> + u8 reg_idx =3D ring->reg_idx;
>> + union wx_rx_desc *rx_desc;
>> + u64 rdba =3D ring->dma;
>> + u32 rxdctl;
>> +
>> + /* disable queue to avoid issues while updating state */
>> + rxdctl =3D rd32(wx, WX_VXRXDCTL(reg_idx));
>> + wx_disable_rx_queue(wx, ring);
>> +
>> + wr32(wx, WX_VXRDBAL(reg_idx), rdba & DMA_BIT_MASK(32));
>> + wr32(wx, WX_VXRDBAH(reg_idx), rdba >> 32);
>> +
>> + /* enable relaxed ordering */
>> + pcie_capability_clear_and_set_word(wx->pdev, PCI_EXP_DEVCTL,
>> +    0, PCI_EXP_DEVCTL_RELAX_EN);
>> +
>> + /* reset head and tail pointers */
>> + wr32(wx, WX_VXRDH(reg_idx), 0);
>> + wr32(wx, WX_VXRDT(reg_idx), 0);
>> + ring->tail =3D wx->hw_addr + WX_VXRDT(reg_idx);
>> +
>> + /* initialize rx_buffer_info */
>> + memset(ring->rx_buffer_info, 0,
>> +        sizeof(struct wx_rx_buffer) * ring->count);
>> +
>> + /* initialize Rx descriptor 0 */
>> + rx_desc =3D WX_RX_DESC(ring, 0);
>> + rx_desc->wb.upper.length =3D 0;
>> +
>> + /* reset ntu and ntc to place SW in sync with hardwdare */
>=20
> nit: hardware
>=20
>> + ring->next_to_clean =3D 0;
>> + ring->next_to_use =3D 0;
>> + ring->next_to_alloc =3D 0;
>> +
>> + wx_configure_srrctl_vf(wx, ring, reg_idx);
>> +
>> + /* allow any size packet since we can handle overflow */
>> + rxdctl &=3D ~WX_VXRXDCTL_BUFLEN_MASK;
>> + rxdctl |=3D WX_VXRXDCTL_BUFLEN(wx_buf_len(ring->count));
>> + rxdctl |=3D WX_VXRXDCTL_ENABLE | WX_VXRXDCTL_VLAN;
>> +
>> + /* enable RSC */
>> + rxdctl &=3D ~WX_VXRXDCTL_RSCMAX_MASK;
>> + rxdctl |=3D WX_VXRXDCTL_RSCMAX(0);
>> + rxdctl |=3D WX_VXRXDCTL_RSCEN;
>> +
>> + wr32(wx, WX_VXRXDCTL(reg_idx), rxdctl);
>> +
>> + /* pf/vf reuse */
>> + wx_enable_rx_queue(wx, ring);
>> + wx_alloc_rx_buffers(ring, wx_desc_unused(ring));
>> +}
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h =
b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h
>> new file mode 100644
>> index 000000000000..43ea126b79eb
>> --- /dev/null
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
>> +
>> +#ifndef _WX_VF_LIB_H_
>> +#define _WX_VF_LIB_H_
>> +
>> +void wx_configure_msix_vf(struct wx *wx);
>> +int wx_write_uc_addr_list_vf(struct net_device *netdev);
>> +void wx_setup_psrtype_vf(struct wx *wx);
>> +void wx_setup_vfmrqc_vf(struct wx *wx);
>> +void wx_configure_tx_vf(struct wx *wx);
>> +void wx_configure_rx_ring_vf(struct wx *wx, struct wx_ring *ring);
>> +
>> +#endif /* _WX_VF_LIB_H_ */
>> --=20
>> 2.30.1



