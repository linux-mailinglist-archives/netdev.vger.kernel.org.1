Return-Path: <netdev+bounces-136904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 026ED9A3945
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1711F21813
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 08:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0C518E025;
	Fri, 18 Oct 2024 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBUEUgPR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DEE17DE36
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241781; cv=none; b=fxcXdVyBEncY5Ugafr5Dm27X7O7Mm32Xdp6yOwVHO8L91SjfVrt+0gmh0E8ije3PDPcIMoA89V93dPyq6FwwrJX4Dwc7z4aelauOXrmeJ4mMOeSYHPlv4wLNRldegKEJwZs2RqI5LYXdjaRJ/S+Rb276zIcx3b6Q0D491obPnPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241781; c=relaxed/simple;
	bh=l4GhfVAYJpyscuevUxdrW5HUqHQC3xrmU65eic+tjaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxCuWyOShAKGVQTgGcpAa+3Y8gYC3h8QAnsnokV+yZwJjp6MIr7qJNivJVsNd2gi0/9G0looRiNOcr7aHKseQMrcV906eQ91hXn8FiLJSTZf7doeM40VB28c1rHFzqWhSVqsvnzDmBqB79BZtd6X1i0jff+KDG2C4k8r9VtzpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBUEUgPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D126C4CEC3;
	Fri, 18 Oct 2024 08:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729241781;
	bh=l4GhfVAYJpyscuevUxdrW5HUqHQC3xrmU65eic+tjaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBUEUgPRWm30vea+CNPZHvCABQ9oWgl3uiSfd8QaoiVxOkCNgARIOiqaKgRxI+hVT
	 XjxUcd9MNHth1m330nrpjINuYTv2h53gwUmL6AUFDUjDXJsmWGK/lQSuy52Xk1DNlc
	 XHBFovCoeZo5fXmClcIUD2S/cpOx8Yl8iR+mz9yw1z9xhweuyXJsaRnIwvegEAO05L
	 fHCBWsSrctcYbHDm1x2aNZca4vb8022aVxD4lROcqW3UffGud1liG/STJs4WYQHq5h
	 y5pXwWBr0xmXYI9iDJy2eAPotik0Mm/XF6Vkh6h8g6NJFEMOODtQs5h9R59MGPXJg1
	 NCJk8rr/3msyQ==
Date: Fri, 18 Oct 2024 09:56:17 +0100
From: Simon Horman <horms@kernel.org>
To: Ales Nezbeda <anezbeda@redhat.com>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, kuba@kernel.org
Subject: Re: [PATCH net-next v2] netdevsim: macsec: pad u64 to correct length
 in logs
Message-ID: <20241018085617.GB1697@kernel.org>
References: <20241017131933.136971-1-anezbeda@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017131933.136971-1-anezbeda@redhat.com>

On Thu, Oct 17, 2024 at 03:19:33PM +0200, Ales Nezbeda wrote:
> Commit 02b34d03a24b ("netdevsim: add dummy macsec offload") pads u64
> number to 8 characters using "%08llx" format specifier.
> 
> Changing format specifier to "%016llx" ensures that no matter the value
> the representation of number in log is always the same length.
> 
> Before this patch, entry in log for value '1' would say:
>     removing SecY with SCI 00000001 at index 2
> After this patch is applied, entry in log will say:
>     removing SecY with SCI 0000000000000001 at index 2
> 
> Signed-off-by: Ales Nezbeda <anezbeda@redhat.com>
> ---
> v2
>   - Remove fixes tag and post against net-next
>   - v1 ref: https://lore.kernel.org/netdev/20241015110943.94217-1-anezbeda@redhat.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


