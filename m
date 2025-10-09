Return-Path: <netdev+bounces-228325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3E6BC7C5B
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 09:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFACE1887050
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 07:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4352260565;
	Thu,  9 Oct 2025 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SpgREKNK"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA431799F;
	Thu,  9 Oct 2025 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995967; cv=none; b=VJ0/QayuTLJr8z+/by3VXyyjRq81ROAD1OK49thA0zrgOGbcluvo24kzdR0fNkTZAW/f79Yv/7a9Oz4m+nMPKIEkJ/Lros0vYyI1HvSzSe9olRa4TxjQo1ISErEh4m9enNo4wo5a1d0uXrpJbRBsyVUpH+tlei3A1Ck0xXKrW4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995967; c=relaxed/simple;
	bh=+hrsr++BG+hhX/XC2ss0gCm4cDOtDIgJnF3I3PCRQB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hz7qX9HowI2JfEPi9tDU9EYv3f7VJMUlMcIUXcGJHUJyjErDJd4LyfUPNjuoCSfzSqzKG/SMBPNv21A7XCT+z+597w2R77mvIfoJB09f3hsiPs+/9+BWDO0aM9JykqW4rDjACEIO9X29adr702KZd/WOz4SbPVJIBOFS9An66Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SpgREKNK; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=LA
	P2ebwkkMXglVrpoqIznx5uP3LFvjY/47DXQOHH//8=; b=SpgREKNKGHWYItecy6
	FHDbLsJ8bkj3juJO88kv1RpXDcfRgXj4FKMn2TBvpVyZTr5fRWv5IYi+Nopch4wp
	1sLbGacV9s0sNMmn+8gSYE8jUdLQElVYdzW6SY6Wa3SQY8FODz3qm8QBnjqnTCG9
	eD/GI7Zu/qxvYLtQDlw0bIiLs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBX3z2aZedoTvH3Cw--.45821S2;
	Thu, 09 Oct 2025 15:34:52 +0800 (CST)
From: yicongsrfy@163.com
To: oneukum@suse.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-usb@vger.kernel.org,
	marcan@marcan.st,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	yicong@kylinos.cn
Subject: Re: [PATCH v4 3/3] net: usb: ax88179_178a: add USB device driver for config selection
Date: Thu,  9 Oct 2025 15:34:50 +0800
Message-Id: <20251009073450.87902-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <666ef6bf-46f0-4b3e-9c28-9c9b7e602900@suse.com>
References: <666ef6bf-46f0-4b3e-9c28-9c9b7e602900@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBX3z2aZedoTvH3Cw--.45821S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurW8Ww48uF15CFyfKFy8Zrb_yoW3trb_ur
	1kXF9rJr15Wr43X3W3Jr47Zr4SyanxKrZxJr48CryrW393XF4Dtr1DZr9avw1Iqr4rJF1D
	tFyjga93Ar17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj0Jm5UUUUU==
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBzQ7h22jnXdTujAAAsd

Hi, Oliver:
Thank you for your reply!

The issues you mentioned above, I will fix them one by one in new patch
versions. However, I'm a bit confused about the following comment:

> > +
> > +static void __exit ax88179_driver_exit(void)
> > +{
> > +	usb_deregister(&ax88179_178a_driver);
>
> The window for the race
>
> > +	usb_deregister_device_driver(&ax88179_cfgselector_driver);
>
> Wrong order. I you remove ax88179_178a_driver before you remove
> ax88179_cfgselector_driver, you'll leave a window during which
> devices would be switched to a mode no driver exists for.

In my init function, I first call usb_register_device_driver and then call
usb_register; in exit, I reverse the order by calling usb_deregister first,
then usb_deregister_device_driver. Why is this sequence considered incorrect?


