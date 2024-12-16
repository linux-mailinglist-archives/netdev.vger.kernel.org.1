Return-Path: <netdev+bounces-152306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C7F9F35A8
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5ECB188CD5E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0D6204563;
	Mon, 16 Dec 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcYbxc4r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB014D6EB;
	Mon, 16 Dec 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365645; cv=none; b=N9zC0PFvbmYuZ8igPrbAPg6rBWdeMLehq7bhV+ySYrUN2xtAYETPBYv6nDSkMaCSmxDGR5r19g/uIN058OrBt5M5ffq2SKLwjld8j+Kg/UCpuRzeeUciNXAV4i4ca4ZnDqoxkFnHxb0vh21RALRayTASl4y+9DxpYsnLWM/Y1WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365645; c=relaxed/simple;
	bh=cSJ22Debhf9nuQXNk7DVXyxrXy76QvlwtjrA0/hy5ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1BdkYfYip4YFT5GbGFLSKuVq6p6up2nXKJjpzCsVT2bUYl89JjKO9GCDnV3/vGmVKUFQAoDkd3f2VrgLDwgrU6WMhpOdF2ioo6uFS4FdepIVB6eB9QSyslWPV0A9SeCUaWdPeLPrCNmy1Zx5sA4b5IM0TOmFqMUHfNQ4TXNeq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcYbxc4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CACC4CED4;
	Mon, 16 Dec 2024 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734365645;
	bh=cSJ22Debhf9nuQXNk7DVXyxrXy76QvlwtjrA0/hy5ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pcYbxc4rK+heeLnv8W1+ynvmGxAs4yr62bEfB0OVgC3zJX0EA0GLVZ0x6ygRowaNg
	 umuv5l05LukmAKylAleoYPL/Tw5TBQ4dVDrYBq8pOlN9EjKk3kZW+i955Qm9HvORoJ
	 nMrtLF1m6R7EfT95Y3HcQyu+DUw2hlyLksXkoQLXnEJdn/MAkyi0MSAW+QTqO2PBHe
	 pJJPcXirwGRTC5co920pr+fllSThQUwkwx646MufMVUHgZZ0+s9A5QyNF4QASCDk52
	 KhCSF9CanHa+vrjpEK/ls/0AWx+oTb1Z5N7hqWQ3QzqZOn+odXx+34dmxijHoxUYgu
	 SIjeBXsA9mphw==
Date: Mon, 16 Dec 2024 16:14:01 +0000
From: Simon Horman <horms@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: jes@trained-monkey.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] hippi: Remove unused hippi_neigh_setup_dev
Message-ID: <20241216161401.GG780307@kernel.org>
References: <20241215022618.181756-1-linux@treblig.org>
 <Z14-sYvgzEPZSTyR@gallifrey>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z14-sYvgzEPZSTyR@gallifrey>

On Sun, Dec 15, 2024 at 02:28:01AM +0000, Dr. David Alan Gilbert wrote:
> Note the hippi list address bounces:
> 
> <linux-hippi@sunsite.dk>:
> Sorry, no mailbox here by that name. (#5.1.1)

I suggest submitting a patch to MAINTAINERS to drop the that ML from there.
In general, patches for MAINTAINERS can be targeted at net.

