Return-Path: <netdev+bounces-205320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE65AAFE2DD
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6B41888982
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A96B27C16A;
	Wed,  9 Jul 2025 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4m32uLy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8C027AC45
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050341; cv=none; b=BDhYrXLdNmyOLGMFaQOV0pxO8s7u4Pv8e3uGK4kcJVLbLnP47CtzWOL7EK8Q9+EY1kiSPUqav6dk5RSJ8t34iroyzrDfYMHfn2l/r7re5i4UmAUzj4Sv+1QXzjsOLTJup9HCblT1SIh6gPSKYVG2Qc/COK6VVkzkQWVE0BEiLW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050341; c=relaxed/simple;
	bh=IVme17Ihm0k8R5PYq8ai+ZS7Js0Elz4hy+gSjpreobI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCPW68OqK0g7SK78Bk6AVlAncG2rReK1u6fsxAkU6y6OePSJavFXytz3xfgS4M/qR9YYOcDKko/pz5rHbWt+WtgfJImbi7Txt8gPR4s076MiwS+phKwXMH3uaCNGVdTmO2Iv60o4X0rhxw4q/bXROUMHqIg4NnX5mKKBk8Aru24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4m32uLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DACEC4CEF5;
	Wed,  9 Jul 2025 08:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050340;
	bh=IVme17Ihm0k8R5PYq8ai+ZS7Js0Elz4hy+gSjpreobI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4m32uLyLEUfbaAx9fE7/Ez/x8qQUqMBahh+Hg4gauvjvHN1xfhz5Hkehn97YdPfF
	 Vek8EXvODorycZRevOvm7Hz8jghZw3vyCMXeXtZA0L9ju7qoDKJVbmxzBfkD44UgSx
	 7HLcFG49UwwFKQ7Ex9+9hSVdxGpHnfMEtlv7y6cd7dzzwB7GfFoo1/2oPdEvLhVj1v
	 WmcA0SsU4bDPUivpvBX0mi70aCUU03CXltKiE3dOEMCuxR0N8vcaQN/76hR5PLT2/t
	 G1zDCCK1YNN8KfFaEysKcAjXeGKP3d+O1AIDXb//0tc5fa8hhZUwfsxFJMR22o6VnS
	 G7alyQFFyicsQ==
Date: Wed, 9 Jul 2025 09:38:56 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V6 07/13] devlink: Implement get/dump netlink
 commands for port params
Message-ID: <20250709083856.GI452973@horms.kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-8-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709030456.1290841-8-saeed@kernel.org>

On Tue, Jul 08, 2025 at 08:04:49PM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Add missing port-params netlink attributes and policies to devlink's
> spec, reuse existing get_doit/dump_doit of the devlink params for port
> params and implement the dump command for all devlink ports params.
> 
> This implements:
> 1)  devlink port param show
> 2)  devlink port param show <device>/<port>
> 3)  devlink port param show <device>/<port> name <param_name>
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


