Return-Path: <netdev+bounces-201292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E26AE8C9D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511A81894395
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF672D5C8B;
	Wed, 25 Jun 2025 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1Di+KYC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47548634A;
	Wed, 25 Jun 2025 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876632; cv=none; b=YvwHISJKTHw7xvwwKRvD/vMgC1yRFXAo9FdNT6muLtG2Gqhue1HbvKHgAVodbe+Y171m7jDfOFyjtc6t08TJak7EKzNjTiL8Hyz88xMjyb3J9/8b1APYU8iYm23+Or2W6MxLJ29e2QqcAR1N5+tOkPrqC/ZBIyPFy539HFePXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876632; c=relaxed/simple;
	bh=RthnF4fFeRyk9Gmg9wEI8C/dlSVpbxQt34w1wuFERRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYCKFOrC6BAFibJCjdhwfIrsra0fRWkSnC3r8u9qvD18VtP0r2b6yBN34OuflchRa9M6qOrWoLlQcxB9HGMUICX9ZIg2vz1SAacEBFWxpX0oGm2Davl6KxaEzMZ1VtpO132c7dC+US5Re54BSIqNCkMIk1X4VMUORuE3sc60/rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1Di+KYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA82AC4CEEE;
	Wed, 25 Jun 2025 18:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750876632;
	bh=RthnF4fFeRyk9Gmg9wEI8C/dlSVpbxQt34w1wuFERRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1Di+KYCjMGRzpFYKJprImcSUKNR0fL79BQVpBCRe6YbPAxIMlbxa04dbrOBaocQ5
	 jOJVQGjzc9bLxptC9DSNe8RqHr/ZPp+Bf+i+Ygq3FCiY5wYdiok2n6LE1nJX4h/zk2
	 Ho95+aLj1UNGlSc378i4m3332AXDoCxuPv8TRgmNhhhmIPWWGis3/4DWoVbNHPWTZ8
	 ljKNhDzXNsk88fbs7MU0JPnkeAZ0RY13D2eTPbnhZbDdK2kHoRleEBxZssOhPdW9/t
	 qcDe1wdTz3/CCH9dUaWSw4FEPXfVzg+V/VeAmd5ADvfZM7IdaocaVmrDKZXMZPS2Vk
	 Ve+DrzXR8FrvA==
Date: Wed, 25 Jun 2025 19:37:08 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: Remove unused function
 first_net_device_rcu()
Message-ID: <20250625183708.GL1562@horms.kernel.org>
References: <20250625102155.483570-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625102155.483570-1-yuehaibing@huawei.com>

On Wed, Jun 25, 2025 at 06:21:55PM +0800, Yue Haibing wrote:
> This is unused since commit f04565ddf52e ("dev: use name hash for
> dev_seq_ops")
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


