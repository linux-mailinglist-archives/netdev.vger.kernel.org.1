Return-Path: <netdev+bounces-13849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF0273D5A7
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 03:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EA2280E23
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 01:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692E8628;
	Mon, 26 Jun 2023 01:57:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F997F6
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 01:57:21 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A10135
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 18:57:18 -0700 (PDT)
X-QQ-mid: bizesmtp79t1687744604torhgi2o
Received: from smtpclient.apple ( [115.195.149.82])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 26 Jun 2023 09:56:43 +0800 (CST)
X-QQ-SSF: 00400000000000N0Z000000A0000000
X-QQ-FEAT: hoArX50alxHdr8IYIpwL7dIONO3ef8vkWcBLXrC2ZEJXK6okii7oit0ERGDh4
	fV231C/jVpd33lU5Fk+owRQB1VJZu7x5KJ8jxYFEKDj/w3fqeUAwhbJwR9BKvOYXN2bLotE
	ija/796KcO0+f7qhqfzm5oBkV+eK5xSqRB6Ag3WbgpUuINQ3GMOsSIhuFpB663qwS7W62UO
	62oP90MMooz65j6jDu8XtnM+4GZp4tduqG9flFhrhLttsBIdrv+MgdcsMW9idGsTNQdabbf
	g5nC6pPaEQIdAv9frzUmJCX5QFGwoCHbJV/Lv52bi8hvjiN8rFmZQQJL+r+Ym2h3wryCa2x
	j8zZy8Mr+2GmdAQMwr/rMrAg+86l3SW6BzmVLwhVN3uE+IQJz2huPs3E152mhfXEZ3QMKRB
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16913895645472102631
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
In-Reply-To: <362f04fc-dafb-4091-a0cc-b94931083278@lunn.ch>
Date: Mon, 26 Jun 2023 09:56:32 +0800
Cc: Jakub Kicinski <kuba@kernel.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6964AD00-15BF-4F2D-9473-A84E07025BE8@net-swift.com>
References: <20230621090645.125466-1-jiawenwu@trustnetic.com>
 <20230622192158.50da604e@kernel.org>
 <D61A4E6D-8049-4454-9870-E62C2A980D0C@net-swift.com>
 <362f04fc-dafb-4091-a0cc-b94931083278@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3731.600.7)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> 2023=E5=B9=B46=E6=9C=8825=E6=97=A5 23:40=EF=BC=8CAndrew Lunn =
<andrew@lunn.ch> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sun, Jun 25, 2023 at 04:31:01PM +0800, mengyuanlou@net-swift.com =
wrote:
>>=20
>>=20
>>> 2023=E5=B9=B46=E6=9C=8823=E6=97=A5 10:21=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Wed, 21 Jun 2023 17:06:45 +0800 Jiawen Wu wrote:
>>>> The old way to do hardware reset is sending reset command to =
firmware.
>>>> In order to adapt to the new firmware, driver directly write =
register
>>>> of LAN reset instead of the old way.
>>>=20
>>> Which versions of the FW use one method vs the other? Why is it okay=20=

>>> to change the driver for new FW, are there no devices running old FW
>>> in the wild? Or the new method is safe for both?
>>=20
>> Lan reset contains of phy reset and dma reset.
>> New FW versions will support NCSI/LLDP which needs phy not to down.
>> When drivers do lan reset, fw can set a veto bit to block phy reset =
and
>> still to do dma reset.
>=20
> That does not answer the question. Is this backwards compatible with
> old firmware?

Yeah=EF=BC=8Cthe veto bit is not set in old firmware, so they have the =
same effect.
>=20
> Andrew



