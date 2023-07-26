Return-Path: <netdev+bounces-21130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF147628C8
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 04:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871B5281162
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 02:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920F91101;
	Wed, 26 Jul 2023 02:37:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87306623
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 02:37:40 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2B02688
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:37:32 -0700 (PDT)
X-QQ-mid: bizesmtp78t1690338944tcr3pbhf
Received: from smtpclient.apple ( [183.128.134.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Jul 2023 10:35:42 +0800 (CST)
X-QQ-SSF: 00400000000000N0Z000000B0000000
X-QQ-FEAT: 7YFKcddXagi8hgABcLf89iR8RVmg2suw1qWfQp4oHa4rGAG4gNl+KcjaCfcCs
	xI2CCRlzwDR+s4XbQHb35wZDYQzR3lQaLWe6zX40PGAt1goJcCDKBJANprqHn417GQu9Ao8
	Vuuw8zxqnLEEwU/RUZCHGicvDruZNjAeSyg5kr70DbLqTEblkssVOLt5nNJjxVQb8kKTIxp
	+mLwSI/dvEW1/Lmr+OqpzL23JgbRN5CuURixWd18JaibP0RFyrjlWl6opLxOvCo5BcJI2pK
	nTSCHs3trYor1UvfYzYHoE+bQggSFqHqmLCWZQ5V0CTnC6dRxAQkGRMf6sFReqKpWph4Xbp
	R2fN+zNEaZ6WYH7ZngLS0nlC4+St96E3MFmoimixCp/AWZX49hNdFq47hNdL6ilzuovBvE3
	qToibXO+Uik=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11446036847257293427
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH net-next 2/2] net: phy: add keep_data_connection to struct
 phydev
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <ZL/KIjjw3AZmQcGn@shell.armlinux.org.uk>
Date: Wed, 26 Jul 2023 10:35:32 +0800
Cc: Simon Horman <simon.horman@corigine.com>,
 netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B0F6878-3ABF-4F99-8CE3-F16608583EB4@net-swift.com>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
 <20207E0578DCE44C+20230724092544.73531-3-mengyuanlou@net-swift.com>
 <ZL+6kMqETdYL7QNF@corigine.com> <ZL/KIjjw3AZmQcGn@shell.armlinux.org.uk>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
X-Mailer: Apple Mail (2.3731.600.7)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> 2023=E5=B9=B47=E6=9C=8825=E6=97=A5 21:12=EF=BC=8CRussell King (Oracle) =
<linux@armlinux.org.uk> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi Simon,
>=20
> Thanks for spotting that this wasn't sent to those who should have
> been.
>=20
> Mengyuan Lou, please ensure that you address your patches to
> appropriate recipients.
>=20
> On Tue, Jul 25, 2023 at 02:05:36PM +0200, Simon Horman wrote:
>>> + * @keep_data_connection: Set to true if the PHY or the attached =
MAC need
>>> + *                        physical connection to receive packets.
>=20
> Having had a brief read through, this comment seems to me to convey
> absolutely no useful information what so ever.
>=20
> In order to receive packets, a physical connection between the MAC and
> PHY is required. So, based on that comment, keep_data_connection must
> always be true!
>=20
> So, the logic in phylib at the moment is:
>=20
>        phydev->wol_enabled =3D wol.wolopts || (netdev && =
netdev->wol_enabled);
>        /* If the device has WOL enabled, we cannot suspend the PHY */
>        if (phydev->wol_enabled && !(phydrv->flags & =
PHY_ALWAYS_CALL_SUSPEND))
>                return -EBUSY;
>=20
> wol_enabled will be true if the PHY driver reports that WoL is
> enabled at the PHY, or the network device marks that WoL is
> enabled at the network device. netdev->wol_enabled should be set
> when the network device is looking for the wakeup packets.
>=20
> Then, the PHY_ALWAYS_CALL_SUSPEND flag basically says that "even
> in these cases, we want to suspend the PHY".
>=20
> This patch appears to drop netdev->wol_enabled, replacing it with
> netdev->ncsi_enabled, whatever that is - and this change alone is
> probably going to break drivers, since they will already be
> expecting that netdev->wol_enabled causes the PHY _not_ to be
> suspended.
>=20
> Therefore, I'm not sure this patch makes much sense.
>=20
> Since the phylib maintainers were not copied with the original
> patch, that's also a reason to NAK it.
>=20
> Thanks.
>=20
> --=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>=20


Now Mac and phy in kernel is separated into two parts.
There are some features need to keep data connection.

Phy =E2=80=94=E2=80=94=E2=80=94 Wake-on-Lan =E2=80=94=E2=80=94 magic =
packets

When NIC as a ethernet in host os and it also supports ncsi as a bmc =
network port at same time.
Mac/mng =E2=80=94=E2=80=94 LLDP/NCSI =E2=80=94=E2=80=94 ncsi packtes
I think it need a way to notice phy modules.




