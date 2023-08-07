Return-Path: <netdev+bounces-24741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9DD7717F8
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 03:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443B61C20904
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 01:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1871D649;
	Mon,  7 Aug 2023 01:46:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F83392
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 01:45:59 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DFFC19AF;
	Sun,  6 Aug 2023 18:45:39 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3771hFiC5030517, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3771hFiC5030517
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
	Mon, 7 Aug 2023 09:43:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 7 Aug 2023 09:42:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 7 Aug 2023 09:42:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 7 Aug 2023 09:42:43 +0800
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
Subject: RE: [PATCH -next 6/6] brcm80211: Remove an unnecessary ternary operator
Thread-Topic: [PATCH -next 6/6] brcm80211: Remove an unnecessary ternary
 operator
Thread-Index: AQHZxodyLvV38Vq6lUarMSYN6WoMea/eE5fw
Date: Mon, 7 Aug 2023 01:42:43 +0000
Message-ID: <f72991b36d6a449ea5cf476d438bcd1d@realtek.com>
References: <20230804035346.2879318-1-ruanjinjie@huawei.com>
 <20230804035346.2879318-7-ruanjinjie@huawei.com>
In-Reply-To: <20230804035346.2879318-7-ruanjinjie@huawei.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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
> Subject: [PATCH -next 6/6] brcm80211: Remove an unnecessary ternary opera=
tor
>=20
> There is a ternary operator, the true or false judgement of which
> is unnecessary in C language semantics.
>=20
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
> b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
> index 8580a2754789..8328b22829c5 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
> @@ -27351,8 +27351,7 @@ static int wlc_phy_cal_rxiq_nphy_rev3(struct brcm=
s_phy *pi,
>=20
>         for (rx_core =3D 0; rx_core < pi->pubpi.phy_corenum; rx_core++) {
>=20
> -               skip_rxiqcal =3D
> -                       ((rxcore_state & (1 << rx_core)) =3D=3D 0) ? true=
 : false;
> +               skip_rxiqcal =3D (rxcore_state & (1 << rx_core)) =3D=3D 0=
;

skip_rxiqcal =3D !(rxcore_state & (1 << rx_core));

>=20
>                 wlc_phy_rxcal_physetup_nphy(pi, rx_core);
>=20
> --
> 2.34.1
>=20
>=20
> ------Please consider the environment before printing this e-mail.

