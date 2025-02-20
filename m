Return-Path: <netdev+bounces-168326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04B1A3E84D
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149F419C2E08
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 23:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C31265CBA;
	Thu, 20 Feb 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFsFO/Oa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA121D5CDD;
	Thu, 20 Feb 2025 23:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093770; cv=none; b=pNDlmuNAa94pO44nKqOS1hqsoTKJxQYBWZs7gluX+oxn7or9D+shzjXS//4bue7dTTLBoHJ9K0W9ANN5SlR/zHA+BxRytYQUDqg5HGXd3O3UVxtMtnf3HczZseMvE69xJtcFHQGyquOhJtCphaUlGOoSeqfQSGyH8gyOnKO13Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093770; c=relaxed/simple;
	bh=k5aa28gQFx6ZWYhz97vvz1POUZSI9NWBUQ9gyT3GQkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afsQEtSoXtz72iHB6MzeiBIHKEl9KSK1X5hLMYVmvBdfznVfPVQqpQbywuhFUCNcT3tbw4lUTUZzOYKhddNRS7vBT/PPw+/mCPmi3O6k6y6hbeehu9MBixkez8JGfvNkBSv1ZruPbX4q3zpK2LOu2mhn+XXY9iRfSVVg/mjTi0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFsFO/Oa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D27C4CED6;
	Thu, 20 Feb 2025 23:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740093769;
	bh=k5aa28gQFx6ZWYhz97vvz1POUZSI9NWBUQ9gyT3GQkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dFsFO/Oaes9rPOHMzfA0mZSMnTEHvqtt5uPz8hhdU5yy/tFm/wwIjkePeyBzRrS6j
	 cEjBLDOqNkhRSPsechq2icSFmqHUp5E9ppCzPrtL95qQ+e31UTQhZcUQhyR4i5F+Ds
	 ZSJz9rluWWVpQOhggJpjm2NLer69uGbahLEB+8/KZLdSU6AKoprCJRzR4Ju2FTu00X
	 6TzeRlUtzJLCuOkIm6nFLm5jpimvuoBzsjuTlnuHzWCofhebFnOnZpDgfVKs6RastO
	 E48C/U1+mrAtNzQB1vEBvcVdw0GEbodqOXw2vUX0TYqI0l+KwxfJexk/rd8UHEjef/
	 8gxeYmQyp0B/g==
Date: Thu, 20 Feb 2025 15:22:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Jan Petrous <jan.petrous@oss.nxp.com>, NXP S32 Linux Team <s32@nxp.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: fix DWMAC S32 entry
Message-ID: <20250220152248.3c05878a@kernel.org>
In-Reply-To: <E1tkJow-004Nfn-Cs@rmk-PC.armlinux.org.uk>
References: <E1tkJow-004Nfn-Cs@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 09:23:14 +0000 Russell King (Oracle) wrote:
> Using L: with more than a bare email address causes getmaintainer.pl
> to be unable to parse the entry. Fix this by doing as other entries
> that use this email address and convert it to an R: entry.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index de81a3d68396..7da5d2df1b45 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2877,7 +2877,7 @@ F:	drivers/pinctrl/nxp/
>  
>  ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
>  M:	Jan Petrous <jan.petrous@oss.nxp.com>
> -L:	NXP S32 Linux Team <s32@nxp.com>
> +R:	NXP S32 Linux Team <s32@nxp.com>
>  S:	Maintained

I had to look thru old commits, 8b0f64b113d61 specifically.
Can we also strip the "NXP S32 Linux Team"
It's pretty obvious from s32@nxp.com that it's a group address,
and this way our scripts will know that this is not a real reviewer.
-- 
pw-bot: cr

