Return-Path: <netdev+bounces-131852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E593D98FB84
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 02:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0E8282BDC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591551849;
	Fri,  4 Oct 2024 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ectya0tX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A7117C9;
	Fri,  4 Oct 2024 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728001792; cv=none; b=pnVmPYpJ/q5qe0qseV3mxd7PsWUqUQffwR91nR1dpWq2J8JN4eRrL16jBO+bdGWsxC6ujdsxLnIEEIEeTfxRFwLLSax6jFAYN9aCo4pQ4yl5bhFMIpSo0QZzB4Bxky8DYwlRO+0E27mWYW9Rzg7+HIA/ir3x6l+OVpWh9A09sa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728001792; c=relaxed/simple;
	bh=YyVZKcTVrgRoGugQPFc10CYVKRspGrgEhV5lxIQlSRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+xb6VOUPBFGFLu+hzT9yAgks70CpAuaiw9mkqjDiwSAoPGqXBF6ONawGuDQDN6MVmDIgr0qgDLoK2m8p3wSnjIspmqnJvxlU7bYn8ys6iABFCToE8dlq5X25ZhYEKHwS4jNeTr1OMs0J8GpkLorwNOeZjSnG54hbSAURpPaqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ectya0tX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D209C4CEC5;
	Fri,  4 Oct 2024 00:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728001791;
	bh=YyVZKcTVrgRoGugQPFc10CYVKRspGrgEhV5lxIQlSRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ectya0tXDNXaiRD2QEzL0KWx8DF3gvsO97I7qhI8j7D8XdyRnIG3W5CTG8FlcBdfE
	 UK8V94a/j4LGAGJTfpRe3CRqOygqwL5T2pXUN4i6bvpP+M7eodBlS6Qo3dHvfaEKUD
	 dQV57TyZup+bfjLOcNHaWm6SaqPlagrEPnvUxGMafOvDEcDRxME5og4dQGMhuerqAG
	 1d+WslMh3dym8CT9QEmVDIrVOBLWF3whSYqagPYDQ2wLmUNR+T2JYde00wfVseHorY
	 949E4MuFq+KK3WsfBsZRo8QUAJKplfn+KNVfJQDXjrsxzFv67D7l7ivVxrrfQQ7ft2
	 UWCLDSsjKwxLQ==
Date: Thu, 3 Oct 2024 17:29:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 thepacketgeek@gmail.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, max@kutsevol.com
Subject: Re: [PATCH net-next v4 00/10] net: netconsole refactoring and
 warning fix
Message-ID: <20241003172950.65f507b8@kernel.org>
In-Reply-To: <20240930131214.3771313-1-leitao@debian.org>
References: <20240930131214.3771313-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 06:11:59 -0700 Breno Leitao wrote:
> To address these issues, the following steps were taken:
> 
>  * Breaking down write_ext_msg() into smaller functions with clear scopes
>  * Improving readability and reasoning about the code
>  * Simplifying and clarifying naming conventions
> 
> Warning Fix
> -----------
> 
> The warning occurred when there was insufficient buffer space to append
> userdata. While this scenario is acceptable (as userdata can be sent in a
> separate packet later), the kernel was incorrectly raising a warning.  A
> one-line fix has been implemented to resolve this issue.
> 
> A self-test was developed to write messages of every possible length
> This test will be submitted in a separate patchset

Makes sense in general, but why isn't the fix sent to net first, 
and then once the trees converge (follow Thursday) we can apply 
the refactoring and improvements on top?

The false positive warning went into 6.9 if I'm checking correctly.

