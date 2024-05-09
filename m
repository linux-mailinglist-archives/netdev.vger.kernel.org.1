Return-Path: <netdev+bounces-94902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8498C0F79
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B455F1F2131B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B314B09E;
	Thu,  9 May 2024 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5rTTNG6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5635914B091
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715257032; cv=none; b=PjIc5fHxqe/GkkPaDZeUz7ZsnxEHh8hcnaRou8unc2ccB0TAeZ3LCHz3hvth9XAdZ5Czs8T0yDwWKh17LXpvv2k1/MPU8dzdyjbw37yKXjbo8astjLIn8AtooFo28xXkfxnl8V1JRz2Tep85FGABnVOjz8rTMlYfySU+MexWenc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715257032; c=relaxed/simple;
	bh=htPhXNncKpm0tYKNvYTzZz0fp1hlxKk6GMYghADLDOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFAEmBl4cH+jKeZc06cwf6GH4gbvAAfc8UY7HgfYsKqX2AtVLD35AXaIo7oprZ+ERm/3RT1zSZPvC+IjCRXOm3gXMnhPo5vVPu5JOXUsD2Uz6wi62tg3wbJDn2mjlooT2/QSzBwCprBeI8fUh6nGRiNE17hb/janNeJQu44i0UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5rTTNG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048ACC116B1;
	Thu,  9 May 2024 12:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715257031;
	bh=htPhXNncKpm0tYKNvYTzZz0fp1hlxKk6GMYghADLDOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5rTTNG6iNd5+wF1FZ4MG9uVn87GE2LUveFT8Sj+ZTKJW6WuHUFMeH4RPcHadNFe6
	 bUMGQ0VRXPTTN6gCIMM6C341JSM+AAoUz2/K6GL3xvuVvvX30h/rJc1Gpe9MFnkGdm
	 5zXpQCZi3HFcUWXKUtrELpX+glO54Olt4PksIA6LMltOIWEggVkREcV0QbH5A3qcQW
	 7wpf580JEpRSQBSXXL/XQfkU25AzhhRFK+lOSKXKQ0WweEvgx1mgXYZXs3jOhXUL71
	 dqfRN+1mpOBC4GAn7oMm+URypbCk1OmafRtEZjujCGrig02FddM2SbcCQ1UNPNlOv/
	 fJm/ffV8IYVgw==
Date: Thu, 9 May 2024 13:17:07 +0100
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, laforge@osmocom.org,
	pespin@sysmocom.de, osmith@sysmocom.de
Subject: Re: [PATCH net-next,v3 08/12] gtp: remove IPv4 and IPv6 header from
 context object
Message-ID: <20240509121707.GR1736038@kernel.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
 <20240506235251.3968262-9-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506235251.3968262-9-pablo@netfilter.org>

On Tue, May 07, 2024 at 01:52:47AM +0200, Pablo Neira Ayuso wrote:
> Based on the idea that ip_tunnel_get_dsfield() provides the tos field
> regardless the IP version, use either iph->tos or ipv6_get_dsfield().
> 
> This comes in preparation to support for IPv4-in-IPv6-GTP and
> IPv6-in-IPv4-GTP.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Simon Horman <horms@kernel.org>


