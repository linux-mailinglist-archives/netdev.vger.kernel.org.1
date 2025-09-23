Return-Path: <netdev+bounces-225493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928D4B94BF3
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A5B16AC3B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 07:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E42311597;
	Tue, 23 Sep 2025 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+rOo2mS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F1D311595
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612137; cv=none; b=qVTHnxzIatAO6b46zZ5OBgINmT1CIM8wRT2Wm4cj/2JhSc5T5rPlVuNeXH+nZ7zJHcSyqakxeJLrlWCbsRvgZ4FKPby9n5w72hcL3zpLDdtx0GI6RjWK9nZUNRu7sUcNdSwYr/nXGZBiExz2G8Dygd2uunk18STwa7HFF58ybuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612137; c=relaxed/simple;
	bh=Igvh6RTX9kdcohiS64t4gY2ss2/x/aVZzic4ycTDbp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHpQ9jIfIdt/806NmqpF/uUhklFxSKEM6RQB4LMKjnXx/jdHYzFTvcapSpFZlJjHP0PddIWOdQkc7ulbh+jUvWKbOg2DHMmeWzCcDwUTkn2m/jiz+MXiUrmuc3skMAPpLMpZlDyYNt+w9JpXMGjFiXa0tqUC/SGvlLXSM2Hjbmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+rOo2mS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7AAC4CEF5;
	Tue, 23 Sep 2025 07:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758612137;
	bh=Igvh6RTX9kdcohiS64t4gY2ss2/x/aVZzic4ycTDbp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+rOo2mSSw0Lom3gIqM0QjFMM2nLHtB+vOpk1bZjvvBuq9LJp4Aw1ATUELYiFiRZi
	 8OqVE0iG8YuGyL8Opl4R+gQ/p2QaOwCQTZ2mYgjzywxb17sPufZKbraGqhjbnVYCBL
	 mvyzwQiSFKPBPY4uaFOuMPsuzuaENOVjiyktSMy94qALtVlLSYztNlkIvP63r7fQfF
	 IHMRlwlQAENbFQGGPUU0OeCI0MdLWYquSVpw22Um2rzTfTj711goilYPqDi/zCezrb
	 gmXe3yiW01IFvus94s72NbFtU5tuOVkRjufGiEzmpLNX1PhUxcCkOc43ugBu+G8vqV
	 /U2p5ujPrSe3g==
Date: Tue, 23 Sep 2025 08:22:13 +0100
From: Simon Horman <horms@kernel.org>
To: Jan Vaclav <jvaclav@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net/hsr: add protocol version to fill_info
 output
Message-ID: <20250923072213.GB836419@horms.kernel.org>
References: <20250922093743.1347351-3-jvaclav@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922093743.1347351-3-jvaclav@redhat.com>

On Mon, Sep 22, 2025 at 11:37:45AM +0200, Jan Vaclav wrote:
> Currently, it is possible to configure IFLA_HSR_VERSION, but
> there is no way to check in userspace what the currently
> configured HSR protocol version is.
> 
> Add it to the output of hsr_fill_info().
> 
> This info could then be used by e.g. ip(8), like so:
> $ ip -d link show hsr0
> 12: hsr0: <BROADCAST,MULTICAST> mtu ...
>     ...
>     hsr slave1 veth0 slave2 veth1 ... proto 0 version 1
> 
> Signed-off-by: Jan Vaclav <jvaclav@redhat.com>
> ---
> v2: Added an example to the commit message to show
>     how userspace programs could use this property.
> 
> v1: https://lore.kernel.org/netdev/20250918125337.111641-2-jvaclav@redhat.com/

Hi Jan,

thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

