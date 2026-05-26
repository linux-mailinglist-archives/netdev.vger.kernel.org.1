Return-Path: <netdev+bounces-291880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABJtF5rsFWogfAcAu9opvQ
	(envelope-from <netdev+bounces-291880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:55:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C505DB9B3
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D881730AEA74
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A676C3BFE24;
	Tue, 26 May 2026 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R66C3xZB"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC67D2DEA7B;
	Tue, 26 May 2026 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821331; cv=none; b=r6P+uedlxGUZqMuUAf4kScRJz5grShd0Roxf33SU93Muwl1QUyvK4z80kgMTwnXv38hqMOQHCxQQXl2mzbCjHhbHfQmBNULy5QdTr4LGzWlmDDA/CLN93gR8uS8zYlBigbKLk0ANHm+1Qy9MwBrtRAk3vrP1dAP9uBW/Iaa495g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821331; c=relaxed/simple;
	bh=0EL5x8+TZGDIraf8UUqY4kkZjJXXT2+S4iC1J4z4c40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isj3vgzOVBAcWAwI7RzxUUgTVWmJE4oixWg4X+08KlS+S1K8GDRdMw8vyRGlrHzeOXsQc3+m9u7iYTEABwU/Ln+UqMfB4b9frk6hAnMzKXfUSLG/M/lzIp9MhkUD8E7ipmuCvXYoAikEoaIo7oxYZ95UbTMr6Dlv3FVYr9nyFQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R66C3xZB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=q/mZfeEODQi26JC8lul3a6HKpuOhERZOr6DhpJHYplI=; b=R66C3xZBbD38swfm8X5Vh9TTpY
	3SCmWbtjQQxY4g53/24j0E6g5BmFHCepoU9D4IVSOikao7MYHfk47j9MqtB0SaFFJHMWiS9UJ+yNe
	L2t3blbuZ+47pt3gboRA77PLNaIAlzaFbhNAr0REeS2CP16Lxr95arGiA/OIr7bxJnMM5Xk4Z2VZU
	bEcvzfqXtR5GOQqA3cotbxYWRLh6xe4JlXZeLjTZUqfKtmFo80+dX+ePmi4O45l4hZxbOqU2qbnh1
	gneSXiuj7uYtTkpiJzWqLH7XY5KsL30BtHzcpuQN1sHL5m33t3m6ZNs6URQpC6dx453beQHLQyfuN
	JJNI+ltg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRwpX-00000002sMM-1vN0;
	Tue, 26 May 2026 18:48:43 +0000
Message-ID: <1c341b25-e720-4f63-9db1-99348c8ebed9@infradead.org>
Date: Tue, 26 May 2026 11:48:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] docs: net: updates for old and cobwebbed
 docs
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 vladimir.oltean@nxp.com, willemb@google.com, sdf.kernel@gmail.com,
 ecree.xilinx@gmail.com, jesse.brandeburg@intel.com, linux-doc@vger.kernel.org
References: <20260526160151.2793354-1-kuba@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260526160151.2793354-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291880-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: C1C505DB9B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/26/26 9:01 AM, Jakub Kicinski wrote:
> I'm hoping to start feeding our docs into the AI review tools, instead
> of maintaining a separate repo with review prompts. To experiment with
> that we have to refresh the docs a little bit.
> 
> A read thru our current docs makes one slightly question the value
> of including them in reviews. But directionally, I feel, it's probably
> still right. I'm hoping the Rx Checksum section about not dropping packets
> for example to be impactful. I don't think the current AI agents or
> review docs include this guidance.
> 
> Jakub Kicinski (10):
>   docs: net: netdevices: small fixes and clarifications
>   docs: net: fix minor issues with driver guide
>   docs: net: statistics: fix kernel-internal stats list
>   docs: net: update devmem code examples
>   docs: net: fix minor issues with the NAPI guide
>   docs: net: refresh netdev feature guidance
>   docs: net: fix minor issues with checksum offloads
>   docs: net: add Rx notes to the checksum guide
>   docs: net: render the checksum comment in checksum-offloads.rst
>   docs: net: fix minor issues with segmentation offloads
> 
>  .../networking/checksum-offloads.rst          | 67 ++++++++++++-------
>  Documentation/networking/devmem.rst           | 27 +++-----
>  Documentation/networking/driver.rst           |  7 +-
>  Documentation/networking/napi.rst             | 11 ++-
>  Documentation/networking/netdev-features.rst  | 60 +++++++++++------
>  Documentation/networking/netdevices.rst       | 31 +++++----
>  .../networking/segmentation-offloads.rst      | 37 +++++++++-
>  Documentation/networking/skbuff.rst           |  6 --
>  Documentation/networking/statistics.rst       | 19 ++++--
>  9 files changed, 172 insertions(+), 93 deletions(-)
> 

There is one more cleanup that you could do. Current (linux-next) docs builds
give this warning:

WARNING: ../include/linux/netdevice.h:2622 Excess struct member 'ax25_ptr' description in 'net_device'

-- 
~Randy


