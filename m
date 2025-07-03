Return-Path: <netdev+bounces-203852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5E8AF78B0
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C041CA0FEF
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D572EF673;
	Thu,  3 Jul 2025 14:50:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD262EF672;
	Thu,  3 Jul 2025 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554255; cv=none; b=STa+xzZ5Clg8Az3xYDz2qiB4qrhf+9pLRtwNMryAILYiRh76jY9JOy4ObpMliW1O+XuMX8NHdUSfHKLNZuCLOtHlc+Ewce6eOULwZEs2br5emXx6qsqgAbDJ6ueu5N+VTy0As7Mr9yym0PZBRX30Mv5C1h+rWl6N+HoLbdLkqho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554255; c=relaxed/simple;
	bh=nECBj7L7o/iTM+VDO6pCb7cj48ibd1v5YABfHIlqWaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVX3596HS9wYDekQerHMoIUJoOOoevK0oR6SsShOkcQ393aIFEf/JF5YrXsuBGf03rfXQ2b5bWwS+8OOCIZ3rDKPemR8mX4h8ZHWANrtH9DS/ZANB8ZiuRolYW8bdK3/5jMJHEN7iclHVRYV3qfsQp7y5UiOwhO8P+c0ouyA910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1B071479FB;
	Thu,  3 Jul 2025 16:50:50 +0200 (CEST)
Date: Thu, 3 Jul 2025 16:50:49 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
Message-ID: <2mwkeitol2vfo7wobza73fah7ubcxcpv5lijdeyvg64v7hdo72@musgzrk6dnfj>
Mail-Followup-To: Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702074619.139031-1-g.goller@proxmox.com>
 <c39c99a7-73c2-4fc6-a1f2-bc18c0b6301f@6wind.com>
 <jsfa7qvqpspyau47xrqz5gxpzdxfyeyszbhcyuwx7ermzjahaf@jrznbsy3f722>
 <1e896215-5f3a-40f9-9ab5-121109c48b3c@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e896215-5f3a-40f9-9ab5-121109c48b3c@6wind.com>
User-Agent: NeoMutt/20241002-35-39f9a6

On 03.07.2025 16:04, Nicolas Dichtel wrote:
>Le 03/07/2025 à 13:04, Gabriel Goller a écrit :
>[snip]
>>>> +    // get extra params from table
>>> /* */ for comment
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/
>>> Documentation/process/coding-style.rst#n598
>>
>> NAK
>> (https://lore.kernel.org/lkml/
>> CA+55aFyQYJerovMsSoSKS7PessZBr4vNp-3QUUwhqk4A4_jcbg@mail.gmail.com/#r)
>
>I will follow the netdev maintainers' guidelines.
>
>If the doc I pointed to is wrong, please update it. It will be easier to find
>than a 9-year-old email.

The netdev maintainers guideline doesn't contain anything about
comments. Also the coding-style doesn't prohibit single-line comments
with the `//` style.

The comments are kinda pointless though, I'll remove them in the next
version.

>Regards,
>Nicolas

Thanks


