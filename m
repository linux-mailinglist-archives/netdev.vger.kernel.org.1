Return-Path: <netdev+bounces-82993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B79889064B
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E632A46C1
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 16:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314A444376;
	Thu, 28 Mar 2024 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr/1SOrS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE5B43176
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644529; cv=none; b=N7PEzbywwm6uOzXwdt9I5KLj4YUPdaKOQ7FNMdeKwtJhextHhPr+VHHyo/D3ypTb9dWtVCQK7Y04sGkEHiVFkJmpo7hhwpAy7RzCcHvmLYYr648yqJgLH4GiQdQego59EoOXT05tbCKU4TMzd5y9vgFHCMG/RGms95Rq2MiRxik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644529; c=relaxed/simple;
	bh=XCS8coifLJoAHodCgPDnHwtBvKFyYNMs8FtMyUu4F5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLvYIHVm9Wu2hG9iI8BJLNm8OOUrJ4W290D1aO6XgiPpZYzQnOykkw9ZBYxe3wjxy8urvoqs8M4mDdq9GDsQ56tLfVmS6xpqtReAW7Gnng1iGbCLyCtvnxWkLNTRnPjWJvbRdylJhkXQM+rpA9Z95jkveoWRSuAoxAUr/+U1/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr/1SOrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAAFC433F1;
	Thu, 28 Mar 2024 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711644528;
	bh=XCS8coifLJoAHodCgPDnHwtBvKFyYNMs8FtMyUu4F5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zr/1SOrSZkUxqJy0E+QLq1IXfcEWYfN8ZbtWSdwVtIIi7Au67KNS0ccFrSB2Gwbf1
	 yFQMHIAuJzvhSxu3YKERGeflNE7MxdxwIlN7VFfLJsPq3pwFp+xbdrk16Q5lNk3+1X
	 c+ASHp18/WcfXoajRbTsq98fsIPCNzONapgOdSHo29GTpchCbZkEThS4q6ESvwWzF1
	 LUKSS66gKRmGVBVZKAe8yTX4mA8iqdd/Cz9X2ad9d5vrjmbT3qQdz6xyzg6eAGpmSZ
	 DxV+/96B3aHYbW9mJhz7viISF398dDXxokkSaB8SHehHZgy1CweHiv8qfuHqwcMPHm
	 oIHYHyiunNmeA==
Date: Thu, 28 Mar 2024 09:48:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, <netdev@vger.kernel.org>, Eric 
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir 
 Oltean <vladimir.oltean@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 vadim.fedorenko@linux.dev, Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v2 2/2] virtio-net: support dim profile
 fine-tuning
Message-ID: <20240328094847.1af51a8d@kernel.org>
In-Reply-To: <1711591930.8288093-2-xuanzhuo@linux.alibaba.com>
References: <1711531146-91920-1-git-send-email-hengqi@linux.alibaba.com>
	<1711531146-91920-3-git-send-email-hengqi@linux.alibaba.com>
	<556ec006-6157-458d-b9c8-86436cb3199d@intel.com>
	<20240327173258.21c031a8@kernel.org>
	<1711591930.8288093-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 10:12:10 +0800 Xuan Zhuo wrote:
> For netdim, I think profiles are an aspect. In many cases, this can solve many
> problems.

Okay, but then you should try harder to hide all the config in the core.
The driver should be blissfully unaware that the user is changing 
the settings. It should just continue calling net_dim_get_*moderation().

You can create proper dim_init(), dim_destroy() functions for drivers
to call, instead of doing

	INIT_WORK(&bla->dim.work, my_driver_do_dim_work);

directly. In dim_init() you can hook the dim structure to net_device
and then ethtool code can operation on it without driver involvement.

About the uAPI - please make sure you add the new stuff to
Documentation/netlink/specs/ethtool.yaml
see: https://docs.kernel.org/next/userspace-api/netlink/specs.html

And break up the attributes, please, no raw C structs of this nature:

+	return nla_put(skb, attr_type, sizeof(struct dim_cq_moder) *
+		       NET_DIM_PARAMS_NUM_PROFILES, profs);

They are hard to extend.

