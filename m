Return-Path: <netdev+bounces-244027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C341ECADA5D
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 16:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CFE63072AD1
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 15:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B286128C5A3;
	Mon,  8 Dec 2025 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="NiAGbnOm"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F75248F5C
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208964; cv=none; b=O2OVtdFYIC7FtcRKHMTB7ttppCGStm/8dfx7Q+ny8AN7JDr6q6P66WBgIcJGRSw8qImwXhd8UGSCMYOyeFgDnKhIWjUMvc0jE341ELjAMOJ/4y7CVU0YPIzA8U3FxLT3W4CvuWYIu3D95w+4rdBP32q6zmaShbxUAnh/RmPhXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208964; c=relaxed/simple;
	bh=1eoGTflTqxYX62gB/2kcXC6SrEQnGQt5PbZYJUx8sHY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ovOTrO8L3y+qDbLjh1qSEssw0alFxFQSa3xEup8HydlXt8cM67p4VOhfgRjdTaGhAMvl4hhkKzHKN9pxuDLIDn9J1ppO4W+lfEGZTuF2DiAbbTZvCJRDiWe9O19U88WQE09jeJk3md0Jre5VaSeclvLV7WCp1Nu9h6ReUUq8uz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=NiAGbnOm; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1765208952;
	bh=1eoGTflTqxYX62gB/2kcXC6SrEQnGQt5PbZYJUx8sHY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=NiAGbnOmYJfgUyG7e+eZRAWzA8cueXIzOWC3RbJl6T5GLdRE/87vBTt1mEFk1x8nG
	 Evq3q2Rs2nLs3A6C0F0Z2DpRAL2928zU+ag5IzVr9tSyguqgwxCXOc88ijNMMGUOAO
	 zRUxQ8/EvoHLcwW1MM0pcjzOexaTW5cVn01aChH4LRL9ZR+LGcw7DGtqg0KbZg1jNx
	 e7HGSiaMuSJ9t3U9N/7K+ZaGUXEqFA+CundOZ5zq5T5/CISvGLLr15wLH3bp965ViD
	 WYPRRIuvXYj3xQ4mZzzXufb1Sv/FVuGm7tgJXMTW3vv4lmKbpMAc9HkLLZXplFpwEu
	 9xHuFCB5Vo1uQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 719096000C;
	Mon,  8 Dec 2025 15:49:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 38DCC20070C;
	Mon, 08 Dec 2025 15:48:46 +0000 (UTC)
Message-ID: <0c6b1c65-078d-4978-aadc-aae232274db1@fiberby.net>
Date: Mon, 8 Dec 2025 15:48:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Subject: Re: [PATCH net] tools: ynl: fix build on systems with old kernel
 headers
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 Jason@zx2c4.com, davem@davemloft.net
References: <20251207013848.1692990-1-kuba@kernel.org>
Content-Language: en-US
In-Reply-To: <20251207013848.1692990-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/7/25 1:38 AM, Jakub Kicinski wrote:
> The wireguard YNL conversion was missing the customary .deps entry.
> NIPA doesn't catch this but my CentOS 9 system complains:
> 
>   wireguard-user.c:72:10: error: ‘WGALLOWEDIP_A_FLAGS’ undeclared here
>   wireguard-user.c:58:67: error: parameter 1 (‘value’) has incomplete type
>   58 | const char *wireguard_wgallowedip_flags_str(enum wgallowedip_flag value)
>      |                                             ~~~~~~~~~~~~~~~~~~~~~~^~~~~
> 
> And similarly does Ubuntu 22.04.
> 
> One extra complication here is that we renamed the header guard,
> so we need to compat with both old and new guard define.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Found when syncing the "standalone" GitHub repo with ynl which
> has a CI building on Ubuntu.

Thank you for catching this.

I had put it in the sample commit, which was postponed last-minute.
Next time I will include it in same commit as the spec.

Reviewed-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

