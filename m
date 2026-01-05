Return-Path: <netdev+bounces-247141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A94BFCF4EA5
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 828103024585
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D114B322B7F;
	Mon,  5 Jan 2026 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy0gT2Gk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685E322B6C
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632963; cv=none; b=nQE3n8OE1TY5wJEjHnM4fYE7Z7/hgr7azE6NsXy4uNpfRMWvChGTaX2ebD7YV4vsJRxQn/5NWIZRgfZANCEYz6OLB/NaM+WGPWHjGz6EGbpLKC9veh+hcqeHs4rv3XBM6+A++SVAYpZpzWu1wPdddLyi9DrjIU6yYCmLeP/AsZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632963; c=relaxed/simple;
	bh=fO37iRMVO3LLiMyCns6kCYliejMPbipiAIpw0Bhmgdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8Wp3emQswwHbgj/upQOZ2DzlObKul6F+S579H/6a9EnS/u5r+khgvQZjmLLMIiEMcnyTg8zNzOq9ZHSsLRVgTy4W91VcCt7G8uzTJfyLqV4Vl//al6JOOcLymTHazfg9WptM0QZ3E8gXk/tqFSHBq055R5wkEz1EHMhj+/yvSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy0gT2Gk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74247C19421;
	Mon,  5 Jan 2026 17:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767632962;
	bh=fO37iRMVO3LLiMyCns6kCYliejMPbipiAIpw0Bhmgdg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gy0gT2GkYhPeXwcH1MuEQ7sFGTiLtj/d5uHJilfaCLNWheQsR7QGTVSa6jVuAusWj
	 QXIh3z8f9/ZztzOcapBs62AlY9KSlYgGfAErCkJsRa6c1pxSqNEgSmEZ1qfsM2fjRF
	 uV3Vm98O8727Js5flwPoSxKG9T4NkLmJ/Ib5MWriHU46JPl0a7s5BKFABlURKj+/mq
	 z8iDlrEphqQyjQmF3gglSNf/r9sZNsdvzPJ+s45bTR7rib70pCQG7ODnqcgdGW8GHR
	 y3XMyZ4P1lK+3E7sJ/QxO2ayNpUqKO5QZJ79f7mnmwMTv+E5Q2Mz0huiAgbg4xjxPR
	 Etl/31ITULG+Q==
Message-ID: <dca3ee7c-78bc-4203-ba58-0a7607cc1395@kernel.org>
Date: Mon, 5 Jan 2026 18:09:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netlink: specs: netdev: clarify the page pool API a
 little
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
References: <20260104165232.710460-1-kuba@kernel.org>
 <m2y0mcguzu.fsf@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <m2y0mcguzu.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/01/2026 12.27, Donald Hunter wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> 
>> The phrasing of the page-pool-get doc is very confusing.
>> It's supposed to highlight that support depends on the driver
>> doing its part but it sounds like orphaned page pools won't
>> be visible.
>>
>> The description of the ifindex is completely wrong.
>> We move the page pool to loopback and skip the attribute if
>> ifindex is loopback.
>>
>> Link: https://lore.kernel.org/20260104084347.5de3a537@kernel.org
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
>> CC: donald.hunter@gmail.com
>> CC: hawk@kernel.org
>> ---
>>   Documentation/netlink/specs/netdev.yaml | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

