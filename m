Return-Path: <netdev+bounces-290934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHFBCi3XEGrYeQYAu9opvQ
	(envelope-from <netdev+bounces-290934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:22:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA8E5BB191
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97706301C152
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 22:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A411838F922;
	Fri, 22 May 2026 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKTHnqFK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD713438AB
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779488402; cv=none; b=Zuk6GbnXWF5cJpBXv/RCxdB6LcFXcRKQEChXxwNQGDCQ68xluzCbr3d0VUwvxjGI7n24aK/MPoi3Nq+spaJKpjrAHvpRp3IX+/kRV7W2Vk1y11GNbrMriLcvOHuH0lX6Owuy4vzqcn/y/IlJwN5qN2VciLUtGMc7fEm/B1ulN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779488402; c=relaxed/simple;
	bh=VmcCURu8RLNauZvkQRfTo1DQegxKuOIHWcZWlQtv/NQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ql8bDBkPguLsHotji3kHjgANdGNQenK5tNsXoYecJ9gsm3OevTD7md7utNVz+bRQjvjkqSS0wocnIWGpTnBVusEBLU/HGQx6OJibH98Egh7GzFzq6inXL8WT9cKjD6ilimFJMdDJTn0u19rtR+Ca4mKsmyldir9BQp/7TFwfYco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKTHnqFK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2975F1F000E9;
	Fri, 22 May 2026 22:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779488401;
	bh=vfmU0AYl5+P7EU4QIj7Q9JR0WtXfEvzV9OYoL6gkHpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nKTHnqFKyVYZr9qIyIwqjF1gr7gqoVTltKMdD2oJe73qUd945n6mykBsGFVih3mO8
	 bH3qM6aZ5YpjiJKvFBs500//++JSP9Q4FROuFwZn9FgAAam2DvKbFQeloAF7JRzPQz
	 IboeXNlQ25CNKXIXjR7PfXfb5IVhYiW/XDjOdMUv9fPMvvJWFYkE4m+vhax0OPzG+6
	 Qp0zlZZb8R4YHetWygx6yS8shgFJBKi1kGzzR8UuWpUZFhSqsexW9/VutYK8rhkVl2
	 z2yxWAxGxGOi17eXRdPOHQOryEUM8EoCYSYhFxIV+HQXBb2g1m079RGq2APfKUy2D+
	 LskrcuTsULajg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B73393100E;
	Fri, 22 May 2026 22:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [iproute2-next] netshaper: Fix man page accuracy and formatting
 issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177948840989.1388561.9416850398264720043.git-patchwork-notify@kernel.org>
Date: Fri, 22 May 2026 22:20:09 +0000
References: <20260522030702.2671992-1-mohsin.bashr@gmail.com>
In-Reply-To: <20260522030702.2671992-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexander.duyck@gmail.com, dsahern@kernel.org,
 stephen@networkplumber.org, pabeni@redhat.com, kuba@kernel.org,
 ernis@linux.microsoft.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,networkplumber.org,redhat.com,linux.microsoft.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290934-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email]
X-Rspamd-Queue-Id: 7CA8E5BB191
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 21 May 2026 20:07:02 -0700 you wrote:
> From: Mohsin Bashir <hmohsin@meta.com>
> 
> This is a follow up to a previous patch that was merged before the
> feedback was provided. See link below for previous patch series.
> https://lore.kernel.org/netdev/20260518202353.390827-1-mohsin.bashr@gmail.com
> 
> Address the following concerns:
> 
> [...]

Here is the summary with links:
  - [iproute2-next] netshaper: Fix man page accuracy and formatting issues
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=de8c3aaa3545

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



