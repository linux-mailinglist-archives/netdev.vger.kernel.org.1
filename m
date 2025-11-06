Return-Path: <netdev+bounces-236411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD7BC3BF62
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376EF3A9C29
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D8334572E;
	Thu,  6 Nov 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8U+qok7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DF63396F8
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441369; cv=none; b=CBDfptR8QUt5cD00zQc12vkZIPr3IDcfClqdoeuxnt+5dSAOJ9ul9nD1ILfbbRRXLkW7qX5lNHRL5wLbbuLC13sFIhRQ66sNGFCXl9i0t61zg6qgFoHqO2s3hL3IWSp3fGMIka2nIlBf+X4b+NfcKoAI3bfsJ8afoH2PTQ2UcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441369; c=relaxed/simple;
	bh=Y7+PDGlldUvO4hLQ1aM5oru6Z1dcWAQtFGoRq4bY7LE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdHnrTr7J+Xqj+eSjXpxwrhXsAoqEAohnP6uXy0yf7kLcPHrXXIlRagOhcckcMnpNLim4FmyP5R4ejkwyvsRp4cNS0T0E7tKVbwsdvNZirithMqHZP1E4HhV7LMQfTXDUL8CPd/wTY3SybIjnlbLqXdEqjYKmoZyG5skcYDESNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8U+qok7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07B2C16AAE;
	Thu,  6 Nov 2025 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762441368;
	bh=Y7+PDGlldUvO4hLQ1aM5oru6Z1dcWAQtFGoRq4bY7LE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K8U+qok7/Nn3L0g1rQr5QF/KC9j6O6ZAt05XJGW08TfWxxp70YGIXQMoDV6X2wqm7
	 ofbg8CC9TQZcKXF1daWTE/9M5Wduk/0+dAEMxU884NPQcgsdwJzrTVRtZBS/Lci82D
	 RyQfzkdYv3QYs9Xict//lhzB4eliLutqC5fPgW3iwu0OwrBHUXiGtdWAyJ3KXuN5V/
	 0FnUOGOjO8Zasl6RNHOSx/pGj84WrCtESJVMHNDZK3ZvWIpYB2qucO9vUjO9WrxFSi
	 w3kHYZUE2OtoGyJywyjR5juEtmNBfJZkJDKFDGH5rbn7ecr9Quga314OsOkbz+RPb+
	 I8/hiwJwFfxxQ==
Date: Thu, 6 Nov 2025 07:02:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net, donald.hunter@gmail.com
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, joe@dama.to,
 jstancek@redhat.com
Subject: Re: [PATCH net-next 0/5] tools: ynl: turn the page-pool sample into
 a real tool
Message-ID: <20251106070247.7dcefc97@kernel.org>
In-Reply-To: <20251104232348.1954349-1-kuba@kernel.org>
References: <20251104232348.1954349-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Nov 2025 15:23:43 -0800 Jakub Kicinski wrote:
> The page-pool YNL sample is quite useful. It's helps calculate
> recycling rate and memory consumption. Since we still haven't
> figured out a way to integrate with iproute2 (not for the lack
> of thinking how to solve it) - create a ynltool command in ynl.
> 
> Add page-pool and qstats support.
> 
> Most commands can use the Python YNL CLI directly but low level
> stats often need aggregation or some math on top to be useful.
> Specifically in this patch set:
>  - page pool stats are aggregated and recycling rate computed
>  - per-queue stats are used to compute traffic balance across queues

FWIW I'd appreciate any feedback here. It's hard to draw the line
on what to implement in a tool like ynltool and what to leave for
the YNL Python directly.

