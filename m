Return-Path: <netdev+bounces-230635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D59BEC145
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22D44277F7
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 00:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C27D4A1A;
	Sat, 18 Oct 2025 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEtf1gVd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F383C38;
	Sat, 18 Oct 2025 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745973; cv=none; b=UA/ksyC2yz+K8x1hJo58alndBpKO/OZTvFP6Wkl6sd/+hLDXO3A6lLFsZ1YmFRejB9glAmNvC+LYESOrxF51hZXMNNHPQpJ9o+v0UWere12Y5kONRA2HOhrgRE3p6M6KbURuilgOjLaJ1H94AfeGp5c8uLgZTBkJV6PdladOOZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745973; c=relaxed/simple;
	bh=jV4Zs/tV6yikwVmrBHnbe2SYjnv2Ls8kBLOfNJx5X14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAeaE7bAjyxMM3iKjfq8nIeVhNir0n6hyFITDNBO6zX9YQoI1K8nOl5hDmef6sqeDuiaf8Yk2imQ1E/lx1Zyjhe4oxUY6c9eV1TcIJWHxnFLO5fOYIkYHp2NjDgik7udCCdX/bdiY7zdvbVaWr9801lcw5pFnIIJylmMBtJgeHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEtf1gVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0FBC4CEE7;
	Sat, 18 Oct 2025 00:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760745971;
	bh=jV4Zs/tV6yikwVmrBHnbe2SYjnv2Ls8kBLOfNJx5X14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MEtf1gVd6B59SsEa06Pl0mRRmUC0PFo5X0vLALcL1xEgSh3gf8q0taZAPgD6PMla1
	 uLEgICYiFCKKttS7E1N1pCbbc6qDXtQJzPsoHzK/OKImcKdfaMqX4UyQju9tqSbh9+
	 kIVHtCgGtg/qUaxP/e8cw9gqFb9A7m0eDMtv0QYyF3OPqskBDHh8kv7nqw1KWEtj+c
	 bteswHGDfrx8rCPx1l2ZwD1WPlRb1z+38lJ8Qb3aRs+v6m26XiXGqquKxzRHRbdh5O
	 /cXY0iaBHxP1CS4LPjKv1OkjLbJs7uc1AR96Hf9NVE+mhNg2mD8n0PvAYlXQ3AXpqR
	 LFzm4t7OsTj1g==
Date: Fri, 17 Oct 2025 17:06:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, andrew+netdev@lunn.ch,
 danishanwar@ti.com, vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v14 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <20251017170610.4f5c3f22@kernel.org>
In-Reply-To: <20251014072711.13448-5-dong100@mucse.com>
References: <20251014072711.13448-1-dong100@mucse.com>
	<20251014072711.13448-5-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 15:27:10 +0800 Dong Yibo wrote:
> +/* FW stores extended information in 'ext_info' as a 32-bit
> + * little-endian value. To make these flags easily accessible in the
> + * kernel (via named 'bitfields' instead of raw bitmask operations),
> + * we use the union's 'e_host' struct, which provides named bits
> + * (e.g., 'wol_en', 'smbus_en')
> + */
> +static inline void mucse_hw_info_update_host_endian(struct mucse_hw_info *info)
> +{
> +	u32 host_val = le32_to_cpu(info->ext_info);
> +
> +	memcpy(&info->e_host, &host_val, sizeof(info->e_host));

This is not going to be enough. C bitfields are also affected by endian.
The best practice in the kernel is to define the fields as #defines
and user FIELD_GET() or direct & / | operations with the constants.
-- 
pw-bot: cr

