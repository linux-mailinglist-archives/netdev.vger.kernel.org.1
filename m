Return-Path: <netdev+bounces-170078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE3DA47346
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C573188AC2E
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 03:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FF71537DA;
	Thu, 27 Feb 2025 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXRMEJgp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B68182BD
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 03:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625507; cv=none; b=gat9yrVdxu4/wtp5VXpYqEr3ByLy/x9Muo8ducLv3pqgqX6mDZvI+zY65BYtGM9D8P+30v2knQzaKMqHPrw9Qt2liEn2GrcZTtf/RwWW7ZLTtXyFTW2CHymdvywy0PxtePuNvg3U9rtfFl+MhJl31ikxHsgscIjfNUtlJwu4leo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625507; c=relaxed/simple;
	bh=1WCzRUiWdOh3Z7ACd6nSUaQp45jGi7UUglncaMl8U0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRzdkOLbQ4Oq7owJpE4HPhkYuWB5JuZekbwljaisiXCGW7jAspGuK2sPJqxUia+SFbczq91Aa2WwTki/4ezzurAkIm4l2Lz5djbYNU99NnQ7h/HkgDl2Kq0G1N6blOacrHsZdDSykd14Joo5pXIr3KhHf2I52XsCS2Y7naiINx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXRMEJgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46248C4CED6;
	Thu, 27 Feb 2025 03:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740625505;
	bh=1WCzRUiWdOh3Z7ACd6nSUaQp45jGi7UUglncaMl8U0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kXRMEJgpJOnZErMy83X5knz+h4zd92N4lq8WQdRWJqn62cuUfN8itmSOFZmXfKsxp
	 ci3pYtCcbb7kgAfpfD/4MNrTzSH3g9egCyfrMieqfruRYnrpfkIh8upuoAOfZ2fZss
	 oFwbWOcsqBBW5SPgrxYP2GF7MmQDsV/XoVODHfVo9y+lrszUqXcC6z+vojBPZL0jyU
	 51y7io0Pxp+D0VVJKKdgF+niNLFOIvBK6nmx1k9PG+EEm5ekJn5c8oX7l26PZMI2DX
	 GG2Bz4Zqn11FsH2NcbZ3pr+ncJtTLbrZZ7LUfbjYqYpE0OSAmzVCvNITVMQitSVmdV
	 775e/eqBSkdQA==
Date: Wed, 26 Feb 2025 19:05:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v20 01/25] mailmap: remove unwanted entry for
 Antonio Quartulli
Message-ID: <20250226190504.09b57456@kernel.org>
In-Reply-To: <53278a6e-dbb4-4f81-8c21-1bfb447ab8b1@openvpn.net>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
	<20250227-b4-ovpn-v20-1-93f363310834@openvpn.net>
	<53278a6e-dbb4-4f81-8c21-1bfb447ab8b1@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 02:30:06 +0100 Antonio Quartulli wrote:
> any chance to get this patch merged in net-next, so that I don't need to 
> resend it each time?

Sure.. let's see if the series can get merged as a whole and then
either it's a non-issue or we can pick it up.

In general if you want it applied separately you could post it
separately. I guess, stating the obvious.

