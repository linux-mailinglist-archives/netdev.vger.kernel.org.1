Return-Path: <netdev+bounces-264315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tl3CI/hnqWkp7AAAu9opvQ
	(envelope-from <netdev+bounces-264315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:24:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AE82108A5
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CAEE302571F
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A2737186A;
	Thu,  5 Mar 2026 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QRQGFCYu"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102C3347FEE;
	Thu,  5 Mar 2026 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709877; cv=none; b=BVDbbiAhhQ+lg3iv299pczRBkj6ujJCgFSLiG4a2w6WJzZHJYuyfUSSveqMsAfqebF3PpropJfJ8n9j6Sh+xpxLkfOjGCtJsTz5QSqeWP+maC99X6Pz1tLz193jf9pgeu7XlErBUPj/lGfh2gkKORQRREvB073WAs/B/3nDyzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709877; c=relaxed/simple;
	bh=DMNhvzrgXP9OiLu4K7KpyXETlnZrSn3rv2sewPh6MLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjk9g01HcEFMIzoSIYUK/1ZrhE3HdaosdQpUZV5ZP1MVj6myxc2l498yem5AUanPA3IYcyi8hxe7xIk8c7PUrrK2W4htmO3p4ou9IznPNw5MQfgAlvL3CNfSc1s1h1U6pAbwSCtZqN1bNWZ6wDSgUkgZfTlDBSb4SBNpVdbVLo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QRQGFCYu; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772709869; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=vvTlZrXhHafuL5ISIBMXPqy33iMyPkUxCrG6mnIfRsg=;
	b=QRQGFCYuNGn211kL0Sn5tJvqQVaEmBoqZC3IMPPhSaXz/PTbX4QlUzo8tgobCExstuuEMPvy6HtpNbmcjDhZYiJV9uxHKeuq9mLR/ly0Vsburf4BA3TXjNbV6UZC7+SCYis3kL9itEoxLlDTTSi4L81le4N+uSWUsOaS1DFJxMo=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X-K9U76_1772709868 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Mar 2026 19:24:29 +0800
Date: Thu, 5 Mar 2026 19:24:28 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: sawara04.o@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net/smc: Add documentation for limit_smc_hs
 and hs_ctrl
Message-ID: <20260305112428.GA57792@j66a10360.sqa.eu95>
References: <20260305092226.27379-1-sawara04.o@gmail.com>
 <20260305092226.27379-3-sawara04.o@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305092226.27379-3-sawara04.o@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Queue-Id: B6AE82108A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264315-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 06:22:24PM +0900, sawara04.o@gmail.com wrote:
> From: Kyoji Ogasawara <sawara04.o@gmail.com>
> 
> Document missing SMC sysctl parameters limit_smc_hs and hs_ctrl
> 
> Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
> ---
>  Documentation/networking/smc-sysctl.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
> index 17b8314c0e5e..67c2bdc533d7 100644
> --- a/Documentation/networking/smc-sysctl.rst
> +++ b/Documentation/networking/smc-sysctl.rst
> @@ -111,3 +111,27 @@ smcr_max_recv_wr - INTEGER
>  	like before having this control.
>  
>  	Default: 48
> +
> +limit_smc_hs - INTEGER
> +	Whether to limit SMC handshake for newly created sockets.
> +
> +	When enabled, SMC listen path applies handshake limitation based on
> +	handshake worker congestion and queued SMC handshake load.
> +
> +	Possible values:
> +
> +	- 0 - Disable handshake limitation
> +	- 1 - Enable handshake limitation
> +
> +	Default: 0 (disable)
> +
> +hs_ctrl - STRING
> +	Select the SMC handshake control profile by name.
> +
> +	The selected profile controls whether SMC options are advertised
> +	during TCP SYN/SYN-ACK handshake.
> +
> +	Only available when CONFIG_SMC_HS_CTRL_BPF is enabled.
> +	Write an empty string to clear the current profile.

It would be better to clarify that this string refers to the name of a
BPF struct_ops (type smc_hs_ctrl) implemented by the user.

> +
> +	Default: empty string
> \ No newline at end of file
> -- 
> 2.43.0
> 

