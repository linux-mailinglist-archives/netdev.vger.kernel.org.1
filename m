Return-Path: <netdev+bounces-198018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 520BFADAD2F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967583AB049
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0235525D209;
	Mon, 16 Jun 2025 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quR9BKnH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA65627EFEB;
	Mon, 16 Jun 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069046; cv=none; b=biI2YCZBOMTqVriAwIgOD14/1HYmd3lef1/RazUXPRrv7gu7JD5y4sxHZ/SnqQVjhbMlwP48TXYGI9H+SPqh4ZheRVfHQWrdnr97fIfHj8PFAJEg4/QagZhtRR92dkLWLwnjqm0iH/zS0o5JK1wlaxqNnYoGBg6h7VwGLnY+KqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069046; c=relaxed/simple;
	bh=+1iHAvn5lkU0MLPZUomUSjEv+7jWX2Hk26+E4H64IPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKaSkWRFWcVEMAA3O7bae5ByQhq8BTMmXf3xIu7/BGx2/oK9B8kILjSBHXIHu+wwlBvX2DjgvlK11Wdlggh63Vv8DEcv4amWh7NNw6dVQpWaIWbSPsL3qKXSXXcn8c+b3clcio3X52yhpHzWiR4YZLUx/SDYfsTHERRdP7nwjtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quR9BKnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D72C4CEEA;
	Mon, 16 Jun 2025 10:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750069046;
	bh=+1iHAvn5lkU0MLPZUomUSjEv+7jWX2Hk26+E4H64IPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=quR9BKnH46+jEpELJpY79TwT/YfI2clyTbONqqJ++noN03kqqk3Qk5mkOTfPvY/Vu
	 564KpNo9bv3YRdMo7cd+NXF2T4cjlF8Jp6Dbb9UuWt2cKEI0wiD9ZY5fFzUVM+mSYH
	 pgwjOEez074TdiEeU1Su6VKNtzCBxbAEyajrzPqrR6emhDypeRzfL8Fnw5LbCIjMSn
	 Sp/U44LKcB2NDtQtkmjLHGNyuwWvN/+XYXU9zhT08ynYtINnGx0U6DFpjV1ZzWDqvG
	 EulIBik/IBpsAB6rlSssq77ZMinti7wvL5l1T8bSukHBg+CWdMFvcBkVVskpBOcMUz
	 Wj0J8SVsIhhjQ==
Date: Mon, 16 Jun 2025 11:17:22 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next] ptp: Use ratelimite for freerun error message
Message-ID: <20250616101722.GA23708@horms.kernel.org>
References: <20250613-ptp-v1-1-ee44260ce9e2@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613-ptp-v1-1-ee44260ce9e2@debian.org>

On Fri, Jun 13, 2025 at 10:15:46AM -0700, Breno Leitao wrote:
> Replace pr_err() with pr_err_ratelimited() in ptp_clock_settime() to
> prevent log flooding when the physical clock is free running, which
> happens on some of my hosts. This ensures error messages are
> rate-limited and improves kernel log readability.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


