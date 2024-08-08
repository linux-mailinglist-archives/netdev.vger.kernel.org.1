Return-Path: <netdev+bounces-116942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A37D294C20E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49A81C22DF9
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF4818FDC1;
	Thu,  8 Aug 2024 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyHyfjlO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8711218FDB8
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132456; cv=none; b=V+V2XefeRX5hMJPQMfsDmoa+oTjrOsdow1+KMfIZyiyyCPSrfBMimZeZU8WoNSHr6x4TB9BZp1n46w010fFWSR6o/iqGVo+/6cM4/PJvOs77aa2SFZyxARjmQ/xEwvoLLz8Y6RQ0+DX/rfrP3dfJwrOJMYLHUXjYTXJ0LBITjK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132456; c=relaxed/simple;
	bh=RoTevx7vL7NwmsD3X0FaqMamp3PrtCYQLFbIdFh7vTM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=PXVhbcEc0nBtsvNUYjvlPWLRobg9BYC7ZeEjtv2NeDPbJzG7SQRkx1NlrnDPNLSe1v0QBb5Lrs3EvfEy7ssfYD3BKkGEu/O1LL80VsjX5CZXEg5E4GWdkl1cbdepprN60y5636+oTZ5C3j+gBsf2yOo/eJ0CMVSy7xqaoyUkElg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyHyfjlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7B7C32782
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 15:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723132456;
	bh=RoTevx7vL7NwmsD3X0FaqMamp3PrtCYQLFbIdFh7vTM=;
	h=Date:From:To:Subject:From;
	b=cyHyfjlOYSivF6gxSyCUzcAktA0xUCBZyAkewsdC55+L4/t+boy96ikGiO81dZdfu
	 GwStxagwG42RKKYs7s0PV7oty8flYEzx4EBK0iSG8XqkMWpWmp8buRCfbxPJoLnFYF
	 ujhVG7etqT4RwVbC/QiPeZxuvdSBZBVmI6r8+OXaMZcDtL+5CGLKNL7WenOle94qN/
	 GgBdZi7dqfMzI3SovoDb/AtGQsPyR+hUW1GHozd+nH3rK5bU4u2QpSdAaj+bcTNTXX
	 QuBDg62lqyRjPG51obTZQrDzS3nhDWc2Cg0HT76Uc2lix29uh/f07U6xC4kbGkDJIx
	 p8uj3lhcUb2cA==
Date: Thu, 8 Aug 2024 08:54:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: potential patchwork accuracy problems..
Message-ID: <20240808085415.427b26d7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Minor heads up that updating state in patchwork is agony, lately.
I think people are building more and more CI systems, and patchwork
can't handle the write load. So I get timeouts trying to update patch
state 2 of of 3 times. NIPA is struggling, too, but at least it has
auto-retry built in..

So long story short if something seems out of whack in patchwork,
sorry, I'm doing my best :(

