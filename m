Return-Path: <netdev+bounces-231073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D85ABBF4621
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 04:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915A3188278E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 02:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0B481720;
	Tue, 21 Oct 2025 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YKDysDRu"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F98B1643B;
	Tue, 21 Oct 2025 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761013832; cv=none; b=FALtOB0E7O1qbb26zYwrP6Cv0nR6nHVk64tlDbaIaS/zcmJ3dCaQfIZC1IaBzrxSUNoEh9S4iBJQBwXNXig4rjsS4M+EwjmXfFf7Ny3dRMusk98zk2K8iWWc/fuL3ojK4J/RwKPW76OmPc1koY/Ya9V2H+LWtgnnRAOcE5ogvvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761013832; c=relaxed/simple;
	bh=Z2+4HZ/8aE77Mf75rV9B4S0bhZRimjkMIhrEuQriFHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XaByUtFlqSTmFINly0AC6mbCe6zgWcPnlQWfuOtjguFwkxVzIjIHmHU7UHhZG1oEf4OBTxL8vGsuYKhUDfrPdj+Jdxf1U1OMSFSRLSOzkpuSjpwesGUZZ5oudczemgzuzh4TcPYYwmcEa8sIR+QLp0eS3IFLCWmX0fuoJnhoVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YKDysDRu; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Py
	hu7/CDxbsKFX8/iPnM99yJ3CHYeq9v3lil4GaQQMA=; b=YKDysDRugA4QrYKxsI
	OkVScu26BH0TNBMOedzxC5PJ09ZuwJhuNbrwiJnqR/s1Gpdd401c4qjWSxFc0hiq
	sNvDUeOPs66gr1i0W0SYUP20FlQhwDE2jTWWT186FWKh359kGUvBtrJtck4IgDXs
	GPxeypHGJ6Cba2F4OIwT1QGwM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCn_sQF8PZoHMW3Aw--.11139S2;
	Tue, 21 Oct 2025 10:29:28 +0800 (CST)
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
Date: Tue, 21 Oct 2025 10:29:25 +0800
Message-Id: <20251021022925.2881236-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e4ce396c-0047-4bd1-a5d2-aee3b86315b1@rowland.harvard.edu>
References: <e4ce396c-0047-4bd1-a5d2-aee3b86315b1@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCn_sQF8PZoHMW3Aw--.11139S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr4fWr4fur13GFyUtF4xJFb_yoW8Cw18pF
	WjgF18AFWDJF4rA39rt395ua1Yqws7Kr1UWr43J3W5Zrn09ryavrsI9r4Y9ry8Wr97Jw1j
	q3yFg3WS9F9rCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uomh7UUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBzRTt22j26djUJgAAsy

On Mon, 20 Oct 2025 11:56:50 -0400, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sat, Oct 18, 2025 at 05:56:18PM +0200, Michal Pecio wrote:
> > On Sat, 18 Oct 2025 11:36:11 -0400, Alan Stern wrote:
> > > > @@ -169,6 +175,12 @@ int usb_choose_configuration(struct usb_device *udev)
> > > >  #endif
> > > >  		}
> > > >
> > > > +		/* Check if we have a preferred vendor driver for this config */
> > > > +		else if (bus_for_each_drv(&usb_bus_type, NULL, (void *) udev, prefer_vendor)) {
> > > > +			best = c;
> > > > +			break;
> > > > +		}
> > >
> > > How are prefer_vendor() and usb_driver_preferred() supposed to know
> > > which configuration is being considered?
> >
> > Currently they don't need to know, but this could be added by passing
> > a temporary struct with more stuff in place of udev.
> >
> > Really, this whole usb_drv->preferred business could be a simple
> > boolean flag, if not for r8152 needing to issue control transfers to
> > the chip to find whether it supports at all.
> >
> > It seems that ax88179_preferred() could simply always return true.
>
> Instead of all this preferred() stuff, why not have the ax88179 driver's
> probe routine check for a different configuration with a vendor-specific
> interface?  If that other config is present and the chip is the right
> type then you can call usb_driver_set_configuration() -- this is exactly
> what it's meant for.

I tried calling usb_driver_set_configuration inside driver's probe()
to select the configuration, but my USB network card has three
configurations (bNumConfigurations=3), which causes usb_driver_set_configuration
to be called twice within probe():
```
static int ax88179_probe()
{
        if (bConfigurationValue != I_WANT) {
                usb_driver_set_configuration(udev, I_WANT)
                return -ENODEV;
        }
        //else really probe
}
```

Although the final result is correct, this approach seems flawed.

This issue does not occur when using choose_configuration.


