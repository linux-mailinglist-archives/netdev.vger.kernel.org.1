Return-Path: <netdev+bounces-268265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDE/I5tduGnXcgEAu9opvQ
	(envelope-from <netdev+bounces-268265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:44:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0001929FE34
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0807A30205C3
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD613ECBC6;
	Mon, 16 Mar 2026 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG434r53"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885DA3CD8BD;
	Mon, 16 Mar 2026 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690263; cv=none; b=oD3B+5E0BSCZduFuOD+zTF1u9oZGu6b+X5ZDVWuA/8xzG48lqWCfeOzIrVuLLHPF9NF6/KKLGNZhKr52UrPmAWv5ZhwIydUhVrdTkEjsBAiuWKYRdPDoGAlf+2pEos1nsxr5uCNdjTVD5fWeYAczhGMoOj1VKNvTHeVPCK46DpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690263; c=relaxed/simple;
	bh=K/9zQqWDOIZ02xhcKFxY3R1ays/fTGdkiB8VVp4het8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYYmZ7sdRlMl+lQqo9520Lnnd6JvpyRXsDOABO3wcS6ue+AXTyx7mT5KMkzsWyD9v01ruW2mbkoDhFtXWCSKVHkkKsO0f07DK0Gggs+7XGFjynmCbeYyufKKwQnRhAB2wRVktxxCQlj5LVF3cN5LKefSuqDM+J+HQ3TWdSqzoLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG434r53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED889C19421;
	Mon, 16 Mar 2026 19:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773690263;
	bh=K/9zQqWDOIZ02xhcKFxY3R1ays/fTGdkiB8VVp4het8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HG434r53eZ0OfE+KnXBfsox7a9jp2EnD4avLhhmU7BEyR3a0NavqY8O2Q4HMgjpSl
	 3Rbx4hHnepSvWKxRJwbmVxmevyx+RUCzgq6SaD0S2H6qErtIOeuVP1OasnpNUk6Lzs
	 RRQgbkBH0yn3MVs9roi5VKosMPTFhtWfIcShXy00wDdlKaCfnHhW4/wy69VWzhSxB5
	 btd0cQ81Iuee4KMixCbZpJ6NmLA8roZaKJoH8r76xThR/V8Gk8LjmNvInESREjJ8Yf
	 bGwKNYF9ufHYtpGXE6DJv942WPBdggMzUVf/BnRkxTtxv8I3Xb/WXGqwkTehyJ7z27
	 VrO0Q8Mspqq/A==
Date: Mon, 16 Mar 2026 21:44:19 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC net-next v2 00/12] Add TSO map-once DMA helpers and bnxt SW
 USO support
Message-ID: <20260316194419.GH61385@unreal>
References: <20260312223457.1999489-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312223457.1999489-1-joe@dama.to>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268265-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lwn.net:url]
X-Rspamd-Queue-Id: 0001929FE34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 03:34:37PM -0700, Joe Damato wrote:
> Greetings:
> 
> This series extends net/tso to add a data structure and some helpers allowing
> drivers to DMA map headers and packet payloads a single time. The helpers can
> then be used to reference slices of shared mapping for each segment. This
> helps to avoid the cost of repeated DMA mappings, especially on systems which
> use an IOMMU.

In modern kernels, it is done by using DMA IOVA API, see NVMe
driver/block layer for the most comprehensive example.

The pseudo code is:
 if (with_iommu)
    use dma_iova_link/dma_iova_unlink
 else
    use dma_map_phys()

https://lore.kernel.org/all/cover.1746424934.git.leon@kernel.org/
https://lore.kernel.org/all/20250623141259.76767-1-hch@lst.de/
https://lwn.net/Articles/997563/

Thanks

