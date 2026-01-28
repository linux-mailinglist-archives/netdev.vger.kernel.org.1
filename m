Return-Path: <netdev+bounces-254324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCS9J8Qyeml+4gEAu9opvQ
	(envelope-from <netdev+bounces-254324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:01:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1E5A4EE2
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E01233171D43
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA662EA172;
	Wed, 28 Jan 2026 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/feX2du"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4663081BD;
	Wed, 28 Jan 2026 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615017; cv=none; b=KqHpqOLw5K8aIOjAXy7nLorFUrVTCA2FsaQuSQHacweMAoZo3ZChkI5KG0F8ey7sHsc4L9iadPAuk4AdaM39Zq9KN4kjMNE7QbZdlbvGfOrT2ohPhO4Uch66rciwXUlImtlesRWQu2fZyqGe9DImTitmiyMqKLGYt5AhWnuMRW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615017; c=relaxed/simple;
	bh=Ms6JSPLx+R0AGkkQXNUtlIKDAJmwsS9TPgZf+SoweB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/Z2swyLU5be7xdQffQh/gWijLVJF1I6j3wi9dVpuvfHk4Ug0zilA02H5luy3vzB8gc0I8T+ub+8b2SqGo+tNJzjHcndQDOeOmW4I/vWAwhuHgTR1oLx4Tlyfx4uCWoGc8k8C9pRsL5Ie0IodXu/SUBKmSfB/8080MNv2C9YNgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/feX2du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E418AC116C6;
	Wed, 28 Jan 2026 15:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769615017;
	bh=Ms6JSPLx+R0AGkkQXNUtlIKDAJmwsS9TPgZf+SoweB0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k/feX2duw105DXZwD6VCd+YxveRBQQvZwG1gOS/X0ZdFYkzFA6flqG/HNZxbCSfEo
	 9S8zDChgoORh5Zyax+Grj+WTS3kYtPu9i+rikFALF271mQxYnQpc9H9/qdlMYKUfZF
	 AsBZ1QCegWxjyUlNMxdHoA0QkK/ou4etDhoUDKOHIHSLKb0z/7NK3UEWtL6R1o08hs
	 7MG3+rRl/P54CNe8LJHDsqbTyk4VKLMXkVVlsfhwjS2FCEAH8bGgkEjI1Z5sPALKEG
	 yP0jnOXkMTCnXyidLUhJ0LwyZCZCQybgN1qZ1dURyhzo/rGFzVuw/VvYe3wKcGr374
	 q2owya+xV+W4A==
Message-ID: <1fca424a-6215-4303-a0cd-623063945ce6@kernel.org>
Date: Wed, 28 Jan 2026 16:43:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: dts: fsl: Drop unused .dtsi files
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260128140222.1627203-1-robh@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260128140222.1627203-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254324-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.ibm.com,ellerman.id.au,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,netdev@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[robh.kernel.org:query timed out,chleroy.kernel.org:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0E1E5A4EE2
X-Rspamd-Action: no action



Le 28/01/2026 à 15:02, Rob Herring (Arm) a écrit :
> These files are not included by anything and therefore don't get built or
> tested.
> 
> There's also no upstream driver for the interlaken-lac stuff.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   .../boot/dts/fsl/interlaken-lac-portals.dtsi  | 156 ------------------
>   arch/powerpc/boot/dts/fsl/interlaken-lac.dtsi |  45 -----

Those two files were added by commit 8c43d2b0ca10 ("powerpc: Add T4 LAC 
device tree binding & defs") together with 
Documentation/devicetree/bindings/powerpc/fsl/interlaken-lac.txt

Should the Documentation file be removed as well ?

Regardless,

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>



>   .../boot/dts/fsl/pq3-mpic-message-B.dtsi      |  43 -----
>   .../fsl/qoriq-fman3-0-10g-1-best-effort.dtsi  |  80 ---------
>   4 files changed, 324 deletions(-)
>   delete mode 100644 arch/powerpc/boot/dts/fsl/interlaken-lac-portals.dtsi
>   delete mode 100644 arch/powerpc/boot/dts/fsl/interlaken-lac.dtsi
>   delete mode 100644 arch/powerpc/boot/dts/fsl/pq3-mpic-message-B.dtsi
>   delete mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi
> 

