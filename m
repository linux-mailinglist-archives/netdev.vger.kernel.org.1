Return-Path: <netdev+bounces-227119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC55BA8A1A
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 11:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AADC16663B
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 09:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BF32C21E5;
	Mon, 29 Sep 2025 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aroyKRwE"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14BF288C27;
	Mon, 29 Sep 2025 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138241; cv=none; b=WSQ1Ruc1hZTz+Jn6kT3CmVO7seP+5sK7WVTCP77BEaozCzZ9I2A+3nBccmR0+wWguD27ZxCVOkF6pEB8ztezZLcrULC/2VIYkZ9onxKn9zZGeZDoEw6or5+vh9lvJH6dC0Y7kAJmvmQTApS9/toGaNB1Fhqmks9ZqmdzNG80y7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138241; c=relaxed/simple;
	bh=qwTP3TYBFqj3Ognvf2JD6IFPhugLfyw+AeXRkf4akbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rD1jDJ73Lw6lttA+PqgA1pR9MbvskzmTaoB63XVb0Hz3zH4nSGr+IzC68N6UpTJ39Q+nluqDRbYMTCqSw9pXw14yKWh6B1WmCLmhSvgHpl5lqCl9Sew+2198kHGfhDXwXGpwyNsoCi9EN33IDUDfBb9XXJt2ztdQ65S0tstrccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aroyKRwE; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=L5
	hfgvg0tHb6OJZAY54Dxllt6cuKoaHL0ON0QGJWaP0=; b=aroyKRwEcJbIhId4nd
	0rrzThLXpN9xfemCffCRxuUqXk7NGxdh+eSQqPaMRCWzlXGqeANdGz0LhzHCO58m
	yXHmgknM07+M3R9cbYG8t46igap9EWgEEHZMX36OvLaH3MhyxwOzilG41yXz0mW1
	deoqJ4fCQ/jjice+MJUS3ZPxo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBnBDyGUdpo8ve1Aw--.23868S2;
	Mon, 29 Sep 2025 17:29:44 +0800 (CST)
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
Date: Mon, 29 Sep 2025 17:29:42 +0800
Message-Id: <20250929092942.3164571-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c9e14156-6b98-4eda-8b31-154f89030244@suse.com>
References: <c9e14156-6b98-4eda-8b31-154f89030244@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnBDyGUdpo8ve1Aw--.23868S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw48Gw4UJF4kXryDZrWDurg_yoW8GFWDpF
	s5WFWFgF1jq3yrGr1UAwnrua4rtws7Wa1vgr93tw1DXwn8ZrWqqr1xKF4avF9rCrn3Jw42
	yrWq934rWFy3Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UzWl9UUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiUB3X22jaT2NHZQAAs9

On Mon, 29 Sep 2025 10:45:19 +0200, Oliver Neukum <oneukum@suse.com> wrote:

> On 28.09.25 03:46, yicongsrfy@163.com wrote:
> > From: Yi Cong <yicong@kylinos.cn>
> >
> > Some vendors' USB network interface controllers (NICs) may be compatible
> > with multiple drivers.
> And here is the basic problem. This issue is not an issue specific to
> usbnet. It arises everywhere we have a specific and a general
> driver. Hence it ought to be solved in generic way in usbcore.
>
> Nor can we do this with a simple list of devices, as we cannot
> assume that the more specific driver is compiled in all systems.
> An unconditional quirk is acceptable _only_ if usbnet would
> not work.
>
> Please get in contact with the core USB developers. The problem
> needs to be solved, but this is not a solution.

Thank you for your reply!

Should I add the AX88179 chip information into the `usb_quirk_list`
in `drivers/usb/core/quirks.c`? (Of course, it will also include a
 check for whether `CONFIG_USB_NET_AX88179_178A` is enabled.)

This way, `usbnet_probe` can detect the blacklisted information.

usbnet_probe (...)
{
	...
	info = (const struct driver_info *) prod->driver_info;
	if (!info) {
		dev_dbg (&udev->dev, "blacklisted by %s\n", name);
		return -ENODEV;
	}
	...
}

From an implementation standpoint, this approach is indeed cleaner
and simpler than my current solution.
Is the method mentioned above an appropriate approach?


