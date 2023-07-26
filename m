Return-Path: <netdev+bounces-21145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3C2762923
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 05:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7103C281B91
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37731878;
	Wed, 26 Jul 2023 03:13:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844E1108
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:13:21 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01F02682
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 20:13:18 -0700 (PDT)
X-QQ-mid: bizesmtp82t1690341172tcsnzy8k
Received: from smtpclient.apple ( [183.128.134.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Jul 2023 11:12:51 +0800 (CST)
X-QQ-SSF: 00400000000000O0Z000000B0000000
X-QQ-FEAT: 6/K5pWSRdGqvuE1UuUhl7Tf19bBxPZ6I+G8qbtTMvfj0YzZ5MGOUyfm55VoTm
	ujJ0GuoywAfuLfUjDyaUumQhLvt4whJ1ZsDRIZR3MlYXjJVCL9thZMzqrAHMITdA0D4tOky
	vzHHWthZyPNlNQntY6qxrus5AwRFSCa7gjfyg6i0Z/1oBVF7fGrfBrnqSPalzbZnG+LlkLs
	QUSx0iU97Jrw+V5GYN+R/3tPvoZRNRS5eA3NKy5FTRyCl9QYdNcCeYYfnxNPb7S/DHcvr9M
	ljDUCmIX6F0BiC5QTbncNoMfojdHbJzywGBj2zAQsLv+18BCBpzBSOp9RMUREmFMZc40AgS
	8hcfCoCLWsE8MGWJJTW3/j83bW7jMGnzEI5k48rhRpwhO4/h/2LpLIgl7wbj1yEdHBhdjQY
	CvPaK0O4w8s=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8522088838517270912
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH net-next 1/2] net: ngbe: add ncsi_enable flag for wangxun
 nics
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20230725194456.7832c02d@kernel.org>
Date: Wed, 26 Jul 2023 11:12:41 +0800
Cc: netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E243F8C-76F8-4792-B8C4-201E65F124F6@net-swift.com>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
 <6E913AD9617D9BC9+20230724092544.73531-2-mengyuanlou@net-swift.com>
 <20230725162234.1f26bfce@kernel.org>
 <6D0E96D7-CDF4-4889-831D-B83388035A2C@net-swift.com>
 <20230725194456.7832c02d@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> 2023=E5=B9=B47=E6=9C=8826=E6=97=A5 10:44=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, 26 Jul 2023 09:59:15 +0800 mengyuanlou@net-swift.com wrote:
>>> 2023=E5=B9=B47=E6=9C=8826=E6=97=A5 07:22=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>> On Mon, 24 Jul 2023 17:24:58 +0800 Mengyuan Lou wrote: =20
>>>> + netdev->ncsi_enabled =3D wx->ncsi_hw_supported; =20
>>>=20
>>> I don't think that enabled and supported are the same thing.
>>> If server has multiple NICs or a NIC with multiple ports and
>>> BMC only uses one, or even none, we shouldn't keep the PHY up.
>>> By that logic 99% of server NICs should report NCSI as enabled.
>>=20
>> For a NIC with multiple ports, BMC switch connection for port0 to =
port1 online,
>> Drivers can not know port1 should keep up, if do not set ncsi_enabled =
before.=20
>=20
> I'm not crystal clear on what you're saying. But BMC sends a enable
> command to the NIC to enable a channel (or some such). This is all
> handled by FW. The FW can tell the host that the NCSI is now active
> on port1 and not port0.
>=20
>=20
Ok, I think I understand.
Thanks.

Another question.
Then, after drivers know that portx is using for BMC, it is necessary to
let phy to know this port should not be suspended?
I mean this patch 2/2 is useful.=

