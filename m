Return-Path: <netdev+bounces-198977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C627AADE912
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E776F4062FE
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1531E285C8E;
	Wed, 18 Jun 2025 10:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="darTD0yq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE09B27F16D;
	Wed, 18 Jun 2025 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242553; cv=none; b=HDtWsFkMvK7nW58fCCbQlZu5mLueNTmQ/pdjU/OYCrJ5Y7g8tfytL5Y+lhR/BawwcTgkKwh+R3Hr8quSJv0dQ21x25rdu7+Ir5zDE7GMgv+VkRNweCLuOLi/CrUiU8BHUjai3PNV96Kq0rSpK7aEFRVKIWxNO6ygtazMyBbh7lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242553; c=relaxed/simple;
	bh=hA1/C70zCQRsqeKpAGRD4HPcwrD8fzW+BRyIETNDT7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQkoIRPchZSeXsboj4yWi5rQap9bFYpQtVPdHnWf7UGpSbttqg28GQ8qrE+7+4/oAPKZHJLuDbsd56meS1oJgP+pWviShlXIwYPtFi6zpxMEpDiNxo1X4YwGAmQ0bZ/Qy0zXfu49W6SbmMRNQQhsRAUuda+lxCjPU0eBfVvgNIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=darTD0yq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EC6C4CEE7;
	Wed, 18 Jun 2025 10:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750242552;
	bh=hA1/C70zCQRsqeKpAGRD4HPcwrD8fzW+BRyIETNDT7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=darTD0yqfMgrbx+HnGO21HdmDFDVdmoRh3QrxdE04Ryew6XHIHaiUh6mViTqBnnku
	 XivU09Oo12aZEaTi9ayWPuJbB4AOi8cXTGTSy7WJLVHidGlJfyQhhq73d3pBSojp4z
	 vpBrVB5DtvMd30MRu9GtTmGK9BmmtYHtJt9fJO8+1jq3/wZz+lVCQgbpQIJJEp//yN
	 mN3qAzvtII/PI+89uTaW4yT/8fmvFpJQeTtK9fNHhYoqlvhEjLrDsUF0dmFAlyuaD+
	 S/q92aOCERH9RCQZoWygGS4GVZp/vANpJlSfuhycHlUVzpBNXBrlMhr4xxthY5MWwW
	 Zef7oJXQuICUQ==
Date: Wed, 18 Jun 2025 11:29:07 +0100
From: Simon Horman <horms@kernel.org>
To: Himanshu Mittal <h-mittal1@ti.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com,
	m-malladi@ti.com, pratheesh@ti.com, prajith@ti.com
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Add prp offload
 support to ICSSG driver
Message-ID: <20250618102907.GA1699@horms.kernel.org>
References: <20250617101837.381217-1-h-mittal1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617101837.381217-1-h-mittal1@ti.com>

On Tue, Jun 17, 2025 at 03:48:37PM +0530, Himanshu Mittal wrote:
> Add support for ICSSG PRP mode which supports offloading of:
>  - Packet duplication and PRP trailer insertion
>  - Packet duplicate discard and PRP trailer removal
> 
> Signed-off-by: Himanshu Mittal <h-mittal1@ti.com>
> ---
> v2-v1:
> - Align with recent firmware name handling updates made in:
>  https://lore.kernel.org/all/20250613064547.44394-1-danishanwar@ti.com/
> 
> v1: https://lore.kernel.org/all/42ac0736-cb5a-4d99-a11c-6f861adbdb5f@ti.com/

...

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h

...

> @@ -349,6 +352,7 @@ struct prueth {
>  	struct icssg_firmwares icssg_emac_firmwares[PRUETH_NUM_MACS];
>  	struct icssg_firmwares icssg_switch_firmwares[PRUETH_NUM_MACS];
>  	struct icssg_firmwares icssg_hsr_firmwares[PRUETH_NUM_MACS];
> +	struct icssg_firmwares icssg_prp_firmwares[PRUETH_NUM_MACS];
>  };

Hi Himanshu,

Please also add icssg_prp_firmwares to the Kernel doc for struct preth,
which appears a little above this hunk.

Flagged by ./scripts/kernel-doc -none

Otherwise, this patch looks good to me.

-- 
pw-bot: changes-requested


