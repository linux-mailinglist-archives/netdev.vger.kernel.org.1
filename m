Return-Path: <netdev+bounces-263168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMuRAebNpmntWQAAu9opvQ
	(envelope-from <netdev+bounces-263168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:02:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C861EEE54
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 432523025432
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 11:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231AA331A65;
	Tue,  3 Mar 2026 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES/NAHaf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B682D46B3
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538604; cv=none; b=gY8Dh0yAO7rC/t+2DEWPuRxo/QPQcJoQb9xZ1tRfzvxEM3p6JnoONHcvC7K4N9LN4t/AjccM89rlds5VGP+oSv/CjZwuE/1vNJ0Rba8draIUGdQktUzKG4xlyACT9YnRnMVjdsETOdFSx7AkbxH/KAeRSeIC0uQa0T5Rcqt5+Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538604; c=relaxed/simple;
	bh=u8rbT8/NeKpEeeWz81Ro38SoLa3EiUTRyj4XZHnUePs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qj69GMopMOMGc0dbuSn1kMQXUcQVOZ5lZ/hslIMBHag6uS/Hdk6aSdCdEEa2LFbpS/hCO6MA6gp01hzQMSu+KJS1DF7ebGyYYekyA0EWAHck5vHQLYhvWVmvIZeSpLcclOcwupYl9hRZr2ORDg/IVX021F34iuNjJrrp72g66VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES/NAHaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1154C116C6;
	Tue,  3 Mar 2026 11:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772538603;
	bh=u8rbT8/NeKpEeeWz81Ro38SoLa3EiUTRyj4XZHnUePs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ES/NAHafPPT6VOzbqOeuwzNiDHTrQNI1c1pbNI6Mjb05tHLgfLn6Q/hNyo8P+zEt1
	 i1511EMuYJby5DUv6/QPUpdxXYL1O4BLSc7oLm8sN5/w/lYdVxV1TvFo79985nKEB0
	 nNN2mpvwTX2s4PaJIXN9vU+xnvorZKk5kH74LpmOvht09iwa+OW9IvqzSHoG/IzUCS
	 d53kIn9yCKlyS3CzG6tC1MWW0f/Yie+vMew1kfyw+6yg5nB0m4BPtiCDYyU7Rgz8vn
	 lxGoqZaB6SLcqI3M9Fsj48surk3XYwv8eTPXQ7KSBtMPiBMHOIHPqwvlL2NcQzMR5r
	 9wUqs9NgnBCjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEC7380A965;
	Tue,  3 Mar 2026 11:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] indirect_call_wrapper: do not reevaluate function
 pointer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177253860530.835747.6240964290195165095.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 11:50:05 +0000
References: <20260227172603.1700433-1-edumazet@google.com>
In-Reply-To: <20260227172603.1700433-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Queue-Id: F2C861EEE54
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-263168-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Feb 2026 17:26:03 +0000 you wrote:
> We have an increasing number of READ_ONCE(xxx->function)
> combined with INDIRECT_CALL_[1234]() helpers.
> 
> Unfortunately this forces INDIRECT_CALL_[1234]() to read
> xxx->function many times, which is not what we wanted.
> 
> Fix these macros so that xxx->function value is not reloaded.
> 
> [...]

Here is the summary with links:
  - [net] indirect_call_wrapper: do not reevaluate function pointer
    https://git.kernel.org/netdev/net/c/710f5c765803

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



