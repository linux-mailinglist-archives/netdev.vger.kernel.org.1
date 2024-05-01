Return-Path: <netdev+bounces-92770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EB58B8C12
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 16:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0881F232D2
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A991DA24;
	Wed,  1 May 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyPxZrny"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9A1F17B;
	Wed,  1 May 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714574662; cv=none; b=Y38WZoSIhNZHtVD/k+MgdeLSCB4LfrWkb0uHHOD2qQ1VQvPZXUELMq2Ap6nD7lJTcypchg5bDeXbwgQ+wuKAVJCPSFVXoTZs+YTABKkUc0sT0+u8qaWyQSMwKFBqKi4h1glChAOHgqzxPmvYL8tTN5zOsloCNTrpvqNnh8Zk/zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714574662; c=relaxed/simple;
	bh=KpgBLuvahv1swO9jxxfBhJtTgwYOnlVXsVrM2js3DXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1MySYRFBG1Wyh6UIDdQ/HeKGIOSakgzzgYi+Z/58c8eabGIZ/lfD6KbbiTgYn9ltRxHuGrhsWrReLW+98tAWzbS4gVoxwaqe4dHfHXyRWrMyGxOGwCbY3SnFpX9uoSCE9UlxE87ZZ+UQPpBx20RCeXzHSIJeTYoQGkE9Tw10Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyPxZrny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A6BC072AA;
	Wed,  1 May 2024 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714574662;
	bh=KpgBLuvahv1swO9jxxfBhJtTgwYOnlVXsVrM2js3DXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HyPxZrnyG8QiQZ3dSCCTUMtYvN31EH4iIsP9AzhzFcgjwl9R5eT94CmJIDKdTad/9
	 jzzXqkJ6kPVoX+6Q7uHdLFZAmsqclsa5IZMoZiZFXmkx6+LUxPuUtMUSO0LIaf/oOK
	 MhBy1xW1Mt33PQtYJMjWKkYcP/mbY9od+FFm03Twg+kuP/DXIJdEMKFuJ0u0tPHfLH
	 gR23dl1y7ZC3u1SwB3L2uXOzJNsN7Aub1YovFl2BmzAqGC2S+R0APlhhE2r8Msd7Zi
	 NZa/BYfRxzkekTWDUQyvP2TG1TpU7oN9SreBtuRHuMAmiP2W+F7o409wzCChYZKVOm
	 dGKVJPybTYKMQ==
Date: Wed, 1 May 2024 07:44:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, "David
 S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Jason Wang <jasowang@redhat.com>, "Michael S
 . Tsirkin" <mst@redhat.com>, Brett Creeley <bcreeley@amd.com>, Ratheesh
 Kannoth <rkannoth@marvell.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal
 Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Jiri Pirko <jiri@resnulli.us>, Paul
 Greenwalt <paul.greenwalt@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v11 2/4] ethtool: provide customized dim
 profile management
Message-ID: <20240501074420.1b5e5e69@kernel.org>
In-Reply-To: <1714538736.2472136-1-hengqi@linux.alibaba.com>
References: <20240430173136.15807-1-hengqi@linux.alibaba.com>
	<20240430173136.15807-3-hengqi@linux.alibaba.com>
	<202405011004.Rkw6IrSl-lkp@intel.com>
	<1714538736.2472136-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 May 2024 12:45:36 +0800 Heng Qi wrote:
> >    net/ethtool/coalesce.c: At top level:  
>  [...]  
> >      446 | static int ethnl_update_profile(struct net_device *dev,
> >          |            ^~~~~~~~~~~~~~~~~~~~  
>  [...]  
> >      151 | static int coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
> >          |            ^~~~~~~~~~~~~~~~~~~~
> >   
> 
> This is a known minor issue, to reduce the use of 'IS_ENABLED(CONFIG_DIMLIB)'
> mentioned in v10. Since the calls of ethnl_update_profile() and
> coalesce_put_profile() will only occur when IS_ENABLED(CONFIG_DIMLIB) returns
> true, the robot's warning can be ignored the code is safe.
> 
> All NIPA test cases running on my local pass successfully on V11.
> 
> Alternatively, I remake the series to have IS_ENABLED(CONFIG_DIMLIB) back,
> up to Kuba (and others). :)

You should remove the ifdef around the member in struct net_device.
It's too much code complication to save one pointer in the struct.

