Return-Path: <netdev+bounces-135098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD06599C35D
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D542833C0
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE3A14F12D;
	Mon, 14 Oct 2024 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhlqlJSa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAD114A60F
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894698; cv=none; b=F1zaSegdIGNR+dB480JA1iZW9c4sv68i/zU+kBWa/zBj/A4PentjFUjhjA139iivX9Pvzvv5vMpUIGVtkIE/OLrxheN4vPjMTu6atXaSuqPaDM4u0ZvQxVmt4y1eAsKZYbQ8JG1bu0rHFxwZ/a5FC7FaP87S2od4Tbwoerd4BNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894698; c=relaxed/simple;
	bh=4ods7aJLQvBDP32mFMeuQJAEmLsu3AktdfWzx++QINA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTIOEEqgelDvEI6Jz7ac8KqE14XjG5fHNWyLvsxD3e+Ogab090ka51E0ig9n1FlDYn9GUOBvND5kNG8MYLW6rrdaoUKDS3pYZ8yEwkKjYEIEuKwgaAOPh5D9eIQ0z9jwvaQsDXYdMdyGAokrTYFU/ktvPE04Se6BkAgbk27O+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhlqlJSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A9EC4CEC3;
	Mon, 14 Oct 2024 08:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728894697;
	bh=4ods7aJLQvBDP32mFMeuQJAEmLsu3AktdfWzx++QINA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhlqlJSaHFAUb1m6vAWiLWJloQUGMESZ00Vw4eet9OiGTAb6xD/a0rNOVnwzLqYu7
	 dCQSe8yyPGTSRSNBxqg5iYf5bXN3OomzO1DEJPU1JHHT0tG9S2KJs/9T90KpCTIXo9
	 RBPKsG7wCB01LspqDNTsuJjgvImAEPwWz/3zh0q41q4Jk4I0/ZoXWiTQlLxk9FItTr
	 It0cmg4lsMz0bm9/Z4mFnLMC4LeTPeLclisxMyz4hhzD9kbkbcwXMo1IUJV8upDIJW
	 LjCesPgK2xjLAhSSuiO+3uohOHYfjmef4xeBSGHotaXcJduDhag+YjMWlPhR/5faxP
	 cS0WMsV4SdhTQ==
Date: Mon, 14 Oct 2024 09:31:34 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: implement additional ethtool stats ops
Message-ID: <20241014083134.GM77519@kernel.org>
References: <58e0da73-a7dd-4be3-82ae-d5b3f9069bde@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58e0da73-a7dd-4be3-82ae-d5b3f9069bde@gmail.com>

On Sun, Oct 13, 2024 at 11:17:39AM +0200, Heiner Kallweit wrote:
> This adds support for ethtool standard statistics, and makes use of the
> extended hardware statistics being available from RTl8125.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


