Return-Path: <netdev+bounces-165018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0BAA3015D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE18E1655EE
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 02:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BE226BDB3;
	Tue, 11 Feb 2025 02:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejGYiU3+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B4326BDA2;
	Tue, 11 Feb 2025 02:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739240198; cv=none; b=Hy8JuAyJFfsdfe4SvW2/FrZVulwWpyF8Ug3rrkyvSzcwo8/Z4WJg5p2YCvHNQlWv7Ro3kxm4gC9sgsyXhUjVadOR7lm5KaMWqVMeo5HjbbzFtgK52JC2JPvN2Pg0LX9rqU2gpRFmBngzwe8BiqGhZuW6tsuy9nqTxW2sSAFnokg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739240198; c=relaxed/simple;
	bh=fEv6X8Hx3fCso82ONbxyIf/q5HtoY16v5CGLukgD5E8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huiULTZgOQYTQ93QgDg+CJi6IAtNp858sK75aTey2hnaleN/+q7gDOVd7k3zvz+WEYEyrjvVQQCpTSHrb01mDWltBF+nCLsTOEUvBn0GVZsDS8nAMvRxb47Z1o46bF061RM4rXxpD/lNDa0ddw9voKv1L0bC6KQyy6AH8JBCLMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejGYiU3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3460FC4CED1;
	Tue, 11 Feb 2025 02:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739240196;
	bh=fEv6X8Hx3fCso82ONbxyIf/q5HtoY16v5CGLukgD5E8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ejGYiU3+CFtzVuKRkUhUqbv+TUMOJ/U7II7I6YFayxQ2YaCnRSdiph2UvmL2Fmm+E
	 zoO24xGPl9SWja8vNnrBSryyb3rcHloMQQlO8JrAlGwIERKpsxmub0CGEBhlMR9cfc
	 eJ9TIpWOhVQS2kOtmkowhnkW8O+XW9OK1hdTUysUiz4O1EFNzMFsOyX6mY7RNfQW9s
	 ULB6KdvcgnKBMnQySN0hWW5FArYEb8EDKa6piO1juNN5tc9b2q2CSGHGP0N8xYLgqV
	 2yab9nCZ3tGO+ssgDZEHRCbbo0b044X2R59GlJH3accWTuSoQwC+2wio8TmSQ9/LN0
	 FxofzohbZ1Pbw==
Date: Mon, 10 Feb 2025 18:16:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, ahmed.zaki@intel.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org (open list:DOCUMENTATION),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] documentation: networking: Add NAPI config
Message-ID: <20250210181635.2c84f2e1@kernel.org>
In-Reply-To: <20250208012822.34327-1-jdamato@fastly.com>
References: <20250208012822.34327-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  8 Feb 2025 01:28:21 +0000 Joe Damato wrote:
> +Persistent NAPI config
> +----------------------
> +
> +Drivers can opt-in to using a persistent NAPI configuration space by calling

Should we be more forceful? I think for new drivers the _add_config() 
API should always be preferred given the benefits.

> +netif_napi_add_config. This API maps a NAPI instance to a configuration
> +structure using a driver defined index value, like a queue number. If the
> +driver were to destroy and recreate NAPI instances (if a user requested a queue

"were" is correct here?

> +count change, for example), the new NAPI instances will inherit the configuration
> +settings of the NAPI configuration structure they are mapped to.

