Return-Path: <netdev+bounces-22213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E897668E3
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 11:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F23228231B
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 09:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB4410950;
	Fri, 28 Jul 2023 09:31:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAB1D305
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 09:31:20 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319C21BC1
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 02:31:17 -0700 (PDT)
X-QQ-mid: bizesmtp62t1690536469tz4fepbg
Received: from smtpclient.apple ( [125.119.251.0])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Jul 2023 17:27:47 +0800 (CST)
X-QQ-SSF: 00400000000000O0Z000000A0000000
X-QQ-FEAT: +ynUkgUhZJlkPFy+fa6uDnm+gZqteoXjrRIvkQSe92PfEUZkOl8JCX9dA2CEP
	WmSaAZ6W9egFjTsFsATApGl7TMxqzsvkbCp0LHvFs5+135Qudb0QdIIK/OEmaoRcYVJCojd
	YTSBciGgLpRmr00imcd3/AAHwHjMClaXhAPXnbEev7lL5n5P6R1khOse+LHwSEIaxIf3GVG
	1PLhhAGkar/f2joCjjy4JXDmMMqncnoJqSjJW8i54Dps5JsA1tQMpbJ2Ng/u4s9yeNc56M5
	9UqJZ1zq91FiiYovG9mjvTW6sBDpKVQN4L049LIIkK1v64pmMAYqFXlaDsQekganJMvBFQn
	miu2TP73ZebhKv1LQdixeV4hXtKcifsTYzvlqRbZm03xsUAp+mY7nhIHCNLWA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2867555983614791962
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH net-next 2/2] net: phy: add keep_data_connection to struct
 phydev
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20230726112956.147f2492@kernel.org>
Date: Fri, 28 Jul 2023 17:27:37 +0800
Cc: Andrew Lunn <andrew@lunn.ch>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Simon Horman <simon.horman@corigine.com>,
 netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7600051-05CD-4440-A1E3-E0F2AFA10266@net-swift.com>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
 <20207E0578DCE44C+20230724092544.73531-3-mengyuanlou@net-swift.com>
 <ZL+6kMqETdYL7QNF@corigine.com> <ZL/KIjjw3AZmQcGn@shell.armlinux.org.uk>
 <4B0F6878-3ABF-4F99-8CE3-F16608583EB4@net-swift.com>
 <21770a39-a0f4-485c-b6d1-3fd250536159@lunn.ch>
 <20230726090812.7ff5af72@kernel.org>
 <ba6f7147-6652-4858-b4bc-19b1e7dfa30c@lunn.ch>
 <20230726112956.147f2492@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> 2023=E5=B9=B47=E6=9C=8827=E6=97=A5 02:29=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, 26 Jul 2023 18:43:01 +0200 Andrew Lunn wrote:
>> On Wed, Jul 26, 2023 at 09:08:12AM -0700, Jakub Kicinski wrote:
>>> On Wed, 26 Jul 2023 10:54:25 +0200 Andrew Lunn wrote: =20
>>>> As far as i understand it, the host MAC is actually a switch, with =
the
>>>> BMC connected to the second port of the switch. =20
>>>=20
>>> Not a learning switch (usually, sigh), but yes.
>>>=20
>>>> Does the BMC care about the PHY status?
>>>> Does it need to know about link status?  =20
>>>=20
>>> Yes, NIC sends link state notifications over the NCSI "link?" (which=20=

>>> is a separate RGMII?/RMII from NIC to the BMC). BMC can select which
>>> "channel" (NIC port) it uses based on PHY status. =20
>>=20
>> How do you define NIC when Linux is driving the hardware, not
>> firmware? In this case we have a MAC driver, a PCS driver, a PHY
>> driver and phylink gluing it all together. Which part of this is
>> sending link state notifications over the NCSI "Link?".
>=20
> I've never seen a NCSI setup where Linux on the host controls the PHY.
> So it's an open question.
>=20
> The notifications are sent by the control FW on the NIC. There's a
> handful of commands that need to be handled there - mostly getting MAC
> address and configuring the filter. Commands are carried by
> encapsulated Ethernet packets with magic ethertype, over the same RMII
> as the data packets.
>=20
> All of this is usually in FW so we should be able to shape the
> implementation in the way we want...
>=20
We certainly can do all phy operations in Fw when we are using NCSI.

I=E2=80=99m confused about what other network cards do when it's used in =
both host os and BMC,
Because I can not find any codes in ethernet for now.

But this seems to go against the idea that we want to separate these =
modules.

>>>> Does the NCSI core on the host need to know about the PHY? =20
>>>=20
>>> There is no NCSI core on the host.. Hosts are currently completely
>>> oblivious to NCSI. The NCSI we have in tree is for the BMC, Linux
>>> running on the BMC (e.g. OpenBMC). =20
>>=20
>> But in this case, it is not oblivious to NCSI, since the host is
>> controlling the PHY. This patch is about Linux on the host not
>> shutting down the PHY because it is also being used by the BMC.
>=20
> Yup, we're entering a new territory with this device :S
>=20


