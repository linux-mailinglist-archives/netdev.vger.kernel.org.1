Return-Path: <netdev+bounces-42795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A873C7D02AA
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 21:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B345AB20D42
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3662F3C08E;
	Thu, 19 Oct 2023 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WulCu3bn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199273C06D
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 19:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C280C433C8;
	Thu, 19 Oct 2023 19:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697744587;
	bh=LjrTlBbAy9tL8fyll2/yeV1R9C88AXD2Wq7hLY4tZww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WulCu3bns2V6OirFpjnFhBLuItJj8etOeHOTPQrtEPFHxVojcIEOtZX/cfSuVrQEj
	 ylWzkCE4/ZcYWrgeCywov4vSrDR3SzJoU/zjgK4ZRnSm9dNvjoMIl5JthrRPHu4KUK
	 I4tRz739rRAfP6x2AprydtUZEXb+rBra4u4u411fRpApTiMByNYhVPFKOoNFfP0P3A
	 9alsTVaPWtvthFybyI9e7F3WTthmuFfv1AD54mbTNK/RsKDWsEeuQ85dYxBAKNsABH
	 C9mmp6Tt8Vxj/iIjqq5T/7Qbh5kElvzTpt6P0QQ98evMnVdrRdvNbK4VoRqDG3qD25
	 o4gzRMBDcX1fw==
Date: Thu, 19 Oct 2023 12:43:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for v6.6-rc7
Message-ID: <20231019124306.084dedbd@kernel.org>
In-Reply-To: <CAHk-=wh0jmsuetiD_k+M9NHt=ZH=9AyBa-3+MYDfBPMw6tsaOQ@mail.gmail.com>
References: <20231019174735.1177985-1-kuba@kernel.org>
	<CAHk-=wh0jmsuetiD_k+M9NHt=ZH=9AyBa-3+MYDfBPMw6tsaOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 12:17:36 -0700 Linus Torvalds wrote:
> Well, it certainly sounds like *somebody* has surrounded himself with spirits.
> 
> Of the alcoholic kind.
> 
> Just _what_ does the calendar on your wall look like?  Is it maybe
> spinning or looks doubled up?

A spirit told me to burn the calendars and live by vibe :]

