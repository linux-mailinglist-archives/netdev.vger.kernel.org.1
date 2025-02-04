Return-Path: <netdev+bounces-162443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99887A26EBB
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6122018871CF
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EAD2066E5;
	Tue,  4 Feb 2025 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On/zLR7q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDADC20125D
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738662439; cv=none; b=eSAw1nTIUrhEmCTcCgYK2bpJRcWiFGA3t9wOYjdDP0OPfM8AC5ula0bl8EnmmUW9PlJ1/1ULE+gjTLdlHCuVwTYZwZ4AsETojde0v27V7aqA/ESgo3XQqI+i+pmBbZG4dsH/zhTmlfneHdlByyTMwTT1gBMPLH3wwperH2jAsWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738662439; c=relaxed/simple;
	bh=C2zZvBFQfi/llnSqpQRqG2mTn3t73PX0K/Zh+rjZvJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCQDKzAZW7jpFTtGOC4I4aORCukGzI5dadvGFj7MmW1xYmUTgMZfzaxigCucSROYbLLUXRSGCpHGQerUr6HeWUDTE9OxB64xPMM+/Pzyqd1h3SfBtLbSD0ZqMWGfzm0UJwTkINxTJ0W/z51bPQY0xAccgXlm62XLgw1d+ZWfAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On/zLR7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C58C4CEDF;
	Tue,  4 Feb 2025 09:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738662438;
	bh=C2zZvBFQfi/llnSqpQRqG2mTn3t73PX0K/Zh+rjZvJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=On/zLR7quK6qTiyoBkZD8d910QkAfjx3YlmqdVWNSGHFXMv+r+ntn7Z6UhbPk33My
	 BnWNVFpYXOe9P2ZaGA3RoiVsfGiG+u47EZCQ5TBoJCcXkN3Jy5O7NZlhvULG/JGZZD
	 z9uu5Eh36aQl5mznu5EfPCOvPQJpIgk9jF1QpuYRCeYSbVbUHpc/onbuUBsmVWa6hU
	 K1Hss7CoXSd4fvzpc0ai/PcnmKVtwpz1dJJDsKCZ04ioPnQqvQBNxMmTEcMV/5NxUH
	 +BjBE1CAItK1fVVz4eMudbN1vMbikkg3j50ZtzjsrxMUNlYAhsof1IW5cDGRXCz//a
	 X6eekuo/p2ZNA==
Date: Tue, 4 Feb 2025 09:47:14 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] neighbour: remove neigh_parms_destroy()
Message-ID: <20250204094714.GN234677@kernel.org>
References: <20250203151152.3163876-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203151152.3163876-1-edumazet@google.com>

On Mon, Feb 03, 2025 at 03:11:52PM +0000, Eric Dumazet wrote:
> neigh_parms_destroy() is a simple kfree(), no need for
> a forward declaration.
> 
> neigh_parms_put() can instead call kfree() directly.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks Eric,

I agree that this is the case. And I think it has been so since
commit efd7ef1c1929 ("net: Kill hold_net release_net").
Or, IOW, for about 10 years by now.

Reviewed-by: Simon Horman <horms@kernel.org>

