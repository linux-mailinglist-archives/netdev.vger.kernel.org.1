Return-Path: <netdev+bounces-92982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85CB8B97E3
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 11:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FC51C2302E
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 09:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3222D56459;
	Thu,  2 May 2024 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTXtqf5e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF9A56457
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642654; cv=none; b=lfP46zy4ry+GNNyvVIw3IaexAPUx2CFv0nNRKlyVQOnCnkNPPuI3aHNRNzcz3sf48lcYzrjj/rmNfNsZuscfLyXSyAaCTPRk1eZZhc27vNoCEhvo9bq6BA7EMxE6AT0FjuI1M01bjgWklh8NlXUI+LN1jX/AAOhuAT37w+rSb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642654; c=relaxed/simple;
	bh=ogXqEfvOUAsshk8BXgnHZO89kIVI3jmM/KizswVY4PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQXq33tKtxk0D9Hi+V1TzpsXlioFCyWqtMQfq3XI54jlLGB1kr5kFsAyIdNDfe03u8B/VhtqhhJg7U+jzlVqq4LYTPw7rtRmLMrWYf2lB0HB0wBxVzPhRUA2CpAH74BlhFvw7vNmFF4TqGQGfNIk3CKmv34kjmWHpH0KjITQ20s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTXtqf5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07DBC116B1;
	Thu,  2 May 2024 09:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642653;
	bh=ogXqEfvOUAsshk8BXgnHZO89kIVI3jmM/KizswVY4PY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jTXtqf5edOasdD96ANiW+G1YlJqJHWCpuaPNr75PwBVPpRtb2uomiyqMeBhXt778p
	 60pj+6FRNHlZKk8BqUs0p7t7CaNjINTPXMY37uup/kEU5rcgtkCh1wYMIfqYnHnZQL
	 8TV/DQiT+21qm461DJZO6XBSxhMQt7SGJdhDYD2ArbCEdFl1/7qRw0a4VezdFi+T/M
	 u2qgG46qdc3sYglJty92/q6piP1ZFCi+CqRJs9xDCQsj6obi3E8aPhl8sUlKd7QZYs
	 TmoI9hZP5jsQeIZWVq7+Et2dMeas13Ex30i7GZUdnr+03KDMXNZT/z3JaBYKbdD1/j
	 27kPHxJT8cLqw==
Date: Thu, 2 May 2024 10:37:27 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com,
	Edwin Peer <edwin.peer@broadcom.com>
Subject: Re: [PATCH net-next v2 1/6] bnxt_en: share NQ ring sw_stats memory
 with subrings
Message-ID: <20240502093727.GE2821784@kernel.org>
References: <20240501003056.100607-1-michael.chan@broadcom.com>
 <20240501003056.100607-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501003056.100607-2-michael.chan@broadcom.com>

On Tue, Apr 30, 2024 at 05:30:51PM -0700, Michael Chan wrote:
> From: Edwin Peer <edwin.peer@broadcom.com>
> 
> On P5_PLUS chips and later, the NQ rings have subrings for RX and TX
> completions respectively. These subrings are passed to the poll
> function instead of the base NQ, but each ring carries its own
> copy of the software ring statistics.
> 
> For stats to be conveniently accessible in __bnxt_poll_work(), the
> statistics memory should either be shared between the NQ and its
> subrings or the subrings need to be included in the ethtool stats
> aggregation logic. This patch opts for the former, because it's more
> efficient and less confusing having the software statistics for a
> ring exist in a single place.
> 
> Before this patch, the counter will not be displayed if the "wrong"
> cpr->sw_stats was used to increment a counter.
> 
> Link: https://lore.kernel.org/netdev/CACKFLikEhVAJA+osD7UjQNotdGte+fth7zOy7yDdLkTyFk9Pyw@mail.gmail.com/
> Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>



