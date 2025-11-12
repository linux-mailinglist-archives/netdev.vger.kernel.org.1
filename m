Return-Path: <netdev+bounces-238071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9214C53AC5
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 18:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA82034470D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 17:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472283446C5;
	Wed, 12 Nov 2025 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmZ4CePu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53934252B;
	Wed, 12 Nov 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968195; cv=none; b=G53PsimXwinHQiqu2+augFWBLAO5/o6L4qpPueLP5A7hWNPwDJgFwrKTA9AHqmugXzlXEPNF31s4hYYNqM7j76NKzHzUMh+sbi9/68TPPuarLU9/4ubeYacJWV7REkfz8rg1uFzLHzzpmLvvBo6JHYAOC6Im1+UYPYpbcs0Ze7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968195; c=relaxed/simple;
	bh=DQokmYTmssHAQAv2cUEKyYA7eBDMOahLhFMYAyYRp5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMigzE9qkMjLa9t0t0OyR+MeHwNKGGSwSTYvX67ctzXsjL8cRewzw412EJfbe4jZ0wyll69WDfEn9IRHnDPJREz8M2Vjj1UHIQMIlGmA4h2YqCQ4ijvZJXIhV03LObihHLpWNR/PgGY/3NUigMTTjesHmB30o3wDRAq9Fj0goO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmZ4CePu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288FAC4CEF7;
	Wed, 12 Nov 2025 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762968194;
	bh=DQokmYTmssHAQAv2cUEKyYA7eBDMOahLhFMYAyYRp5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tmZ4CePu/LKx4wlkJFq6OLjlSiCYSLP13El6gNPLsHkv0DVMe1uX4TnLg6rnDk43Z
	 D9KO9kCjeDR3/OtEBcr33m5OsZC+nBzCP8IJkw+sjjL1mjEzsboQG6u+LoLHwKSRZf
	 gQ4lfefYy5u4Sadm6bKqdDx8CGmJ3hw6DWvdiP3wuj3elCcbhUNP0fa8hs4btoF5/X
	 TpoLcnhS65mP6SUyaWsnQE3r0QcMf9omNOkOLAnF1T9RYgBih9iDj0PLt/1r7N0Yn3
	 OilQjnX5tWv3XmmBMnZ7pCj9cg+pIYWTxgCt4hGYoSOLTT7ptDFDWZefP4vIoxlM15
	 CM5H30hqJVv9w==
Date: Wed, 12 Nov 2025 09:23:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>
Subject: Re: [net-next 06/12] bng_en: Add support to handle AGG events
Message-ID: <20251112092313.1b48c06d@kernel.org>
In-Reply-To: <20251111205829.97579-7-bhargava.marreddy@broadcom.com>
References: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
	<20251111205829.97579-7-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 02:27:56 +0530 Bhargava Marreddy wrote:
> +inline int bnge_alloc_rx_page(struct bnge_net *bn,
> +			      struct bnge_rx_ring_info *rxr,
> +			      u16 prod, gfp_t gfp);

drivers/net/ethernet/broadcom/bnge/bnge_netdev.h:524:34: error: marked inline, but without a definition

