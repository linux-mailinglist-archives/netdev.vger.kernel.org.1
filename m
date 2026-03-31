Return-Path: <netdev+bounces-273537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBomCZSQy2kuIwYAu9opvQ
	(envelope-from <netdev+bounces-273537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:15:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EFB366D00
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67F7030DB457
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4E93E557F;
	Tue, 31 Mar 2026 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4Jb8nhq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698643DCDA4;
	Tue, 31 Mar 2026 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948222; cv=none; b=vE92bXVuBsn+PIAnKuZPQhZ3jdl0qNKXLf9dw6LcQHRp+vc+n9vgOqrNpHxakr+WSdc9SQXuKANiRwiJOtC5ibYon/0R8iuIEqpsL6JgciVTzqDc6cjFPKizqT1eACLKLVNaHJZxt1RIctEDUjmqpbsKXXyawDbhvKFdI+A1d5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948222; c=relaxed/simple;
	bh=WvTJgMky5yWjni4cCM9GofMz0+w/f0RTdLFyZMjZCMs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iIdsGwkOvhHxC0zIW/xNBfRlRxfjQ/6VOYZCpuESFGWvwUGyy4BqmnUpele3tHjMAGmsBFyzWZEdbyK0jpQrAKE+gnYEsPv+vLp3wu6FqvqUTFzjs9VTnuXvD4A6z43xZHXNq6NABicE6MrtSRnh1CeGL2nfIetM656ok75xxZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4Jb8nhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A02C19423;
	Tue, 31 Mar 2026 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774948222;
	bh=WvTJgMky5yWjni4cCM9GofMz0+w/f0RTdLFyZMjZCMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D4Jb8nhqEI3DS6Q0VU7gmSkR31eWhzerEzQ7YDbNpsJnY6gT+eEEYAzRldVbfJ2CH
	 aytjlJJqKVadtwB486FZAU1PoEzDWIP1hTnolmJqVGMNOwF12cEQI38hsBX18WSEK7
	 tf8m/x1Lk7XmQ2SDJaBxTw41jfrMsY3RCXn/XhFTEpxnMyKy3Hy151vFTwpszZ/TsM
	 e2Lr755XZz1Cb8PpN29Iq8+rNfYH9gE3LXL2dSTT1wQSHUltmIxg6C7MTyjFpJQY4l
	 uTDMx8QE7KVf7zCKy2S5syqVRIu6u/Fx8dg0DFSE6E8a253hz2yEh31N8FCztkdn8H
	 iLEJivck0qKrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CB7392FF48;
	Tue, 31 Mar 2026 09:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] NFC: pn533: bound the UART receive buffer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177494820579.2191087.3471389176795007575.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 09:10:05 +0000
References: <20260326142033.82297-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260326142033.82297-1-pengpeng@iscas.ac.cn>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@kernel.org,
 mingo@kernel.org, kees@kernel.org, pabeni@redhat.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-273537-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 74EFB366D00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 26 Mar 2026 22:20:33 +0800 you wrote:
> pn532_receive_buf() appends every incoming byte to dev->recv_skb and
> only resets the buffer after pn532_uart_rx_is_frame() recognizes a
> complete frame. A continuous stream of bytes without a valid PN532 frame
> header therefore keeps growing the skb until skb_put_u8() hits the tail
> limit.
> 
> Drop the accumulated partial frame once the fixed receive buffer is full
> so malformed UART traffic cannot grow the skb past
> PN532_UART_SKB_BUFF_LEN.
> 
> [...]

Here is the summary with links:
  - [net,v2] NFC: pn533: bound the UART receive buffer
    https://git.kernel.org/netdev/net/c/30fe3f5f6494

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



