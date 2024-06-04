Return-Path: <netdev+bounces-100705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948298FB9C9
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 19:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DFD281F8B
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511C1146A7A;
	Tue,  4 Jun 2024 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByN3WWcp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4F42AF16
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520642; cv=none; b=bvzYMMaRag+u2sg5+SM8tIVd/FxPnDsDytAXVNNhcVCI/FNnS57XnfmdZ7eoE6xLAurTZyg+P5Q5hyJ4spzWljLB+t+o31MKxQIe6o7FT3Iw+fwO0ZZmUP952fkDhnf5WhriwPsJC7MToCQDJ0C3jiIPprygZSJiLlGqIHMbs+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520642; c=relaxed/simple;
	bh=wuLcJEDBcJsZ3NaLcPDL3HcDMXAbQYto+i/8CFtwcog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWRpF/ok/8ytuNtxOlnMv95zNKdoiBiQ6z1cXQY2uY7nNVQ+npUuiTovcYhnd+Y3oMAJ/5+G0f2M7to3XDMfJUCCpg28wQcGeXPQVFl6m/yLUErPbXyfjV6XqWAGOiHRNnFCw/LcsIVDVfjtipNtvABjhBWgF/cwBleM2WnLKjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByN3WWcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE674C2BBFC;
	Tue,  4 Jun 2024 17:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717520641;
	bh=wuLcJEDBcJsZ3NaLcPDL3HcDMXAbQYto+i/8CFtwcog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ByN3WWcpMotwrLU6VexuORAXzspGOfqqLJhRRUgTP/ysDG68E+5lcISRZF+m7uv4q
	 zHQi8xt1+7WJFwcoZcf4E933p2SgEDwrWvPsJF0oeIbMHBA9lmQLLehuZYEZqUFCX1
	 c3YMVSOLygUv3QXV9itH6eftmDMWrQ2DRPHRbITB4FlaNOsJynrs03QF7pk/k3u2Ns
	 T1I948gEPD1BCpfrtI1f6MMXDOZ/W2M+JD4FhOqIrusrjvlKboYKvkg0/WzasB+LmA
	 4QwVV6BVKgJD0h5BgKaqYADGxKeKQbukdJiodLsTOfBtuj481AV9Rz+YaGFzlM0oBA
	 PH7RjOYhsbt3g==
Date: Tue, 4 Jun 2024 18:03:57 +0100
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, dsahern@kernel.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next] net: allow rps/rfs related configs to be
 switched
Message-ID: <20240604170357.GB791188@kernel.org>
References: <20240531164440.13292-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531164440.13292-1-kerneljasonxing@gmail.com>

On Sat, Jun 01, 2024 at 12:44:40AM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> After John Sperbeck reported a compile error if the CONFIG_RFS_ACCEL
> is off, I found that I cannot easily enable/disable the config
> because of lack of the prompt when using 'make menuconfig'. Therefore,
> I decided to change rps/rfc related configs altogether.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Hi Jason,

FWIIW, I think it would be appropriate to also add help text for each option.
And I would drop "Enable", modeling Kdoc on, f.e. CONFIG_CGROUP_NET_CLASSID.

Likewise for CONFIG_BQL, although that isn't strictly related to this
patch.

...

