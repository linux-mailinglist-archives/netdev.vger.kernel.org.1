Return-Path: <netdev+bounces-178539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA42FA777D4
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51578188F51F
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 09:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4772E1EDA2A;
	Tue,  1 Apr 2025 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCeV6Q+/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2358F1624D5
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500073; cv=none; b=Xbzc9yN/fq0i9p5jU1zaWCBgvmZx9Z/NgMzjjLsrLkKv2lZvxGkM7+1ejOGbjMukbPkojUxiJnojI9bQueYQsFNAqBxSj1k6J7w7WYEUVPcP5kH40Lomw6M8T8XPF8QM8XdFOzbVvJn6MD7B8F/92Bg2lhGZEzK1kucRKWe3m+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500073; c=relaxed/simple;
	bh=7lkAOLmurMCkLel+JEnAt0AfvmrS0keXEItR7INNDXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkANEFDqjz4OVGV1YFCO2nOYPOa1NWGEHCXFQJSXQUrTlSqBZQ+E4AtayTD2M83sjsQcPssKWKDWEA230G6to/Pegs1bGZPi9iRSaJin9uP8JXgfPGKp/whiQIVbiaXcdZMOfd0sNGoaWnKXo8UPWYuL+v5kcdIIPCurNEJlcyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCeV6Q+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD2EC4CEE4;
	Tue,  1 Apr 2025 09:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743500071;
	bh=7lkAOLmurMCkLel+JEnAt0AfvmrS0keXEItR7INNDXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tCeV6Q+/pvkhcx91PG1MjGJj26MDQSAzN5cUN18jYSX31tCdizbhkOdQUVKLQZeE7
	 Qocao8Czzn8TGft7RucqfYzeauAZx18r/0btTdO98PlUhxaVVfyPEXM0DskQPbNMml
	 EB/eo5sUh/OyMzJi0q3VPqBAlBm+lGndPYI4WUb6SgSmKUILXpAnCl11ryLNZDsJqG
	 wloIFVT+Vec7yd7goYUcENJGEy7PhnWECr2QEa0PtN3w+I9jWedofCq7OmjkZ81xbx
	 TWd6No/Ar0t5xZVx050FFRAaCWxjBK8dKFSLbho/6S7BQF7PblesHx41OWKrtv9N4y
	 wjPVPJ7sB00Hg==
Date: Tue, 1 Apr 2025 10:34:27 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Davide Caratti <dcaratti@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Fix ETS priomap validation
Message-ID: <20250401093427.GA214849@horms.kernel.org>
References: <20250331-airoha-ets-validate-priomap-v1-1-60a524488672@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331-airoha-ets-validate-priomap-v1-1-60a524488672@kernel.org>

On Mon, Mar 31, 2025 at 06:17:31PM +0200, Lorenzo Bianconi wrote:
> ETS Qdisc schedules SP bands in a priority order assigning band-0 the
> highest priority (band-0 > band-1 > .. > band-n) while EN7581 arranges
> SP bands in a priority order assigning band-7 the highest priority
> (band-7 > band-6, .. > band-n).
> Fix priomap check in airoha_qdma_set_tx_ets_sched routine in order to
> align ETS Qdisc and airoha_eth driver SP priority ordering.
> 
> Fixes: b56e4d660a96 ("net: airoha: Enforce ETS Qdisc priomap")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


