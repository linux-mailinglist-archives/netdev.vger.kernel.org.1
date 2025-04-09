Return-Path: <netdev+bounces-180890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DD2A82D36
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 19:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E611B64F44
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CDA270EA6;
	Wed,  9 Apr 2025 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgQO0Ynr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBCC1BF33F;
	Wed,  9 Apr 2025 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218396; cv=none; b=rSGWATXOkqBjUnEEMz49kZtxpyo3uwyfipH5IAmAqOL9jrAjpQ9JSnGL71F6/W7/c9/S3u7Wwy+atoENPyXCSCkSjMvgGNmqG1tvBba9XPufrdI9J9Dw+FnWOol28vNZyUglqL/5c7QMAXb5rZ6xmvqT7dCIcK8FcBODqWKWSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218396; c=relaxed/simple;
	bh=NXMhv+VVEYftOJ76w+3cGn9WxGbJC5rBcev8hsK3ALU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbZ4ad/ukPDACzzznQUgLxr/QNSs+U7moiWXLwuG5rzbOKANKy+NoJKLT+HliZ5sZ3ykGumvvflJTXPPTJqq1VZQwJKeAgdcRm9mI7qhOeB8DP3ZD9PPt0KtV49NnZJf5rrzgSu8oZQ9r2UskRcLBHq+C9VbYY/sD1R0QDPOjsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgQO0Ynr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892EAC4CEE7;
	Wed,  9 Apr 2025 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744218394;
	bh=NXMhv+VVEYftOJ76w+3cGn9WxGbJC5rBcev8hsK3ALU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QgQO0Ynrk2uUEmlNq+Oi1/C7HRieeFw3w9+aS/s4l33j4tms9FJvvPkBB3T/ujI3z
	 z0U7AZizS8xJn48yWCBYNTe6vIxF7Z+u8PJp1uMSV/VzpOY0nh5ArdIQh2ax9sbQHZ
	 fubgOR5Hgquhklwgia9vul9RokP4bSOl12u3+2oUXPwQwf5qsECz52Cz6U2zitkZhv
	 HLKJVQwZ1osfP6tYvN53tlkxHc6HajT0p1WA9HPcl7hLv9uUUe4n2FvX4iB9BV3Ib+
	 0WB0gq2XZrDD11PSMp3D/loz3qp4nGds46tOMggQPg1gi7Vsc0H+/Me7FUPD92W0qA
	 jqEGTaZzDa3PQ==
Date: Wed, 9 Apr 2025 18:06:30 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.swiatkowski@linux.intel.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net 6/6] pds_core: make wait_context part of q_info
Message-ID: <20250409170630.GN395307@horms.kernel.org>
References: <20250407225113.51850-1-shannon.nelson@amd.com>
 <20250407225113.51850-7-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407225113.51850-7-shannon.nelson@amd.com>

On Mon, Apr 07, 2025 at 03:51:13PM -0700, Shannon Nelson wrote:
> Make the wait_context a full part of the q_info struct rather
> than a stack variable that goes away after pdsc_adminq_post()
> is done so that the context is still available after the wait
> loop has given up.
> 
> There was a case where a slow development firmware caused
> the adminq request to time out, but then later the FW finally
> finished the request and sent the interrupt.  The handler tried
> to complete_all() the completion context that had been created
> on the stack in pdsc_adminq_post() but no longer existed.
> This caused bad pointer usage, kernel crashes, and much wailing
> and gnashing of teeth.
> 
> Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


