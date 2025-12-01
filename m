Return-Path: <netdev+bounces-243089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9618EC9969F
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 23:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B7BC345E87
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 22:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9AF279DA6;
	Mon,  1 Dec 2025 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILWiSJhk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687AA28F5
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629145; cv=none; b=LWBKrg894oIvVqn+ucZLttb0fl0tQtCqjFYg3JOW6n3cWbpS7eIBpUZiWbj3MUUXVMHj/fKyDaGj40q3UsfMBqKxX8vkcb9TdkObpuRxr0wwXQa8ZHbhZrOUTrdiS5q5dVI8dwuzXf9BEKJqOQ3iOYgG4dhQBV4Co9VpuL/qjs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629145; c=relaxed/simple;
	bh=ralqT3QCc6mNpETQkK8u1CP22RyJ2XjLxXP4ULdFNHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfN9qEVFFLE3eSJk5FcfRLUqOU1LGNtxCD6KILEB6sselb/DG9RW7V0tYf66Hjzo2hyAoi31kJdsFm8EPz971jsvJDMP2cxRTOdE7MAr6SPhYEo+yvRTYW5daPIwFKDOsJn9k+3LKNYsARsBn2wACl9eTbbGwhF5l4JPQJvD6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILWiSJhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8070EC4CEF1;
	Mon,  1 Dec 2025 22:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629145;
	bh=ralqT3QCc6mNpETQkK8u1CP22RyJ2XjLxXP4ULdFNHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ILWiSJhkp/VaffF7JGjHiwdKLLLbaIKPawPD4O7ExPt1/+7BWArOFcQ++7WgA0ojo
	 Zr0eOdDhiUoT67q4MkXKkmLNpYiRVKfiDZvf9uBhMsMwahzA5+JWhVKnMgrOJVrd3g
	 P4IRGxfPFFibReSQIeBFDv8IvwypwjPzfP/TFTiSGsb/v74iVjpqvxAxBvOGS9/Qo7
	 Wf54Tin+yMWdHgvGRcb7kwofMR+FymRP4hzce57/fO0RxJNSsxQlWAn2CL/4AZdImD
	 PJu66oVYLcXDkmCWB6JeDmNcwka2cf8RXa0iV9JYZVkQb2+4I/WPmQhsR61KHQyQE9
	 4JOGNUgwu/6cg==
Date: Mon, 1 Dec 2025 14:45:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Edward Cree <ecree.xilinx@gmail.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-net-drivers@amd.com
Subject: Re: [PATCH net-next] sfc: correct kernel-doc complaints
Message-ID: <20251201144543.26f845de@kernel.org>
In-Reply-To: <20251129220351.1980981-1-rdunlap@infradead.org>
References: <20251129220351.1980981-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Nov 2025 14:03:51 -0800 Randy Dunlap wrote:
> + * @port_id: port id (Ethernet address) if !CONFIG_SFC_SRIOV;
> + *   for CONFIG_SFC_SRIOV, the VF port id

Thanks for the cleanup, but TBH this one sounds a little bit awkward.
Hopefully the SFC / AMD folks can suggest better wording. I'm dropping
this version from PW, I'm trying to wrap up netdev for 6.19..
-- 
pw-bot: cr

