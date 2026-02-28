Return-Path: <netdev+bounces-262024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LcIKJxAomlz1QQAu9opvQ
	(envelope-from <netdev+bounces-262024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:10:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD9F1BFA22
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56959309B9A7
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC10F2D0601;
	Sat, 28 Feb 2026 01:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnTu23qp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A07825783C
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 01:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772241049; cv=none; b=R1Vb7WbWkr/UISE/JWeoY1FRr737POy70t/cs5TAeB1b/olh2lDDGa3DGqWBgG9m2JB6sjRNKgDGAz7W5a3u3xgCFNDY7hNkTxvf8HTmOq7ZyuAM4dPNG6dNAdPc7wGpDFfGTAp7ZTQf9kmYViH+K3e3Eaj78gxpI2shOXL1/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772241049; c=relaxed/simple;
	bh=xjluGbbtted7Zs+A0krwhJo8J9nNZnmllR5qE+yp4XA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=La5TZ0V3eRjTDVlZGPnWx7ytIJf8Q93PkNhBr1Jqkc3kpdBS7LFmceWl6ukcvTqfguoYjPGqninc6Q2Z52wzNMKmi+1EMHntQpdR7Au5hTumN+dNwvs/ypcG1QkrQ6jA/moEiJ49rGKnXuY0Hb3byo7Y41b9saXpmosbimyqLfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnTu23qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B84C116C6;
	Sat, 28 Feb 2026 01:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772241049;
	bh=xjluGbbtted7Zs+A0krwhJo8J9nNZnmllR5qE+yp4XA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jnTu23qpuz43VC+HvkqV6sUsjLF7QlCvDQow63fgh6j0Doqlv2gEowZ9lL0iIXje1
	 gm8NjsPrMaKaOs4hbObnu4kby8SUOjTFcrm236+/xens4gQ0fIwADgjRLSCBMjxRB5
	 gyB1664e9AVvPF2PjlXXop8g7jE08ZGkwVj9M+/IK+DLCqb+Xiz7er/zx9X5XRZdNb
	 WEGgTqYjhd1GiwduIQQfxMw7zgz9sRywFZxj+ejRxd+XmjUDf3ZSSUwFdtpkyDZ6NC
	 I3py8VM5ZkPCcvcCKbzghl6kjrS1QNGw/yyB2BvdFYf/Sjp21QoVyAX8RfUn1N/yD7
	 dS57e7QeU4HDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E6B39EF96A;
	Sat, 28 Feb 2026 01:10:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] include/json_print.h: add includes for `__u32`
 and
 `timeval` declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224105280.2825498.12921287265294578079.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 01:10:52 +0000
References: <20260223223435.289652-1-slyich@gmail.com>
In-Reply-To: <20260223223435.289652-1-slyich@gmail.com>
To: Sergei Trofimovich <slyich@gmail.com>
Cc: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262024-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1BD9F1BFA22
X-Rspamd-Action: no action

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 23 Feb 2026 22:34:35 +0000 you wrote:
> Without the change the build fails on `musl` as:
> 
> ```
> ../include/json_print.h:100:44: error: unknown type name ‘__u32’
>   100 | unsigned int print_range(const char *name, __u32 start, __u32 end);
>       |                                            ^~~~~
> ...
> ../include/json_print.h:82:30: warning: ‘struct timeval’ declared inside parameter list will not be visible outside of this definition or declaration
>    82 | _PRINT_FUNC(tv, const struct timeval *)
>       |                              ^~~~~~~
> ../include/json_print.h:57:45: note: in definition of macro ‘_PRINT_FUNC’
>    57 |                                             type value)                 \
>       |                                             ^~~~
> ../include/json_print.h: In function ‘print_tv’:
> ../include/json_print.h:60:48: error: passing argument 5 of ‘print_color_tv’ from incompatible pointer type [-Wincompatible-pointer-types]
>    60 |                                                value);                  \
>       |                                                ^~~~~
>       |                                                |
>       |                                                const struct timeval *
> ```
> 
> [...]

Here is the summary with links:
  - [iproute2] include/json_print.h: add includes for `__u32` and `timeval` declarations
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=987be6691510

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



