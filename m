Return-Path: <netdev+bounces-82864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B5F890059
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 14:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9B5291417
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 13:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AAE7FBCD;
	Thu, 28 Mar 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUiBmZ7N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4187EEFD;
	Thu, 28 Mar 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632921; cv=none; b=cqxFmMdz1Tv59mXLgS96V+/pcWTqSw1iiiE/H3ArkypQ3bA039DRM2xp08zu6G0y/ZOQy7sNB1OausB22Fm3wCinNobuTn1e0ZD0YuzYtry7e++us6JhnQR1t9ZN8U8w/n8O1e5RjhGv0vHCjTU633iSUp1Ox2sai6kezfI7lQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632921; c=relaxed/simple;
	bh=s1ojYS2+JRfTB7o0CPNS2JrePk4xJPutIw+z3Sz6OoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQ3QTV04aIrW4B5fqj/RaENYQH9mCDbnyvrbYa2oUjPo30CSJdVPqMpPHDwM4v1rMW/Q76vEb3D3/tzQooy/O0SnCPiSjrZ9VteUqPEfrWAhAGMz2AbYI+ynxbYJKeJzSk6KtNXlemJLo2pUxM4nOBl1DTGTlYAY6M3bqx7kvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUiBmZ7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DF7C433C7;
	Thu, 28 Mar 2024 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711632921;
	bh=s1ojYS2+JRfTB7o0CPNS2JrePk4xJPutIw+z3Sz6OoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUiBmZ7NYRHu+2sOls0diGtxc9BREMcXL/yC5Lp1hdbidgStU4UP7ulY/Wiz9szt8
	 9dL1hRyWxihk7TFA+/Gj7f4d8gHpZ5uq2qdsjJ6oYzSTT0wr/r6AX04RJjFHeO/Sfb
	 yq3aaha6pOqpMITwtGQhifRBPmeaoznheZLCZkLsiIiQ+4+ITxbc4vNTzN+fNSYfXg
	 t3UC6WpUR8IIrMb/iTWaF3nokUD6uOyWQllzXV25s2yKE/+lkn8G/Kc0pXvuziQddR
	 jt2YE8/qgqIMOh3n8igo9zJ0uIpYKvnYdlacqO/oBfiKSjhcWiXShM1mhZMipSMmtV
	 6+KhLW31mxQqQ==
Date: Thu, 28 Mar 2024 13:35:16 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jiri@nvidia.com
Subject: Re: [PATCH net-next 2/4] virtio_net: Remove command data from
 control_buf
Message-ID: <20240328133516.GK403975@kernel.org>
References: <20240325214912.323749-1-danielj@nvidia.com>
 <20240325214912.323749-3-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325214912.323749-3-danielj@nvidia.com>

On Mon, Mar 25, 2024 at 04:49:09PM -0500, Daniel Jurgens wrote:
> Allocate memory for the data when it's used. Ideally the could be on the
> stack, but we can't DMA stack memory. With this change only the header
> and status memory are shared between commands, which will allow using a
> tighter lock than RTNL.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

...

> @@ -3893,10 +3925,16 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  
>  static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
>  {
> +	u64 *_offloads __free(kfree) = NULL;
>  	struct scatterlist sg;
> -	vi->ctrl->offloads = cpu_to_virtio64(vi->vdev, offloads);
>  
> -	sg_init_one(&sg, &vi->ctrl->offloads, sizeof(vi->ctrl->offloads));
> +	_offloads = kzalloc(sizeof(*_offloads), GFP_KERNEL);
> +	if (!_offloads)
> +		return -ENOMEM;
> +
> +	*_offloads = cpu_to_virtio64(vi->vdev, offloads);

Hi Daniel,

There is a type mismatch between *_offloads and cpu_to_virtio64
which is flagged by Sparse as follows:

 .../virtio_net.c:3978:20: warning: incorrect type in assignment (different base types)
 .../virtio_net.c:3978:20:    expected unsigned long long [usertype]
 .../virtio_net.c:3978:20:    got restricted __virtio64

I think this can be addressed by changing the type of *_offloads to
__virtio64 *.

> +
> +	sg_init_one(&sg, _offloads, sizeof(*_offloads));
>  
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
>  				  VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET, &sg)) {
> -- 
> 2.42.0
> 
> 

