Return-Path: <netdev+bounces-277811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFYuLzez22lkFAkAu9opvQ
	(envelope-from <netdev+bounces-277811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:59:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 346193E46AD
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C91CF300B982
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A13237F01F;
	Sun, 12 Apr 2026 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF51XSf9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565C37FF67
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776005938; cv=none; b=tBXmSu5MNzMrT8iNUO8u0eOj1DEOXgSrjM1mnc1iazwj6Lpi33GwXY9RU9RU9dKPqX6XFNy7o5aac+o+CC9KY5MgMA0nvo6VrIdnc1VaTZtRxevQAnEIhOmrL/VN/MZRA1qfW08+QcyssISzBtVLO83r7aqVT61jIuUlON2t2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776005938; c=relaxed/simple;
	bh=ydsPDjVGsCeHWbPEKbjjI2nmQTicYsIGs2BIxAuK4rg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otmCsin3M9dH2W8+qdlRAnfk17cxJTXoaMTd0GjCOPEO0stAOeRKE9lgTYQ/LO6johXPpG9/rlAvfxk4DDeySSKuNIF7grDEOlTFWA15FB+QY7z2CxxUFD2ghcqyWo04Rp0+a3fh257LhIrGsju3w4f8WnjdW+nKk1aEJaLYnzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF51XSf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516E5C19424;
	Sun, 12 Apr 2026 14:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776005937;
	bh=ydsPDjVGsCeHWbPEKbjjI2nmQTicYsIGs2BIxAuK4rg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cF51XSf9mm39l0tm+vr+8OmSdquGgjfXemm0L2iBO1InNmg+lKjgouwRaiBv7X/Dc
	 hzY5GQ7lKb3bdScjh7KEl7fxTemcxcyge3sZY3NX55rOi/wXyiF/y7W6XYoRn6Xej4
	 D12Rcxs1YTHSjyMqgqbjQgrPtfUMq0QuD/F5EiC6SVckjopxP7Y35n9GJk7zsetGxq
	 A1DDwOH4MuW/lXcyosSkJOBDRJJkFCIbaWtrL59f9SxTOqw1ZFZOPaTuc+OBVA4C3u
	 rLcsMIzsxxbaT60nqUp8QH8qBRC4IAJbmfsZZywy7CyaBM2fT428rDSO7vZ4UfpoAO
	 oOsE8fg/J9LLA==
Date: Sun, 12 Apr 2026 07:58:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 00/15] ip6mr: No RTNL for RTNL_FAMILY_IP6MR
 rtnetlink.
Message-ID: <20260412075856.68f37eb6@kernel.org>
In-Reply-To: <20260410211726.1668756-1-kuniyu@google.com>
References: <20260410211726.1668756-1-kuniyu@google.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277811-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 346193E46AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 21:16:56 +0000 Kuniyuki Iwashima wrote:
> This series is the IPv6 version of
> 
>   https://lore.kernel.org/netdev/20260228221800.1082070-1-kuniyu@google.com/
> 
> and removes RTNL from ip6mr rtnetlink handlers.
> 
> After this series, there are a few RTNL left in net/ipv6/ipmr.c
> and such users will be converted to per-netns RTNL in another
> series.
> 
> Patch 1 extends the ipmr selftest to exercise most of the RTNL
>  paths in net/ipv6/ipmr.c
> 
> Patch 2 - 6 converts RTM_GETROUTE handlers to RCU.
> 
> Patch 7 removes struct fib_dump_filter.rtnl_held.
> 
> Patch 8 - 9 use RCU for mr_table for CONFIG_IP_MROUTE_MULTIPLE_TABLES=n
>  and CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=n for ->exit_rtnl().
> 
> Patch 10 - 12 converts ->exit_batch() to ->exit_rtnl() to
>  save one RTNL in cleanup_net().
> 
> Patch 13 - 14 removes unnecessary RTNL during setup_net()
>  failure.
> 
> Patch 15 drops RTNL for MRT6_(ADD|DEL)_MFC(_PROXY)?.

Hitting a bunch of:

  SKIP      no netlink MFC interface

on the new test here. Do we need to add something to .../config ?
Current effective config for the net target is here:
https://netdev-ctrl.bots.linux.dev/logs/vmksft/forwarding/results/597761/config

