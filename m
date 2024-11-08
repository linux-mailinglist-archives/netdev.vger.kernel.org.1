Return-Path: <netdev+bounces-143265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 740719C1C07
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CA1AB20F7D
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1255C1E32B3;
	Fri,  8 Nov 2024 11:17:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBC01E0E0F;
	Fri,  8 Nov 2024 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731064653; cv=none; b=SWkeg52yz6EmAtjQwv8FsLeMZ9JkHMRBc86GF5Hfs6QBqW/CwnP0rhI87/Mj/KDP0HQbXtQEK1JGOwIXihD5wmQ+Guumyjy6DJwXcW6cWSHrIZJQL6eC8Ovz+zuxyu1ayN+hJ/+m0eC5KaCP/SPMevcFNe8Owz/kefi27/M6Ykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731064653; c=relaxed/simple;
	bh=IE3H64dNQq6c0bCyu50h6oFeZV+uAfBveuuEvTA6ZoI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UKIy2umeNkguhxzY+HH+/C/4+uuI2mydRdODZEmHqkumZ8M96UzKYE/VUT/J/0pZ0UCyvyXDPFYGeL1Sw8zuFJCziCetG45FvzU0Qt9Uea2v/U8UvhQOktzh7fLteSQog3s9mZ7LPdJLgaNg1nOC12amcvUAUllvmzIdX431c54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XlGcn3jX0z9sSL;
	Fri,  8 Nov 2024 12:17:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jedhCAK4NTvb; Fri,  8 Nov 2024 12:17:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XlGcn2v6Rz9rvV;
	Fri,  8 Nov 2024 12:17:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F1248B780;
	Fri,  8 Nov 2024 12:17:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id s51MEc62SJBS; Fri,  8 Nov 2024 12:17:29 +0100 (CET)
Received: from [192.168.232.253] (PO25383.IDSI0.si.c-s.fr [192.168.232.253])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DF8D88B77A;
	Fri,  8 Nov 2024 12:17:28 +0100 (CET)
Message-ID: <98b8084f-8f66-4e87-b182-dda6bf0c3d57@csgroup.eu>
Date: Fri, 8 Nov 2024 12:17:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/net/ethernet/freescale/ucc_geth.c:2454:64: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Linus Walleij <linus.walleij@linaro.org>,
 kernel test robot <lkp@intel.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 netdev <netdev@vger.kernel.org>
Cc: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>
References: <202410301531.7Vr9UkCn-lkp@intel.com>
 <CACRpkdbW5kheaWPzKip9ucEwK2uv+Cmf5SwT1necfa3Ynct6Ag@mail.gmail.com>
 <2010cc7a-7f49-4c5b-b684-8e08ff8d17ed@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <2010cc7a-7f49-4c5b-b684-8e08ff8d17ed@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/11/2024 à 11:30, Christophe Leroy a écrit :
> 
> 
> Le 08/11/2024 à 09:18, Linus Walleij a écrit :
>> On Wed, Oct 30, 2024 at 8:05 AM kernel test robot <lkp@intel.com> wrote:
>>
>>> tree:   
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C5a1ff6cef1f642fba00a08dcffce0903%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638666507603442752%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=2dgpku3%2BPjovwZxpedYowAAB%2BR%2FeyxOc0Ys3kE0KK6E%3D&reserved=0 master
>>> head:   c1e939a21eb111a6d6067b38e8e04b8809b64c4e
>>> commit: b28d1ccf921a4333be14017d82066386d419e638 powerpc/io: Expect 
>>> immutable pointer in virt_to_phys() prototype
>>
>> Ugh Stanislav do you have ideas around this one?
>>
>>>     drivers/net/ethernet/freescale/ucc_geth.c:244:21: sparse:     got 
>>> restricted __be32 [noderef] __iomem *
>>>     drivers/net/ethernet/freescale/ucc_geth.c:405:22: sparse: sparse: 
>>> incorrect type in argument 1 (different base types) @@     expected 
>>> unsigned short volatile [noderef] [usertype] __iomem *addr @@     got 
>>> restricted __be16 [noderef] [usertype] __iomem * @@
>>
>> They all look the same, it's from this:
>>
>> static void set_mac_addr(__be16 __iomem *reg, u8 *mac)
>> {
>>      out_be16(&reg[0], ((u16)mac[5] << 8) | mac[4]);
>>      out_be16(&reg[1], ((u16)mac[3] << 8) | mac[2]);
>>      out_be16(&reg[2], ((u16)mac[1] << 8) | mac[0]);
>> }
>>
>> Is it simply that we need a paranthesis extra around the thing casted
>> to (u16) else it becomes u32?
> 
> Not at all. The one you point here are:
> 

...

Note however that there is work in progress on this driver that will 
impact hundreds of lines, so maybe wait until that is done ? See 
https://patchwork.kernel.org/project/netdevbpf/cover/20241107170255.1058124-1-maxime.chevallier@bootlin.com/

Christophe

