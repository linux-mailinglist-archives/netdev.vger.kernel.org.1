Return-Path: <netdev+bounces-104421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D085F90C776
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1651C22338
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF45153BF7;
	Tue, 18 Jun 2024 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhLRQKGJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FE51534E4;
	Tue, 18 Jun 2024 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700953; cv=none; b=GLH2y943yX8S8V3dpCMfs9F07JSlOf+mUt+cV5VOxMamp3WWTjjbdoqwLIK2aWnevpEP8DJDlV1tRSo2LF7Xo1vT9ptcXZN9IYUmbl9Tj8fX2yEn3QCNdrC9NfqN9UUjVsNQ/m3Z3GfKd/3rs7fgwpx+tZNL56YmT5W0zQ/aSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700953; c=relaxed/simple;
	bh=wdA3KxbH/9QRi6aGx06dfNEHr3+Gs5JGJu1NsVCUF0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7djbj4MWYtIVyBTlpo22KYnPRivsAIzbrOUFzVHep0ugQXECc8xSQqSirDgYS+HAcd60BvByI9207X0GNFiw7v/BL4HHYs7yjlADpsXqUm801/4mF6SYthV3Bz72yh3mKniLzGfyl9E4il1z3y0GFeToTIYPtgvxGal8sCFtrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhLRQKGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95452C4AF1A;
	Tue, 18 Jun 2024 08:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718700952;
	bh=wdA3KxbH/9QRi6aGx06dfNEHr3+Gs5JGJu1NsVCUF0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhLRQKGJibXj2Z0VShiCldKgKVUR2s3XNHkV5Bny9MrGfiRiWrlKc6//5P4PzvM65
	 hYYTJercHGSHHX1U3uei4hrwtAReTJs+fDaanywxGUeD2STqPT2Kl0kkbRz8kisC1m
	 CVIl9PRfmABo010yrLPvE0UwBj71etHdeObtudWDGmYj41c2AxlFdxbGeGTGnCnxF1
	 aPFNkhtTdrDiqttirLSbpQP8eIO+4j4c7n4fPAacptwzpd3eRK2ebljIxrDYj/BuAk
	 uGbznXGhTsjiHFrj8dzaMu3b1xmuCNpl6in+ylI0TdUr0hrE0HrYklWc1IrpAXSuQg
	 8FIHwV0D5qroA==
Date: Tue, 18 Jun 2024 09:55:48 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v5 09/10] octeontx2-pf: Add representors for sdp
 MAC
Message-ID: <20240618085548.GF8447@kernel.org>
References: <20240611162213.22213-1-gakula@marvell.com>
 <20240611162213.22213-10-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611162213.22213-10-gakula@marvell.com>

On Tue, Jun 11, 2024 at 09:52:12PM +0530, Geetha sowjanya wrote:
> Hardware supports different types of MACs eg RPM, SDP, LBK.
> Also, hardware doesn't have an internal switch. LBK is a
> loopback mac which punts egress pkts back to ingress pipeline.
> RPM and SDP MACs support ingress/egress pkt IO on interfaces with
> different set of capabilities like interface modes ranging from
> 10/100/1000BaseX to 100Gbps KR modes.
> 
> At the time of netdev driver registration PF will
> seek MAC related information from Admin function driver
> 'drivers/net/ethernet/marvell/octeontx2/af' and sets up ingress/egress
> queues etc such that pkt IO on the channels of these different MACs is
> possible. This patch add representors for SDP MAC.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c

...

> @@ -683,6 +684,15 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		snprintf(netdev->name, sizeof(netdev->name), "lbk%d", n);
>  	}
>  
> +	if (is_otx2_sdp_rep(vf->pdev)) {
> +		int n;
> +
> +		n = (vf->pcifunc >> RVU_PFVF_FUNC_SHIFT) & RVU_PFVF_FUNC_MASK;

nit: This seems to open-code FIELD_GET

> +		n -= 1;
> +		snprintf(netdev->name, sizeof(netdev->name), "sdp%d-%d",
> +			 pdev->bus->number, n);
> +	}
> +
>  	err = register_netdev(netdev);
>  	if (err) {
>  		dev_err(dev, "Failed to register netdevice\n");
> -- 
> 2.25.1
> 
> 

