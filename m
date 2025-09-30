Return-Path: <netdev+bounces-227291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B33FBABF94
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4DF1C8400
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1402F39CD;
	Tue, 30 Sep 2025 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mvaLzq5i"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF719343B;
	Tue, 30 Sep 2025 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220114; cv=none; b=nK9cWZG4XfIL8LvXxwA0Fy7kAZ/NJX2xodGi0KCP2NR8VDBIHJBnkS4pHAlBz5YCdBSlVG0BcA7LOhXnPXnh/stjJc2QGxhWSEkyn0sjNXjYRqyBDHVcktufFBLe1H2nItol3f6STakMRzsPFzK7pwDi1y7L546Jg6PDHB5g3+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220114; c=relaxed/simple;
	bh=UHY0gFXBcnA/7x1oJsrA5+gORyeVIqDA/vZ7MExLlQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tNvbMGjsa5vKMVj8RQW8+l9CvvFaDlkBNn0LTKZ+4RUcIwa6etR567o0NHqCw+cUexXj3wJBvWh2QAYlbQrEfNRObImX9gtES7xlr7qwcF+TerAB8h6Fv4BP2VnRFd5Lx3/byBVVbBMdSECpn+Rp+4MluU15yDQsR5T4elbLjgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mvaLzq5i; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=QD
	tkFZKpVeOPbIznEGb2uwyNPmNuUjWVSuMZG4Tkv8A=; b=mvaLzq5ikOtEs/zWIr
	uz4kBlAlq16fNEYNeEbkrBW66axGhNlXtEksbI7Cuh5+lfOVvRYBmzLwVSD1qr3F
	FWcq22k9+KD7TjlVqfXeB+QCdbWszlOABzQ4uk+bvLty+aVZOM0IZL1mr4pvhTuW
	g0EkXRpc5xUO7X1ywxex43Q6U=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDXvOVYkdto5vI3Ag--.35015S2;
	Tue, 30 Sep 2025 16:14:17 +0800 (CST)
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
Subject: Re: [PATCH 2/2] net: usb: support quirks in usbnet
Date: Tue, 30 Sep 2025 16:14:15 +0800
Message-Id: <20250930081415.3410752-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5a3b2616-fcfd-483a-81a4-34dd3493a97c@suse.com>
References: <5a3b2616-fcfd-483a-81a4-34dd3493a97c@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDXvOVYkdto5vI3Ag--.35015S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFyktw4Utr4kXry8AF4xWFg_yoW8JFy8pF
	WrGFWY9rsrG34Iyr1xZw47ua48tw4kWwn8WryqqrsFkw4avr1aqryxK3yY9F9rWr1Ikr42
	yrWav3s3JF43Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uzc_fUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBFATY22jbjuZO6AAAsu

On Mon, 29 Sep 2025 12:21:30 +0200, Oliver Neukum <oneukum@suse.com> wrote:
>
> On 29.09.25 11:29, yicongsrfy@163.com wrote:
> > On Mon, 29 Sep 2025 10:45:19 +0200, Oliver Neukum <oneukum@suse.com> wrote:
>
> >> Please get in contact with the core USB developers. The problem
> >> needs to be solved, but this is not a solution.
> >
> > Thank you for your reply!
> >
> > Should I add the AX88179 chip information into the `usb_quirk_list`
> > in `drivers/usb/core/quirks.c`? (Of course, it will also include a
> >   check for whether `CONFIG_USB_NET_AX88179_178A` is enabled.)
>
> That would need to be discussed.
> Ideally the probe() method of cdc_ncm would never be called.
> But there is the possibility that cdc_ncm is already loaded
> and the other driver is not.
> >  From an implementation standpoint, this approach is indeed cleaner
> > and simpler than my current solution.
> > Is the method mentioned above an appropriate approach?
> Well, no. Declining devices is not usbnet's job. If the logic
> needs to go into a device driver, it needs to go into cdc-ncm,
> which would need to check quirks.

Thank you for your suggestions!

I've placed the quirk in cdc_ncm and modified its probe
method accordingly. Could you please review whether the
v4 version of the patch is appropriate?


