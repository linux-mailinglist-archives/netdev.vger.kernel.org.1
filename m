Return-Path: <netdev+bounces-268848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GOjKv0BummXQQIAu9opvQ
	(envelope-from <netdev+bounces-268848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:38:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B43B22B501E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58D593021C05
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF61221F39;
	Wed, 18 Mar 2026 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIH7LB+H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C824919CC28;
	Wed, 18 Mar 2026 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773797877; cv=none; b=WiaqeZSDq7pch7EeTLP2Gx+3Jggd2MvejtxufDI7bpWEcwXPVnktMI27sie4glOIY2l7gD3w5s5mv2Qb4y/5Zqjcwmf5OavkDZFUx5KAjZfv1Xuk8LttfwGEBQ7EhWw4sLmAGd4MIzlqmunMidnDaf1RV+qcmIdq5efy/U1cT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773797877; c=relaxed/simple;
	bh=8OACo2zU2/Bwj39w1bVR7n+Z35I8eMA8qJPBBV2F4rE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3ICy4hKZN0kSyU4OLfKc+6WtvFQblfxT2tkYRbO2MrX7UhHeFjwqWKpFqhVxk2MsaaV08UFNwy89rcXn3YCx8hFZWGtc7zJh2pKMLH0zWksrHLYOabafAyeN4bgQ4FwQgSotb8prXP4Kqrsmre5x88GZNX/GmiqLUzJZ4nSDEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIH7LB+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17280C4CEF7;
	Wed, 18 Mar 2026 01:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773797877;
	bh=8OACo2zU2/Bwj39w1bVR7n+Z35I8eMA8qJPBBV2F4rE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fIH7LB+HGwfHzRBOUSh0yQNEb+BJAtXcRA+jJU6u0FMryEYe4LJ4c9oH3kE7vaAKe
	 1cgmHkrkIYe0jcomna4SowGENOLQmnhCkc2nPvC/qv6NBsaETvu677vSmIu3EBl+8O
	 yHK6IATc6qJH0sJWIvXMFhZ+J4gK0IFANjwavlhEmXREDlDi9R7zULMpcGo9MdRBQ7
	 9JBz80ZLBH37mhE3KlT8HiwX6JfQwdwFrsRfLa7AjFfUNNyDpxG+AWqTPgsFYUNZ8s
	 4T0n2fdrKqBzGkbRTC4MpxfeV7CD8+jMpYuUx1Ss1y+w1n/oIo/AAcBspJxOeD1IsM
	 zMaKGlbifdaLA==
Date: Tue, 17 Mar 2026 18:37:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] bonding: move utsrelease.h include out of
 bonding_priv.h
Message-ID: <20260317183756.33d67d60@kernel.org>
In-Reply-To: <20260316-bond_uts-v1-1-428696ea79d5@debian.org>
References: <20260316-bond_uts-v1-1-428696ea79d5@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268848-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B43B22B501E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 05:17:45 -0700 Breno Leitao wrote:
> +++ b/drivers/net/bonding/bond_procfs.c
> @@ -6,8 +6,11 @@
>  #include <net/netns/generic.h>
>  #include <net/bonding.h>
>  
> +#include <generated/utsrelease.h>
>  #include "bonding_priv.h"

Somewhat unfortunate placement, shouldnt it be the first include above
the linux/ ones? If we were going best-effort-alphabetically?

> +#define bond_version DRV_DESCRIPTION ": v" UTS_RELEASE "\n"
> +
>  static void *bond_info_seq_start(struct seq_file *seq, loff_t *pos)
>  	__acquires(RCU)
>  {
> diff --git a/drivers/net/bonding/bonding_priv.h b/drivers/net/bonding/bonding_priv.h
> index fef6288c6944f..f9b327b6a494a 100644
> --- a/drivers/net/bonding/bonding_priv.h
> +++ b/drivers/net/bonding/bonding_priv.h
> @@ -12,11 +12,7 @@
>  
>  #ifndef _BONDING_PRIV_H
>  #define _BONDING_PRIV_H
> -#include <generated/utsrelease.h>
> -
>  #define DRV_NAME	"bonding"
>  #define DRV_DESCRIPTION	"Ethernet Channel Bonding Driver"

I think this entire header can go, TBH?
DESCRIPTION is used only in main
And DRV_NAME can be replaced by KBUILD_MODNAME where it's used.

> -#define bond_version DRV_DESCRIPTION ": v" UTS_RELEASE "\n"
> -
>  #endif

