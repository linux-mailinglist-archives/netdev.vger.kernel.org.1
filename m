Return-Path: <netdev+bounces-180384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 140F0A812AF
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8791B86D50
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288B422F150;
	Tue,  8 Apr 2025 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzYc/TdO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0456C22D4C6
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130550; cv=none; b=Ea6Qus3IOUD6ty+R1cYE+kc6jgXM24XbHcpSZIU+wa8dUBtCNT+056o9P8hKKtK8UxlAWatKzZ3vfZZeNFdDY/17gW7XTW7+tXrU8WwtHlHYlgd9EJT5iW5nLtT3vdo9WXR8z05wYVpvf87Xs0eXYY7n5vK7ZR7xE0MPCCnQyQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130550; c=relaxed/simple;
	bh=1HB1F8QkNSUIiuIotUXEJ7L1j22CmYtXoIAfE7FCT9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfV5P0pb7vSz3OEaOpuEf6citUcknujgv59FRFUgGVxV312Mz0GQxOVJjgIMdIzOzGvmER8RtykLYH/+h47haDFy1hKeGNX9k/3KA8ipikN3V18p26939vLC/O3ihBzpS5hBGKqnPWkqyw8ENJeTroG8eur9hQWcievDCckwVGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzYc/TdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F662C4CEE5;
	Tue,  8 Apr 2025 16:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744130549;
	bh=1HB1F8QkNSUIiuIotUXEJ7L1j22CmYtXoIAfE7FCT9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UzYc/TdOJmrzA5R3BNkuNWMV8OZu7h6dYg8O4gUZDSsmM5nI7eNIhBsy5HLJE4xaN
	 KsNeYR/vgN9wUXdRex/bhiwFW/blJJFWEYKuOa8RixPajbCcM3py5jqI/XIyvkd/OT
	 gcXlHN2qBiuX0UMIEU6FNVMojpA5uwQe9xxR5oqNvLWQOFd1vPB1F3nKpny4AScAlG
	 9e0WMc51O3ub/BePFUXG+fJq+E5hjtfecSEbNiWp+QK5536bGks8vAB7SIps+qqqDX
	 TMlLS7hGbxeLz9ApFOfV0Z62VdrW25Mpkk7zGTFr1ia9MG/EGYfyuoGd5CzGpI7tzc
	 juqeBNHH3sT5A==
Date: Tue, 8 Apr 2025 17:42:24 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, suhui@nfschina.com, sanman.p211993@gmail.com,
	vadim.fedorenko@linux.dev, kalesh-anakkur.purayil@broadcom.com,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 3/5] eth: fbnic: add coverage for RXB stats
Message-ID: <20250408164224.GC395307@horms.kernel.org>
References: <20250407172151.3802893-1-mohsin.bashr@gmail.com>
 <20250407172151.3802893-4-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407172151.3802893-4-mohsin.bashr@gmail.com>

On Mon, Apr 07, 2025 at 10:21:49AM -0700, Mohsin Bashir wrote:
> This patch provides coverage to the RXB (RX Buffer) stats. RXB stats
> are divided into 3 sections: RXB enqueue, RXB FIFO, and RXB dequeue
> stats.
> 
> The RXB enqueue/dequeue stats are indexed from 0-3 and cater for the
> input/output counters whereas, the RXB fifo stats are indexed from 0-7.
> 
> The RXB also supports pause frame stats counters which we are leaving
> for a later patch.
> 
> ethtool -S eth0 | grep rxb
>      rxb_integrity_err0: 0
>      rxb_mac_err0: 0
>      rxb_parser_err0: 0
>      rxb_frm_err0: 0
>      rxb_drbo0_frames: 1433543
>      rxb_drbo0_bytes: 775949081
>      ---
>      ---
>      rxb_intf3_frames: 1195711
>      rxb_intf3_bytes: 739650210
>      rxb_pbuf3_frames: 1195711
>      rxb_pbuf3_bytes: 765948092
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


