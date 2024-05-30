Return-Path: <netdev+bounces-99263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636998D43F4
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70AB41C2143E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847A11CAB8;
	Thu, 30 May 2024 03:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eXvMuQNl"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482B1C698
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717038664; cv=none; b=KrjCAifWgqcwajRTzh1f7u+2HHhdWA9Jv/IA0//NWuPfeNSymVIHNEkVvmkZzXyBkFSlnZUGdv6BMxehFA3ZhzF02IqJdaXx+CEqEHZ8hQQfJ8x4WnRaYOdDrkRPD6fN+NUXIi0TwiV2IgF/F2qd4TF4AJd3pXVYR1sCu6ehdig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717038664; c=relaxed/simple;
	bh=7sNUcNSmqNPsQTDr6e/iLs21QkaLHkuaxWMxfWhXeW4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=CqwqBbk/ZVW23FAlnW+khosJE4SUgN3vMkhjd37vKM3sKgnY+5JmBNELj9FBlDmXSsuBWFSWGLWvpn0hN6KnQxb/ItEgm3iQnWfPkxln8uEMRHsYBK+vw+nIwusQf34BLL+GGsb5MKILUu5c0ktychmmtxNf5yQdONERcE9glW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eXvMuQNl; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717038654; h=Message-ID:Subject:Date:From:To;
	bh=TAMGz5OlUaCO7hHm1pRgBuMGTSA1Xh++eGteDd5wnhw=;
	b=eXvMuQNlc+CY0NqAmmJbWTNV2CR6em+J5kMMOGh6aq/wMAWi80/v38r541nh6DoKHjd6idMyLCw3WDqUzWrris7K4fnHuxS+2N0qsTmmv7KPrH2K+QAp2McqIqucR0v+gdSAm1qefUDmrYh83EK0cZ2QjCoZ2HjhrbDsi1CW91E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W7VW4jL_1717038653;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7VW4jL_1717038653)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 11:10:53 +0800
Message-ID: <1717038610.151065-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net 1/2] virtio_net: rename ret to err
Date: Thu, 30 May 2024 11:10:10 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Daniel Jurgens <danielj@nvidia.com>
References: <20240528075226.94255-1-hengqi@linux.alibaba.com>
 <20240528075226.94255-2-hengqi@linux.alibaba.com>
 <20240529171053.132ae776@kernel.org>
In-Reply-To: <20240529171053.132ae776@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 29 May 2024 17:10:53 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 28 May 2024 15:52:25 +0800 Heng Qi wrote:
> > The integer variable 'ret', denoting the return code, is mismatched with
> > the boolean return type of virtnet_send_command_reply(); hence, it is
> > renamed to 'err'.
> > 
> > The usage of 'ret' is deferred to the next patch.
> 
> That seems a bit much. Can you call the variable in patch 2 "ok"
> instead?

Sure.

Thanks.

> -- 
> pw-bot: cr

