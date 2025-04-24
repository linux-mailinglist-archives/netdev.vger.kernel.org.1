Return-Path: <netdev+bounces-185750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED344A9BA2A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 23:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432364C032E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 21:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619631F4CA2;
	Thu, 24 Apr 2025 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3Wa5Dsy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C05A13213E
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531490; cv=none; b=hiPNkPKsnbN1j7jPUsVdCOML9drnYpTML61QAWiBKwNd55WZJAI21pV226TF3Sw9XLT6eyi2ZiMMxjKNnw+rifAwk1D7yEZYxv0CaCDM5zjdm6K7TpCHUJbQ2gZl8fyC1MubKXkPfmDq6YJhlNhWdpUOcTHa5+Ok8GDG6y6Cb/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531490; c=relaxed/simple;
	bh=vXFnq7T8BFjilvzemBf6JKS+yPMnZnAunb0OsaIiAmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDWWPIe51h28nWxYBGS1mHhhaTTY/QTSi6T/rwCGh/STUr33mViEgZTrdhnpD8gGvZ2B++DHX6p9ZdTbDMS93N/pUs5Eyv3fZlfxavqiyxcnoHq0j+Fv25vkB55US18SyOK0LzOySpwHkfDxxO1zQCKjB01tD5vxs6XvReA+vaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3Wa5Dsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C6CC4CEE3;
	Thu, 24 Apr 2025 21:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745531490;
	bh=vXFnq7T8BFjilvzemBf6JKS+yPMnZnAunb0OsaIiAmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P3Wa5DsymeIBSXqagXow5N/PjznV9lD3vYmuGPBdGXwy1w10yw+MryLX9oMrdSWlN
	 JII13UbpH78ZyMDKSSsgXu+Rgx6JbfWH9kcB6PVPD/DrNygtxYfhQ7IWBHHC0a3UvB
	 JH8wG8Rue4LtbwJVvyskfwgnC9tiEUJ/VOCjEVjFI96M3OlBP2RHzvGFTHr53LAH16
	 3hoVMaCxqKRkx8p6v4grBeOtTd8sv10lbkCrvQ9OIUAm3CAJhJX/v1+yAYyTtq+2yn
	 N6BIYaMY5Mre+M0uXaXufvaqLtOOQzhE2Fu31LXPkdWWsoh/IBKitpFoYh5ZczzWCr
	 ujdKmbEVIIb3A==
Date: Thu, 24 Apr 2025 14:51:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
Cc: "jgg@nvidia.com" <jgg@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [iwl-next v5 0/5] Refactor to prepare for Intel IPU E2000
 (GEN3)
Message-ID: <20250424145128.60467c51@kernel.org>
In-Reply-To: <IA1PR11MB7727AF19E37851E3A4964C77CB852@IA1PR11MB7727.namprd11.prod.outlook.com>
References: <20250416021549.606-1-tatyana.e.nikolova@intel.com>
	<IA1PR11MB7727AF19E37851E3A4964C77CB852@IA1PR11MB7727.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 15:58:56 +0000 Nikolova, Tatyana E wrote:
> Would you be able to review this updated patch series?
> 
> Netdev maintainers,
> 
> Based on Leon's previous comment https://lore.kernel.org/all/20250216111800.GV17863@unreal/, he would like to get acks on the netdev portion before creating a shared branch. Would you be able to review the series?

I think the usual process would be to submit a pull request to both
trees. 

