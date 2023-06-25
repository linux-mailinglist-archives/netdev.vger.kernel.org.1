Return-Path: <netdev+bounces-13789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ECE73CF62
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 10:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B97280E39
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 08:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CAF36C;
	Sun, 25 Jun 2023 08:31:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA327F3
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 08:31:49 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A10010C9
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 01:31:43 -0700 (PDT)
X-QQ-mid: bizesmtp68t1687681872talrsn6m
Received: from smtpclient.apple ( [122.231.253.75])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 25 Jun 2023 16:31:11 +0800 (CST)
X-QQ-SSF: 00400000000000N0Z000000A0000000
X-QQ-FEAT: znfcQSa1hKadF7oO4KimXsrv2/QCmT/kBinJxmkBiagNDvYuhdGRj5PB/GuD/
	HcWEs+v7Ec5juIbLweTtuSISYX78vvyho4fQ7s4kFjv8qgNJ4FduK5IsWBbK4yy+VATz20g
	5b2fOjZlrQUp17ya7wNHc9pQJqT+61zf/N0fYaG0a9sfRe3r0Iqixvj+r/zKRev1zZW84tG
	7z9pmck5tDNsJdoitBhBuM1+TMstK7Eu+vW0gAmIm1rto69tLON7MLZMUD8Y85MCa/Jnl6+
	IFRFbNXSEjaHkYEpU/84qo1tUxhbehjQ+qmo3PxduuZMZ0lKefu1GBQ8+fHuwVD+lw90eSY
	w6Jfiijm+XoLX9gf70C83pzJicdq/jiOmHvB1e3I2nnDXgfjKgCFBH+Wz8qJVD9M/nljVIi
	EDqP1TNeP0U=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3016795818448747042
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH net] net: txgbe: change hw reset mode
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20230622192158.50da604e@kernel.org>
Date: Sun, 25 Jun 2023 16:31:01 +0800
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D61A4E6D-8049-4454-9870-E62C2A980D0C@net-swift.com>
References: <20230621090645.125466-1-jiawenwu@trustnetic.com>
 <20230622192158.50da604e@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> 2023=E5=B9=B46=E6=9C=8823=E6=97=A5 10:21=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, 21 Jun 2023 17:06:45 +0800 Jiawen Wu wrote:
>> The old way to do hardware reset is sending reset command to =
firmware.
>> In order to adapt to the new firmware, driver directly write register
>> of LAN reset instead of the old way.
>=20
> Which versions of the FW use one method vs the other? Why is it okay=20=

> to change the driver for new FW, are there no devices running old FW
> in the wild? Or the new method is safe for both?

Lan reset contains of phy reset and dma reset.
New FW versions will support NCSI/LLDP which needs phy not to down.
When drivers do lan reset, fw can set a veto bit to block phy reset and
still to do dma reset.

>=20
> We need more information, we had a number of reports recently about
> drivers breaking backwards compatibility and causing regressions for
> users.
>=20
>> And remove the redundant functions
>> wx_reset_hostif() and wx_calculate_checksum().
>=20
> You don't have to say that, it's a natural part of the change.
> --=20
> pw-bot: cr
>=20
>=20


