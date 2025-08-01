Return-Path: <netdev+bounces-211331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E72B18077
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171D7584653
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 10:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3CF236457;
	Fri,  1 Aug 2025 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyg2FWDl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A346233D88
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754045680; cv=none; b=WW9O0N7MOU6wt8NPMIgERH4qNz2RJqnBpIxNbZxsRXxnQ8qacWiNElLBNA/6GmYfvXGcIBWdPFk9IY5QCrJmTYhy5n1PtANI8jSgvJHLjnjHxeYwFaSVFsf08RZTQkDa74l5vap5xPGQIuLHL3KIAVM4NoHXTnLzZGZJrvN5+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754045680; c=relaxed/simple;
	bh=YhdJ/lh1lCKEvPdzkfqidOEqCCxiu5UC0mYzu4SNJsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNi7V0xmVS/3EAfvPzNwrP+roLSeP7oqYgbG4JcMDeQvk5f1j6OoYRKMTZUA4/Sla4FwH6lG/mr2UoprxIIDzngOZkn0+hx6Zc7KKl7KuSlEVE6labQIZgHglgdDzQ5+2uwqkAVA3jILIeToX8qEV41je33LXRY62A2IEQJ7YjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyg2FWDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AA7C4CEE7;
	Fri,  1 Aug 2025 10:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754045675;
	bh=YhdJ/lh1lCKEvPdzkfqidOEqCCxiu5UC0mYzu4SNJsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyg2FWDl2O4iY3JDllnk2KepWIxNSCYpB3sl+Hl88rHq8+n8tIHdvFNGP/9h9DVwQ
	 sT/1ZrUGQwZ8yoUQU0eopcUt+mPoX//hy7+0bYzTnxpd6S+jIzbwxP4UnDmKVKS2M9
	 95WSW1B6xf3k7a5BMo6gtM3ehqgrl+ANmNV9W5eY196aespo0KMHz3Tam/1OrSEAp8
	 jmjRix2XB5msoeA/U7h1btPnPr3r/qKhjxDnwZy8NsehLa0bz0yjxwOloT3vc2SUbR
	 gZUGX+vSbVqkeEbBcm+O2SCxOqymAGH803e9Q0pwXIBz+w/ttM5/TNa3BYAehVl/eF
	 MqYxzIWX85+wA==
Date: Fri, 1 Aug 2025 11:54:30 +0100
From: Simon Horman <horms@kernel.org>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com
Subject: Re: [PATCH net-next] sfc: unfix not-a-typo in comment
Message-ID: <20250801105430.GM8494@horms.kernel.org>
References: <20250731144138.2637949-1-edward.cree@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731144138.2637949-1-edward.cree@amd.com>

On Thu, Jul 31, 2025 at 03:41:38PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Cited commit removed duplicated word 'fallback', but this was not a
>  typo and change altered the semantic meaning of the comment.
> Partially revert, using the phrase 'fallback of the fallback' to make
>  the meaning more clear to future readers so that they won't try to
>  change it again.
> 
> Fixes: fe09560f8241 ("net: Fix typos")
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

Thanks Edward,

And sorry for not noticing this in my review of the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>

