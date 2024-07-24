Return-Path: <netdev+bounces-112835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C970193B738
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 21:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFB728585B
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 19:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A056F161915;
	Wed, 24 Jul 2024 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbyDURut"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FF652F6F;
	Wed, 24 Jul 2024 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848339; cv=none; b=nJNTtIAa0MgbH40OgJUxBf3NGmiZc265dgYtiL0hPM95QSMWeETbO1Il8e/sUHgW1DrdQmj/4nNyakqTX1tyx/1/R1z3dQpOk5Mrqwg8xUfCg/IvZXhNVwrZe7mGtAsxAZngdvf/8N9r/L0jmRyM4TCAvVYpVR2p301NGOiX/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848339; c=relaxed/simple;
	bh=qskHKITXkXN6ZSf1yUvLt2Gm1+dd/1MmkpCdaXVlEYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+Sbli4UxJ+siP/ucch5w3MKm9X4odK+4TSCE1q6apEF0lf+BR1CQBBbC3woNNkjoPvPwW2U7LzMZALCoBuN5CnvBtIJWDU0sAuxF/ZQ4Wy0RDFGbriKSTc/LO+V2Lwf7F8ZdV+voHZ+AUTKMqx9UxOPdquz+qLcXLbJ23eWst8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbyDURut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8888BC32781;
	Wed, 24 Jul 2024 19:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721848339;
	bh=qskHKITXkXN6ZSf1yUvLt2Gm1+dd/1MmkpCdaXVlEYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MbyDURutnAMJwHUXyBBs2ZSiwhsipHdOxle+g4JrqX+8AaeQ/xaaeRvQUSYXRPvfH
	 +6abebMoRD5DKfCniwnraH6cRpc4QUHeVFCFD/ZPcUDCiIHrRoOzYcaRiUXoWoe48d
	 DizUCF6hxzEfAXjgyvg7ZlpWR7zEn+SieQUrS7vdgJm9dTWzVTC4cRxEHbjpbkwhSb
	 S7hk1PqcWDYLtRKuFw2Ej7KExJE0IVNkL1UmQWL4lo6jMFu5QwEEDOkLhHMsNT7Lzb
	 hCoDJ9wAQSy61GkDWFsopBOkzsWubEU5et1UoDjoNNN06llEj8VbPzSP+Uj3briA+8
	 O17pwAPL2LnBQ==
Date: Wed, 24 Jul 2024 20:12:15 +0100
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kennetkl@ifi.uio.no
Subject: Re: [PATCH] net/tcp: Expand goo.gl link
Message-ID: <20240724191215.GJ97837@kernel.org>
References: <20240724172508.73466-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724172508.73466-1-linux@treblig.org>

On Wed, Jul 24, 2024 at 06:25:08PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The goo.gl URL shortener is deprecated and is due to stop
> expanding existing links in 2025.
> 
> Expand the link in Kconfig.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Both the motivation and updated link look correct to me.
I also checked that there is no other usage of goo.gl in this file.

Not sure if this should be for net or net-next.
But regardless this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

