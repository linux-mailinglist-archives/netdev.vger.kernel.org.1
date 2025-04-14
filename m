Return-Path: <netdev+bounces-182016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE21DA8759B
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 03:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1596163B83
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 01:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090D1155342;
	Mon, 14 Apr 2025 01:57:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA5833FD
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744595826; cv=none; b=q29SmjkSUqjPjm+sVeJdxLcNfqcc659k2eLCMxzw9RMfclVhSw+6t+WE8MKCtlQRooEnpkgKiJDSg6Gm/su8Y+72eiUhiu4PfLLXoyfOMvxA7dxNA9jFHmM7sH1MByCY+iskp8o/jjreBSA8ZzuUAsLo8Hf3vYzI8phvxoEQKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744595826; c=relaxed/simple;
	bh=K4jDfSA6VwouTcAXFJEUxzH9ebQIGuU3ZDA7b4To9yM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=mj38bk+PUE1HuWCokZeNPvXys1n8lcnWPmuN/rlOBB8DrkCgfbrd0717Q76X+PJQEfzZlmnBTmqI1FiCP4hccuMf2TDbiX8Ax7Kw3Yc6nZcH3o+dn/Nz6EgQ0yhWLTgQwOAUknsFsuYNS5MjMPxAExCHqIYUA+weNQ+DYwETajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas2t1744595734t732t50423
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.107.143])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 18241777142377757364
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<horms@kernel.org>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20250411024205.332613-1-jiawenwu@trustnetic.com> <20250411162339.452e78c6@kernel.org>
In-Reply-To: <20250411162339.452e78c6@kernel.org>
Subject: RE: [PATCH net-next v2] net: txgbe: Update module description
Date: Mon, 14 Apr 2025 09:55:33 +0800
Message-ID: <006b01dbace0$4f204bd0$ed60e370$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJv93QGh5ZsPYnpZTk5cBeSpw0Q8QDwyvb8snJK/oA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NvH2zBBgt3uT9K5yCplgzxGTkgXdKjRirj1t3sEQUU5Uk/RuO1VCr+Tl
	15QkuUkOdcMn7BX29BfDgc6Hdf+c2p3FCB/R5G5khIm9IG1qU3IvndKOSmgfgou6lSQZwE2
	1+CgChxbT1iajO5U0HAxkweLiaBSOuSs3mjhljzF2J+X4rsHftaiv9xbHtKhel8y3RXjYrB
	YzJl0qRK1iYKWD8bfMAgZyhpnXeWpvsWMdVXihHizL1ndfUM0FZ5ZMFEe4Rum4YnGVbQDP8
	PE3EqofpI0lhFH9/CSzl6P7GlTBYK9PxYdklDfRTn/Ek2dAr26lF0BoOHZjE1fa4zVikKbB
	sJqtX3NUP9ZdXkHaq7D3qte7I2Pm8sZBtkuIlgzbFz1Qrh1A1Vwbwn5zy16vsJVzzcSigPV
	tT7442SzMWmBM6if+d9/+3lMk7EDmdo9OU5LX8cyb+axgvL6l/lEvEmdd34Fno1pgw6cwYz
	1SA26j9bbKSGk7ESSMRsbcCHnFDoBUDuyzcfq+D0e6KKG2bABSifntzBLCsd+CvB8qqFuAe
	li875JppFqsoVhE4By3N6nEcF2CpPiDkNBhaoJb3VU3avCjVR37aZE47RNeEoTSUApCowRp
	64l9gH+rVvdAdQ5GUS5SbPY3dTDSXqHPfLodH1HupkHnwnIwKCcnOKbBpqTMD3I/HKOGg5k
	odIrDpP1wYi3A6V9K1xY+hWlkAvrEUvFlR2fXua4t9uo/kAYvlEDku2OjkPyL6B6Awhfg1/
	B305msmAR4ys38eTOaxvhE+05kwenbDfKe58gxoraFW5GzXITqgVJDlJATg14m1vA3xc3IK
	P2DeQ7d9VV8uTBFAOXuOZwLxy2ZUW/LzX+l/sE+jzSLkXlQab520Bnl2LdQYy/qx9uQDRxP
	S5VsE0NcWUL6WlugJFUqLRS3DRDivkk/3knLavQ0SjWCE4dkaP7Ox6MnAA6vC1BnLwhybSp
	yBITmJhLaSi6XlgPurpevDD1W53AtMm/TWj3P96H44IpOva7ErtvV3d8g3ajkFvjndGxN7o
	x867OalFozcjLTB5g+
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Sat, Apr 12, 2025 7:24 AM, Jakub Kicinski wrote:
> On Fri, 11 Apr 2025 10:42:05 +0800 Jiawen Wu wrote:
> > Because of the addition of support for 25G/40G devices, update the module
> > description.
> >
> > Fixes: 2e5af6b2ae85 ("net: txgbe: Add basic support for new AML devices")
> 
> Post for net-next == it's not a fix == no Fixes tag should be present

Thanks, I forgot it...


