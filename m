Return-Path: <netdev+bounces-204643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0056EAFB8E6
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B604210E2
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 16:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0470E1FC109;
	Mon,  7 Jul 2025 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ch4g89cw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5782E370C;
	Mon,  7 Jul 2025 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906831; cv=none; b=Do4uOkI+z3ZBfyfnt+EgUR5dFe94SzwadMCE/qR9e+vwegybivrNDYmgxx7fON2DbspY4/I1Y5Hjjnmzm4LBvmx+oYKPalt157IPOpwrpHSj86X86IAV2bIcIQ4J+27tl1G5xJX3nmjaTOinK806oi1TkVVhg2B8OlzHbwtva/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906831; c=relaxed/simple;
	bh=jCpay9PdCtV2PyhEzIh+wlmenNd9TVrdouGArgklFaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIgc0JKOXhRduP1bvUqr5Rj4gtO49dBFdth0lzvkT/hIsBFU9GsTVUwqaQRK2ysFmT5tEybJ8+B3egGvM6Kon7Q6XhmUoEl35rV1UUr/E2JBeH4c974/8/M38S+iglPO9W/j53+JaQDw3gqD/rIYMQWF+TOxaG3AZIgnk4ZjjBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ch4g89cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F9BC4CEE3;
	Mon,  7 Jul 2025 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751906831;
	bh=jCpay9PdCtV2PyhEzIh+wlmenNd9TVrdouGArgklFaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ch4g89cw7DIzEVo2YG+jVYcUhSS45MxahdWLDYjWIJs0V4qEauI5TAufjR2C45No0
	 bTZJw7Ma1kL9zhW5ZSTY6zBE336di3mWuR6+zI948/mLMn9jIssVslFV6WGp9tDri0
	 BVWWgwhiKDtU2veq8FuUX0gBXsAdWSQCFB8B64xholM+WXHMrauPOdhS028vVB0ynf
	 MoDkToGREZX+4r0ULA2GgPub8qZ6/LDWhvv2TPzCutLv9SYeQ957ZkszwVTVKga2H+
	 MfqSPHOclQTrC22/k298J2h6ACxUcA4X1gk/PsLkeTBVrFif+EtJnWXfgE9GbkFBfZ
	 n/i5nFpXrjj8Q==
Date: Mon, 7 Jul 2025 17:47:07 +0100
From: Simon Horman <horms@kernel.org>
To: Faisal Bukhari <faisalbukhari523@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] netlink: spelling: fix appened -> appended in a
 comment
Message-ID: <20250707164707.GQ89747@horms.kernel.org>
References: <20250628104422.268139-1-faisalbukhari523@gmail.com>
 <20250705030841.353424-1-faisalbukhari523@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705030841.353424-1-faisalbukhari523@gmail.com>

On Sat, Jul 05, 2025 at 08:38:41AM +0530, Faisal Bukhari wrote:
> Fix spelling mistake in net/netlink/af_netlink.c
> appened -> appended
> 
> Signed-off-by: Faisal Bukhari <faisalbukhari523@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

I note that this file was code-spell clean both before
and after this change. So there is nothing "obvious" that
should also be changed while we are here.

