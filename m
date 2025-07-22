Return-Path: <netdev+bounces-208789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E71C4B0D21D
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 08:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7B23B33AB
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 06:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12812289825;
	Tue, 22 Jul 2025 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KTob0Jx2"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A19228937F;
	Tue, 22 Jul 2025 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167134; cv=none; b=LamgCWHVx48Oha7XlA9mp44eczMq5/tOm9o4JFKOPjEFQJzeH5pPPeUwU8CEwDHl0TPPjteRa8SAL1R4gHQbAgx1JrSnIOIrLR67l1xPiKC3lPtrOC50mQHjYrkCq8krfmRP1Q/LNE4uoeQWA50GIlSQSKxES4n12dMESZTRyGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167134; c=relaxed/simple;
	bh=0IuwptWdpym6clpItyDXKXWMQcO684yPDmzDWcQI0cI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eZJ2RoWHmJlCf/lIVYNgUbJQb//zoGJcM/WBAVwgPiSxAHHwJWwdPm9zazOOiZ9yC832HPYW12Q/Ej//nyNKuC0gB8YrKWLaDjnbLYKy1GrKrGAu7LvAGuZ/6dmTj6uNkkuw/FWoRPUjvnNIuwtx4u1PpMT4qnyl+gMTEC482JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KTob0Jx2; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0T
	pDUQ830hMTN/h2gtHBh5uvsH0UJwbSz9gBHzv+if8=; b=KTob0Jx2rWa2PhTG+y
	UzzOqC0GQO0YleaVQDOgHbRsvj264bCJPGOKlWysztPiKABia5hemYJiebrtGB3r
	MMV+rMA7RROsXd3ia1UfZRYzVwQbACpaR/OtwOYMjgm15HEJOcHMD0e3rF/ep6pb
	fmtWI8Y6d5UBTyOkQ6gt/9ncs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3oJ__NH9oTxLlGQ--.37444S2;
	Tue, 22 Jul 2025 14:51:44 +0800 (CST)
From: yicongsrfy@163.com
To: greg@kroah.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	oneukum@suse.com,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: cdc_ncm: Fix spelling mistakes
Date: Tue, 22 Jul 2025 14:51:43 +0800
Message-Id: <20250722065143.1272366-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025072210-spherical-grating-a779@gregkh>
References: <2025072210-spherical-grating-a779@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3oJ__NH9oTxLlGQ--.37444S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWDKr45Cw15ArW5AF15twb_yoW8uw18pF
	WkCFW5CFnrJrWUuw40qw4I9ryYvas8GFW5GrW8Z3Z8ZFnIyFn7uF4jqrWSka4Sgr4UCry2
	vF1jgrWfWw4DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jso7tUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiUA2S22h-LnKvTQAAs9

On Tue, 22 Jul 2025 07:46:34 +0200	[thread overview] Greg <greg@kroah.com> wrote:
>
> On Tue, Jul 22, 2025 at 10:32:59AM +0800, yicongsrfy@163.com wrote:
> > From: Yi Cong <yicong@kylinos.cn>
> >
> > According to the Universal Serial Bus Class Definitions for
> > Communications Devices v1.2, in chapter 6.3.3 table-21:
> > DLBitRate(downlink bit rate) seems like spelling error.
> >
> > Signed-off-by: Yi Cong <yicong@kylinos.cn>
> > ---
> >  drivers/net/usb/cdc_ncm.c    | 2 +-
> >  include/uapi/linux/usb/cdc.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> > index 34e82f1e37d9..057ad1cf0820 100644
> > --- a/drivers/net/usb/cdc_ncm.c
> > +++ b/drivers/net/usb/cdc_ncm.c
> > @@ -1847,7 +1847,7 @@ cdc_ncm_speed_change(struct usbnet *dev,
> >  		     struct usb_cdc_speed_change *data)
> >  {
> >  	/* RTL8156 shipped before 2021 sends notification about every 32ms. */
> > -	dev->rx_speed = le32_to_cpu(data->DLBitRRate);
> > +	dev->rx_speed = le32_to_cpu(data->DLBitRate);
> >  	dev->tx_speed = le32_to_cpu(data->ULBitRate);
> >  }
> >
> > diff --git a/include/uapi/linux/usb/cdc.h b/include/uapi/linux/usb/cdc.h
> > index 1924cf665448..f528c8e0a04e 100644
> > --- a/include/uapi/linux/usb/cdc.h
> > +++ b/include/uapi/linux/usb/cdc.h
> > @@ -316,7 +316,7 @@ struct usb_cdc_notification {
> >  #define USB_CDC_SERIAL_STATE_OVERRUN		(1 << 6)
> >
> >  struct usb_cdc_speed_change {
> > -	__le32	DLBitRRate;	/* contains the downlink bit rate (IN pipe) */
> > +	__le32	DLBitRate;	/* contains the downlink bit rate (IN pipe) */
> >  	__le32	ULBitRate;	/* contains the uplink bit rate (OUT pipe) */
> >  } __attribute__ ((packed));
>
> You are changing a structure that userspace sees.  How did you verify
> that this is not going to break any existing code out there?

Your question is very valid. I can only guarantee that the devices
in my possession do not involve references to the relevant structures,
but I'm not sure the behavior of other vendors' implementations,
which may vary.

So, perhaps it would be better to keep things as they are?


