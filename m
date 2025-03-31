Return-Path: <netdev+bounces-178424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D19A76FA8
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4462B1624A1
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E30C1E0E0B;
	Mon, 31 Mar 2025 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd+8Of0f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9BE1D6DDD
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454117; cv=none; b=KtTJwOgkWje27IXpKPG3qYzBEscZQehnQuNcqZUm4TF85uNXnwvDdspd5j0nhFjor4WVDlVX6H1mFrP4sc8GcUI8S4FVUtkPUWREiBsVtQlTMW6N0fOUyi6rPwjE7mWrvbb6laEmAiP2atWYu8oghEvGoKrDwmEqVr+eU7I8mAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454117; c=relaxed/simple;
	bh=Mz5alxl/L5PiPVvNe6gbrn7Niv64tbJwEDdR2Afegno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VxZOcAvNhcXYCMCewJ/Y3MfmHWtfnFjLttdawkb5Nd9I2k2YtFkdbEDAvyUgs0QxJyMDg43WfUIwAQlnxvxTOb99LgjbzJkNDXk6B9xEeq7nq6rkqkYX6E+OMPU1fsBgfYScQEcj2I30BF1lfWIR8YgIVXp48uyKpnZet+NAhtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd+8Of0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAAAC4CEE3;
	Mon, 31 Mar 2025 20:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454116;
	bh=Mz5alxl/L5PiPVvNe6gbrn7Niv64tbJwEDdR2Afegno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wd+8Of0f2fejLOQRLXVs2eMlVrG4p/eL4WOZae3PANnhYWMadvONGVieDNcl+7tZd
	 BM2lFB+4FUx+Hxi5MFQFw31XgpQpSQUeJVhTeJWjbNYfNGFoAhsdXVRKHqvCqzrJIi
	 aDUisHc2FjnTm1bDcZ9vNdT2NXmRyiWBRRe1GgmLz3Ox0281z/McW7UU4HjKR2sC5Q
	 Je6gLB5z16gTeaY7a8i0q6r0awDTYkugQ3qC2GVYWor1OztdCJgIN6X4Ck0rR5pNNs
	 E1HDY1CRG8UYoTeh/bAbGFOjcs2sRzCVcjlWRWqVV6Ea7s7V+7YjfJQqsg64czWuC4
	 uS24PS+dVJ9vw==
Date: Mon, 31 Mar 2025 13:48:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net v4 04/11] net: rename rtnl_net_debug to lock_debug
Message-ID: <20250331134835.5f1ed531@kernel.org>
In-Reply-To: <20250331150603.1906635-5-sdf@fomichev.me>
References: <20250331150603.1906635-1-sdf@fomichev.me>
	<20250331150603.1906635-5-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 08:05:56 -0700 Stanislav Fomichev wrote:
> And make it selected by CONFIG_DEBUG_NET. Don't rename any of
> the structs/functions. Next patch will use rtnl_net_debug_event in
> netdevsim.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

