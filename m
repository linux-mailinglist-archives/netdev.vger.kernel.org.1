Return-Path: <netdev+bounces-251675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFrMDLAfcGlRVwAAu9opvQ
	(envelope-from <netdev+bounces-251675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:37:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 927FC4E938
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB9687A73EC
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA3E2BD015;
	Wed, 21 Jan 2026 00:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOIAq7AP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1CC2BF019;
	Wed, 21 Jan 2026 00:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955813; cv=none; b=BJdmcn/wxZ1XS0NCMKrBNEdNREIfdUlnbGoEX9Od3cw3P/0WhBwoS7SeZp+q+zO/gONVP3C5rjR2DGuhIQUpzSSxKAAHI5xP7AquLGyuLXQunpmx8ZiSaQWiefdN+fgg4aWDUNVDfnTMGit4IoGi+8yU/LGZyRgGvAwveQQRIpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955813; c=relaxed/simple;
	bh=JQPodyJXiqn+AXIyS04EQX2JmIgHq5lzuwwxLaYSoSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fr7l+viSpdbeoR1apJwsRQDGRS6MXKSlLWsU8QDoGtcrtI1gnv0drMXzipi0fQHcaKbj4uU7bkut3M0NrrTjYapc7hdwATb3jDdPLzjOeImpCSlgw/Lx87VKOdE3cVijE1/v+CpFdLoDCu4X3j/PdgovfgOtPCyBtxKswwuC0WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOIAq7AP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB0FC16AAE;
	Wed, 21 Jan 2026 00:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768955812;
	bh=JQPodyJXiqn+AXIyS04EQX2JmIgHq5lzuwwxLaYSoSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TOIAq7APjoKMhHg/PLE0giYAAX8H9oZZQOgtKRkIh97DEsVli4T97MBGbMPytJjFc
	 yMT1SQ8xc8WimzxPqYWj744iAIfqtjL4YUbJSJPUEfQhpSddq0BLSVldxq5Ucx1oCU
	 zbUOY1oW2eXhDrKaiMRN9aFXZZxtDRVdfoIpGar7zMBGRkUymwKhRLvzmW9y1Rojaj
	 wK0AQiIR2avKaQk+dKq7omC4+04TLL1qgSx+RCAvURMbDgXpYZ273h9gFvxUzqvv3P
	 LyE6JqDLZSef8y0ODbZfjuh6obMG7EZEDhHxHOtUi6XEj4ydT4AjPG8M7owj+yAuzk
	 lZHW3M2gKN9eg==
Date: Tue, 20 Jan 2026 16:36:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, David Ahern
 <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>, Arnd Bergmann
 <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, asml.silence@gmail.com,
 matttbe@kernel.org, skhawaja@google.com, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 4/5] net: devmem: document
 NETDEV_A_DMABUF_AUTORELEASE netlink attribute
Message-ID: <20260120163650.5a962648@kernel.org>
In-Reply-To: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-4-686d0af71978@meta.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
	<20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-4-686d0af71978@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251675-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,arndb.de,lwn.net,lunn.ch,gmail.com,fomichev.me,vger.kernel.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 927FC4E938
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 15 Jan 2026 21:02:15 -0800 Bobby Eshleman wrote:
> +- Once a system-wide autorelease mode is selected (via the first binding),
> +  all subsequent bindings must use the same mode. Attempts to create bindings
> +  with a different mode will be rejected with -EBUSY.

Why?

> +- Applications using manual release mode (autorelease=0) must ensure all tokens
> +  are returned via SO_DEVMEM_DONTNEED before socket close to avoid resource
> +  leaks during the lifetime of the dmabuf binding. Tokens not released before
> +  close() will only be freed when all RX queues are unbound AND all sockets
> +  that called recvmsg() are closed.

Could you add a short example on how? by calling shutdown()?

