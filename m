Return-Path: <netdev+bounces-136480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E20A29A1EC3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F34B1C2033F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D384D1D9664;
	Thu, 17 Oct 2024 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dL/1hkfV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01461D95BE
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158382; cv=none; b=AUjNGJlMT61L9+KO13awJT2vSsmX+2qEdkBCKjFYrfBsezi8AZmBzXxCk3xcCusSJk4t7rgmbyXmBoQf/X7B+snSq1xhHqdN665F270//qm4cybDJW5edFRojlokQGOUxjOm9yqIXYxRwdEX5qj+oJAMGG3QgggRvAsGlkT5bQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158382; c=relaxed/simple;
	bh=/wuOGEEvNYquRC66hYVt0oRxhuEpdfr1+7xxF1GTnqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ15lCEsbOlbcSnP3lAUL4J/K+ncOROnzxmRAu5FAG7La9+R66JyOadafYNo0UQZFBJJiU6pVTxfqS+sXcyGkFpKntgcraY7mmKBaI6sqtqS1fGJHz2Un9+rvUkpyFCob8x9JtGyBREFgIaUKgHa35H4OeuF54qq5vAU3oKAWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dL/1hkfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFE6C4CEC7;
	Thu, 17 Oct 2024 09:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729158382;
	bh=/wuOGEEvNYquRC66hYVt0oRxhuEpdfr1+7xxF1GTnqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dL/1hkfVN+NhWJWq4AV53lWwhY8V+IAndQd/BOUyF2VPaEXIsqSQBpR5USlpAHRtc
	 yejEOSNCzegSxi1+MC/jnA2OuKBFrOlWtcFjGXkTLDBMlqtjMTqvcJfa+y8sCSz8mt
	 SCwnYnzpSQi7lO+SdQwQSkfdkIQSPEUg74Hp0X3uhB4mmshG68mrzBYd7HYcs5AQfu
	 o4AE0GuSiXy9DOkodxTJP2ABThzgBp50V5GtFx70VouPstB8XfbKLhctN0ejN0DaaZ
	 i+hgr6GjeTmZ3ZZNCPld3Zdrj5lT3olBTaDMgPCNLQm9q3Pxs9OYJ5EQ+gh06aXYy+
	 NW1ORwBxR6saA==
Date: Thu, 17 Oct 2024 10:46:18 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jan Sokolowski <jan.sokolowski@intel.com>
Subject: Re: [PATCH iwl-next v9 2/7] ixgbe: Add support for E610 device
 capabilities detection
Message-ID: <20241017094618.GA1697@kernel.org>
References: <20241003141650.16524-1-piotr.kwapulinski@intel.com>
 <20241003141650.16524-3-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003141650.16524-3-piotr.kwapulinski@intel.com>

On Thu, Oct 03, 2024 at 04:16:45PM +0200, Piotr Kwapulinski wrote:
> Add low level support for E610 device capabilities detection. The
> capabilities are discovered via the Admin Command Interface. Discover the
> following capabilities:
> - function caps: vmdq, dcb, rss, rx/tx qs, msix, nvm, orom, reset
> - device caps: vsi, fdir, 1588
> - phy caps
> 
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


