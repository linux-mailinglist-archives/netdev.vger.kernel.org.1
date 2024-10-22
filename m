Return-Path: <netdev+bounces-137963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8367E9AB426
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05BB0B22860
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CB11BBBFD;
	Tue, 22 Oct 2024 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqaWHJJY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5004E19A281
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614992; cv=none; b=qPNuCgF2tjRHTKg+9pKSYfVXobLPrHxpDSDp/Dm72XQLsrLkmEXp14IFzLFBoNMdK7W6o0+shdleX+IGAiVJWYcdbvmQ66DMoWVpxW2ZUji+F+R2k0mRFHEY2B/sRWVC18iTsbl596Vh9BRoqjzbiLQ7G5c7HayrvCdGqGT+KDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614992; c=relaxed/simple;
	bh=Jvg132qvvippd41sy1WGeyN8yVQhLw7jmiKfi+6tb7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG1Z5v6qW5xCN7zKE5kD1wylBZEL9y+Hg3b/c2TWnuXX5lgnEhlX/1Kw3E74/zzyea4UNlfobF3xbD4vV8brkGKKbhUtfM5Ut/8lJ1+RLIWYF6krg0Kc+wVn3y9aNmWl4k/snsi2Nz+WP4/8dpukgImQEkHfccDetN3D6zjEf9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqaWHJJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75A4C4CEC3;
	Tue, 22 Oct 2024 16:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729614991;
	bh=Jvg132qvvippd41sy1WGeyN8yVQhLw7jmiKfi+6tb7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqaWHJJYyQFSeulcC9L2bg7aeCPsPbdpuwMPAFEPj68gE8Gc+Kpmxab4XaFxoWJQC
	 fyFywYoTa0PlPnIHeMiITbAfHFMckBDDAQE78ojBm1X9DNCR4LiE4FcMF4rclZdkfE
	 W8ise3nmGbFDgJuoH4UHRIs/9iIYhU+daplPCoZlaCl2h4GY0wbp3Carj/Nn19qpde
	 jVHvRbkIlH1uvMXYs6FOfM1JXWoON4a+nj3+ac7C0m2zEwzm8stAmeoVFV7ARf6GFI
	 5UpyL5LxTh0OSE+iV5oujOhR5KdpyYckHCDQhMjJUp5QfKtW4107vikX+ruZosR1Tr
	 7Dpi15J6UbSzA==
Date: Tue, 22 Oct 2024 17:36:28 +0100
From: Simon Horman <horms@kernel.org>
To: Nelson Escobar <neescoba@cisco.com>
Cc: netdev@vger.kernel.org, satishkh@cisco.com, johndale@cisco.com
Subject: Re: [Patch net-next 4/5] enic: Allocate arrays in enic struct based
 on VIC config
Message-ID: <20241022163628.GG402847@kernel.org>
References: <20241022041707.27402-1-neescoba@cisco.com>
 <20241022041707.27402-5-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022041707.27402-5-neescoba@cisco.com>

On Mon, Oct 21, 2024 at 09:17:06PM -0700, Nelson Escobar wrote:
> Allocate wq, rq, cq, intr, and napi arrays based on the number of
> resources configured in the VIC.
> 
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>

Reviewed-by: Simon Horman <horms@kernel.org>


