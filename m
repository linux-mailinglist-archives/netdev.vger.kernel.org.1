Return-Path: <netdev+bounces-24739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FED37717E8
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 03:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77551C2090B
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 01:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E22649;
	Mon,  7 Aug 2023 01:43:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D802392
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 01:43:30 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B51F1713;
	Sun,  6 Aug 2023 18:43:26 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3771dYi55025316, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3771dYi55025316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
	Mon, 7 Aug 2023 09:39:35 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 7 Aug 2023 09:39:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 7 Aug 2023 09:39:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 7 Aug 2023 09:39:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>,
        "sgoutham@marvell.com"
	<sgoutham@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
        "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
        "tariqt@nvidia.com" <tariqt@nvidia.com>,
        "s.shtylyov@omp.ru"
	<s.shtylyov@omp.ru>,
        "aspriel@gmail.com" <aspriel@gmail.com>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "richardcochran@gmail.com"
	<richardcochran@gmail.com>,
        "yoshihiro.shimoda.uh@renesas.com"
	<yoshihiro.shimoda.uh@renesas.com>,
        "u.kleine-koenig@pengutronix.de"
	<u.kleine-koenig@pengutronix.de>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "lee@kernel.org" <lee@kernel.org>,
        "set_pte_at@outlook.com"
	<set_pte_at@outlook.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com"
	<brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com"
	<SHA-cyfmac-dev-list@infineon.com>
Subject: RE: [PATCH -next 1/6] net: thunderx: Remove unnecessary ternary operators
Thread-Topic: [PATCH -next 1/6] net: thunderx: Remove unnecessary ternary
 operators
Thread-Index: AQHZxoduaAYTDJlTBUyphtGbEFvm5q/eErLw
Date: Mon, 7 Aug 2023 01:39:50 +0000
Message-ID: <15759f98483947999393a25b857bc4fe@realtek.com>
References: <20230804035346.2879318-1-ruanjinjie@huawei.com>
 <20230804035346.2879318-2-ruanjinjie@huawei.com>
In-Reply-To: <20230804035346.2879318-2-ruanjinjie@huawei.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Ruan Jinjie <ruanjinjie@huawei.com>
> Sent: Friday, August 4, 2023 11:54 AM
> To: sgoutham@marvell.com; davem@davemloft.net; edumazet@google.com; kuba@=
kernel.org; pabeni@redhat.com;
> jesse.brandeburg@intel.com; anthony.l.nguyen@intel.com; tariqt@nvidia.com=
; s.shtylyov@omp.ru;
> aspriel@gmail.com; franky.lin@broadcom.com; hante.meuleman@broadcom.com; =
kvalo@kernel.org;
> richardcochran@gmail.com; yoshihiro.shimoda.uh@renesas.com; ruanjinjie@hu=
awei.com;
> u.kleine-koenig@pengutronix.de; mkl@pengutronix.de; lee@kernel.org; set_p=
te_at@outlook.com;
> linux-arm-kernel@lists.infradead.org; netdev@vger.kernel.org; intel-wired=
-lan@lists.osuosl.org;
> linux-rdma@vger.kernel.org; linux-renesas-soc@vger.kernel.org; linux-wire=
less@vger.kernel.org;
> brcm80211-dev-list.pdl@broadcom.com; SHA-cyfmac-dev-list@infineon.com
> Subject: [PATCH -next 1/6] net: thunderx: Remove unnecessary ternary oper=
ators
>=20
> Ther are a little ternary operators, the true or false judgement
> of which is unnecessary in C language semantics.
>=20
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/cavium/thunder/nic_main.c    | 2 +-
>  drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c
> b/drivers/net/ethernet/cavium/thunder/nic_main.c
> index 0ec65ec634df..b7cf4ba89b7c 100644
> --- a/drivers/net/ethernet/cavium/thunder/nic_main.c
> +++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
> @@ -174,7 +174,7 @@ static void nic_mbx_send_ready(struct nicpf *nic, int=
 vf)
>                 if (mac)
>                         ether_addr_copy((u8 *)&mbx.nic_cfg.mac_addr, mac)=
;
>         }
> -       mbx.nic_cfg.sqs_mode =3D (vf >=3D nic->num_vf_en) ? true : false;
> +       mbx.nic_cfg.sqs_mode =3D vf >=3D nic->num_vf_en;
>         mbx.nic_cfg.node_id =3D nic->node;
>=20
>         mbx.nic_cfg.loopback_supported =3D vf < nic->num_vf_en;
> diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> index a317feb8decb..9e467cecc33a 100644
> --- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> +++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> @@ -957,7 +957,7 @@ static void bgx_poll_for_sgmii_link(struct lmac *lmac=
)
>                 goto next_poll;
>         }
>=20
> -       lmac->link_up =3D ((pcs_link & PCS_MRX_STATUS_LINK) !=3D 0) ? tru=
e : false;
> +       lmac->link_up =3D (pcs_link & PCS_MRX_STATUS_LINK) !=3D 0;

lmac->link_up =3D !!(pcs_link & PCS_MRX_STATUS_LINK);

>         an_result =3D bgx_reg_read(lmac->bgx, lmac->lmacid,
>                                  BGX_GMP_PCS_ANX_AN_RESULTS);
>=20
> --
> 2.34.1
>=20
>=20
> ------Please consider the environment before printing this e-mail.

