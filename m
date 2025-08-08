Return-Path: <netdev+bounces-212182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9868AB1E967
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5880C7AAC37
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F8827C842;
	Fri,  8 Aug 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvc9tXR5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543A273D76
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754660688; cv=none; b=Y+FvFfEEVzNvFDF494kLaTfj7FQr4Ii380PQlWD5ud2n7gSEnzI8NQet7oYRwBx/HIZI8/qfZGNp+ZwRlX6lTg6OY5Yl/8fkINyLkHzUsrluUke/mGpx8LCDaCYfsiehOyL/z+Bg7LVn7X+3zzzTdopdGyuKNOC2kCbrTmfQ57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754660688; c=relaxed/simple;
	bh=Fjd74z6nl1sIEBfOGJhqPzlxzMvI3qYffQ5FwgvdElo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPYvxKa8afXORppqRFpw/qVrSSxhXJhM8Sr4hUZrVe9ZxE+b5deKmJ3lIjMobxYaDdwPEI74Y+gbOdPK0kRT/jA6vME5JCQ073BfpiInK6XWPQHlRDq+YH2k0CivFC0H7Wnq6RED3TfWGoVGj2gU9jY5IfYGMPmOOMGq9VZoz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvc9tXR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01973C4CEED;
	Fri,  8 Aug 2025 13:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754660687;
	bh=Fjd74z6nl1sIEBfOGJhqPzlxzMvI3qYffQ5FwgvdElo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvc9tXR57pefvA1PnVW0wnrR3PuOYiTWpjNJAG02qMdbZy7EhHwXzUvQ3fJJiG/Ew
	 0D93wGg+Y7K0uZ4W7HzPIBHrLVZJX0LcRjhtGyH+nf5cWi9QTQ8NsaeBtH/0D2ajLY
	 TIju01DgC2tolEmwQ7PJTAwqDlp1l0iMIN1YqqP09Hz9PcjzO1u4L3uV3AKcJ3Wtbx
	 MZvwT1fCIqFn98eHeKVKcr06x4VcX0aygXXtkgI4XFiOHuW0hsqdHosymeIZPUk0yj
	 E1Gfmox2Lc9HpYsrZRjIrVISHfc8j89WN0XX4d42KfiqP1YPf6TlrWB9013TUyle5u
	 wHq2OAM1L5vXw==
Date: Fri, 8 Aug 2025 14:44:43 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 4/5] igc: drop unnecessary constant casts to
 u16
Message-ID: <20250808134443.GD4654@horms.kernel.org>
References: <2f87d6e9-9eb6-4532-8a1d-c88e91aac563@jacekk.info>
 <8ae30b40-04e5-4400-92fb-86101b5c667d@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ae30b40-04e5-4400-92fb-86101b5c667d@jacekk.info>

On Wed, Jul 23, 2025 at 10:55:20AM +0200, Jacek Kowalski wrote:
> Remove unnecessary casts of constant values to u16.
> C's integer promotion rules make them ints no matter what.
> 
> Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
> Suggested-by: Simon Horman <horms@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


