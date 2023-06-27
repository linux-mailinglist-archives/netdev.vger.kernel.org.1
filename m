Return-Path: <netdev+bounces-14130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B4373F0C7
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 04:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59991C209D9
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 02:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63F3A44;
	Tue, 27 Jun 2023 02:20:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E92A23
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 02:20:12 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D981720
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 19:20:07 -0700 (PDT)
X-QQ-mid: bizesmtp80t1687832338t5ib88fb
Received: from smtpclient.apple ( [115.195.149.82])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 27 Jun 2023 10:18:56 +0800 (CST)
X-QQ-SSF: 00400000000000N0Z000000A0000000
X-QQ-FEAT: QdNbrVbAPlu0ZcHzibRS7fc4+yjPO59eV0tsw1ptgkHnwOo6/sfHNeWu3u/5F
	iER8ig5SQ9rYvhtirPvEmLqKsEaLjUE+K3OJZLTW8bVgUi7Z+MHCy3lDgo+mXynk5+L5C1f
	1MxRi7b49fsYCrDWruLLam2qCFgfmnGUda3/IsU6tLe84LsO7WaV64FdiGroA9+El363hmv
	fighDFO0suPbtsB2l/m+q3LYAkYqP4aaJmW8OhBIU84JXTEJ4PQ3WSa2BuAkbEusZOIKi8B
	annMAlPR/0zPSf46f6s83vG8YHU7pVU9IMgPPDjCad3FbhxWrd/H93Ns0tS+6AqyzLq57pQ
	Vv7mxSlkLZz/mS9S9wsh09yT+TMVzYa17+AVYOnBXJbcIciFCFHDw+r8iX/oF5Xh1lGo/vd
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16090861321225047725
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
In-Reply-To: <20230626102411.2b067fa8@kernel.org>
Date: Tue, 27 Jun 2023 10:18:46 +0800
Cc: Andrew Lunn <andrew@lunn.ch>,
 Jiawen Wu <jiawenwu@trustnetic.com>,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <23312110-478A-4AC2-A66D-33C4BD2DBD0E@net-swift.com>
References: <20230621090645.125466-1-jiawenwu@trustnetic.com>
 <20230622192158.50da604e@kernel.org>
 <D61A4E6D-8049-4454-9870-E62C2A980D0C@net-swift.com>
 <362f04fc-dafb-4091-a0cc-b94931083278@lunn.ch>
 <6964AD00-15BF-4F2D-9473-A84E07025BE8@net-swift.com>
 <20230626102411.2b067fa8@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> 2023=E5=B9=B46=E6=9C=8827=E6=97=A5 01:24=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, 26 Jun 2023 09:56:32 +0800 mengyuanlou@net-swift.com wrote:
>>> That does not answer the question. Is this backwards compatible with
>>> old firmware? =20
>>=20
>> Yeah=EF=BC=8Cthe veto bit is not set in old firmware, so they have =
the same effect.
>=20
> Why were you using the more complex FW command then rather than just=20=

> the register write, previously then?
>=20

Using FW command can notify fw that lan reset has happened, then FW
can configure something which should reconfigure.

Drivers write the register, the FW will not know lan reset has happened.

Later, we found the things which FW need in NCSI/LLDP/WOL... is only the =
phy.=20
So just block phy reset, and use simple the register write.



