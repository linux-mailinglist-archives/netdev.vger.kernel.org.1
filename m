Return-Path: <netdev+bounces-84622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 672938979D0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E47C1B22998
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BCE155A25;
	Wed,  3 Apr 2024 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmGgUXU8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C969146018
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176529; cv=none; b=FMXYmcw3nKymPltT3ugsQdwcrhusKgFMTS4JbQ+llHo53dagWjviGrAh6N5y/5to7Q5pir+IB+l1dgeSvwB1EtNfw5biG/hxQCB9yB0dIr/rECWhONUkeetMJZgRhA402J5AINBQKghnQRjuAhFZFnv2UFvzUPjxk9y7Lw7E1bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176529; c=relaxed/simple;
	bh=+qORx5matsjqP5sTFy6Psrj5nLqFXic/oNqJWuGDQMw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l0tgXoXhWu1jIlBiGpYqE3CfNMk4JJQjKKNx11kwz8v3wccX/pBH0GOn9f+izSLuTyePZvH8YlDdUqIzJsH1eu0g3/gFEVg2w1uOOX0sEOpKYbFw081GS0C2OVIPJHET6johvq2+NunLqmokT88YUmtxuxXza64+6E/+Psy1xxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmGgUXU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2198C433F1;
	Wed,  3 Apr 2024 20:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712176529;
	bh=+qORx5matsjqP5sTFy6Psrj5nLqFXic/oNqJWuGDQMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JmGgUXU8DLPkIFK6G+k7yofrsD8WLwWxx8jLyigy7gt627QMzvfnpx7uF5ACfOmpw
	 M2d2J10gCu64mwNqlQK97GYj/+/sTZ8NFAsjkmcpyKXf42GS2llinho2ADMC2CCYIH
	 jfSvWlmacKiTBUB5mW8j+zT+zVPaUmssGW7vxtb6kyDvtpPNjCs6aiH8MzFeoO891O
	 eG9ZmvKLRneQMq753TQJRK1C68cRMoJKvY1Qk5b+gtyK0aiHFmwrWCQS5hvaMkQRx/
	 nupoEJnjCMJML1lq+dNjgd31ck+R9O+VcdbHjZZOMyftWBsb6/057V2ZHiME+MfWqZ
	 94f/8Nt2SMm9A==
Date: Wed, 3 Apr 2024 15:35:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 03/15] eth: fbnic: Allocate core device specific
 structures and devlink interface
Message-ID: <20240403203526.GA1887417@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171217491765.1598374.8648487319055615080.stgit@ahduyck-xeon-server.home.arpa>

On Wed, Apr 03, 2024 at 01:08:37PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> At the core of the fbnic device will be the devlink interface. This
> interface will eventually provide basic functionality in the event that
> there are any issues with the network interface.
> 
> Add support for allocating the MSI-X vectors and setting up the BAR
> mapping. With this we can start enabling various subsytems and start
> brining up additional interfaces such the AXI fabric and the firmware
> mailbox.

> +int fbnic_alloc_irqs(struct fbnic_dev *fbd)
> +{
> +	unsigned int wanted_irqs = FBNIC_NON_NAPI_VECTORS;
> +	struct pci_dev *pdev = to_pci_dev(fbd->dev);
> +	struct msix_entry *msix_entries;
> +	int i, num_irqs;
> +
> +	msix_entries = kcalloc(wanted_irqs, sizeof(*msix_entries), GFP_KERNEL);
> +	if (!msix_entries)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < wanted_irqs; i++)
> +		msix_entries[i].entry = i;
> +
> +	num_irqs = pci_enable_msix_range(pdev, msix_entries,
> +					 FBNIC_NON_NAPI_VECTORS + 1,
> +					 wanted_irqs);

FWIW, deprecated in favor of pci_alloc_irq_vectors().

> +	if (num_irqs < 0) {
> +		dev_err(fbd->dev, "Failed to allocate MSI-X entries\n");
> +		kfree(msix_entries);
> +		return num_irqs;
> +	}
> +
> +	if (num_irqs < wanted_irqs)
> +		dev_warn(fbd->dev, "Allocated %d IRQs, expected %d\n",
> +			 num_irqs, wanted_irqs);
> +
> +	fbd->msix_entries = msix_entries;
> +	fbd->num_irqs = num_irqs;
> +
> +	return 0;
> +}

