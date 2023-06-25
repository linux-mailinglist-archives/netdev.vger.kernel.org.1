Return-Path: <netdev+bounces-13788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C6973CF02
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 09:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18D0280FC0
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 07:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F9C80B;
	Sun, 25 Jun 2023 07:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061AB7C
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 07:40:21 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD4EE41
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 00:40:18 -0700 (PDT)
X-QQ-mid: bizesmtp74t1687678770tjzfep3q
Received: from smtpclient.apple ( [122.231.253.75])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 25 Jun 2023 15:39:29 +0800 (CST)
X-QQ-SSF: 00400000000000N0Z000000A0000000
X-QQ-FEAT: ILHsT53NKPix8pF0liLWBCmgoMALj+d+NOpL8FdpkO5yVfPvYRVDaKCKZqDoi
	2uv1Eja8n64c/bm8K8yhASkvskHSwR6nGZ40VgqUBRAnbwn9uNVCs0KHzOERrUHltQHlAE1
	JB5keKjAF3BztNhG4wEMBiCYj4cK7ziKL6J2QEvQWCfKDwg8Dy1eUaD6dHnxyZWa5CI46as
	kwqXHSg1vIVtUfduB26y5Di+QWIHcCEKkf9wqnL9QuS/YqpQF0uGTVztPFDzfs22kfQiHQb
	fIQt2Zdu9vEGh6yVoZg0AGebUwFlJ63gabxZ3iTK2KL80ULSkHtQIuUZe5kSh45m5TpEuYS
	yU2Px7/u2qXeqqpsA4R4MPHt80M1ZxdfLLYaMgc38Erlnc/+xtCD5XDP3L36Q==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16703797501109676385
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH net-next v2] net: ngbe: add Wake on Lan support
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20230622192528.7bef1fa3@kicinski-fedora-PC1C0HJN>
Date: Sun, 25 Jun 2023 15:39:18 +0800
Cc: netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1CF289C-6B9B-4E28-A1ED-ECB81B9EFCEB@net-swift.com>
References: <D021CF8344C66466+20230621094744.74032-1-mengyuanlou@net-swift.com>
 <20230622192528.7bef1fa3@kicinski-fedora-PC1C0HJN>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> 2023=E5=B9=B46=E6=9C=8823=E6=97=A5 10:25=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, 21 Jun 2023 17:47:44 +0800 Mengyuan Lou wrote:
>> + if (wol->wolopts & WAKE_MAGIC)
>> + return -EOPNOTSUPP;
>> +
>> + wx->wol =3D 0;
>> + if (wol->wolopts & WAKE_MAGIC)
>=20
> Maybe my eyes deceive me but it looks like you're rejecting all
> configurations with WAKE_MAGIC set and then only supporting =
WAKE_MAGIC.
> Did you mean to negate the first check?
>=20
> How did you test this change?
Sorry, I just test that "ethtool -s eth0 wol d=E2=80=9D to close Wol.
And I forgot to test =E2=80=9Cethtool -s eth0 wol g=E2=80=9D to reopen =
it.=20

> --=20
> pw-bot: cr
>=20
>=20


