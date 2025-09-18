Return-Path: <netdev+bounces-217020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4129EB37156
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C2047A902F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 17:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E512E1757;
	Tue, 26 Aug 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wfGTXvB8"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7838431A57E;
	Tue, 26 Aug 2025 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229401; cv=none; b=qRzf56LBGcQqyd7zmAshTunZeVfKRvuvOSkZPRpaLMkhKsCuKCPOg3RMIAWIMVZlgxWUVFBLSIVLO6k30953EhPQ2cJS04BliVrn0H4d/0R7nzzCDNNjwP4phKbJ9yKmft/XT6NFV/tqK4TReKfOdH6KdyK+EclxkUBrR97VuZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229401; c=relaxed/simple;
	bh=F8Nrp5aXQVl7CcBB2xksa3tGA5YohT1DD9rv4P/KdWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKZsykpSgozioyXXKryBxM1SQDBNR/xDAhfzHBuqzCJw8QVW0f63eH8udQtqAeE4MicE6r/7ZeCAovnpIY4S7bxmRy279jiug0uS3KlLzihL4Hn5ds9Y20Suo+jX52ncBhzxHdij8CGrAWxez5gLVc37Sk3Yr+3H7Kh54rYo1XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wfGTXvB8; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e4cb25cb-2016-4bab-9cc2-333ea9ae9d3a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756229396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8Nrp5aXQVl7CcBB2xksa3tGA5YohT1DD9rv4P/KdWs=;
	b=wfGTXvB8GFqwq+ajrR12L/JKcbakLCVWfM8CJmsoCe+A6IRSI156GmmVZmpHKywlnBXbFO
	GhOjc90Krekp1QqbE4Y1ifAo7IEFk2Sklt1uGO4wR92snBNRnrTVNrtduQBgMSIRFl3Bcx
	4ow+D7KobG/SywwSbGn+mOk5Zu0+48w=
Date: Tue, 26 Aug 2025 18:29:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/7] net: stmmac: fixes and new features
To: Konrad Leszczynski <konrad.leszczynski@intel.com>, davem@davemloft.net,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 cezary.rojewski@intel.com, sebastian.basierski@intel.com
References: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/08/2025 12:32, Konrad Leszczynski wrote:
> This series starts with three fixes addressing KASAN panic on ethtool
> usage, Enhanced Descriptor printing and flow stop on TC block setup when
> interface down.
> Everything that follows adds new features such as ARP Offload support,
> VLAN protocol detection and TC flower filter support.

Well, mixing fixes and features in one patchset is not a great idea.
Fixes patches should have Fixes: tags and go to -net tree while features
should go to net-next. It's better to split series into 2 and provide
proper tags for the "fixes" part

