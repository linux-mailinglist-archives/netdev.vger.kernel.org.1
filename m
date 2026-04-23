Return-Path: <netdev+bounces-280886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF78Fkuh6mlF1gIAu9opvQ
	(envelope-from <netdev+bounces-280886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:46:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F69458348
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63D7D301E945
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9303347500;
	Thu, 23 Apr 2026 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gHsocES4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572763093CB
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984389; cv=none; b=WdSihtMf7v28K7s0Hb03ism+4ZFcPfCIP9BJm4BdDfth+DVedSEPPVCIG/BdsXaPKioAQMaACiUWuM8agGgQRgwCG5E+9Nxse9NWp5oV5q/8GDwxkz8ZcTuqJsw91UXvuwuRt/RGYOK6WlwMMjPWoSeIFZVAkYOlmyEObVxeQfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984389; c=relaxed/simple;
	bh=l9uHSdgj37MlVqmUNMTjAdytE8mxXV9iMRTSDZHL+Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrwCZSuegSKNjWpH3LU72R9HyFGawMwMkDsnGn+JFh6oWOT/SgCwTO0hF9PoKU4uyg+YxX+NfuOgebP3OWjWXv/KUcR6SQhiiTbCB8mns1MQobNiiG4rSEdO+MWSBh1lkUk0pKlf4uxRcAqEdjZkxoSJFBBGytghipRYQCT0jD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gHsocES4; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8d68f702851so801867185a.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 15:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776984387; x=1777589187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LOyCcpWY9ETk6/DQ/Zzf9IsC2/j7viPfylDYdsbXpuw=;
        b=gHsocES4rM2iEUWKqG8kp+69ntn5/8KkwOOSvqiYUtEDR23ce6l56FUnFcdYvMklOU
         d4iVS5lIb3Y+GL0Pnq9sDAjar03xr2XnLZije5OdOOdjBatHPNLRzHwLUkXjsDLM25G1
         HPol8Kez21ljDOoCS1nRmB9Bl2hxNYShOzDakJLxpTpzUDnbLkKpVZZe9Hf8si1UWDLl
         /Cj/tkVtPO0B6oC/FFGdIQihVUQjyOgTJxjcv9iAiTPKYvDblGzxvu9aLUQxbRuQ4I6I
         q9T4Qp3qASJDwtuUTFCpGZq4yXMEbbQ+J5KEDDPrrylcADSqCh6vlyled3ozriSBybLE
         EDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776984387; x=1777589187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOyCcpWY9ETk6/DQ/Zzf9IsC2/j7viPfylDYdsbXpuw=;
        b=NIM71nfONle+JLsfgI3bMX2Gc5wx5K/1a1z4wCOFnNTi//Fj3vTpiCC55VvtkVrXS3
         0JwFXZiW4tA0WFvTo3jh8PTWtn+D80zrOGozfNc9DDNi01UJDD8s2FXAvxutYfKHtdhh
         p7uBKipHZ1ZNLEmFLz0XzZy5DHXVM8urIoaW2ZMfSPG0pmywsnDovPdO9/nY7CnApsMd
         DADwJRlJvLILg6YhR2gC/GC5hu7mKhGyW6M0IT7N5CFR+BqQSuE2D+FYOWoc1fwojkcy
         uF2dQtehUm7BpqdoXQdlWIjqfDC56/9jYdNYwNpFD90BJtkblPdMYkPAjDK6lISxfUkw
         75HQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rcQdWk3kHAHR068NtP+E1KvjWJfH6IDeyq9DfG/30i/1y53lJvtKEqjJO3+vKHBZB8jGAzFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd47WTtY4p9kLllH2gGWY2K6LV6sHT2vJN40LFAwN/n5K7cUR7
	bpxkGC9i4q2bWQWt8kB9WXwkyEIGOAfnWBHaVNNZycNZLgP6ovCQ5ollU8Xdxd0SgxU=
X-Gm-Gg: AeBDieuiRUBIJEgKUNUNRHQo9rRtkg5UMJ3NEVvGCHzTHSk9Jum+l3a3HrMer3W6Pbt
	tbQgtoy2aQRn/TE717ZHp8PavvZ0zeYl3k0dnDgbSWv7x5L+ZP6yc7caBT2g/dts8KMDHDmDfll
	S2lXjhxeDledmIphyELyCER+5nqCThfs1OL3Zhti49VebouOYZnhzdc7ZfsbDkn0dFf3yTMhPs4
	YPut+mhYatiLl5q2s/V9tWoOJ6pdQL3XU4BV9igx7afbe/zDLUJ8TX1i6AhUZadOI1MgshOe7q2
	MH15fqfLDifTr8Xa7ChjjhtIBG1dBEKIpYH1Qs3DaDcyHklV6X3Mq6oFHI2PHOG6BWNne/dvOPn
	W/TD+otgXxRvCvvT7SecZg02gJFL8jAia3x3gKzC8UHykGJFkAq/jcGTIP4bZ/NxB6VaWyd/a4X
	2/+9aG7aydCsjouTkLw5WxVeryq10ceL+mZxLA3qFj1QrxJHJOplUBy7pXVAQ173y0pdzgJWjHy
	Z0tbFje8kBleaenGwcBTXWBmZU=
X-Received: by 2002:a05:620a:440d:b0:8ef:74c9:daa7 with SMTP id af79cd13be357-8ef74c9e32fmr1451093685a.8.1776984387201;
        Thu, 23 Apr 2026 15:46:27 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d98c15a9sm1970538185a.43.2026.04.23.15.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 15:46:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wG2oU-0000000GMBz-0jKo;
	Thu, 23 Apr 2026 19:46:26 -0300
Date: Thu, 23 Apr 2026 19:46:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Stanislav Fomichev <sdf@meta.com>,
	Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260423224626.GV3611611@ziepe.ca>
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org>
 <20260422162928.GL3611611@ziepe.ca>
 <20260422132740.5f809bf7@shazbot.org>
 <20260423142828.GQ3611611@ziepe.ca>
 <20260423132016.4a25e074@shazbot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423132016.4a25e074@shazbot.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280886-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: B5F69458348
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 01:20:16PM -0600, Alex Williamson wrote:

> My suggestion would be that we leave VFIO_DEVICE_FEATURE_DMA_BUF
> unchanged and add a VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl which takes
> the fd from VFIO_DEVICE_FEATURE_DMA_BUF, along with a steering tag and
> processing hint.  It would fdget() the dmabuf fd, validate it's a
> dmabuf via f_ops, validate it's a vfio exported dmabuf via dmabuf->ops,
> find the matching vfio_pci_dma_buf via priv under memory_lock, and
> stuff the provided TPH values into the object.  It would be left to the
> user to sequence setting the TPH values on the dmabuf before the dmabuf
> is consumed by the importer.
> 
> Is that a more reasonable uAPI?  Thanks,

Off hand I think it can work, with the proviso that if userspace uses
the dmabuf before setting the tph the importer may ignore it. I don't
think that is a problem in practice.

Jason

