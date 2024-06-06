Return-Path: <netdev+bounces-101355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EA28FE3F6
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 12:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3827D2828A1
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BED19067D;
	Thu,  6 Jun 2024 10:13:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8651514FF
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668834; cv=none; b=WqasX7eA/PCIIf+nn0SpunUu0K2uz/8RQqI7yYyY+BK8qTaIoLUWn3TLlaY8lybv2AAsXDeGmQ+UjvsjxJS1AfX/SR2242UgffqxTsar+1GCe1w64PVQozzSLKBMio3jgCrRLdZFGcwVLGP9rzyesrTsOtxizGejeE950tV1N+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668834; c=relaxed/simple;
	bh=gGw6DOYtg085qcZldp4u8pXHccu6H8bo9EaJeMWbLaE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ITCGS3X3mpdJcLgEKdhwyP9+k1mguMWNFrSp6lD8OwFVhlHratXxxz1Vl5+/Pj9WW34Xjqk2QBfr1wjpPAl5UbxSvnsUdS480ehz1xA2eK8BQS7kTgBaQCNVH/LSwZivuGwzpxPuOKtZMr/P0zPLMSUvizrzjSGc3wH+/KsJpNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp77t1717668800tflgbh86
X-QQ-Originating-IP: AnznEBxa31bkfVsR60XMV2qn7YWvZV6XZA7WGjvDMP8=
Received: from smtpclient.apple ( [122.231.252.226])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Jun 2024 18:13:18 +0800 (CST)
X-QQ-SSF: 00400000000000O0Z000000A0000000
X-QQ-FEAT: W2+t/dR9tbqcmBE1oZHPpC1dfiA3Kw00hJcYyGmTjQ9VEzaYYTGcyhChMp2ul
	5FTfLmbvwgF7RLx32Hi107iiHxH3UYkvF3dwdSNWmM5ShRfmPRbTee68bQrMJ8+v3iVtl5k
	ZvOC4FXGAArEi1X0gEu0f5POeHXFLcPPMkB7S7Itts6RFO02Bi/vru+icpV7IsC8R2kyjHo
	LAm3vAgCclQzYPsMHOMtaKMVCjObD7KWC82bRRDmt8JItEoMvvF/WOl3dg9J0QMtBvEEPO6
	ukbdwrp8wre9UhavtKxQFELrrkmi2g+vJ3iJZ4XBlAxEZFPcb++18ieqHrz8EZ6p3vSHH6d
	bCoA6BrYNQhZ0mka0+HlJrsCvwWIWUjw6nBfjk2eEtbJTsZKFcotcDFwkEQcgsVx09TwqNQ
	KIg30LY7JhvtxKqLgDyVpw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15318657561148951144
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH net-next v4 0/6] add sriov support for wangxun NICs
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20240605174226.2b55ebc4@kernel.org>
Date: Thu, 6 Jun 2024 18:13:07 +0800
Cc: netdev@vger.kernel.org,
 Jiawen Wu <jiawenwu@trustnetic.com>,
 =?utf-8?B?5rip56uv5by6?= <duanqiangwen@net-swift.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EED7EF04-3358-4E91-BBC5-7B09370F9025@net-swift.com>
References: <3601E5DE87D2BC4F+20240604155850.51983-1-mengyuanlou@net-swift.com>
 <20240605174226.2b55ebc4@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1



> 2024=E5=B9=B46=E6=9C=886=E6=97=A5 08:42=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue,  4 Jun 2024 23:57:29 +0800 Mengyuan Lou wrote:
>> Add sriov_configure for ngbe and txgbe drivers.
>> Reallocate queue and irq resources when sriov is enabled.
>> Add wx_msg_task in interrupts handler, which is used to process the
>> configuration sent by vfs.
>> Add ping_vf for wx_pf to tell vfs about pf link change.
>=20
> You have cut out the ndo_set_vf_* calls but you seem to add no uAPI
> access beyond just enabling the PCI SR-IOV capability. What's your =
plan
> of making this actually usable? It's a very strange submission.

 Vf driver(wxvf) will be submitted later, uAPI for virtual network =
devices will
be added in it.=

