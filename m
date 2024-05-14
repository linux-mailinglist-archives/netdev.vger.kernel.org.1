Return-Path: <netdev+bounces-96322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2193D8C4FB0
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61DFB1F21C2D
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041D12E1FA;
	Tue, 14 May 2024 10:25:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193112E1F9
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682315; cv=none; b=LQlwU3HztG5LtbwEoLqhW1d7hfocL/G7mvJdoEsr0jKqWDaHu/6IX/nIbkcAq1fDBw9SkLpZiJaLBuWfTJ+0gp9SIifVk+by2/U0nWUUBU5EwzQnZ4xzC0aaHOKqgatSk31ekXm9LL59bdpkNRbymGyAjN7k9UUUFdNFbKNPpBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682315; c=relaxed/simple;
	bh=/Wv5+sRJ7CwlUIFxazmXshL4SnTpGS9RMso+ozhQtRM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WEwiNIrtuthWa/+d3lX6E14+obkufYk1VARMMKnZa2uWDn0RF9HGcwc6p1HCYsoVfq/sZxXzmrDwFr3kNCNgwnFi0BOnf9IaTkH96bvGj2O2ZHdLYJlAxXQIZOOPFB66uS9IkRu6HyNriuPt+bdq7hbF68WUeg8oLSE/Gpr5vWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz6t1715682289tfmhh7g
X-QQ-Originating-IP: ONpo4J6RjJVRnpTO0lrgE3Q5i1k+QMPO+gBfnK6QlQc=
Received: from smtpclient.apple ( [125.120.144.133])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 May 2024 18:24:47 +0800 (CST)
X-QQ-SSF: 00400000000000O0Z000000A0000000
X-QQ-FEAT: qTz9uDfsL3SNlDIlX/2XbcuT4Pc1wUSR3B7qdnlRQVFTCUNdVZT3Xcd2Tu+Pc
	2HEI/5RWYvxIyLBCCxF4fc04oujFNILP0gkK80iS/5MsaaAFDSQsbL/+85PywHou8FUh8N4
	thwXXmlJZCO9P1GljRLgxcI44APbXvN2vTixT3JRAyrTNggKucZ3WN3ewYMgLzx0nlRfLOu
	gHlxK75n1sfEBmSKk3PPpGt8UqG0wOGEMcOXJapXCUOQDseD48KCMBdGb9e2W6txncujmoC
	hzf4e9zHvFc3RYnO3Kl2pkBG8u5giMcKC1Cq1iKYYR0fFc4DjYABUIIcg2dWuDNNB13zkgX
	5x5NYZaO15Y//9VBt7/bzEOjGc8JarKC8QSAvmlYk+IHGL3R2IEl8nI4pn9+xiBQzNZUNQ4
	UmU/ZAID2uc=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17803102876130720133
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.153.1.1\))
Subject: Re: [PATCH net-next v3 0/6] add sriov support for wangxun NICs
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20240416073143.581a56c5@kernel.org>
Date: Tue, 14 May 2024 18:24:37 +0800
Cc: netdev@vger.kernel.org,
 Jiawen Wu <jiawenwu@trustnetic.com>,
 =?utf-8?B?5rip56uv5by6?= <duanqiangwen@net-swift.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <084F9089-0C3B-4A9D-B706-BFFB6A5A1FF0@net-swift.com>
References: <587FAB7876D85676+20240415110225.75132-1-mengyuanlou@net-swift.com>
 <20240415112708.6105e143@kernel.org>
 <36569F35-F1C1-44DB-AC46-4E67158EEF0A@net-swift.com>
 <20240416073143.581a56c5@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3774.500.153.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1



> 2024=E5=B9=B44=E6=9C=8816=E6=97=A5 22:31=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, 16 Apr 2024 10:55:16 +0800 mengyuanlou@net-swift.com wrote:
>>> On Mon, 15 Apr 2024 18:54:27 +0800 Mengyuan Lou wrote: =20
>>>> Do not accept any new implementations of the old SR-IOV API.
>>>> So remove ndo_vf_xxx in these patches. =20
>>>=20
>>> But you're not adding support for switchdev mode either,=20
>>> so how are you going to configure them? =20
>>=20
>> Do you mean .sriov_configure?
>> Had implement it in patch2 and add it patch5/6.
>=20
> No, I mean configuring the forwarding, VF MAC addrs, getting stats, =
etc.


These Apis will be added in vf driver which will be submitted later.=

