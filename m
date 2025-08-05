Return-Path: <netdev+bounces-211781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 888AFB1BB31
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 21:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4307184DAC
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 19:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C04259CBC;
	Tue,  5 Aug 2025 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h12VViHG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF127258CDC
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754423573; cv=none; b=IbyGk649IyxZmP4Q4benfpfF57qPqd5CeYeZBNojUefCNNtbXTbbkU5UdeUN5TLKlL7H2nCYfvoR8IHyjSNOa5616tVGrJW6gtGJigPNWnOw0+5wleMqniDR3J0DmLGKkMXwmbz7MMkcesen8HiFhrtj76Y2gvi7c8YA/Rd6s4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754423573; c=relaxed/simple;
	bh=EnsH8YaUxXWensuWs9XSdX/sp0Jxa4K/aC1wE2fzMfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eknKyyg6B/zW0Qnvgpvgp30MuPpYCxwTAhQtDYGpA8+5foTaptv5HxJ/44tt4P3F8yD1WMX+b8MMkyuGL+sCDFQSzLfhkAnMXdjBHEybLkYGqJeiA+ls8tMr2AybQMM7Ir00Ua/E0SaOhWKhcY0nkYD9sMA4kWbJt6UY7AO/vr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h12VViHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84978C4CEF0;
	Tue,  5 Aug 2025 19:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754423573;
	bh=EnsH8YaUxXWensuWs9XSdX/sp0Jxa4K/aC1wE2fzMfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h12VViHGcP5UEwXypd7UlLzXiLU9y43ss/kdtT7Fwk8ma7JTqVGcdru/p+9JAMoza
	 Tc7ZjM3uKS/I+tmjX/99WIW9PJMO9xl18k7Ym62Q204iX/nTYuTfi+MdwNzdV4rkJR
	 rYiy6bP5k9YA8tYrWKBT0tmPbPUIy6k71q8vrfqYZ8lZQUZ4AhqpPEo7GGXNjqhF4g
	 xfX8y8QK0sfm+HHqoAk7ZGSwgqAa6qRa1jk8M6F5xOm9/pndVMP86KQXa6hb3VYKgE
	 E7CWE4tshgK9HMbgpJHNRDqmGsve6iEJ1gnrmdLbwEAVHUlibXBNZXQBFVBXxHvLnu
	 UtZ0cubRzZ70Q==
Date: Tue, 5 Aug 2025 20:52:49 +0100
From: Simon Horman <horms@kernel.org>
To: David Hill <dhill@redhat.com>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH 2/2] PATCH: i40e Add module option to disable max VF limit
Message-ID: <20250805195249.GB61519@horms.kernel.org>
References: <20250805134042.2604897-1-dhill@redhat.com>
 <20250805134042.2604897-2-dhill@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805134042.2604897-2-dhill@redhat.com>

On Tue, Aug 05, 2025 at 09:40:42AM -0400, David Hill wrote:
> When a VF reaches the limit introduced in this commit [1], the driver
> refuses to add any more MACs to the filter which changes the behavior
> from previous releases and might break some NFVs which sometimes add
> more VFs than the hardcoded limit of 18 and variable limit depending
> on the number of VFs created on a given PF.   Disabling limit_mac_per_vf
> would revert to previous behavior.
> 
> [1] commit cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for every
> trusted VF")
> 
> Signed-off-by: David Hill <dhill@redhat.com>

Hi David,

Unfortunately adding new module parameters to Ethernet drivers is discouraged.
I would suggest that devlink is an appropriate mechanism.

-- 
pw-bot: changes-requested

