Return-Path: <netdev+bounces-132923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450BC993BA8
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 02:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F231C23EDB
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3451B79C0;
	Tue,  8 Oct 2024 00:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIJaIsVJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A03F6AA1;
	Tue,  8 Oct 2024 00:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728346884; cv=none; b=h0BKHwFa2j4K/I1q87xq2uQIhgbCHRchVdZGqNB3Dc1s275kXFjdqohKqAR8YjBM+Mu4gpZQlBgWGhZz+G+aEzTRnOn/OSuMYgpCwG6MP6b1ahYax2fSUVfCf1NgXzYKbxSBu3iZ9UfPTMsk8BdxZ6dH8ebd69zNvqcSlQu93po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728346884; c=relaxed/simple;
	bh=KR2Ypbof7fqw9S7256Ff1zDPZlQAMxBLEB5g0hsgCZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V99i9hDteo5FlSQhV/oXTH5M52CYOALkbUoXrPd/jv8pVPf/irtnDwxVQvBuVu085deG+cHeqfzVgG1jV/gZjDGUnfWbBTlHGwnLsvDDZWtqdBA/c5FR/lzcuIZTdi7beGmsvzATpD13aASFETjP7chUaZ5MCHeHraRgLJVCoqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIJaIsVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CA7C4CEC6;
	Tue,  8 Oct 2024 00:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728346883;
	bh=KR2Ypbof7fqw9S7256Ff1zDPZlQAMxBLEB5g0hsgCZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZIJaIsVJ34+zdvuDnp7Dl5OPRS+eCx1i1ukMtkrah40cZotU6y8j/g+TEThMc+tCe
	 b7pE/vOVrW586WGd/3bDUrjo/01jyylT1aW4pMy0B2EeUg37dk8/tvHkwm66Nvu931
	 mpdoUBMIcEpWR4Aik/MWyafpQLMIGxUOzjS7t2AaMdPkhU3HYf8YOzo8wIxrvsCoCZ
	 2llvApPIA+HH40GNRXRXcXrXy6NAg9bMjuHLfgDE+lQj02pxS8dit2uKmyi86WBQLu
	 i5he+pxrUwEvMYEs0RbZF6VnhVEaEbORc1g1HM+3aPXa7shG3nhGEavMTewubOzxyd
	 yv7fm8sWXMu/Q==
Date: Mon, 7 Oct 2024 17:21:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
 chunkeey@gmail.com
Subject: Re: [PATCH net] net: ibm: emac: mal: add dcr_unmap to _remove
Message-ID: <20241007172122.6624c1ec@kernel.org>
In-Reply-To: <20241007203923.15544-1-rosenp@gmail.com>
References: <20241007203923.15544-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Oct 2024 13:39:23 -0700 Rosen Penev wrote:
> Fixes: 1ff0fcfcb1a6 ("ibm_newemac: Fix new MAL feature handling")
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

I'll fix this one when applying but please make sure there is no empty
lines between tags in the future.

