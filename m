Return-Path: <netdev+bounces-85586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A17389B7FA
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 08:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87BF2820B5
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 06:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ABF18C19;
	Mon,  8 Apr 2024 06:50:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB422554B
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712559057; cv=none; b=Cvz5dbPnVDeXHJWOiJ6q8B2jVZUkkhCyJksTEekgWBb+b8SqlxjS5wOO/LjmkAv2s1gGpbF49Vj0iJPxOP95kWwAOwxy3LxkPsVVAoKzmnFvb7Lfk8NxeIwDCYmj1Nsdq7gV4L8ePyHURjff0vpmApBTQ5+IIUTUCz56uDmGSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712559057; c=relaxed/simple;
	bh=yhQHsp6FMk4jNNLFCEj7Uj3j/v7sXrplLuabWESrz00=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Hdcjn6Pngak0EN3NIXhtnUQS7cVVxNUie2qWQE6+aWHHGAQAfzGZ054O35wVGP7/NrA4Q3fJzw5MVny49QWDQRoFF+7DmpKyAG75v8kjabKE8DZWLtyTRG0uzuFGi1RbmnyFevOqiMLsp3g5E5kDL227Ho5skbZWijpdTcvoeVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp89t1712559027tn67808s
X-QQ-Originating-IP: s86thkMQ/dptL23uE9kCnAxCM7XGqyh83+BkYMUOHCA=
Received: from smtpclient.apple ( [183.128.132.155])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Apr 2024 14:50:25 +0800 (CST)
X-QQ-SSF: 00400000000000O0Z000000A0000000
X-QQ-FEAT: 41oFSI3bg8ZENj7mGI1hEu8sidzwfghW/BQRTmYiFRSnS+OJ6BogV+3NjXXkx
	q9IKwdZEBP1BEP6ivrJmPtPQtUOTetSqrpi6NQSQLWM4c0+ItP5iiYJ4G0L10SHa0YiDbo+
	TBh3Q/63G7vUXbLAL3H0b0+nhKgNm8AvA3sqYoKXOpcxUdfeW6OZbSNKOYhs991Kn9ZnpE2
	cyRzgyvnhGFznjeKEdnUOhmEZ7GRjgKdplbz2po2jGC/mKapzRBzEivhX/zxSsrRTEWT0GU
	M4aZSixRvNOX1Rn9BYrmTGZ5yXRUj66s3E3qQJhyeph709hyz1Fwv8F4cAo8Y8YRJ1juiIF
	B0V+21o6vXe0yJl/GFZZWOfcGhFhgZv0D9Z8W2OVifzPUjnflODnZwend+F5NHSWa+BVYzG
	uvsMqWjDOOg=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15544089858339600893
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.153.1.1\))
Subject: Re: [PATCH net-next v2 7/7] net: txgbe: add sriov function support
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20240403185300.702a8271@kernel.org>
Date: Mon, 8 Apr 2024 14:50:15 +0800
Cc: netdev@vger.kernel.org,
 Jiawen Wu <jiawenwu@trustnetic.com>,
 =?utf-8?B?5rip56uv5by6?= <duanqiangwen@net-swift.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <409E8C82-269B-4D62-B878-B4B451995590@net-swift.com>
References: <20240403092714.3027-1-mengyuanlou@net-swift.com>
 <BDE9D80ABE699DA7+20240403092714.3027-8-mengyuanlou@net-swift.com>
 <20240403185300.702a8271@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3774.500.153.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1



> 2024=E5=B9=B44=E6=9C=884=E6=97=A5 09:53=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed,  3 Apr 2024 17:10:04 +0800 Mengyuan Lou wrote:
>> + .ndo_set_vf_spoofchk    =3D wx_ndo_set_vf_spoofchk,
>> + .ndo_set_vf_link_state =3D wx_ndo_set_vf_link_state,
>> + .ndo_get_vf_config      =3D wx_ndo_get_vf_config,
>> + .ndo_set_vf_vlan        =3D wx_ndo_set_vf_vlan,
>> + .ndo_set_vf_mac         =3D wx_ndo_set_vf_mac,
>=20
> We don't accept any new implementations of the old SR-IOV API.
> Please offload standard networking constructs like flow rules,
> bridge etc.
> =E2=80=94
Is there some exact documents and guidance.

What links and rst are available.

Thanks.

> pw-bot: reject
>=20
>=20


