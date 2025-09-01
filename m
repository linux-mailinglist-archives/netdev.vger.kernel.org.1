Return-Path: <netdev+bounces-218930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57809B3F070
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD9D2C0EEA
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8D4277CBD;
	Mon,  1 Sep 2025 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6QI0SEQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF616274B2B;
	Mon,  1 Sep 2025 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761567; cv=none; b=OaDp38/FqCRxvUoQpdlfm48qCqI67+5ERDED43VLVAvqcUi39wf1dKWhvjQiYxXZSy9hJZeDDnVBFygUjr4YhNgncgso4UyMNu9RGgLhzwXSycHw8R0K/F6yqzw/495CnTP3O8nexrwNLIGq1SB26CRF38ht249n2IcJNfCi9tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761567; c=relaxed/simple;
	bh=LaSjrQUOcuQP3HQ5GOXMHuEWBSR6i4CG1kwtsdlauRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9ZYlzpD/4ULBvVHDObt2bT0QG7EQxBOphRgSyrDLbxHRNkXfO0sIwidkOunPosnyVRCNPa1Y/Dh8xXUYCMxBe8VxarLKDCg6XP0UzzuAfOhNlWyFD4UvfE4AJIoXnwwhPS9796nY2O22L8ub4CLPQ4mtaI+N5cd5uFXjqHZ1SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6QI0SEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9B6C4CEF0;
	Mon,  1 Sep 2025 21:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756761567;
	bh=LaSjrQUOcuQP3HQ5GOXMHuEWBSR6i4CG1kwtsdlauRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M6QI0SEQBoxMN2wj5uasSNpjSq7tTNJ1MvL7+1vcb0qiQdEyr/SBzpvhoed7fmmW2
	 ACX+BdpkUsH1jCGIpfJ4maL3wEzbSpSqUt8Fq2LWpGI1AbzCmoN5H5jGtaBkrdv31A
	 sXRRZw/6K9R+QWYwu+B1+WLQACvNPU8SNOahyKKI5x4+fi76uey7703pv2lpN6duwJ
	 kvHr5RE5xdfA8y+QrtQcemkoWCenrHouf5xnKpszZ58+X1eccE1Mdp3YhVadyovqN1
	 76LpFDKkM5ikfgzz4l+3u5FKY7OxmRdngREx8hozWKBcpZvQUlGzroBXQ6o3I8qhjy
	 T0UgH8RaCnfJg==
Date: Mon, 1 Sep 2025 14:19:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, Vikas Gupta
 <vikas.gupta@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>
Subject: Re: [v5, net-next 1/9] bng_en: Add initial support for RX and TX
 rings
Message-ID: <20250901141925.2a14de07@kernel.org>
In-Reply-To: <20250828184547.242496-2-bhargava.marreddy@broadcom.com>
References: <20250828184547.242496-1-bhargava.marreddy@broadcom.com>
	<20250828184547.242496-2-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 18:45:39 +0000 Bhargava Marreddy wrote:
> +	bn->tx_ring_map = kcalloc(bd->tx_nr_rings, sizeof(u16),
> +				  GFP_KERNEL);
> +
> +	if (!bn->tx_ring_map)
> +		goto err_free_core;

nit: unnecessary empty line between function call and its error check

