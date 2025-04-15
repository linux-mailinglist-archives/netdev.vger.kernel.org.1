Return-Path: <netdev+bounces-182870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DE0A8A34D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275E73B2805
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BF65789D;
	Tue, 15 Apr 2025 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQsvLDgA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A126296
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731983; cv=none; b=aiBKo5h5hd/C+Z3H2jedOyDLNvqbC4gf+uYMXEx9KGnZsKpJbhW+cM5dEmjyXfGcwYWW7GZOpba4B4zYS0QmA83P30RargbL/sSgYqW+77aWKhWyyTNunqpLlm70XEllrL7YkJdLoB2SArhd0lT1GkAinvLkMrZNK1PB1WxtBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731983; c=relaxed/simple;
	bh=/u9uWnKTxQrsHFPIYOsdVbzDhc5VucRx/+dJWztHkPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3EmcpN8G+m51DNFzz+O8qlxXnETIL4c3dr18HdCwLlEJ3ivGqXa0ENMp28SJv5gq7rBQ0wXW//eyDS+InLwItlM4Qcd4wyvRgdwROKUI3qh5xvRysKT4yWTeDOwf18WU5FGoeRL4wU8xU2R5H8Gsn2N7hK6NQO4Rdky6L4G55Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQsvLDgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53378C4CEEB;
	Tue, 15 Apr 2025 15:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744731983;
	bh=/u9uWnKTxQrsHFPIYOsdVbzDhc5VucRx/+dJWztHkPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQsvLDgAH+8EEWIB3AIU8Q0JLESuUgviyba+V7wdC2cKJn+bSLryltLUHkr3jrBVw
	 ouo1OAO9j0PcjefIQEi9YIU/C5CNbklbg72ByeupGcScPpNzidE1aGE1zSS55S+xoc
	 YC543+4GBzG3OwWHuK8iUzHodPR4xx/KjfwL97MxSZNzVhlKzciysGvXIF4Oj8Pvvn
	 GWnUoyf52mIdilPQ1QfUZctcZ8xiHK5glaItJQyYQPAlh4i4ui8Fx3nTpvR+HNVxGk
	 lAZGp+LmsQ3AKnZNkGZDZP6pV8JME+8lKowxPSZtbVbQKbTKsx/CtTW0LUtCZWlR7x
	 HgxdRTaWs281Q==
Date: Tue, 15 Apr 2025 16:46:20 +0100
From: Simon Horman <horms@kernel.org>
To: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Madhu Chititm <madhu.chittim@intel.com>
Subject: Re: [PATCH iwl-net] idpf: fix null-ptr-deref in idpf_features_check
Message-ID: <20250415154620.GY395307@horms.kernel.org>
References: <20250411160035.9155-1-pavan.kumar.linga@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411160035.9155-1-pavan.kumar.linga@intel.com>

On Fri, Apr 11, 2025 at 09:00:35AM -0700, Pavan Kumar Linga wrote:
> idpf_features_check is used to validate the TX packet. skb header
> length is compared with the hardware supported value received from
> the device control plane. The value is stored in the adapter structure
> and to access it, vport pointer is used. During reset all the vports
> are released and the vport pointer that the netdev private structure
> points to is NULL.
> 
> To avoid null-ptr-deref, store the max header length value in netdev
> private structure. This also helps to cache the value and avoid
> accessing adapter pointer in hot path.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000068
> ...
> RIP: 0010:idpf_features_check+0x6d/0xe0 [idpf]
> Call Trace:
>  <TASK>
>  ? __die+0x23/0x70
>  ? page_fault_oops+0x154/0x520
>  ? exc_page_fault+0x76/0x190
>  ? asm_exc_page_fault+0x26/0x30
>  ? idpf_features_check+0x6d/0xe0 [idpf]
>  netif_skb_features+0x88/0x310
>  validate_xmit_skb+0x2a/0x2b0
>  validate_xmit_skb_list+0x4c/0x70
>  sch_direct_xmit+0x19d/0x3a0
>  __dev_queue_xmit+0xb74/0xe70
>  ...
> 
> Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
> Reviewed-by: Madhu Chititm <madhu.chittim@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


