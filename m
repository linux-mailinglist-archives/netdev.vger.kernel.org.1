Return-Path: <netdev+bounces-212181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D114B1E966
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95007A781B
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1472D27CB31;
	Fri,  8 Aug 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJqODS9h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34BA27C842
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754660675; cv=none; b=T4LpGgYgd/uiG18o/2V5BmP8rK7D0uMfDiZpV692EnGhEuSqq5Yms745ob375X7MPGMqcIveiA3AGYajBl+HIQ4G932AoZJ8SRj6+xqcMwBtoCekgDaiKYw6gXqoMifZFYlEqPPFXxZ41EYs4Oeb1F9anJICjh496LiKe2jRtuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754660675; c=relaxed/simple;
	bh=L+KQYCSs9EfjIlqJ6ZcI+ycl9sHpBOuiNmn0PhnTgRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=um+KDnAD1syUBzd1poR5yQZ7bnEEAbq0tihhhYZhN4GrfOJKfqsmrdg/bhJp03mnrXHWdRkAg51YlgLDl6dtrJaNcvuWtWE5FitNv3IeWf37PJzyjCk8rwzroeCaovgwdWBzE/MD7lr4tZ0jctRiWyrnyAX5BD9fxZPsW2COOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJqODS9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9442AC4CEED;
	Fri,  8 Aug 2025 13:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754660674;
	bh=L+KQYCSs9EfjIlqJ6ZcI+ycl9sHpBOuiNmn0PhnTgRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJqODS9h4AtBE8Cg+jvdW0f5GK9qLNnCgm5CzF8wrLPr/9X1Qk1YvrzVuOPU/YSRQ
	 LnejtFyIPxGWuGjg+0XpWRXaDkxVXeWw06AWwsiPZDCJV8bNxXprnP2M7qUpJwWKS+
	 iSpjClqfwT0eG3uK5sPdgqrHFexMd/aKBAuwrCgpphvqPE+B0MCWzu/F7C7bPJsl6j
	 l+7CE0avhSAFtkDojqzXFXBskKC0Wpjgl1Ki3hpdgIzoJSww85qMB703qogY4SXmYG
	 SPkeWuYjQ1OqKcGx4As4YxGPGg6al50dMkSRo2eQQacrTdgU1IX5e7sMqtCPTiyMbP
	 K7uOXk+2xps7A==
Date: Fri, 8 Aug 2025 14:44:30 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 3/5] igb: drop unnecessary constant casts to
 u16
Message-ID: <20250808134430.GC4654@horms.kernel.org>
References: <2f87d6e9-9eb6-4532-8a1d-c88e91aac563@jacekk.info>
 <e16d5318-3e5c-4a4a-a629-ba221a5f04c5@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e16d5318-3e5c-4a4a-a629-ba221a5f04c5@jacekk.info>

On Wed, Jul 23, 2025 at 10:55:03AM +0200, Jacek Kowalski wrote:
> Remove unnecessary casts of constant values to u16.
> C's integer promotion rules make them ints no matter what.
> 
> Additionally replace IGB_MNG_VLAN_NONE with resulting value
> rather than casting -1 to u16.
> 
> Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
> Suggested-by: Simon Horman <horms@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


