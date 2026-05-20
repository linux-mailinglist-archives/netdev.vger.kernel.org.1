Return-Path: <netdev+bounces-289934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCaaKL2pDWox1QUAu9opvQ
	(envelope-from <netdev+bounces-289934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:31:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A2658DB4B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B286E30160F0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E9623EAB0;
	Wed, 20 May 2026 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc4Tbi1m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04FA3DD84A;
	Wed, 20 May 2026 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280084; cv=none; b=IH4r0P53Be8FGpKA1Culg3+i6b63kjRNhNyqPHXJ1vZ+mA0gUYMS7gbdl27wKh6pc4dj91Xogl50FV7hC/HkBntuU57dcfMCKDbTLf8JUJKqCysU34BS7WuP9cr8rbfTRMuXx1pIQ2CCXmGaA/CGvVJUQovsv9GDmernKOmeesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280084; c=relaxed/simple;
	bh=bpGUI4gMFHLVJGU9/dS1wJA2rz7iCVT9GPaW6nsr9cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWTLTrt/AQaZssLfS9QNzAQbK0RxReTwhw7zH8LQeNzu+z5yLw1NjCSCcL56XeLU/dndqhE55GYnA3BbSE1DrOLPm1KMFIinwzjqOSuhPQQmzts7UrSu/19fH46b5P2EGfpTjpIRrPAu6M/T7gMpklPKjZfSHWcZ0tb+cgc4sFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc4Tbi1m; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74851F000E9;
	Wed, 20 May 2026 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779280080;
	bh=YPsDEinQC31MNkFSqLK/AYf2QgBz8ODGpxSGL7Px3IA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Tc4Tbi1mDQTXmycd1ELO6Lje82rVlRYlTAc840+8ZjfSzh5ogFOayADO17WMiJvZh
	 eUNK8P1ItT1GNhsEXP5Mj8bYthxGgeidBMKeFrA/TA3FC//EjtKeQ1zpL1bKFrZdJq
	 GcRahcvzBjBH176FYWWve2Ut0Ybt2qKHE/DXfqM+FKK8Jgur4ifwQtl5WqbcMRbILS
	 IafqUbxhOZzvBEnm9K7SrCw4t/c6QnnVDOZj+Cr92f+H6VG+7JzE2moRiLTvlroN3v
	 DtChkRU1G5QGhIR5nY39NCOmTHKTw2ZxnFHx48fDiSEmdSCKrprcl/eMiedM6X83SJ
	 1LlS4+JwBqwDg==
Message-ID: <8ba30f1d-19ce-449a-966c-236fd6026c07@kernel.org>
Date: Wed, 20 May 2026 14:27:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 2/2] powerpc: remove ehea driver references
To: David Christensen <drc@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260519224353.1282038-1-drc@linux.ibm.com>
 <20260519224353.1282038-3-drc@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260519224353.1282038-3-drc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289934-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com,ellerman.id.au,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,aka.ms:url]
X-Rspamd-Queue-Id: 18A2658DB4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 20/05/2026 à 00:43, David Christensen a écrit :
> [Vous ne recevez pas souvent de courriers de drc@linux.ibm.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Follow-on cleanup after the removal of the IBM eHEA driver in commit
> XXXXXXXXXXXX ("net: ethernet: ibm: remove the ehea driver").
> 
> Remove the CONFIG_IBM_EHEA entry from ppc64_defconfig and the obsolete
> comment in arch/powerpc/mm/mem.c that referenced the driver.

What do you mean by 'obsolete' ?

As far as I can see the commit is still valid, I can't see any other 
module caller of function walk_system_ram_range().

The comment was introduced by commit 26b523356f49 ("powerpc: Drop 
page_is_ram() and walk_system_ram_range()")

> 
> Signed-off-by: David Christensen <drc@linux.ibm.com>
> ---
>   arch/powerpc/configs/ppc64_defconfig | 1 -
>   arch/powerpc/mm/mem.c                | 4 ----
>   2 files changed, 5 deletions(-)
> 
> diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
> index 6316ca4df25d..b022d00708f4 100644
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
> index 648d0c5602ec..1f5ad1a59d68 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -370,10 +370,6 @@ int devmem_is_allowed(unsigned long pfn)
>   }
>   #endif /* CONFIG_STRICT_DEVMEM */
> 
> -/*
> - * This is defined in kernel/resource.c but only powerpc needs to export it, for
> - * the EHEA driver. Drop this when drivers/net/ethernet/ibm/ehea is removed.
> - */
>   EXPORT_SYMBOL_GPL(walk_system_ram_range);

As mentioned in the comment, the EXPORT_SYMBOL_GPL() has to be dropped 
when drivers/net/ethernet/ibm/ehea is removed, which is now.

> 
>   #ifdef CONFIG_EXECMEM
> --
> 2.47.3
> 


