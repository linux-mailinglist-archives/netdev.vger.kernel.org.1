Return-Path: <netdev+bounces-55396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DCB80ABAF
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFE81C209BC
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F21041C82;
	Fri,  8 Dec 2023 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgwK6dUK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D401F61F
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 18:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5EBC433C7;
	Fri,  8 Dec 2023 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702059137;
	bh=TrMyYC46sgdeq5HEr4Veoe5uWZdMdVGOQ4AxMQNhVoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sgwK6dUK4rP01ONBX8ww3IErWDPQe/9/TzAdfqDmu1laKonvRW9asFiYvNjExTCmj
	 +SgGJuUhrtWhZVD6WWKeRBJYY4eLYqGoB5bPBX9k1IKANjMiT813XeBG7R7NdbBgLm
	 49hMG1izHmIvyriftmMO/LIF9z9kTmWK7um5ANdizeMtPLs8tBnvTPzteHN/CXBWRU
	 V5CTGxJKeyrO3PhEyMPT62cX/4yWHppNSxxfcf2M2npKtnt46MbBcMB7aeVJYfIJNE
	 IYTjsSnionvjB3TonFpFJ4rl6/epk5HLON5s/nJ3YpsFqwATZtpxCMaKpyY4ANZCaU
	 DTdpPob4qA4tQ==
Date: Fri, 8 Dec 2023 10:12:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Tresidder <rtresidd@electromag.com.au>
Cc: netdev@vger.kernel.org
Subject: Re: STMMAC Ethernet Driver support
Message-ID: <20231208101216.3fca85b1@kernel.org>
In-Reply-To: <e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au>
References: <e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Dec 2023 14:03:25 +0800 Richard Tresidder wrote:
> I've looked through the diffset 6.3.3 >>> 6.6.3 on the driver
> drivers\net\ethernet\stmicro\stmmac
> But nothing is jumping out at me.
> 
> I could use a pointer as to where to look to start tracing this.

Bisection is good way to zero in on the bad change if you don't
have much hard to rebase code in your tree.

Otherwise you can dump the relevant registers and the descriptors
(descriptors_status file in debugfs) and see if driver is doing
anything differently on the newer kernel?

