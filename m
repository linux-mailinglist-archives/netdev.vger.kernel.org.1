Return-Path: <netdev+bounces-268694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD4JGE6UuWnKKgIAu9opvQ
	(envelope-from <netdev+bounces-268694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:50:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD50B2B031E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8330A32F21ED
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2857F320CCF;
	Tue, 17 Mar 2026 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="enc6jmg4";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="enc6jmg4"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB39E191F94;
	Tue, 17 Mar 2026 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767937; cv=none; b=rVdP5EqL1G0/6AOwdlwyzezcIyxoQ7qCfG4I+V+lX2txD7pwhW1GNDkj5s2ZbnWBsQOm7yVR6dSaVhHw5jVBv3ZjVdygVWYzWgMCe/NTwGl7AvIfdTtYtI+yh74ZjB24ykFOHQ4oroJdam4dMz/QhO6U+09Olt54bG9/zGoilv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767937; c=relaxed/simple;
	bh=qJWlya7iIfbk4wtRhTdXYR03Hd0alni5JVdlet1bMtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwRflmxroWjKP7xhureR7cwIPsGl3ryhy+vHSEhMjoO+ZMdfFo0d+74TzamMn1qbhObJ6n9Pq9cI6TTO10eO5nvqlP5SHQ7UEVLn7Etfq/C9YEsTWdEvThtiEzNj0NU/UZ+FM/RXXJK+fiN584eWQlWdPFziwghneU+XZQHVhK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=enc6jmg4; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=enc6jmg4; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773767933;
	bh=qJWlya7iIfbk4wtRhTdXYR03Hd0alni5JVdlet1bMtY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=enc6jmg4/rOekWZfqS1m9zu2qQG+hm4rtuFdw1Afma6e7+65QDhpcxxsrF6dwSRbV
	 yBWZ2MscuQlG3BwwAGe7i/dSm3AzNFCrzjslqRqbwZLM8WwH2oLHJufwR3elMpG+eW
	 9cE3+p8c/CIyy91BWWKD6ngkt9QKJ9GHpkAWrtr1N6Dtbd1JR9zRJImqgpK4T16efz
	 GhAzkCgQ8JgGzXdnHPj00J7GE95+JabXFHpwcMLEX89ekiMlOXjmGrnBmZ2Gp5xv9n
	 77KZsbFcFq0dYjXjqAxYsulubg+2/OhCj19Co454Xb+AZMNuVD0zcz1Gk+4cc5kWce
	 T4mwzGpOR5v9g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 9FC8D3FDF5; Tue, 17 Mar 2026 17:18:53 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773767933;
	bh=qJWlya7iIfbk4wtRhTdXYR03Hd0alni5JVdlet1bMtY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=enc6jmg4/rOekWZfqS1m9zu2qQG+hm4rtuFdw1Afma6e7+65QDhpcxxsrF6dwSRbV
	 yBWZ2MscuQlG3BwwAGe7i/dSm3AzNFCrzjslqRqbwZLM8WwH2oLHJufwR3elMpG+eW
	 9cE3+p8c/CIyy91BWWKD6ngkt9QKJ9GHpkAWrtr1N6Dtbd1JR9zRJImqgpK4T16efz
	 GhAzkCgQ8JgGzXdnHPj00J7GE95+JabXFHpwcMLEX89ekiMlOXjmGrnBmZ2Gp5xv9n
	 77KZsbFcFq0dYjXjqAxYsulubg+2/OhCj19Co454Xb+AZMNuVD0zcz1Gk+4cc5kWce
	 T4mwzGpOR5v9g==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id D40893FDE5;
	Tue, 17 Mar 2026 17:18:52 +0000 (UTC)
Message-ID: <ef706caa-a28f-46d5-b8db-18095df8da23@birger-koblitz.de>
Date: Tue, 17 Mar 2026 18:18:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/9] r8152: Add support for RTL8157 RX/TX
 descriptor format
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
 <20260314-rtl8157_next-v1-1-9ba77b428afd@birger-koblitz.de>
 <20260316175123.45b8d6e1@kernel.org>
 <2094f5a3-e692-4d8b-9b66-0368e5142b98@birger-koblitz.de>
 <20260317085531.3ddff582@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260317085531.3ddff582@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-268694-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: CD50B2B031E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17/03/2026 4:55 pm, Jakub Kicinski wrote:
> On Tue, 17 Mar 2026 06:04:34 +0100 Birger Koblitz wrote:
>> I would prefer to have individual patches in the series adding support
>> for the new functionality of the RTL8157 in parts that also allow
>> developers to understand the differences, even if this functionality is
>> used only in the last part of the series.
> 
> Functions should be added with the first caller.
Understood.

Since all of the functions defined for the RTL8157 are eventually only 
used when the RTL8157-specific functions are placed into the r8152 
structure in the last part of the series, I will prepare a v2 series 
which consists only of one part adding 5GBit support as this can be done 
independently of RTL8157 hardware-code, and a second, large part 
containing all the code supporting the RTL8157 hardware.

B.

