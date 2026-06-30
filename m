Return-Path: <netdev+bounces-302974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uz8rD79XQ2pfXAoAu9opvQ
	(envelope-from <netdev+bounces-302974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:44:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B57D96E0857
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:44:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NiWf9XzN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302974-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302974-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DFBC30347C0
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AB73E2AC8;
	Tue, 30 Jun 2026 05:43:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09763E1D12;
	Tue, 30 Jun 2026 05:43:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782798204; cv=none; b=PE2dbXitwHxh9sabyq/1x70/92Ltw2l60cT47mMEB6mhqtpB23wpjpOp7AeFhLx8FfabkFhjrH97iXqd29X1chcXC+pqWT+unXb8V+Rk+PQt59ovcBy9W/N4+laBJmT924Y/hhixddpIStlaTlYREoZr2XgtWFrX38mUV/VMy9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782798204; c=relaxed/simple;
	bh=CS1qgN/YcunIIhSx5TxfVdcSHVYJoo750gPC1vSIdBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSW8EVd/6koYr59ZnOw+poxQA2QKBj6O3JSO7yoTvZIs+bMB55Uqxo821wDG/cW+79wFKwXb3QMuHtUeOw7vNjqg7fBnkvsXyhsDzpm9Ls2zhJgM8vuD6n446/ilIM/zhZhm3bCMckx+l9GYPgi4wTav28PF1nczWjEb/2ITNMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiWf9XzN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3948E1F000E9;
	Tue, 30 Jun 2026 05:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782798202;
	bh=8aJUwxqPn5J8U7iknbujNbSqUM1cPZPdUY5Rjn7wydc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NiWf9XzNLL2hvkyu2jw4gPzmT3+0Jq5WxqlP284Z0n3DJvcRU4upVjOe97DsrYDda
	 5ipE3oEbwgkEdwj9xLthoGIp/5JcUytSm11Aa0VnNqDrDsUgLVbC8nfenW+dP+v309
	 9UFgeeGZwpRqRbFRuHbtTE00hH1eQ+flBAkiBlnZHnxgShVkgshCuaG6tVeLIc/IWe
	 BSAFJXDgjsg6eWaeUtwtUF7wt/7Ai+cJtWZcklqiIN3tXezwi2v6TrOfWiIjllfIi0
	 OAoHwQbKnjLrH+qm8C10jZRlssLFdlvxClGNZmITn3OYMkpnk8V03n9cWYY0F2PjxZ
	 rP6m7nabWdcQQ==
Message-ID: <62302ee1-dafd-485e-88a0-feb695d209ad@kernel.org>
Date: Tue, 30 Jun 2026 07:43:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] powerpc: remove ehea driver references
To: David Christensen <drc@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260629211343.3712775-1-drc@linux.ibm.com>
 <20260629211343.3712775-3-drc@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260629211343.3712775-3-drc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302974-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:drc@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:netdev@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com,ellerman.id.au,gmail.com];
	FORGED_SENDER(0.00)[chleroy@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,aka.ms:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B57D96E0857



Le 29/06/2026 à 23:13, David Christensen a écrit :
> [Vous ne recevez pas souvent de courriers de drc@linux.ibm.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Follow-on cleanup after the removal of the IBM eHEA driver in commit
> f721e8ffa92a ("ehea: remove the ehea driver").
> 
> Remove the CONFIG_IBM_EHEA entry from ppc64_defconfig and the
> EXPORT_SYMBOL_GPL(walk_system_ram_range) export from arch/powerpc/mm/mem.c
> that was only needed by the ehea driver.
> 
> Signed-off-by: David Christensen <drc@linux.ibm.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/configs/ppc64_defconfig | 1 -
>   arch/powerpc/mm/mem.c                | 6 ------
>   2 files changed, 7 deletions(-)
> 
> diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
> index f795b74602ec..1eb8e3457e8b 100644
> --- a/arch/powerpc/configs/ppc64_defconfig
> +++ b/arch/powerpc/configs/ppc64_defconfig
> @@ -210,7 +210,6 @@ CONFIG_BNX2X=m
>   CONFIG_CHELSIO_T1=m
>   CONFIG_BE2NET=m
>   CONFIG_IBMVETH=m
> -CONFIG_EHEA=m
>   CONFIG_IBMVNIC=m
>   CONFIG_E100=y
>   CONFIG_E1000=y
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 4c1afab91996..b617b69452cd 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -371,12 +371,6 @@ int devmem_is_allowed(unsigned long pfn)
>   }
>   #endif /* CONFIG_STRICT_DEVMEM */
> 
> -/*
> - * This is defined in kernel/resource.c but only powerpc needs to export it, for
> - * the EHEA driver. Drop this when drivers/net/ethernet/ibm/ehea is removed.
> - */
> -EXPORT_SYMBOL_GPL(walk_system_ram_range);
> -
>   #ifdef CONFIG_EXECMEM
>   static struct execmem_info execmem_info __ro_after_init;
> 
> --
> 2.47.3
> 


