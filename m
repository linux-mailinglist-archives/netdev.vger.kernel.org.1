Return-Path: <netdev+bounces-61677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D5482499F
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 21:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA0C2874F4
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 20:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF9D1DFDC;
	Thu,  4 Jan 2024 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z26dCf67"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC72E2C68F
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 20:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56D1C433C8;
	Thu,  4 Jan 2024 20:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704400531;
	bh=Lx3dFp23qsqlF6j+qme3KDLOLqwXoHkGRSPiJLEEph4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z26dCf67Gxllq7qbzGE45rXaQxZsqa59e8l371rT/8TOmPRNUokhKWvrTGrtuUvDE
	 /F5/bVd/GXEO5Wj/xPJTxSwC11O3hazw+YUttJz+vPnm0qsJf0rxITUtXWzYRqvjb8
	 GcA9r/77cPsdhYeTh4uZ9cK3ykN4cMKYsL/wf8cJM9+wbNPZzcWmudDDCrdqF7/DE2
	 eNvlGlUHta/vpyTDYaoamFcrDfbJoho/quKlM2o6dj9C0twSiEWvNWEY2/8G5ZxZeu
	 gXi3coLosWIEi9cvVvYdGolhnTfEJBK5Yx0zN+OzOazyqEh/DCnX5XEOWnDTvkYoxp
	 JSPHypJ3hdtnQ==
Date: Thu, 4 Jan 2024 20:35:27 +0000
From: Simon Horman <horms@kernel.org>
To: Jan Sokolowski <jan.sokolowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aniruddha Paul <aniruddha.paul@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jan Glaza <jan.glaza@intel.com>
Subject: Re: [PATCH iwl-next v1] ice: Add a new counter for Rx EIPE errors
Message-ID: <20240104203527.GM31813@kernel.org>
References: <20240103141115.9509-1-jan.sokolowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103141115.9509-1-jan.sokolowski@intel.com>

On Wed, Jan 03, 2024 at 03:11:15PM +0100, Jan Sokolowski wrote:
> From: Aniruddha Paul <aniruddha.paul@intel.com>
> 
> HW incorrectly reports EIPE errors on encapsulated packets
> with L2 padding inside inner packet. HW shows outer UDP/IPV4
> packet checksum errors as part of the EIPE flags of the
> Rx descriptor. These are reported only if checksum offload
> is enabled and L3/L4 parsed flag is valid in Rx descriptor.
> 
> When that error is reported by HW, we don't act on it
> instead of incrementing main Rx errors statistic as it
> would normally happen.
> 
> Add a new statistic to count these errors since we still want
> to print them.
> 
> Signed-off-by: Aniruddha Paul <aniruddha.paul@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


