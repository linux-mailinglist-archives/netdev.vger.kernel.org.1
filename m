Return-Path: <netdev+bounces-252787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IFlDAhTc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:52:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEC174997
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BF003016834
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6E72DF6E6;
	Fri, 23 Jan 2026 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2f2wPSB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F255333438;
	Fri, 23 Jan 2026 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769165571; cv=none; b=OUnH41HHeGu/1Q3G9qeYHEOjH3NGAfb9PLvmk9HzdyFQ86gU4TkTKLGkcRL8fG1zf9OhQ1fmrle1FpGb1B0PaiYFFcJJ/j4zer8Vqh13gSPgxEImUJlMQbELRZjr5w+yWlYghJx9yp74waC2AZv1AuU8/btSK0ntICWnXU0PnpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769165571; c=relaxed/simple;
	bh=ojbfcl6dIvtY+adr7dmxP1SqcnShBLlbESAfM2YXYq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHz/H//A/VSGAp61VXhd+L8S2bSnYUg/GsOQOP+jsT3rw0yUAU8fg0y57jQtc85OKSM34FzNRhkU7XrYSh9++eWo4rmvcs40VSanHLUN8f3qPWKa6NTUDxgnBGXqOLgZ6s3WIbmTqMoQAYSImQebsoF7bUh0FAPWzwH2jCJXPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2f2wPSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADCEC4CEF1;
	Fri, 23 Jan 2026 10:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769165571;
	bh=ojbfcl6dIvtY+adr7dmxP1SqcnShBLlbESAfM2YXYq0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s2f2wPSB1By77YZx78G4NYjIc1Edaa8r0GoGZCJpeFJEJOlz2sZP7AuN4jkl7Xic3
	 qzgHcL9a8Kk7TnPbjdNRkGWjb17KQLah8KGDRttLmr4QOcMphSqa3wW9mkZSakxsLC
	 1zBUFXPrgGhlFq5RACJOOn3IMf+ZnxPL36kJ2Y/EtX474wyXYeUhXBa5tXuzFa9OlR
	 ZJc7ZZ56dFOidTDw5mWU+ja41m4km8GQGRxsveK00M3ay8XTyFr2A7RHYHmCU7KpSs
	 Evn9ImxYCjfFCff2GCXxSQ6UX5uVwGuvlIvU1u9P+OmRg04bdfSrkZZxgFtm3F30dG
	 uCjff4WMVBJeQ==
Message-ID: <2b41debd-9a05-4707-b270-a8fa3dd7768c@kernel.org>
Date: Fri, 23 Jan 2026 11:52:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [next-20260122] Build failure on IBM Power Server
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, broonie@kernel.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org
References: <43ea0202-891d-4582-980b-5cb557b41114@linux.ibm.com>
 <f07d721f-ac80-4421-86a3-1f7f76ea8e6c@infradead.org>
 <136ae3bf-b1a3-4ee8-a7ea-dfc90e7b4baf@linux.ibm.com>
 <fa330d98-653c-4643-aee9-9697068e734a@kernel.org>
 <20260123103922.sr7m7py7d4afvc2f@skbuf>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260123103922.sr7m7py7d4afvc2f@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252787-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AEC174997
X-Rspamd-Action: no action



Le 23/01/2026 à 11:39, Vladimir Oltean a écrit :
> On Fri, Jan 23, 2026 at 10:52:49AM +0100, Christophe Leroy (CS GROUP) wrote:
>> +Vladimir, Maxime, Jakub and netdev
>>
>> Le 23/01/2026 à 10:11, Venkat Rao Bagalkote a écrit :
>>>
>>> On 23/01/26 1:17 pm, Randy Dunlap wrote:
>>>>
>>>> On 1/22/26 8:15 PM, Venkat Rao Bagalkote wrote:
>>>>> Greetings!!
>>>>>
>>>>> IBM CI has reported build failure of 20260122 on IBM Power server.
>>>>>
>>>>>
>>>>> Error:
>>>>>
>>>>>
>>>>> ERROR: modpost: "phy_get_rx_polarity" [drivers/net/phy/
>>>>> air_en8811h.ko] undefined!
>>>>> ERROR: modpost: "phy_get_tx_polarity" [drivers/net/phy/
>>>>> air_en8811h.ko] undefined!
>>>>> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
>>>>> make[1]: *** [/home/upstreamci/linux/Makefile:2040: modpost] Error 2
>>>>> make: *** [Makefile:248: __sub-make] Error 2
>>
>> Thanks for the config file.
>>
>> The probleme is because allthough CONFIG_PHY_COMMON_PROPS is selected,
>> drivers/phy/phy-common-props.o is not built because CONFIG_GENERIC_PHY
>> is not selected.
>>
>> Likely comes from commit 66d8a334b57e ("net: phy: air_en8811h: deprecate
>> "airoha,pnswap-rx" and "airoha,pnswap-tx"")
>>
>> Christophe
> 
> The intention was for drivers/phy/phy-common-props.o to be
> buildable/usable without CONFIG_GENERIC_PHY.
> 
> Does this help?

Yes it fixes the build for me.

Christophe

> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index ccc05f1eae3e..53fbd2e0acdd 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -10,7 +10,7 @@ obj-y				+= cache/
>   obj-y				+= irqchip/
>   obj-y				+= bus/
>   
> -obj-$(CONFIG_GENERIC_PHY)	+= phy/
> +obj-y				+= phy/
>   
>   # GPIO must come after pinctrl as gpios may need to mux pins etc
>   obj-$(CONFIG_PINCTRL)		+= pinctrl/
> 
>>
>>
>>>>>
>>>>>
>>>>> IBM CI has bisected this issue and below is the bisection log.
>>>>>
>>>>>
>>>>> git bisect log
>>>>> git bisect log
>>>>> git bisect start
>>>>> # status: waiting for both good and bad commits
>>>>> # good: [24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7] Linux 6.19-rc6
>>>>> git bisect good 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
>>>>> # status: waiting for bad commit, 1 good commit known
>>>>> # bad: [a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d] Add linux-next
>>>>> specific files for 20260122
>>>>> git bisect bad a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d
>>>>> # good: [2574bcf1765ec13bf3ef469aa5b15cce293aebb6] Merge branch
>>>>> 'master' of  Warning: Removed corrupted safelink.
>>>>> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fbluetooth%2Fbluetooth-next.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C441b227c282845cf2a3308de5a5f8110%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639047563441808471%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=FlVDfg3VVHplFxnQpG4oQNlr5Mm3ZzaCve19hnomYNo%3D&reserved=0
>>>>> git bisect good 2574bcf1765ec13bf3ef469aa5b15cce293aebb6
>>>>> # good: [2ad38467d20c16f38d0cffad711ef4f4acdb8b29] Merge branch 'for-
>>>>> next' of  Warning: Removed corrupted safelink.
>>>>> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Faxboe%2Flinux.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C441b227c282845cf2a3308de5a5f8110%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639047563441834557%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=ez4lgXXDn95PjgZNSAjwp%2BWbvJvQYLeHApGrODqs%2Fmc%3D&reserved=0
>>>>> git bisect good 2ad38467d20c16f38d0cffad711ef4f4acdb8b29
>>>>> # good: [a954370fea56ee1bf995524255a34da7a1ddb524] Merge branch 'for-
>>>>> next' of  Warning: Removed corrupted safelink.
>>>>> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fpdx86%2Fplatform-drivers-x86.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C441b227c282845cf2a3308de5a5f8110%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639047563441853661%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=c4Fim5nuBV9O%2BfFTUltpoLTV19%2Fdy394PvzzGBxh8I4%3D&reserved=0
>>>>> git bisect good a954370fea56ee1bf995524255a34da7a1ddb524
>>>>> # good: [c7ec480f05dd0185a26f190471905ddf1215bc52] Merge branch
>>>>> 'staging-next' of  Warning: Removed corrupted safelink.
>>>>> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fgregkh%2Fstaging.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C441b227c282845cf2a3308de5a5f8110%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639047563441870081%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=xgtRCeDKj7BL1EXx%2BSEtCzR5gaN6wKfihyiwh0AFsRM%3D&reserved=0
>>>>> git bisect good c7ec480f05dd0185a26f190471905ddf1215bc52
>>>>> # good: [4427398fed2b8e07a62fd4f3f6fcf9ffcf56829a] Merge branch 'for-
>>>>> next' of  Warning: Removed corrupted safelink.
>>>>> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Flinusw%2Flinux-pinctrl.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C441b227c282845cf2a3308de5a5f8110%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639047563441887814%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=AzoGH2fuDhFyYqK9JxlVZEsx3V7P5x8Yc8%2BuVE%2BBHJ4%3D&reserved=0
>>>>> git bisect good 4427398fed2b8e07a62fd4f3f6fcf9ffcf56829a
>>>>> # good: [852ccea1ca3144beb7003976d4fa04dbf81b307b] Merge branch
>>>>> 'next' of  Warning: Removed corrupted safelink.
>>>>> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fmic%2Flinux.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C441b227c282845cf2a3308de5a5f8110%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639047563441903764%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2BTtdFgkDy9QevJOIHlzjk7Jjd1390L6g0Nr5RpSTYp8%3D&reserved=0
>>>>> git bisect good 852ccea1ca3144beb7003976d4fa04dbf81b307b
>>>>> # good: [f174dabd307dfd92edacb34e8bee0384daa1bd2e] Merge branch
>>>>> 'next' of  Warning: Removed corrupted safelink.
>>>>> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Flenb%2Flinux.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C441b227c282845cf2a3308de5a5f8110%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639047563441919983%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2BaVHILI%2FJcj%2BedPEPrJ1zFeSRGwuXUKb0VHFpZ%2Bp95s%3D&reserved=0
>>>>> git bisect good f174dabd307dfd92edacb34e8bee0384daa1bd2e
>>>>> # good: [e31f3c967c66cf03eecdf50fe138d05f635e3698] doc: Add
>>>>> housekeeping documentation
>>>>> git bisect good e31f3c967c66cf03eecdf50fe138d05f635e3698
>>>>> # good: [0cc83fc23debf3e2df19c4510a77fe2d60ab2693] gpu: nova-core:
>>>>> don't print raw PMU table entries
>>>>> git bisect good 0cc83fc23debf3e2df19c4510a77fe2d60ab2693
>>>>> # good: [75df6953fed6b7274f9c5080925ae4c8d3e424e6] Merge branch 'for-
>>>>> next' of  Warning: Removed corrupted safelink.
>>>>> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ffrederic%2Flinux-dynticks.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C441b227c282845cf2a3308de5a5f8110%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639047563441936107%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=beNKxNQCA6SYkfbETF9eJYQ7mBFWwCKUFce6cwNbHUA%3D&reserved=0
>>>>> git bisect good 75df6953fed6b7274f9c5080925ae4c8d3e424e6
>>>>> # good: [086714bbb96f63785da251e1f8d1ce3e716a6e42] Merge tag 'v6.19-
>>>>> rc5' into drm-rust-next
>>>>> git bisect good 086714bbb96f63785da251e1f8d1ce3e716a6e42
>>>>> # good: [6ea52b6d8f33ae627f4dcf43b12b6e713a8b9331] drm/tyr: use
>>>>> read_poll_timeout
>>>>> git bisect good 6ea52b6d8f33ae627f4dcf43b12b6e713a8b9331
>>>>> # good: [b956937ce78fae5fa785f6a95f291e2137502c5e] drm: tyr: Mark BROKEN
>>>>> git bisect good b956937ce78fae5fa785f6a95f291e2137502c5e
>>>>> # first bad commit: [a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d] Add
>>>>> linux-next specific files for 20260122
>>>>>
>>>>>
>>>>> If you happen to fix, this please add below tag.
>>>>>
>>>>>
>>>>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>>> I don't think that bisection helps very much.
>>>>
>>>> Can you post the kernel config file?
>>>>
>>>
>>> Attached is the .config file.
>>>
>>>
>>> GCC: gcc version 11.5.0 20240719 (Red Hat 11.5.0-2) (GCC)
>>>
>>> ld: GNU ld version 2.35.2-54.el9
>>>
>>>
>>> Regards,
>>>
>>> Venkat.
>>


