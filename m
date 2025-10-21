Return-Path: <netdev+bounces-231087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE3ABF4B42
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 08:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2E004E48E1
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 06:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ED4255F52;
	Tue, 21 Oct 2025 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GSzt2OCa"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64201C28E;
	Tue, 21 Oct 2025 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761028058; cv=none; b=ZMdF6nidtPGa19WFOEYYVE0+W/EhtTs8alMZmZ7God2vJVvxNdBVpnmN9sEAnG5unH4Ss4ZNj2DVhg3pldwTpkVZvlcfij2/JNBddPbEwmhNzbz1qpSfvuyLKx69pLYWWUrH/h9EKQYniNqsFGJjeFmlIIuDkEmN1/4XhNiPVT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761028058; c=relaxed/simple;
	bh=EHgoOyy69Ch6k/sk+su9R1F95d1WPbPxXqvHwkEvQvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/Xo3RRnf920iVTsu6c+g/teMEf7PX4r951pd/9Z+tdGgH0zclV4B86GX0ytPZWDJYESaRCC8Tc4nVk3qHJ8IKsIlTnsWVdTBribmmzZJYaBbYP4pd6y/iebG4sBTRbZajGIjrGbFEQfPBLKCbVliFMD7K9aB7H0JPBafwf3q2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GSzt2OCa; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=5+UuUE4YMf8tywi8j5sifo/4lXDdrqzj48jMSpJLcuA=;
	b=GSzt2OCay66Kk+N/PW+Jw7kJiKLPIE1H8xYuS9b+pZFDIMQN3KC0Qu6HV11CxP
	fxKxFPuMuwW9TknU4/Jzh8a0DkzxC7McXZL4NYSJhx+uH+u3E6zIcwjxav3l24UF
	VwYrrvuf4lyQGMsgwWN9RxBgPp7iDPAhJPzbJZrGgRLNI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCHOlWWJ_dogE_KAw--.13706S2;
	Tue, 21 Oct 2025 14:26:31 +0800 (CST)
From: Yi Cong <yicongsrfy@163.com>
To: stern@rowland.harvard.edu
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-usb@vger.kernel.org,
	michal.pecio@gmail.com,
	netdev@vger.kernel.org,
	oliver@neukum.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device driver for config selection
Date: Tue, 21 Oct 2025 14:26:29 +0800
Message-Id: <20251021062629.2919772-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7353775a-bc2c-4c2d-93bc-b8d3e03c3496@rowland.harvard.edu>
References: <7353775a-bc2c-4c2d-93bc-b8d3e03c3496@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCHOlWWJ_dogE_KAw--.13706S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4UKr1kJFW8Cr4xAw48tFb_yoW8ZrW7pF
	WaqF1rtF4DJF4rtFsrKrZ5GrWUuws7Kry3Wr4fKw1Y9rn8CryYywsF9r43Ar4kGr97Gr1j
	v3yS9a4I9F1DArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5kuxUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBzQTt22j3HhPTPQAAsD

On Mon, 20 Oct 2025 22:59:36 -0400, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, Oct 21, 2025 at 10:29:25AM +0800, Yi Cong wrote:
> > On Mon, 20 Oct 2025 11:56:50 -0400, Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > Instead of all this preferred() stuff, why not have the ax88179 driver's
> > > probe routine check for a different configuration with a vendor-specific
> > > interface?  If that other config is present and the chip is the right
> > > type then you can call usb_driver_set_configuration() -- this is exactly
> > > what it's meant for.
> >
> > I tried calling usb_driver_set_configuration inside driver's probe()
> > to select the configuration, but my USB network card has three
> > configurations (bNumConfigurations=3), which causes usb_driver_set_configuration
> > to be called twice within probe():
> > ```
> > static int ax88179_probe()
> > {
> >         if (bConfigurationValue != I_WANT) {
> >                 usb_driver_set_configuration(udev, I_WANT)
> >                 return -ENODEV;
> >         }
> >         //else really probe
> > }
> > ```
>
> Why is it called twice?  The first time probe() runs, it calls
> usb_driver_set_configuration() with the config that you want.  Then the
> second time probe() runs, the config you want has been installed, so
> there's no reason to call usb_driver_set_configuration() again.
>
> Unless something is going wrong, that's how it should work.  And the
> total number of configurations should not matter.

It might not be caused by the number of configurations, but rather by
the fact that usb_driver_set_configuration handles configuration changes
through a work queue.

I suspect this is the reason (although I haven't verified it further
—I just observed this behavior and switched to a different implementation
by using choose_configuration):
```
int usb_driver_set_configuration(struct usb_device *udev, int config)
{
...
	INIT_WORK(&req->work, driver_set_config_work);
	schedule_work(&req->work);
	return 0;
}
```


