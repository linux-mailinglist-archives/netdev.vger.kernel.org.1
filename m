Return-Path: <netdev+bounces-186621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1231A9FE81
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 02:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F214811C2
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED27313D8A3;
	Tue, 29 Apr 2025 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDiXG8Hl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C5C86353
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745887147; cv=none; b=UdLCQElGnpbmvkiZSOJxckibgB+nms9AVMPQbCUzuSLjNbGHgA+ldm/rplwdU2hmbpV2LsiQalU7VbbFdeM+CY2+LjP6Q+uj+d40zRQG+XrM7GQ8eiLSqb6gsUEJvWHr3548Ia5NeEg7GZ4vBo3L2Pn5ic+SKCKlYcQddaifbA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745887147; c=relaxed/simple;
	bh=IdPDP+yzjvGJATlvy+h89DiE2Uw1wQ2CqY443Cx0BYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMQFib5N2XAxmpksBVN/m1mJGgoQjn0LN2ZqlItHix04dJ4b2493niXRzks9Zf3ySeSj8Wi8xtY6Y1vkPV7U/7CP15A9Oc8LFp+FktL1IXSG7r0UGseZQ1iJeyM6hqaC+JNcR3VpX62LTjBKrWu8GPZ0WxS8Hm0VAIislr2zkKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDiXG8Hl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5A9C4CEE4;
	Tue, 29 Apr 2025 00:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745887147;
	bh=IdPDP+yzjvGJATlvy+h89DiE2Uw1wQ2CqY443Cx0BYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PDiXG8HllcfmLTCWk5gz2FTjUwKgbBmySYjoRZ/upvKo2xmS8lLBJSvCXaFVFDgwb
	 a8H57mesF+DOhZ9wsDqHf3Dz7dHW0iGKe/c1nELGUfabCfXj1EkbpccgE648Pne86p
	 l+OcIAOydM/weIoOAbganyuvFXhPFV4wyV1ysVc4Me2X3ZNWRJjK5v8kSlj25X4zyQ
	 8qy45GZKLooz3iG4hYfHoxEfwpS96iUoRWo60QhliQT2Z3kRe+YE0ZrRYGqRZMzk1d
	 u1qLf6wRU6QiAy4KY0jW3wLcYbXAt2xgJ2Cf5KzfVT50rKnlgsej4P9B3MtnTJzwal
	 +8pueWYMIuC8g==
Date: Mon, 28 Apr 2025 17:39:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, milena.olech@intel.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
 richardcochran@gmail.com
Subject: Re: [PATCH net-next v2 00/11][pull request] idpf: add initial PTP
 support
Message-ID: <20250428173906.37441022@kernel.org>
In-Reply-To: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
References: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 14:52:14 -0700 Tony Nguyen wrote:
>  18 files changed, 2933 insertions(+), 103 deletions(-)

This is still huge. I'd appreciate if you could leave some stuff out
and make the series smaller. 

