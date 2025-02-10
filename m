Return-Path: <netdev+bounces-164909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9F0A2F976
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9590B16606B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D3C24C664;
	Mon, 10 Feb 2025 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxESFO4q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1DE1922E7;
	Mon, 10 Feb 2025 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217058; cv=none; b=Qy/87cjec+7ELMMSZv3yhI9t4H3/GT2pqoSZi/JvmjaynWhCyvAJAYN2JBamL0sbaQyZ+uEsb3QzK7X5EjWrOm9Vz1AugbBKvYJ7P9TUWl7B57Fja46RC6aehNMHa+7ECIgXK1gJLIDSUw9Q8V3AA+CJnI6Oxf916wG3mODTr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217058; c=relaxed/simple;
	bh=P4b06CbqCnBiW5xe8lYME4sCTrtv60mvia48hdWfPFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olGs+iOFaLKyxQ13CTiaqh9V9orBluBUUEsAHpsJWF8GVRv+xwpmnNdaQAzIUWwL0LiggsLHynNas2T5MZSQyuvCwAtjhZ7IFdE9ZW3/zLkSZLYfGa5ZR3Pk1ky5wanOREFTF30q+c+aaE4eHYAcfGL8QEyaoY3kK7MffQ+fDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxESFO4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E08C4CED1;
	Mon, 10 Feb 2025 19:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739217057;
	bh=P4b06CbqCnBiW5xe8lYME4sCTrtv60mvia48hdWfPFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxESFO4qWGWzuXUXHBorqn4DO95VHFyHZfQZC8bZ/wl+Ut99qHdLs6Hggg7Q/sgTJ
	 bAZv22iJAMY4LFN9/zYYWUdMrjxkZv51teV9OMuvhjaN4gwr25UZiBtDpEZcShaaTV
	 iQud2PES/kvILgIAWpMI0Ty5Ge7mGfgAhApQui8XHUIM0jr9fpB0IGQjsEZpXnGBJR
	 FWDNizEBjKjzhNV96As4U52QzVm7t8VnVzbTJsGa6un8OimbM7nCJH3OhRu+N7YcXl
	 JAmhiPapFvqHZ3fPSP1PJZRanGlBOLz2Y5GYAHsYc24mupaNZc+xJP1nK3ckP7gVPh
	 9oWZj4y6MPDNA==
Date: Mon, 10 Feb 2025 19:50:53 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 06/15] mptcp: pm: remove duplicated error
 messages
Message-ID: <20250210195053.GT554665@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-6-71753ed957de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-6-71753ed957de@kernel.org>

On Fri, Feb 07, 2025 at 02:59:24PM +0100, Matthieu Baerts (NGI0) wrote:
> mptcp_pm_parse_entry() and mptcp_pm_parse_addr() will already set a
> error message in case of parsing issue.
> 
> Then, no need to override this error message with another less precise
> one: "error parsing address".
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


