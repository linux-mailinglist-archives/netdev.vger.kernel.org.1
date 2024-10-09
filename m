Return-Path: <netdev+bounces-133584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2E2996663
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524CA1F22C69
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2774C18B482;
	Wed,  9 Oct 2024 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xmcT8xfp"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764AE18E354
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468293; cv=none; b=Aw4Jl2+H/sSznCDNrL7Wil/O4CHtWl1z3xiI1j2ZpAlFZo1uoAItQO99LZVJj9saNq3CAvXoq682Xm4nvOALqBo2EeW9R+SrjGdcT5vdsYw/PiDTekC1VcasOTBRAgd60xNL0R7X5o4YS0iu4KjBV2TsX/w36BzJUvuSejJfESM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468293; c=relaxed/simple;
	bh=wJhVJ+3VA3g67o3DlF2lZIB2H/vMM4MBu8Rqq6UDh1k=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=IqZNtfQnkHAHK/x+ivStUXpVDEMAA4YpQXecZ2r5niIv2l2SRf9HH3izejtYmkx7WlJrDLFbgn3Qm1qerqfoWLXTtpk/Kq6uI6iDES5jIDmUThx2vQ8CUA493zKR8Lvd28CaxT59qWeq3d8XhAuIuk9QU+M2Z3T575OeoWMF9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xmcT8xfp; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728468287; h=Message-ID:Subject:Date:From:To;
	bh=EoPgooXBHHqcZaGog7p/CimjuVHlXZKaNgI2CkSSOvE=;
	b=xmcT8xfpYhOarRGy3b5fRhOExjTLlDw7QHxBWByaPxwKtQALot3SEB6nLx2bLKaeATi9EHShKpIXndpDyQv0l8albDi85LSmR8aC8CCPH8RPBamoGzFbb4iV7NKVTe7zv7BPxacx3qqFugoxHVuX5Q5U7Mv47PtG8aItWGFwxwM=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WGiMLlU_1728468286)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 18:04:47 +0800
Message-ID: <1728468047.566891-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 0/3] Revert "virtio_net: rx enable premapped mode by default"
Date: Wed, 9 Oct 2024 18:00:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 Darren Kenny <darren.kenny@oracle.com>,
 "Si-Wei Liu" <si-wei.liu@oracle.com>
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
 <20241009052843-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241009052843-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 9 Oct 2024 05:29:35 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Sep 06, 2024 at 08:31:34PM +0800, Xuan Zhuo wrote:
> > Regression: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> >
> > I still think that the patch can fix the problem, I hope Darren can re-test it
> > or give me more info.
> >
> >     http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> >
> > If that can not work or Darren can not reply in time, Michael you can try this
> > patch set.
> >
> > Thanks.
>
> It's been a month - were you going to post patches fixing bugs in premap
> and then re-enabling this?

[1] was tried to fix the bug in premapped mode.

We all wait the re-test from Darren.

But Jason and Takero have tested it.

If you do not want to wait Darren, we can discuss [1] or add it to your next
branch for more test.

Thanks.

[1]: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com


>
> Thanks!
>
>
> > Xuan Zhuo (3):
> >   Revert "virtio_net: rx remove premapped failover code"
> >   Revert "virtio_net: big mode skip the unmap check"
> >   virtio_net: disable premapped mode by default
> >
> >  drivers/net/virtio_net.c | 95 +++++++++++++++++++---------------------
> >  1 file changed, 46 insertions(+), 49 deletions(-)
> >
> > --
> > 2.32.0.3.g01195cf9f
> >
>

