Return-Path: <netdev+bounces-231051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4F4BF437D
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 03:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9658B4E369D
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE4E16CD33;
	Tue, 21 Oct 2025 01:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoQlZE7f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA71354AC9;
	Tue, 21 Oct 2025 01:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761008591; cv=none; b=G1SbDJZtO5QEdwGcad/77Ov2lmmJfL9xZgIFXcCvM0DPx7kbSwaJp0PYzMn8FtphVzpaDN1a+VfDSQ9wvdMlDbnSGyF+85AMOZst9zMkNhACjBKmw7mDGxfDqIaBAxGR6WERUR6zWjQg6VywUUrMDQpfPwhd9hu80Qugl5YlnR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761008591; c=relaxed/simple;
	bh=kZUG3ekjbgqMUNy0q3i+gFuqeUpAWQ8+S6giYThScJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cr1d7FzuAbq6JulKWWCfmP6jgBWB/XOxdIdJqW4htxYFsOO31c6Ex0dgBcOdwmiU+R+5rl/jpmJ19/0EUOWUXCaSO5BR57t9JUVgPzxM2C3xw9dXw2Ei52qKZPM7qt6zqmrHs0LLjnjQUPR9gZZrguzyby5HPDrwGLfstcZ3tC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoQlZE7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB3CC4CEFB;
	Tue, 21 Oct 2025 01:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761008591;
	bh=kZUG3ekjbgqMUNy0q3i+gFuqeUpAWQ8+S6giYThScJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KoQlZE7fEp/69DTCsk3mks1FSpdb5anEGzXte01mSzflvCuUOU+bVpIhvRGX6o/iL
	 4OTw5EJxosg4VkG/ckez1u8WrVPGStAgTIg3CU/bsYmzpqADp/q65xcqUTMbuPCOuC
	 f/v5G3D9e9nIn2aw1rkiN2dPrdx70JHXNdrW/MaZf/Y7wtsbSSoFZtRZCv4eD61DCJ
	 /B2b5Amdzzv9vGJgByWu+vKjA9fRj9qnHcmFLjXfOAuHF3frPYU8t74Jog1iMuUtHv
	 SXqDtdgvs+YLiHAgwRpcOvy5L8B9aqpp05DwKSzlNIel5baHxPmf9AHQu5lbXEbDJ9
	 5Ey8byknV+a+w==
Date: Mon, 20 Oct 2025 18:03:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Alexis
 =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: stmmac: Allow supporting coarse
 adjustment mode
Message-ID: <20251020180309.5e283d90@kernel.org>
In-Reply-To: <d40cbc17-22fa-4829-8eb0-e9fd26fc54b1@bootlin.com>
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
	<20251015102725.1297985-3-maxime.chevallier@bootlin.com>
	<20251017182358.42f76387@kernel.org>
	<d40cbc17-22fa-4829-8eb0-e9fd26fc54b1@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Oct 2025 09:42:57 +0200 Maxime Chevallier wrote:
> > If the HW really needs it, just lob a devlink param at it?  
> 
> I'm totally OK with that. I'm not well versed into devlink, working mostly with
> embedded devices with simple-ish NICs, most of them don't use devlink. Let me
> give it a try then :)
> 
> Thanks for taking a look at this,

FWIW I dropped this form PW in an attempt to unblock testing of
Russell's series. I'm not convinced that the tsconfig API is correct
here but I don't get how the HW works. Could you perhaps put together
some pseudocode?

