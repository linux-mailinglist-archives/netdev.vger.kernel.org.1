Return-Path: <netdev+bounces-115876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2A69483CD
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E051284AC9
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 21:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5109214D70B;
	Mon,  5 Aug 2024 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuwLnjcL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3E0149E0A
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722891711; cv=none; b=cAkGZCXCxvh1hmiRndfc20BLdN/XdphZTaayi1+XXUaI4dGqq/CwZfi5jM4zjjQX5cVAHri8/sy64BZZMrC7tMEFbFTbRPZ3exc2kRg4Q3OOJonw+fzRoVIi2lny1uVqpPPxa1n77u7wmxeYf+pBeWlS5QotmtqhaWBibclshd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722891711; c=relaxed/simple;
	bh=KE4D7BaqTSe/EOV15sIqsEKbHrGf19aKqboJTjsfYuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGMSn7auyfh8CHqHpNSqeCa1sg2DCONS9sHi7tRb6AAG4efDluTJ/f1EoCmEGa7Ez6mbBlfdaHRe63g1Vu4ruXDrJQ5jbnAGnqKk9QaAEFr4ca+rzGWXaYf78BbDvXIUjvgh3+e62LSihRbcUraD3RKD3YTD37DSGWItlN+v8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuwLnjcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655C7C32782;
	Mon,  5 Aug 2024 21:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722891710;
	bh=KE4D7BaqTSe/EOV15sIqsEKbHrGf19aKqboJTjsfYuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CuwLnjcLR7NC9HoMe3q1j2VWVoTyYCFLe7o6vPOdSbdSKtaCWm7KfYUzOuegkNzF2
	 e196K9gn48CR+N7Q97eMLjt47HSrLaDe+9YqwUMNVcnkygR7XOvvBu2IiKNJly6fK8
	 XPdrM7BZdCsJdcco6pcqxD+tc0uYIPaH2e2cOYyM+d427ZL3INBLKC0cKWQM1pZ+WQ
	 lfcj1NzrJDiRRJZW1/R6/+wZrnEn/6mH5PY3FQk21uDN3I3oj2KUCQz3ugDjgBc3z0
	 YsNucqh/tibsljQWQxFjdTaTt9JVxQipgpgKFtWECE3/TgcjV1TEqSu7qfgY2KG4Fo
	 k4ohVEZ4GNKUQ==
Date: Mon, 5 Aug 2024 14:01:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 horms@kernel.org, anthony.l.nguyen@intel.com, edumazet@google.com,
 pabeni@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-next v2] ice: Implement ethtool reset support
Message-ID: <20240805140149.7a184ca6@kernel.org>
In-Reply-To: <20240805124651.125761-1-wojciech.drewek@intel.com>
References: <20240805124651.125761-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 14:46:51 +0200 Wojciech Drewek wrote:
> Enable ethtool reset support. Ethtool reset flags are mapped to the
> E810 reset type:
> PF reset:
>   $ ethtool --reset <ethX> irq dma filter offload
> CORE reset:
>   $ ethtool --reset <ethX> irq-shared dma-shared filter-shared \
>     offload-shared ram-shared
> GLOBAL reset:
>   $ ethtool --reset <ethX> irq-shared dma-shared filter-shared \
>     offload-shared mac-shared phy-shared ram-shared
> 
> Calling the same set of flags as in PF reset case on port representor
> triggers VF reset.

Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

