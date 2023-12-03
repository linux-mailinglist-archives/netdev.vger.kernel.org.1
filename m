Return-Path: <netdev+bounces-53324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B298025D4
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 18:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44768B20986
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 17:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4161F168B1;
	Sun,  3 Dec 2023 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtqRwNIp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F515AC3
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 17:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538C8C433C8;
	Sun,  3 Dec 2023 17:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701622886;
	bh=3grxlFh5smxHqqrzAwHvqw9F1PRF28tWTzgvpQYBhuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UtqRwNIpS39RsbxeS8z3aeYK7U6qw6Ny4NPIiBnQyXDZ+7DVKupKzP0zHFSeqPigw
	 gbJG6Y6aM3zK3ItakRT5d43r418tfyXUya8G60YCfowbd0WMiir2skSRFlMBU7pLEB
	 v6AnBsVcXynl4XnWeQbpVKe057+NemJMARpz09/Lz/g/nA2VkCZNHF6j0Cof5D9lEY
	 IlX5HSKvMOLkGQMWU0qS05WuvncF7T4Q27XZ9oAvQsSk6cy7wFzyDBkDR9Hb1QQ1Xm
	 y5s39K4Bt6YHGdU/55o9rU8cFJy1sBnfct40RrrL7kmPXRgEqze9UgAepvPEhycy3h
	 oaRbU2Rc6B3Rw==
Date: Sun, 3 Dec 2023 17:01:20 +0000
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net v3 PATCH 2/5] octeontx2-af: Fix mcs sa cam entries size
Message-ID: <20231203170120.GM50400@kernel.org>
References: <20231130075818.18401-1-gakula@marvell.com>
 <20231130075818.18401-3-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130075818.18401-3-gakula@marvell.com>

On Thu, Nov 30, 2023 at 01:28:15PM +0530, Geetha sowjanya wrote:
> On latest silicon versions SA cam entries increased to 256.
> This patch fixes the datatype of sa_entries in mcs_hw_info
> struct to u16 to hold 256 entries.
> 
> Fixes: 080bbd19c9dd ("octeontx2-af: cn10k: mcs: Add mailboxes for port related operations")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


