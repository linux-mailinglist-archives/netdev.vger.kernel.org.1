Return-Path: <netdev+bounces-296999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K0JWD9TiJ2ox4AIAu9opvQ
	(envelope-from <netdev+bounces-296999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:54:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F02165E93A
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:54:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kernel.org header.s=k20260515 header.b=Xfe6UUJv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296999-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296999-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC219302D13A
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 09:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435C53DEAC8;
	Tue,  9 Jun 2026 09:40:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF0038CFE5
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 09:40:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998008; cv=none; b=CGLj9NjXlh/vpD6WdFt5NCqXvCB1EICFH1FDhMkq/dllvr7jV2kT2cQOQUM0dW6/Kv/x+aCxKIP3DXZ+fPH05DUUeBgDVEJ38nO5QwoFv0Bx97n7fdlJA8abgjyCqMqBaTuHlMF1Lh964/sGpgU0toAdqV1PQ1b03uvQUrsnXbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998008; c=relaxed/simple;
	bh=4aGnP6/bH48dE3BmzD0+W/UIobCGQ972v1CjDVeJgvQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AqANkJZVTRD+2X9NjkgnICIXRZdEgF5+PpKK5ZN7czr+kdzbsP/H6OTgtFwtXsvGGS/jvFF7NSwim2a8zwEXdbbwxJIlBDzSmzPT6yx1zvUJLb5RfsZTf0uMcFYeOMUu7qe1B75g1UlLLlJVMt56p4jNE/fYcrZuNlFdRj9daFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xfe6UUJv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E44B1F00893;
	Tue,  9 Jun 2026 09:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780998006;
	bh=Epe+d6TgSqLv0QryFGEobWb3lCOX4vn5mrOCT1cBANY=;
	h=Subject:From:Date:References:In-Reply-To:To:List-Id:Cc;
	b=Xfe6UUJvx1IRhO2cPsYn7M6+DAfCS8+PSqvEfccB9nSGeNRbWZrVDnBrp1hLm9NKY
	 CJCbPMxLuRAx4scg0fntdQ6xrBFKIoXXPf725YHFOryxmRgCb/K3pjXeMhDQ0nTGl6
	 9iZJCQcFxxS9Sq+gcpVbe/rw8Ja2EfjCb0vs918oJOAFAGM3/+VFd9EXh61cznXOes
	 bLyP6kYEh3O51eO8g3B2ObGRtItM2QzQWWdhvZ1MlP8HXz73uTMMbPktFnxNg7uE1G
	 ilkt5xrt4HRUVgYBd7O/pe4l18XKSHEyInmeOuhsg2d1M1tzu6kcJjy44jpBr9r6tA
	 sEDztVdSc9dNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D93930789;
	Tue,  9 Jun 2026 09:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] rxrpc: Fix the ACK parser to extract the SACK
 table
 for parsing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178099800515.1915898.6611538071201601875.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 09:40:05 +0000
References: <105362.1780573560@warthog.procyon.org.uk>
In-Reply-To: <105362.1780573560@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, michael.bommarito@gmail.com,
 marc.dionne@auristor.com, jaltman@auristor.com, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, stable@kernel.org, linux-kernel@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296999-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,auristor.com,google.com,davemloft.net,kernel.org,redhat.com,lists.infradead.org];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:netdev@vger.kernel.org,m:michael.bommarito@gmail.com,m:marc.dionne@auristor.com,m:jaltman@auristor.com,m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:stable@kernel.org,m:linux-kernel@kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F02165E93A

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 04 Jun 2026 12:46:00 +0100 you wrote:
> Fix modification of the received skbuff in rxrpc_input_soft_acks() and a
> potential incorrect access of the buffer in a fragmented UDP packet (the
> packet would probably have to be deliberately pre-generated as fragmented)
> when AF_RXRPC tries to extract the contents of the SACK table by copying
> out the contents of the SACK table into a buffer before attempting to parse
> 
> AF_RXRPC assumes that it can just call skb_condense() and then validly
> access the SACK table from skb->data and that it will be a flat buffer -
> but skb_condense() can silently fail to do anything under some
> circumstances.
> 
> [...]

Here is the summary with links:
  - [net,v2] rxrpc: Fix the ACK parser to extract the SACK table for parsing
    https://git.kernel.org/netdev/net/c/333b6d5bb9f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



