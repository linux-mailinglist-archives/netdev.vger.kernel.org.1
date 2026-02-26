Return-Path: <netdev+bounces-261116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEmTC7uln2mHdAQAu9opvQ
	(envelope-from <netdev+bounces-261116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:45:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B29AF19FEA7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EC7C30097D2
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9516036215C;
	Thu, 26 Feb 2026 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH8dlHy0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716FD4C81;
	Thu, 26 Feb 2026 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772070236; cv=none; b=RHom6d7gA2KAW3UMEKq8UTqblyVuvl+Ouv7wmbBPhwqNi4RZhJMIWtgW71WGZyT+UVKXO3i1CMLZIi3eORXqotOQ3Q5QVWYjabjoKD2tvogd93MOET+tWq31nME3xMvH+uOUWIznDvSnGTUUKtbqdMln9TEZ6jHqb+VAZ7LJ554=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772070236; c=relaxed/simple;
	bh=BhOSzUokZoKHeOKyuPq1s+G4YR+ei6KQ4tjOOyLQcHI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBsjm4NGlaPFUvtlv5sIH+PftPS9rH0de/rB+Wo5+L9P3kOiP29GTLIPjHcJK087MAtxiBvqdVW/d7c7EzOHSAsNIIr/1N8pfGMtWcyeRnUHw0T5hntw9d0vNM3EMige1HmjX5UHuaGCN5KlSjOfBj4OJVuuXoTpY1GNVXtn+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH8dlHy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEECC116D0;
	Thu, 26 Feb 2026 01:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772070236;
	bh=BhOSzUokZoKHeOKyuPq1s+G4YR+ei6KQ4tjOOyLQcHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TH8dlHy09Wl9FaoynpvrWJL4oNYG+s2COlHlck9FZzFcMdn19JhI6HSJVeo1gtheI
	 FcnB5m3DgVsGf3LSovrVpniu482tiJQXAEShru8nQRGLCk61vOTv9P+p9TKlyLu8eV
	 /60g8cdDsM3jxUWAr4yF3e0g0HnwP85EtpfVTRrpJ7gc8s66+EtS3i72mmez99wTTq
	 NbuJILrhSEP4JyPiXb6Th+EbomCPHifZhm5xuDb29l/AgEbMWeZZC4vB7tnmrRqyIU
	 rpRo1SKvaOeeBu89y9axRnS593kiQNGerjb6FiY2KuUxcCE7SWA/xSPDLJHtV1jxtY
	 E+k8DeSalJxpg==
Date: Wed, 25 Feb 2026 17:43:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Hwang <leon.huangfu@shopee.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>, Neal
 Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ij@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, kerneljasonxing@gmail.com, lance.yang@linux.dev,
 jiayuan.chen@linux.dev, Leon Hwang <leon.hwang@linux.dev>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] tcp: Add net.ipv4.tcp_purge_receive_queue
 sysctl
Message-ID: <20260225174354.5a698ddb@kernel.org>
In-Reply-To: <20260225074633.149590-1-leon.huangfu@shopee.com>
References: <20260225074633.149590-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,nvidia.com,gmail.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-261116-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B29AF19FEA7
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 15:46:33 +0800 Leon Hwang wrote:
> Issue:
> When a TCP socket in the CLOSE_WAIT state receives a RST packet, the
> current implementation does not clear the socket's receive queue. This
> causes SKBs in the queue to remain allocated until the socket is
> explicitly closed by the application. As a consequence:
> 
> 1. The page pool pages held by these SKBs are not released.

On what kernel version and driver are you observing this?

