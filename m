Return-Path: <netdev+bounces-88157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF87F8A6138
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 04:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786902826EB
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 02:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B173125A9;
	Tue, 16 Apr 2024 02:56:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59B2D512
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713236171; cv=none; b=Ft0zrVhLcAA5T/rVLMiB5sUnxBmtxhIhKP+7b1oBpav9mYqM2RIy3Kg8u2Pnr+MpaogAbleuEaIFvaHgaQV/K1uYPoZQI8MN1zxDH/dr0Nmiv92U7T0vLTYc/ZItoCJLdvLC7EK6UledXlwJr6x9C3O9xLOv4c6qs4XocN3RUPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713236171; c=relaxed/simple;
	bh=iwdvYM09X/jbPkDJ+mz8mGgL8fm5hPBD/5nlnZ0mziQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rBQ9qdiWhDRnsUp5DTY+LFw3iwKtClWPw1qKosLSqqcocR1DE93xCzkBV6R+6yHshMnPZrff8jIP+zM+wuc7AkSYNB5ucSKAyEOuDqFITQm2YT1/1YdXpyrUJj/NiTBZ+QleTytM4tSs9CHZI4L6yB90Gc/1bmpV7J0ZVBEiA3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz9t1713236130tf2gfmc
X-QQ-Originating-IP: tR21tQOy+BxuUV8EQtveoGh7CjTBRXhsEXApkH1hUeU=
Received: from smtpclient.apple ( [125.119.246.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Apr 2024 10:55:28 +0800 (CST)
X-QQ-SSF: 00400000000000O0Z000000A0000000
X-QQ-FEAT: QityeSR92A251LSQf5EyvpjRhO6AWPnrWQPUEWFC6aDitdjRIunQBryTOlWqT
	bw6IYz62wCMCTO3P/lSavve5fPPWTVR9qYRUNwOJQo8eC1eKJnuXr57G/GibUeHh/7XB/Y2
	KskezwN42Fikt06tEk1YyYL3RQAwYQwmfbNjJJSGU7/isHKnNfEonS0yRDhWWCc0APWsTt6
	kqDv3y+2qQ7ogdTrWcrbZ3KXI9KIQDO+xy73TJ7caZk9kvum8sDpADcWFnotsg/Gr40gDGj
	UJLKK000da9xL5SKfxEgE7uNVwx8EsB3vle4rqluAhkU05paoGo4hnEaGwRXZzFN0rPBc/Q
	Usk+/2nDJGOGZI3lUq40EkJbJGaA50u28kAPXjgdvdPTXmil3p5kSSIUKgf4d7EhISnZCbf
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14005444982630097532
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
In-Reply-To: <20240415112708.6105e143@kernel.org>
Date: Tue, 16 Apr 2024 10:55:16 +0800
Cc: netdev@vger.kernel.org,
 Jiawen Wu <jiawenwu@trustnetic.com>,
 =?utf-8?B?5rip56uv5by6?= <duanqiangwen@net-swift.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <36569F35-F1C1-44DB-AC46-4E67158EEF0A@net-swift.com>
References: <587FAB7876D85676+20240415110225.75132-1-mengyuanlou@net-swift.com>
 <20240415112708.6105e143@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3774.500.153.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1



> 2024=E5=B9=B44=E6=9C=8816=E6=97=A5 02:27=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, 15 Apr 2024 18:54:27 +0800 Mengyuan Lou wrote:
>> Do not accept any new implementations of the old SR-IOV API.
>> So remove ndo_vf_xxx in these patches.
>=20
> But you're not adding support for switchdev mode either,=20
> so how are you going to configure them?

Do you mean .sriov_configure?
Had implement it in patch2 and add it patch5/6.

I have missed any other interfaces?

Thanks.
Lou
>=20


