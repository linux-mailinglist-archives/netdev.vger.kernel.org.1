Return-Path: <netdev+bounces-280588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FZgFMOU6WkreAIAu9opvQ
	(envelope-from <netdev+bounces-280588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:40:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8841C44C91A
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 378393027B7D
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 03:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0973F3CBE99;
	Thu, 23 Apr 2026 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seVBQwqc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93BB379EF2;
	Thu, 23 Apr 2026 03:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776915646; cv=none; b=MxdAfmsH1yuZHmmP5y5PTeXy+BIw7xM8xev4539LEXt8PXErCDUDXqpQ1bmf+kO1rf+F/PKUfQDFgECHyrltnkekI18/8a4+wkdKDmiuwmkjg8/fUKO5xSp6hLAKBkuWEhOctAlFZhM4iu29JKttgx9Q/yTpE+ujM7RqjABrVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776915646; c=relaxed/simple;
	bh=4vSvclPmQwhQl6kawKVFa0CCd0NhZTiA/bYhm5m9SZo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R+NWg6OzizwLA98zblQxZBlh5z7NuyhN78Wc/DFmVQirA0AL4nKodGKK4dJ4/3+wecXrBKxRedTu1YfCheobrw1xQSLe3q5Vlti3AIfQOs8sb29xfA65c0No7ANPrE5X+UPqbPimr82etTo7J1ABHeaFQwPRn3gSMXSItdkHvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seVBQwqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501C7C2BCB2;
	Thu, 23 Apr 2026 03:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776915646;
	bh=4vSvclPmQwhQl6kawKVFa0CCd0NhZTiA/bYhm5m9SZo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=seVBQwqcRrXA4h3bmzY4ekr0MsZkfSpF7/zk7gRxTCSFpwc/qD7lhcP1ntu9I7ZSE
	 Tq9Yo400Qe2CuJVdLVPxCiUcHjtihpQMrH44l5Q7EYOMXKOvuui+ngTV+pNC4b5/+a
	 c0i+g1Cc57RZqiBsZ34S0EZtqqsoFAznyYwqNym0D+ErhqF+eviwf9VWlsdkxaH0c8
	 iePPbRunGNYgHJoqrqseukNe9TeJUcyvJU9AkznqVhf+my5h/SE9/nXi1itfwUjBAF
	 /AngezAupJami5x2VATITqhAHosH1PKXjcHZI8/X2SvcrjQpFxXBvRox1zVmBN10tm
	 XsQ+JNbGLdqHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD7D3809A86;
	Thu, 23 Apr 2026 03:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: validate skb->napi_id in RX tracepoints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177691560830.4145271.11470573371955167490.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 03:40:08 +0000
References: <20260420105427.162816-1-kohei@enjuk.jp>
In-Reply-To: <20260420105427.162816-1-kohei@enjuk.jp>
To: Kohei Enju <kohei@enjuk.jp>
Cc: netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-280588-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8841C44C91A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Apr 2026 10:54:23 +0000 you wrote:
> Since commit 2bd82484bb4c ("xps: fix xps for stacked devices"),
> skb->napi_id shares storage with sender_cpu. RX tracepoints using
> net_dev_rx_verbose_template read skb->napi_id directly and can therefore
> report sender_cpu values as if they were NAPI IDs.
> 
> For example, on the loopback path this can report 1 as napi_id, where 1
> comes from raw_smp_processor_id() + 1 in the XPS path:
> 
> [...]

Here is the summary with links:
  - [net,v1] net: validate skb->napi_id in RX tracepoints
    https://git.kernel.org/netdev/net/c/3bfcf396081a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



