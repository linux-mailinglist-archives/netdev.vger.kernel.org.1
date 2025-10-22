Return-Path: <netdev+bounces-231585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20EABFAE86
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 10:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B68D19C4890
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D2A30AAB3;
	Wed, 22 Oct 2025 08:32:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82030506D
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121959; cv=none; b=LbDPi1K+QM04zjHN7RM23vEOE+AbqshKPJlQxDvlBPzyWOGkyaDIyk7oeZ2rLLm/wW+z+2l5o5ZHUHlJY3xSZ7igLmHpOkvQXYY5rorR6FHWj9D+nMIlZgSkWRv/J8ydoFOSTYMcfCFlcwvgZs/BcBbRwiNeSlOjZWTzfBgKsZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121959; c=relaxed/simple;
	bh=xTI64vw2hssp9PDzwYAzSbxt/4Fyhnm453P376aLeIs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=t/DSmOtZgow9SJxqmKcH8k2xRi3069PHq27D4828m+IjCUyuUVWOUVkRulGjOCkEdYSr3686B76JbgYew2GMUn7MxeN3sNzO1iSc6/25z6Vh2oDkNu91sJLGkqlsGtKfFzZXrXGOcdkv5QRiEJmiuKe1tSwROJfinTVs03PAgoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz15t1761121908t51262e59
X-QQ-Originating-IP: 5idFpP+wY4vwB+rUYKZTKMU4vbI3XpLQYDa+sdyifHw=
Received: from smtpclient.apple ( [111.204.182.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Oct 2025 16:31:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17359390096827436282
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next] net: add the ifindex for
 trace_net_dev_xmit_timeout
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <20251021171006.725400e3@kernel.org>
Date: Wed, 22 Oct 2025 16:31:34 +0800
Cc: netdev@vger.kernel.org,
 Eran Ben Elisha <eranbe@mellanox.com>,
 Jiri Pirko <jiri@mellanox.com>,
 Cong Wang <xiyou.wangcong@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <27169B5F-3269-4075-89F4-FA7459241EB3@bamaicloud.com>
References: <20251021091900.62978-1-tonghao@bamaicloud.com>
 <20251021171006.725400e3@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Mdc3TkmnJyI/RmihK7KPttKheLLBgQEmwFcA+GneXVKxNWxMtKvm7xAA
	NwvpIrpzgS2pu29mXoIMK22NCLC39Ggxm7TIaqRpPa7lHdS5Hor8qjC5P909psWRWDPkqS7
	LlyTseMEZGTyqiPbbeSPSItyg789BkgZwJ+grmCyzVRYwEpJ3t7lgRNRD1Ynjue6szxmKRJ
	h6qvGvj/0wnAY3WLYd3A8dH43cGUmft4uBlpAo79wOfHoJkeCMvV2pqv2XN+zrLhXpa3i2P
	GM4k7MC0SrbbpLGFrCaK6b2SCvf+YOA/3stooWhEReTda0UOnEvwbPAMPRRHYarUOsToNEi
	Wn9rBxQBMj5mKi1BiXXLp7zOUTzFM3g6q7EQEhH/+HSlB14Zk+YXCOsOJMlKY5D3z8bHvja
	BZKTyaGvCqRxEY1OtTKbW8EIz3rLKaGp9+56sTPhJ4vE62fCBVWzBfmCC4Rpn0dfl+nn02X
	cCxOcymRkvClJG/pDAO6MWTcPfIfBf226MSwvkv+amJBbZjvkDL8Mw97rr6HZX+13z9sv7j
	fpZbc14X+Sko6ju80WPYKwm8KajwvPNBw1NOaVoe4frJVXKLk3d477ujYDUY9Ryh3mVE01l
	DKAQKSQuWjNgohN9s6OJIkM0iRSHwJLiHT/UUz74VEmwQt7dxdoXGwEh1+ENg3anETVp5JE
	XxWqRNg1M032OVrG1lhZQXPHJjMt/I5viWsEdLfKo9hPFqtptSDm1FXm6zrC1IcCvzg9ECU
	U7FCb8vX3YtYDkX4okV+BzQh/11BGDX03NwhXNY/vF0Qi609lF4f/DVJjKzVZjKzvY5XO6r
	nqNqVmNyW3FRMF5tZ8rfInad8kvJM6AivpXQqtWXq//g1tS4bdYner28k8LrySElBtKUmfR
	R2ZhyiPdTOpZzv3MIEMGbMeeVNZMC41W3RGuX4gTLOZi1yAIMfTGhpvRmSIeYylDFTayfrl
	iqW/WffEvYxL51I+leFo8B/M2eIT69hJay4tPlJADqFzqfylhXNCCrNfEUBFLiv6viMfiVs
	Rk1zP0BAquGjVRYHZz
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0



> On Oct 22, 2025, at 08:10, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> On Tue, 21 Oct 2025 17:19:00 +0800 Tonghao Zhang wrote:
>> In a multi-network card or container environment, provide more =
accurate information.
>=20
> Why do you think that ifindex is more accurate than the name?
> Neither is unique with netns..
I thought ifindex was globally unique, but in fact, different namespaces =
may have the same ifindex value. What about adding the ns.inum inode ?

> --=20
> pw-bot: cr
>=20
>=20


