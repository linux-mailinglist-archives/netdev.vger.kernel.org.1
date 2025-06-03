Return-Path: <netdev+bounces-194713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAACACC13C
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 09:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C9E3A3C76
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 07:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBFD2690C8;
	Tue,  3 Jun 2025 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQ/bmAU3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A637117A30B;
	Tue,  3 Jun 2025 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748936067; cv=none; b=OSAKJET9ikhX8Pz0H8oImJiy8rJjF58/i0lbCDovUKDWc7kpah/TaDdYOph3W2z3k8bdEFHZf7IcG2YJ65wi88dp6WmCYTj+KRO1NpiQh7QcJBU5cIlo6N/jfX86xiiWeGvKqc5PdOH2Yr25gyvQz/ibZrMGEpSm48KkW4tj3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748936067; c=relaxed/simple;
	bh=M60ItkNS6CkN2L+hERTegzxapFRD6j6tnT2kUl6gmi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SX/A+wvA86DYZq5n5GDs2hp2+4vVOJUa1sKaRtHrPMpyCdgOYBsdl8DLsdueIvDBKZyXJX/xvdYUCJ9gBT6Zcib2oNGgQvjZ8HUHM0LFEOhpR3KKm1LD5MQh32oI9AAO92lFHa+VXvLdSS96SJTW6H7l3sOfQM2EkYX/C/TBFGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQ/bmAU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C24C4CEEF;
	Tue,  3 Jun 2025 07:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748936067;
	bh=M60ItkNS6CkN2L+hERTegzxapFRD6j6tnT2kUl6gmi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQ/bmAU3Jx2Eng1iDwm5+ctRReKECf2qpsZN7nwKlVwohV12FxbUQn05+0JlsJYKC
	 FCWC7XPBYoKKcOykLhhimycjYAzIqk4OWyi2RcWizYHwtAjYENL2lbfI6oBSMQEqIV
	 0n1yNaVFDsoa6LsG5ovRwXy4JfP1W1IvVFJbNoFd7lveT7cUHh/4Usy+1xMt+JOfZZ
	 ddznlAFTZMGJz0lkAMpOrky4FnlZHyvwUi+mznEntyCVSt/dqmHFBX9+8Ytngt8l8i
	 BMDt3bT8o2y6JgktlLCNuBMMnen0tXKQ6/5rF/z08cVfFyHA9A3Cc7y6deesRLIxDg
	 2BeIZvjH24E9Q==
Date: Tue, 3 Jun 2025 08:34:23 +0100
From: Simon Horman <horms@kernel.org>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH RESEND v10 1/3] vhost: Add a new modparam to allow
 userspace select kthread
Message-ID: <20250603073423.GX1484967@horms.kernel.org>
References: <20250531095800.160043-1-lulu@redhat.com>
 <20250531095800.160043-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250531095800.160043-2-lulu@redhat.com>

On Sat, May 31, 2025 at 05:57:26PM +0800, Cindy Lu wrote:
> The vhost now uses vhost_task and workers as a child of the owner thread.
> While this aligns with containerization principles, it confuses some
> legacy userspace applications, therefore, we are reintroducing kthread
> API support.
> 
> Add a new module parameter to allow userspace to select behavior
> between using kthread and task.
> 
> By default, this parameter is set to true (task mode). This means the
> default behavior remains unchanged by this patch.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c |  5 +++++
>  drivers/vhost/vhost.h | 10 ++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3a5ebb973dba..240ba78b1e3f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -41,6 +41,10 @@ static int max_iotlb_entries = 2048;
>  module_param(max_iotlb_entries, int, 0444);
>  MODULE_PARM_DESC(max_iotlb_entries,
>  	"Maximum number of iotlb entries. (default: 2048)");
> +bool inherit_owner_default = true;

Hi Cindy,

I don't mean to block progress of this patchset.
But it looks like inherit_owner_default can be static.

Flagged by Sparse.

> +module_param(inherit_owner_default, bool, 0444);
> +MODULE_PARM_DESC(inherit_owner_default,
> +		 "Set task mode as the default(default: Y)");

...

