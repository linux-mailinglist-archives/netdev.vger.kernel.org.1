Return-Path: <netdev+bounces-280827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCCxDYde6mksygIAu9opvQ
	(envelope-from <netdev+bounces-280827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:01:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB59455D83
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6468C3039888
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D071736E46C;
	Thu, 23 Apr 2026 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOuOAhO4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C436DA15;
	Thu, 23 Apr 2026 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967001; cv=none; b=mz5CTCtQBm44tM/zRcVIPuO9Lb8wrRCRQ11MlthvOzry+10GwpnMa4ZAGZLUtYlTiGEMppNum0h6jpaJpmgmozsmYhXHEniGd2oS214uU6CY/rtLBLq5pZt6/suUC+nAA++p4Ifa/wiTeqInk9RRD0CCbA7RqJiwYTOXDBdEyqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967001; c=relaxed/simple;
	bh=SFN7PG8q4FiYBmIm9gqoz7Eb7JYv3+w7SKzpox9v6AM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLoR2WxJn4a9j09wRe5rORl6IhVq1uxb0BTTueTewFW7Uv6VQ3aoiV9+7RbodBqkIwNefh2XWEIrOgvd+psZNugDchEkRM1d1ZsGG2SLKmd7eUehG9WsouNUcaLdP8DqjBWJRrk/qU3W+1pcPyIFY3KvHpg8hW4nsu68LvHsucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOuOAhO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA71C2BCB2;
	Thu, 23 Apr 2026 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776967001;
	bh=SFN7PG8q4FiYBmIm9gqoz7Eb7JYv3+w7SKzpox9v6AM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JOuOAhO4/zEwTpb9CO3WRMypMzhIXGne+cqqCIKagjE5R/RzPx5lUcmiIMrVQkdMd
	 VTSLC4GLv6821Dr81Q9BFr1luSW42Bge2tNogV0+A6hfJf9yqV/MHC/uCu1TGR9XyA
	 SEOC7I0jDODIeHtaNWvLWoijcV62UcC/QhYaPR4vXShx7bYxbjrBqUhlPNWX5k1gvv
	 FozRRtRjuJovZzxgIuSdQ05IfqXlYW1vWs+1G2IdUwSpKNUhkmXjCJaADLvEHN8KLV
	 kEjRYfKXCIQDVXwvxeWHB/08kTE2WP3WREZy04qfopyeQqeEgLwd9B/2yS0gdpMMor
	 SRnpX1N+fxhWw==
Date: Thu, 23 Apr 2026 10:56:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Anderson
 Nascimento <anderson@allelesecurity.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/6] rxrpc: Miscellaneous fixes
Message-ID: <20260423105639.6e0a0a7e@kernel.org>
In-Reply-To: <20260422161438.2593376-1-dhowells@redhat.com>
References: <20260422161438.2593376-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-280827-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 1DB59455D83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026 17:14:29 +0100 David Howells wrote:
> Here are some fixes for rxrpc, as found by Sashiko[1]:
> 
>  (1) Fix leaks in rxkad_verify_response().
> 
>  (2) Fix handling of rxkad-encrypted packets with crypto-misaligned
>      lengths.
> 
>  (3) Fix problem with unsharing DATA packets potentially causing a crash in
>      the caller.
> 
>  (4) Fix lack of unsharing of RESPONSE packets.
> 
>  (5) Fix integer overflow in RxGK ticket length check.
> 
>  (6) Fix missing length check in RxKAD tickets.

Have you had a chance to look thru sashiko run for this?

https://sashiko.dev/#/patchset/20260422161438.2593376-4-dhowells@redhat.com

