Return-Path: <netdev+bounces-205321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0908DAFE2E7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84FCB4E179D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6596D27BF80;
	Wed,  9 Jul 2025 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7BF4qvz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124727B51C
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050406; cv=none; b=QMxXpy09mWGMoq53Lz/VJFf6xo5Bg2n88mgF4ybvlsimBH6rZ8xeGPeufnfA3PP0iLF4HZ4VHThugi/xFPpgoizPYa3s3VaxcMJMGoKe6sGzEXoofy3CwnFHuNRndrTAmYy/XrcFxVInnZM859WledRVYAtNBL2Ekm8GPhpUWHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050406; c=relaxed/simple;
	bh=BfyoeOf0hekCx2TvpbDBdGJc93aq3tKHx8XAMZ1sp4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPIUoTBSJldV+86YxIDbzecjwcmtTFMtHTTsttf9vL81tPTeYiHGUR64hhdG1PtRKxDGlJkr9eU0eb8FRbJoCAv+NnvJYw2Aml2enXdTWL0rZLm1tSc4zLls0kJhgbVcucl3c5jB03N0akj2iWPCh9k6oZqSdTemhU5IjEfLrLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7BF4qvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DE2C4CEEF;
	Wed,  9 Jul 2025 08:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050405;
	bh=BfyoeOf0hekCx2TvpbDBdGJc93aq3tKHx8XAMZ1sp4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y7BF4qvzbqh0gX0NrffOhIp04NBpvZHdyjV042aVGw0C9sLfvMYJWj1hhAupxMwyS
	 WLDEPz4w9CFaE6qL7G7QNdTsy88orXh/T4xkJyQQXhifz0KilD6IkHGrJ4ppS+ht0O
	 c5w20eLQ0Kq8BwxTQ3DCIXMBwNPvtneRAhry0WiWIPGggi67z2R+XlBpUi9IjPmYmk
	 jwV0rzIRMAHXUk8BJHmOR/If1j8bg7SYEUTbN7ID2fhxVRPoMAFtQOY/lVLL+7nswv
	 AU1xDD1a0MkzY/VPU79J3oBfjFwgOTa+VVuB+X8YD/tI4eRth1dZsqnPrl0/ouWHCD
	 50H+C5sKEUN9Q==
Date: Wed, 9 Jul 2025 09:40:01 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V6 08/13] devlink: Implement set netlink command
 for port params
Message-ID: <20250709084001.GJ452973@horms.kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-9-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709030456.1290841-9-saeed@kernel.org>

On Tue, Jul 08, 2025 at 08:04:50PM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Add missing port-params netlink attributes and policies to devlink's
> spec, reuse existing set_doit of the devlink dev params.
> 
> This implements:
>   devlink port param set <device>/<port> name <param_name> value <val> \
>                cmode <cmode>
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


