Return-Path: <netdev+bounces-66829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDCE8410A3
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 18:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427D21C23CD4
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D526776C9F;
	Mon, 29 Jan 2024 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVAVvMo+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7CE76C9B;
	Mon, 29 Jan 2024 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548691; cv=none; b=G/k6XNgIaRFekn0H+/7iudyuyxl/5s6MX6mxpUTxothIJoJAUWkeCGVNDsPILg4A5gLAIvN7naUeAeu6NfOt4L0jW4W+5v4G4NtIVmuvyyN1fgFhtB/aCyF1Q2odg+1H4HVh2Em6FGpTomku+8o5jtNm623jjK/wYTsksMJyXK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548691; c=relaxed/simple;
	bh=ItY/kcIqNm1rdDzu5CBPiUuZZCMBdOuHaO1R4dtYASI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2aBWAj2vNbjLAF7wB+bZLNOeYHuvesIS5HtaB7DEaLjCJ3+f2n0tkQEBsEI8UY+TVayXYTKLCDh0xugRaBgrhbwVqNMCYpZEXuWLMFRsNADSIqPjWSj4DKs22UxxETBEDPb4vLeGoDCawgSElUuarNu56oDR3fPPpocu6Qrtrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVAVvMo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41920C433C7;
	Mon, 29 Jan 2024 17:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706548691;
	bh=ItY/kcIqNm1rdDzu5CBPiUuZZCMBdOuHaO1R4dtYASI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XVAVvMo+6Kmz62BtKuov1v3LkpZ8BVEjTqGOGq1xDQbrdFbkIJrDJCPYwfsBjrHDU
	 DziyXWVw9/FT8JGsGaLlZ23MxAyIVVroSHWS5tuufmuVCR8xw3HhwoU/PPziWw3djM
	 msJM1LNMYT5vLny6/cL9KU2CbLoe7h4d/DJDmeSvhJLuwFBB2/kqMXZ/vp0DI66vka
	 2Q4yVvUq5O7jrQQK2WRP1h80/b9kuRep+xbVY6zxCKh/URPZzm8rOPGoGvj3KzUqa8
	 8W6VtI5WqclCHPNedT5aHFbx98bhtFPPj3IFJMpVNCgxKy0IVtfo8HCFIAJFW5sBsp
	 RNs1FGKt4r7ZA==
Date: Mon, 29 Jan 2024 09:18:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <20240129091810.0af6b81a@kernel.org>
In-Reply-To: <ZbfZwZrqdBieYvPi@shredder>
References: <20240122091612.3f1a3e3d@kernel.org>
	<ZbedgjUqh8cGGcs3@shredder>
	<ZbeeKFke4bQ_NCFd@shredder>
	<20240129070057.62d3f18d@kernel.org>
	<ZbfZwZrqdBieYvPi@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 19:00:49 +0200 Ido Schimmel wrote:
> > Installed both (from source) just in time for the
> > net-next-2024-01-29--15-00 run.. let's see.  
> 
> Thanks!
> 
> The last two tests look good now, but the first still fails. Can you
> share the ndisc6 version information? I tested with [1] from [2].
> 
> If your copy of ndisc6 indeed works, then I might be missing some
> sysctl. I will be AFK tomorrow so I will look into it later this week.

Hm. Looks like our versions match. I put the entire tools root dir up on
HTTP now: https://netdev-2.bots.linux.dev/tools/fs/ in case you wanna
fetch the exact binary, it only links with libc, it seems.

