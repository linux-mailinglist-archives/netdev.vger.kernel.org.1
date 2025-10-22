Return-Path: <netdev+bounces-231662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5C2BFC2A9
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 508F4563314
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EEA3385B5;
	Wed, 22 Oct 2025 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLyPN/7t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066C2344046
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139597; cv=none; b=Pfcht0HvdAtP2gwDxAeOBBETW2rmm3jnB5xdnrNuaGmkzXtQ6IArTTQbn/51+/ka/XqSJl/AWhbZxL2GIO+vI6kZvshl9zhRnQhVmzRMPLcqL6R6phJ8lnYQeNPy4BLq163EUpsKDY8x8q3dGKuO/8mX5I2rZvgIpqFfkezEjN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139597; c=relaxed/simple;
	bh=H/erDF3vIIghnsr4LVbaRnO6I86/Wews1gfbU3jckjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOXCMIGh9KrSuey94kCHWBurw6cn+cT8BdJkEpGVxVUzXVwQajrzHBdGMO1TowO7OSCoSXYoRLWa6jv+UIRooDXzTyiraUcoQedSp2tX6W8dEjSiWUd6lx4x/93cm7+JR1qm2apXgGhR1Rg0FUYqpBQzSUaLhnsUf86EPhIjIok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLyPN/7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B85C4CEE7;
	Wed, 22 Oct 2025 13:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761139596;
	bh=H/erDF3vIIghnsr4LVbaRnO6I86/Wews1gfbU3jckjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PLyPN/7t4iJUXHlJNm/un69ysXARO8O9WXNisKOzYUt2IG7q20bbfyPiRp4fZJhI8
	 QHaMD+n6q4e3qaUEytS2TaC/lMdKjZxdrJDnfUf4v5x5XI/KuBkOnjSF3QtjZWGhkK
	 IX696bDoV2T+m1equAdj9eDYjL7wQYcdaWEphDOdw0Xa12pmJdICjBRQe43gllqI1S
	 kulcwwC/oFIgu2QBxa8ZDjL6n4sI3UrQLO3e4wxKSoVDsU6dxlCltM0iHhmlxsOFW0
	 maWkAEoJpSuaaFz2nrOqb7oxxNzuY3Qe9Vve6aq5GijG3iYZUUf44xZWvG3fmpLyFE
	 WqnmxPcdqdfoA==
Date: Wed, 22 Oct 2025 06:26:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <edumazet@google.com>, <horms@kernel.org>, <dsahern@kernel.org>,
 <petrm@nvidia.com>, <willemb@google.com>, <daniel@iogearbox.net>,
 <fw@strlen.de>, <ishaangandhi@gmail.com>, <rbonica@juniper.net>,
 <tom@herbertland.com>
Subject: Re: [PATCH net-next 0/3] icmp: Add RFC 5837 support
Message-ID: <20251022062635.007f508b@kernel.org>
In-Reply-To: <20251022065349.434123-1-idosch@nvidia.com>
References: <20251022065349.434123-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 09:53:46 +0300 Ido Schimmel wrote:
> Testing
> =======
> 
> The existing traceroute selftest is extended to test that ICMP
> extensions are reported correctly when enabled. Both address families
> are tested and with different packet sizes in order to make sure that
> trimming / padding works correctly.

Do we need to update traceroute to make the test pass?

