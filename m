Return-Path: <netdev+bounces-202543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A70DAAEE3B8
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8702441977
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA545292B4D;
	Mon, 30 Jun 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3tsqHUP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E10028C5AC;
	Mon, 30 Jun 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299736; cv=none; b=g3leX6uaRsEoSDvU4PjMLk+gJNU03q0OBSb3+JuKChZolp9N6nxnt3u2kLWE/onVFVxveCUN7L+Y2UCyHjWFc10mJGhw05f4pdgn0mk19JO8PKBp/9neBrfoC0ZK0D9FBZWQmxyyfRYEv5gKI9IxZK1brJyLjpMcnaZw2xZUe/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299736; c=relaxed/simple;
	bh=d7ebQZ9wclnu40DUKgk0nl9hmE8n7d9aqFn5Ipss2bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7sRx6oRpNb165K5fGU/7mo+9OH5EPtpmHH9P5t0YZPEd/aIxVuJBaNh9mrgDt7wKxQSU8QHbjXvZKw/+1tFg6hZGB3cdzXmXPyt1ng5D9tMK+TJbNHxGv4X1qZcko6tWjgQuP1DnYRYlSZFnpdbrhUZPGC7sGdI7igQ6hAzMk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3tsqHUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8026CC4CEE3;
	Mon, 30 Jun 2025 16:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751299736;
	bh=d7ebQZ9wclnu40DUKgk0nl9hmE8n7d9aqFn5Ipss2bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3tsqHUPO0tM+UYSW8LA4BnwsY77eHZ1XNKY+EmhkDKF87bhUhEPObVgy/OWCL2c0
	 0xd+01bErPnNss5JqdULHFjg9xMtIuiKduCE8t4APSO6aJt4AXYKzrtD0zQapNXcQM
	 G30vLGUEcIhEhHCL1ph2q2uYxS3QYe2PxvK7CwngG3+GmpSCY7o6Nl8m0k9bDAK2eG
	 Nxc+4Dq9u5/ANDgvRpVaGuQnhdIEHFeHcLhkC91TyXu+sij6MhJVXfA70Ynz9gOP2+
	 Kwn3T8NWJGhDZw3gQPHRRNXZzS/pcPEr1Z1rEVVbWxmaryizM3pizCD6VxIOyeahQx
	 K28KI0IdXiBBA==
Date: Mon, 30 Jun 2025 17:08:50 +0100
From: Simon Horman <horms@kernel.org>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefano Salsano <stefano.salsano@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
Subject: Re: [PATCH net-next 1/2] seg6: fix lenghts typo in a comment
Message-ID: <20250630160850.GH41770@horms.kernel.org>
References: <20250629171226.4988-1-andrea.mayer@uniroma2.it>
 <20250629171226.4988-2-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629171226.4988-2-andrea.mayer@uniroma2.it>

On Sun, Jun 29, 2025 at 07:12:25PM +0200, Andrea Mayer wrote:
> Fix a typo:
>   lenghts -> length
> 
> The typo has been identified using codespell, and the tool currently
> does not report any additional issues in comments.
> 
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Thanks,

With this patch in place I see that codespell only flags
false-positives for net/ipv6/seg6_*

Reviewed-by: Simon Horman <horms@kernel.org>

