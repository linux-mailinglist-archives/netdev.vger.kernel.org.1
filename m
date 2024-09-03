Return-Path: <netdev+bounces-124707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC3196A7C6
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E995B20CBD
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355C91DC732;
	Tue,  3 Sep 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjNuX1FQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1082A1DC731
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392984; cv=none; b=P88WzXY6+97gPT4rjOtRXgi5CHSy6ZEwkAeyqBAcR6O4CG1vTLV59jyvagiG85B0CRLKy9qCAT/RtZLfP42IqOyngzkt9STX73aaSfKXheiQwCbRTLyaN1Ze5oH8tqlIMbDqh0fuINW7J9NYX1uCV1Luqy5aBrSEJwrYHqdxlTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392984; c=relaxed/simple;
	bh=fzygQy5gzNziNb8p4ILYWgLhZ3zN0B6GdCere4yTyok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktnpq0TiEZcH4DdC2wSVFgUUscYXW6rA6zFZSphb14N4GftHVfY9BX3uxkkirWKMf4zBYJFwCiB/cWiiYpg/F1W3UlMsz1x+mUkds+AVN+W60LWZ7CERBbQpRyVRIqnAW+WUzld1uufZ1aZ8eryX3Xh5WIkwr2Dg4zL9QYrCS0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjNuX1FQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385F5C4CEC4;
	Tue,  3 Sep 2024 19:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725392983;
	bh=fzygQy5gzNziNb8p4ILYWgLhZ3zN0B6GdCere4yTyok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IjNuX1FQnTqim/1Xl9mc8mu5mHM98xUzOFqN4xw8G5z9FVmDy6KN0fIZTW+qK289A
	 YQvRmTGNq9DksgsHQbCEqhArY6wzD7A7pK7MUnJ4remgdbJonWOsLASs5W9m/Ic5Sf
	 5Yarc5QhKNjf74ScUjqrpJ0B29cvMBJARvdDDZSmggGJ+KUIvnlF59XsaD3MqChASm
	 4NBao6xUouwDmw/pOscXr8uEPFFIvPGdZf+zOhV/v5gnJO5Fa2qDXaK4DcMvLs8YUa
	 ytomWf9mWbBXte3gqbPO4oOnd1WsCwHs4ClYflNGrjxIsJOX7lpWQNd/SKJwsu9EP3
	 u+Ig3xnxvcAow==
Date: Tue, 3 Sep 2024 12:49:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Sasha Neftin <sasha.neftin@intel.com>,
 vitaly.lifshits@intel.com, dima.ruinskiy@intel.com, Avigail Dahan
 <avigailx.dahan@intel.com>
Subject: Re: [PATCH net-next 3/6] igc: Add Energy Efficient Ethernet ability
Message-ID: <20240903124942.14021b0a@kernel.org>
In-Reply-To: <20240830210451.2375215-4-anthony.l.nguyen@intel.com>
References: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
	<20240830210451.2375215-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 14:04:45 -0700 Tony Nguyen wrote:
> Example:
> ethtool --show-eee <device>

You're only adding get support or am I misreading?

