Return-Path: <netdev+bounces-208451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C178CB0B792
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 20:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804061895D63
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 18:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6958221267;
	Sun, 20 Jul 2025 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUWBeB1O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66C821E0B7;
	Sun, 20 Jul 2025 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753035010; cv=none; b=Zn1qKmvOnv7oS+ZzC3trgZCDf32rbPPmQgHDkhkDL9Oq8o+KZDC8PtjxTp+C+q2z//PjwMe5BQ/A5XTpeL52fCOC3Uj8mt/yJcWiRMoplU82w2xWJYufaxpmipi611jzMUKq62yNitHVwRdIALh/9JGStrPIit643con3TvBcGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753035010; c=relaxed/simple;
	bh=4/IK3Vez7SgoHXwxl3jXiDUGejFwoQpLuMyaUNLTjSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIWiz9xvrVpicZCfb/XbHQVUACiLV2I8yMFwE51dwJB5YLa6novCqnznLU02E/Y5bXK8wR581ywyDl1z8ysR5fOPTqUyc93UuixFea1YQxqcOsB2laqMzeEuBMWRm+si1ZnWem7Nk6iQfSd9YN9GDwqxjy0tuMffpjrQ+BfVGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUWBeB1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF73C4CEE7;
	Sun, 20 Jul 2025 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753035010;
	bh=4/IK3Vez7SgoHXwxl3jXiDUGejFwoQpLuMyaUNLTjSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JUWBeB1O1VVIkMPtqiCbT4QqQ271zM933RWKmy7JB6AgPuntZoxd/KbjFdrcAoWye
	 ijQOOOjB6GeMfLlYC8kBBEK6zeIg9G6+E4Qfjddwf6y/jNl1U6CSEnh5dmTU005wdZ
	 EtNNFUhp7FgfyhL6rvKmWAtP1kzzx5WdKEDbFexnzk03+t40jPJT42vR6Ytek/KPA7
	 1Y0m2pRxQW7uw+NK3NLI+yedttQwwYp6jdpZYhTUjiNmOI+LgGY/txB1SqPOGEKpKe
	 hXkQ9LF7ui2SO9KOuUSQQ8AyY3ora0OX21ffexoQC91GiriylGihoU/TT04Yz4d2NQ
	 0KacevAP6Ceng==
Date: Sun, 20 Jul 2025 19:10:05 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
	naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, bbhushan2@marvell.com
Subject: Re: [net-next PatchV2 4/4] Octeontx2-af: Debugfs support for
 firmware data
Message-ID: <20250720181005.GX2459@horms.kernel.org>
References: <20250720163638.1560323-1-hkelam@marvell.com>
 <20250720163638.1560323-5-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720163638.1560323-5-hkelam@marvell.com>

On Sun, Jul 20, 2025 at 10:06:38PM +0530, Hariprasad Kelam wrote:
> MAC address, Link modes (supported and advertised) and eeprom data
> for the Netdev interface are read from the shared firmware data.
> This patch adds debugfs support for the same.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
> V2 *
>     fix max line length warnings and typo

Thanks for the update.

