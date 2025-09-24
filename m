Return-Path: <netdev+bounces-225745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4E8B97DF7
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 674D17B55D0
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 00:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ADA14B953;
	Wed, 24 Sep 2025 00:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcbTa/mj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9A13BC0C
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673670; cv=none; b=PNwy799Qb8w4ojgvDIdw16nQOQz803tHPz4R9+pmjADYKED3rGYWzZ7K3x1bVINND63CgQm+ofAiyX+0W8zZODcIh8pUKILM/p0ajnUDAWR+tAT7VgT/CN5sjwaSkBCXnS90tYwiwLtyE0+hcuAnmdBp7RSxNfN8Gz9uh3QVMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673670; c=relaxed/simple;
	bh=0jZz5CUadTlqMTZqsY4u85H5twUdMl/A+qFlWUZs9OA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhwn4k0hQi4qZ6Varcr4NKjlMy9CcqKx7+aRYO7uYDxngATU2fU6gdlPI488l3j56w2B5MXkqE5yuZPJZRDHZjNnBFG2sYL+GzndbeB8CLSEZAkm1v3dHpYEu7bCBfV1bq/+ad+v1pbXs3StpKtRNW4jMxnL3i+ZK2ECD8oByGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcbTa/mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEDDC4CEF5;
	Wed, 24 Sep 2025 00:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758673669;
	bh=0jZz5CUadTlqMTZqsY4u85H5twUdMl/A+qFlWUZs9OA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NcbTa/mj0Vr39Mf/kc/FiXh0PWzMXcAvLEwjViTOhxqZfEomV3Po7c0r5ttwQ8RbS
	 QkUB3d3/QLl7oQFTgZyFcaYn1tOn93lqeTIgvnIF/l3OmtaRQbJryu6AOossyjaNeE
	 CGaU0MJGOJp2xqAWSv9m5CxYMONSeXM07GwJwF23HhLDpsRSYFW44DMJh1YVPsKN6e
	 +h/d7P80iQWO+NGUZM11szOypv7B6fZEl+hDsBTarEzKyr9mzr7pi6dRScQPUDID3H
	 59Jom7enwuH51eoA5ygvr+cMip1/h/+uXGmAT3yo59EwlB8SmnXKyE3onU6Cl1/U7J
	 /otA/AeJXgqjg==
Date: Tue, 23 Sep 2025 17:27:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org, Donald
 Hunter <donald.hunter@gmail.com>, Carolina Jubran <cjubran@nvidia.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/5] ethtool: add FEC bins histogram report
Message-ID: <20250923172748.7269e6f7@kernel.org>
In-Reply-To: <20250922100741.2167024-2-vadim.fedorenko@linux.dev>
References: <20250922100741.2167024-1-vadim.fedorenko@linux.dev>
	<20250922100741.2167024-2-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 10:07:37 +0000 Vadim Fedorenko wrote:
> +		if (j && nla_put_64bit(skb, ETHTOOL_A_FEC_HIST_BIN_VAL_PER_LANE,
> +				       sizeof(u64) * j,
> +				       values[i].per_lane,
> +				       ETHTOOL_A_FEC_STAT_PAD))

The pad attribute needs to be from the same attr space as the attr
you're outputting. You need to create your own pad attr in the spec.

