Return-Path: <netdev+bounces-75850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460F586B589
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 18:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35C328B29A
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7788B12DD9B;
	Wed, 28 Feb 2024 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doTKwAg5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544667FBD7
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139966; cv=none; b=NR22fvZdxE6++oCyEs6FGwXcRCyz47gC7pxCnyHPdhHGDHYolQSaKrkOKigZrB68+d/WTbLRdJA26192LQ7gS5N4r+a17KhWI3XBAWasYf4fRp3CU2LU4efXHw9k+jn7ktnb1gobAq7lpnHYpI9ffYBfoOHDz+DV/qcPpWIVXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139966; c=relaxed/simple;
	bh=qwncyAd8G5gI/88t2O9yQ6ON1GyeGPwQot12tKj1Tnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rdz7D1OXHinVoI2I2gg0Z87c+j5QDPwQkggKVxewSFomK4D8bYY10n/Ck7CKMbugepn4biTCFvm6Yv7D9VLcZP481QPd6bRZU+btuQMcBWhyCMxlpRV8UmmfN6tE3OTPU0yQqhhH5tyCdyH/3+tAqoqP4+5b/+VFuGXnSpDQy7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doTKwAg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08B3C433C7;
	Wed, 28 Feb 2024 17:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709139966;
	bh=qwncyAd8G5gI/88t2O9yQ6ON1GyeGPwQot12tKj1Tnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=doTKwAg52uJKhsVVf2etmC+S2/E2OJToBDtjY/6ksJOVuMqhMAqSsVO6AaCUPxHH+
	 I+yb/Ge2CHzaB/6Hn7fIXgyr0S7ixcFsPY5KSY/QWPH9F8DOhQfCzKwVVDL3AbPIIh
	 m+/fOeC9RMrOitNNbjFu6u4Upbjb9qqQ4BLfnjgDZlP+vzhKwuzMG7oTKcpsNcnjVs
	 DXs1gIMcxBnsDPTJ6zuanrhfcdpnIn0l2Kpb77wyRj+ZG12/InwfXwSlE11LzrxjgE
	 l8LQ8Gr5G2AyuG1n+/RVS9KfmMg6EsYN/ZrVih9ycU86N/VuZmapcg2vW8eX3bXrz4
	 tvSkobcwvADcg==
Date: Wed, 28 Feb 2024 09:06:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Tariq Toukan <ttoukan.linux@gmail.com>, Saeed
 Mahameed <saeed@kernel.org>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed
 Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, jay.vosburgh@canonical.com
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Message-ID: <20240228090604.66c17088@kernel.org>
In-Reply-To: <Zd7rRTSSLO9-DM2t@nanopsycho>
References: <20240215030814.451812-1-saeed@kernel.org>
	<20240215030814.451812-16-saeed@kernel.org>
	<20240215212353.3d6d17c4@kernel.org>
	<f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
	<20240220173309.4abef5af@kernel.org>
	<2024022214-alkalize-magnetize-dbbc@gregkh>
	<20240222150030.68879f04@kernel.org>
	<de852162-faad-40fa-9a73-c7cf2e710105@intel.com>
	<ZdhnGeYVB00pLIhO@nanopsycho>
	<20240227180619.7e908ac4@kernel.org>
	<Zd7rRTSSLO9-DM2t@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 09:13:57 +0100 Jiri Pirko wrote:
> >> 2) it is basically a matter of device layout/provisioning that this
> >>    feature should be enabled, not user configuration.  
> >
> >We can still auto-instantiate it, not a deal breaker.  
> 
> "Auto-instantiate" in meating of userspace orchestration deamon,
> not kernel, that's what you mean?

Either kernel, or pass some hints to a user space agent, like networkd
and have it handle the creation. We have precedent for "kernel side
bonding" with the VF<>virtio bonding thing.

> >I'm not sure you're right in that assumption, tho. At Meta, we support
> >container sizes ranging from few CPUs to multiple NUMA nodes. Each NUMA
> >node may have it's own NIC, and the orchestration needs to stitch and
> >un-stitch NICs depending on whether the cores were allocated to small
> >containers or a huge one.  
> 
> Yeah, but still, there is one physical port for NIC-numanode pair.

Well, today there is.

> Correct? Does the orchestration setup a bond on top of them or some other
> master device or let the container use them independently?

Just multi-nexthop routing and binding sockets to the netdev (with
some BPF magic, I think).

> >So it would be _easier_ to deal with multiple netdevs. Orchestration
> >layer already understands netdev <> NUMA mapping, it does not understand
> >multi-NUMA netdevs, and how to match up queues to nodes.
> >  
> >> 3) other subsystems like RDMA would benefit the same feature, so this
> >>    int not netdev specific in general.  
> >
> >Yes, looks RDMA-centric. RDMA being infamously bonding-challenged.  
> 
> Not really. It's just needed to consider all usecases, not only netdev.

All use cases or lowest common denominator, depends on priorities.

