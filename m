Return-Path: <netdev+bounces-205313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AB4AFE2C7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6676B3B98CA
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD3F27AC3A;
	Wed,  9 Jul 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPXphKwK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993E276058
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050238; cv=none; b=mABPHhxjoGGeSg4dS/Y0wiO+CPnfKBl7OV58BrZe6Y2lJHMX8XWT+Ob+fKEiAlQ8IZB/wk8e174s6lhCoqsij28WV1RFRU1RaguKF8PUlNCpxyXO7/lCtcGTkBngQVMXJTPbq6iZbZI5C6m/he6+Z/Vhkl2D9PIi3QcNKeWF63o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050238; c=relaxed/simple;
	bh=1DXsPK8tvgIFXFXuAAHG5ZECgjbDwMYdDe2+2z5Qew0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVnYuk5biZ024vwlLDucMMNNsCBZTSepIOKJXY3Adlu4XZH95EaPAajegSFKGm3bNiRvQFcS1kWYe4inDI3cuS6sp5I8N3mZJbtdSnwUsJg3i+RdS/c7IUtS8kjNhv6gkDXSk9mfgZDnfM1GHdGAdkwExXfz6E08xSTcliaQe5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPXphKwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118EEC4CEEF;
	Wed,  9 Jul 2025 08:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050238;
	bh=1DXsPK8tvgIFXFXuAAHG5ZECgjbDwMYdDe2+2z5Qew0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPXphKwKPS1cGhzOZBP92Gii7A1+picYmKyWOuNqfwaYRVx+8SPS3o4vFqBN2mtcz
	 PnYimz+1byv7motMcxC93F5BOqA2nmwlMS0NAZHIUFtfeWfCZzieh6GcvQyTlKndru
	 1leVL9FHEUOkm4cND4IfGn3LQSpKJgDdzTQNvBfY4dV9HzawTkV7abLnXw7U+TAhar
	 7kt3erGmzA9C9DPINMqPqFo2qjMUJjEeaCwRUKSB2YV6FwM3tZTnfSKaloP74onyRu
	 rf9Njx2leXEz+caca/sVLC0mcHDVtHaPXbyQ0DdmWQqpsckQVgBKTuB1fao5jRGntY
	 i8db2oKwTQSLA==
Date: Wed, 9 Jul 2025 09:37:14 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V6 02/13] net/mlx5: Implement cqe_compress_type
 via devlink params
Message-ID: <20250709083714.GD452973@horms.kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-3-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709030456.1290841-3-saeed@kernel.org>

On Tue, Jul 08, 2025 at 08:04:44PM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Selects which algorithm should be used by the NIC in order to decide rate of
> CQE compression dependeng on PCIe bus conditions.
> 
> Supported values:
> 
> 1) balanced, merges fewer CQEs, resulting in a moderate compression ratio
>    but maintaining a balance between bandwidth savings and performance
> 2) aggressive, merges more CQEs into a single entry, achieving a higher
>    compression rate and maximizing performance, particularly under high
>    traffic loads.
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


