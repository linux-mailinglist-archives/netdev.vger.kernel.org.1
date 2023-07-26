Return-Path: <netdev+bounces-21124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A3D762872
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13CB1C2104A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 01:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FA51118;
	Wed, 26 Jul 2023 01:59:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9937C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 01:59:51 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAE026B7
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:59:45 -0700 (PDT)
X-QQ-mid: bizesmtp88t1690336767tik9gq70
Received: from smtpclient.apple ( [183.128.134.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Jul 2023 09:59:26 +0800 (CST)
X-QQ-SSF: 00400000000000N0Z000000B0000000
X-QQ-FEAT: 6/K5pWSRdGpdt1E58bRmXzPZVsbyaBUihPv3IUuxys12m/vgjeR9tHK7wGZqJ
	dh1B5hG9cSvkBz1V/g7wjy1o4YRJ8rz6gsqA5GMUlZQZFZf+k2TAGqBR31jjaWjyFLBdZ1a
	FjLUcgrObmanLxXyVHv0xtR625AB4eTE0g6f6pQxJtyogUl1EiesoDnU4/6sUHQzl/ZCQYe
	KhjS3rtMinsE535QjrjhepoaJM80H7AH9zzJkXogNdv/E45TH0CQMP69N8SjFqp+BI+8PUZ
	Etu5ZeDn1tkQ6K+X18sFdexZWJhFRXHVt24P0sctJJ76uRPegenQ3d9Pd0kCnYCaJw9ynR2
	GBeQsqwS4NzP4CN6a+qzXmmrgvqDtDHWnEGSvtTXvgQC/nvIlbgG734ccNG2Q==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10932696225562647213
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
In-Reply-To: <20230725162234.1f26bfce@kernel.org>
Date: Wed, 26 Jul 2023 09:59:15 +0800
Cc: netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D0E96D7-CDF4-4889-831D-B83388035A2C@net-swift.com>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
 <6E913AD9617D9BC9+20230724092544.73531-2-mengyuanlou@net-swift.com>
 <20230725162234.1f26bfce@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> 2023=E5=B9=B47=E6=9C=8826=E6=97=A5 07:22=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, 24 Jul 2023 17:24:58 +0800 Mengyuan Lou wrote:
>> + netdev->ncsi_enabled =3D wx->ncsi_hw_supported;
>=20
> I don't think that enabled and supported are the same thing.
> If server has multiple NICs or a NIC with multiple ports and
> BMC only uses one, or even none, we shouldn't keep the PHY up.
> By that logic 99% of server NICs should report NCSI as enabled.
>=20
>=20

For a NIC with multiple ports, BMC switch connection for port0 to port1 =
online,
Drivers can not know port1 should keep up, if do not set ncsi_enabled =
before.=20


