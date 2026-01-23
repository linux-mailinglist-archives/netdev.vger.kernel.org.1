Return-Path: <netdev+bounces-252683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHwAL/Itc2mTswAAu9opvQ
	(envelope-from <netdev+bounces-252683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:14:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2337249B
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8C5B301F481
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EA42D8DCF;
	Fri, 23 Jan 2026 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dLgAvyy9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F52F318130
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155792; cv=none; b=NZboaR+VanH5u/1Scd4vXrIaxbQh7BsEHxzVX+Ne1Q8CmKJzXjScDOS1z4qP/hdEuZzZ6r1FUoXEp1I0GKrbUUiOtZ6QH4y9G//oDaMl9FE5dDSoGvSlmsP2sZ5Lw7q58V9xfs8G0VKt+kvhb2/rZYeLjaH4jUEx4CWtObfVwRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155792; c=relaxed/simple;
	bh=tR3sZW6jYtInuvVcPkPF69rvDcAsL3acmVG2zLsyMlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALddgW6mgIn8OxJNKaLI7Au5K9fpYBhzy1DIaoBs9rrujwPBbLn+aswDrXSWQFMbG4i9ABYTAvEqTl1aWqNUJA23JK+Hyz76QCuBMaKveYB7LdzVqJwJk7ZOjYz/u8XvHf8r6Yy846eM2WNvzTRrU2pFgMdpC6f6ZHOiBQ/WzQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dLgAvyy9; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 480D9C21AB8;
	Fri, 23 Jan 2026 08:09:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F0E286070A;
	Fri, 23 Jan 2026 08:09:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3ABB2119A8794;
	Fri, 23 Jan 2026 09:09:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769155785; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=avpNbejQVhcRwN5fLLkgDSir1StlELzVRnwamqKBB0w=;
	b=dLgAvyy9xth2EbBZiiTwdhv6IdHWqUpCq8+2FTEyM3BV7DI7IcdEIjlqn97SlrEsuimoK4
	lDbwVEyptmwpJhv9hzcG9Rq+uqLZ8K+qMstkf5ifeeeqDC08TdMCsHoIW125+57h1XU0yk
	QBYkgreqQnS03Czr3so+ch5Y5Rm64l7PGnyJUfc7IS7KxrYuQEExD0FUWPZLd7R5JWwDhx
	vYURtHUKOYaELo60YH/PImA6qAyuJ6f1Cm7TPGyeuRXhh4QTdZ3NtXHfk1wcAQ3xrgshb2
	jtAmtMkcE+9temkACZuhAk5z9KptI/ztm7uGaEX4Rmgxm7CfUv20j3RqJ7S9Lw==
Message-ID: <8e7a73ed-1488-4d13-807c-f17c04c160e7@bootlin.com>
Date: Fri, 23 Jan 2026 09:09:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: mvpp2: cls: Fix memory leak in
 mvpp2_ethtool_cls_rule_ins()
To: Zilin Guan <zilin@seu.edu.cn>, marcin.s.wojtas@gmail.com
Cc: linux@armlinux.org.uk, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260123065716.2248324-1-zilin@seu.edu.cn>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260123065716.2248324-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[seu.edu.cn,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252683-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,seu.edu.cn:email]
X-Rspamd-Queue-Id: 2D2337249B
X-Rspamd-Action: no action

Hi,

On 23/01/2026 07:57, Zilin Guan wrote:
> In mvpp2_ethtool_cls_rule_ins(), the ethtool_rule is allocated by
> ethtool_rx_flow_rule_create(). If the subsequent conversion to flow
> type fails, the function jumps to the clean_rule label.
> 
> However, the clean_rule label only frees efs, skipping the cleanup
> of ethtool_rule, which leads to a memory leak.
> 
> Fix this by jumping to the clean_eth_rule label, which properly calls
> ethtool_rx_flow_rule_destroy() before freeing efs.
> 
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.

Thanks for clarifying how you found that

> 
> Fixes: f4f1ba18195d ("net: mvpp2: cls: Report an error for unsupported flow types")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Change is fine, thanks for fixing this.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


