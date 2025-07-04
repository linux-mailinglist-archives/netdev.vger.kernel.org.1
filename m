Return-Path: <netdev+bounces-204215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F0BAF9974
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 19:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA464882C0
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0995285CB2;
	Fri,  4 Jul 2025 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqo9WsEn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F92E36E7
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751648752; cv=none; b=uwXrmYAw8k+CXKqRBj9tumJUd486lRnQSyne1UtFtSYZyHZEXRb969IJYrS5iwfyH+LiNgP8MGPbdgZ0w7D30wBdHffBtc4TotnhdpExXtxCnSXTlETeLE09dhBtDkFvKxrCF2iw16ZGYZ3Z61kRXa0GV5VPtzkCNjZapgiPw7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751648752; c=relaxed/simple;
	bh=X0tykLQZ7gVKoARvYw2ieqVcpK9qSxB+3MuwK7cUNrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIL8YFhkO2cwu8WdmFVHxDZDMh5TGGL5aDa1ucrRX1hDZdvqGsg0lXeKvKHGNXIHd9jKhruKdhnBvN9RfJQArjov4cl/YeetxPtaMSIpsSvDIIfYvNCw/uCAYhQ/sDRyLOdH4UBTkr5Qy9ZCR3v72ri0KfshX2xXf36pHIl6Rvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqo9WsEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40AAC4CEE3;
	Fri,  4 Jul 2025 17:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751648752;
	bh=X0tykLQZ7gVKoARvYw2ieqVcpK9qSxB+3MuwK7cUNrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqo9WsEnDvtIUCntLBfxrjoo4dKwMojINKmWyP7igIaBdTgKGNha7pfA/5WKyRKcs
	 kv9r4GUFBcmmrGEB1GQklhX8RoeVXA3/YkPldpiAEjFIfGDFWAipTrb1QN7duZY/QC
	 eLS+hZwxTNvnP/lMsfx5yHnij48P1/i6yJuGD+hbi9f0llCvbAmWgHzLbkr+7Y5fwR
	 IM3BC7iTHC05TIoWJmrI3+POkZW88zrbxHUVegNROdfJXJj4uROVPPeaHkitL+yH8r
	 hHd/Fs+h61OjKwvRw/Bfd120GaQ+JWfos4mMwuh6DqazDqSq9Wgx/Q6tT68yjZvRG/
	 Vl2M0CJrwzehQ==
Date: Fri, 4 Jul 2025 18:05:48 +0100
From: Simon Horman <horms@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
	ricklind@linux.ibm.com, davemarq@linux.ibm.com
Subject: Re: [PATCH v2 net-next 4/4] ibmvnic: Make max subcrq indirect
 entries tunable via module param
Message-ID: <20250704170548.GM41770@horms.kernel.org>
References: <20250702171804.86422-1-mmc@linux.ibm.com>
 <20250702171804.86422-5-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702171804.86422-5-mmc@linux.ibm.com>

On Wed, Jul 02, 2025 at 10:18:04AM -0700, Mingming Cao wrote:
> This patch increases the default number of subcrq indirect entries from 16
> to 128, a value supported on POWER9 and later systems. Increasing this limit
> improves batching efficiency in hypervisor communication, enhancing throughput
> under high-load conditions.
> 
> To maintain compatibility with older or constrained systems (e.g., some POWER8 platforms),
>  a module parameter max_subcrq_indirect is introduced as a transitional mechanism.
> This allows administrators to manually reduce the limit if needed.
> 
> The module parameter is not intended for dynamic runtime tuning, but rather
> provides forward compatibility without requiring broader structural changes at this time.
> 
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
> Reviewed by: Rick Lindsley <ricklind@linux.ibm.com>
> Reviewed by: Dave Marquardt <davemarq@linux.ibm.com>
> Reviewed by: Brian King <bjking1@linux.ibm.com>
> Reviewed by: Haren Myneni <haren@linux.ibm.com>

Hi,

In his review of v1 of this patchset, Jakub said:

  Module parameters are strongly discouraged. Please provide more details
  about what this parameter does, I supposed it should be mapped to on of
  the ethtool -g options.

  https://lore.kernel.org/netdev/20250701183107.6f6411c1@kernel.org/

Perhaps I'm missing something, but I don't see this discussed or addressed.

-- 
pw-bot: changes-requested

