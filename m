Return-Path: <netdev+bounces-277492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJUIAtIs2Wl+nAgAu9opvQ
	(envelope-from <netdev+bounces-277492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:01:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1A23DAD5B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87E59300CBCF
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411E43E1CEB;
	Fri, 10 Apr 2026 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eFvEc984"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96E43DB644
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840419; cv=none; b=CxiRfgrHEQINC8KEztAk85fx6qhM1JCJzL3WxjlyDMst9BhfQU/6kgjXIdcqmBivB9yd6PsOZ+uY7gIllGvqeJLJaylghc07azred6hDJgiMysA5MUrSuioDu20y41RGpHTrggT1sSEi13anFZ0TTdhM0/S70t2Ze26YreuSmJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840419; c=relaxed/simple;
	bh=9/+48qVyBND72fFw8N0MzBsrHa3XLgS8ToF54lejyLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZnzysV7hYV1RnTfc20908RDzFI+qHNkbIXnK050PAVDvANisf08SrBwierZW4AXtU8rvqKTKPn5kxDA0P3huxJucdGu/f8VybUDcJQbV5+8KS1w7QxYgJmoO1SNmcyQKBshZO1M3J6AmDk3E+dzaW1hpFHqMDsqK4kXr2YaWUhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eFvEc984; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2ad9f316d68so11081285ad.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 10:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775840417; x=1776445217;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4muxIAPUw94/gS1wtcjYpBOll/D/VUQFDQMiW/Xhw+g=;
        b=NmwBiN81XawrY8iIAmW5QikNt8iBStE0ebRFrle8mTeFci0bJYyF1fH17JnTUUVADl
         XlS4lZ7oLzzz7gVG+Bn+VBmhlJhUbzEQIWtzuFUz0HaWhuRXwU3yZJrpOlPD2d59IW05
         v0ryPrcxCom7epqeTb+qHYoi0rWnnI1Zd+D0McHIwAJgiaTN9S/cwiaQG+ukGe7yvsK+
         KMqD2YveKTqC6K0Gi3KqGB/xyafj38cYrXFWOvFHojeSI718pC8R2T/gqoxJBz/+lcIG
         2eaJcYoBzfgvoVOOSYE+qFtGl0onM0tqaB6/qQIRDaTBe7ZawOQtXIVy4jh3nJEp7E8+
         /+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXIOTY9qDDWWeIGh4kGk3qY9nJiIfzCr53qOGgyxG7FSZtViLTzYvCQNDTXBbLfTS1c9WNcMrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC1XrhVghBm0gATpaNmjSUA7AHc9zgEkRdyKuo0BWyA/QOQwn4
	sXv/RKMdVR2TV+NShrU1mgpXwDz4fUDX+aZOA8pUxBlytIIJNES3br9T0OcCqtg68gohLuPUhwg
	t38Ga4XR/GhEdg1uT0UlwTwvW/B4qJacSL8GLK1SyHuQN8op498IWN3Fq0JgCp0jSNb/Z0vp/hK
	1EAXrE1MazJnhEg9Y+XoiPL/pJP5Ji3PampCDyWqfD70Qzi6o2NpqA/rCmd7mM922yKoIzHuscH
	oQUWkxXNRjxoaZu
X-Gm-Gg: AeBDievmzp6ItliDstpbZQ9S+vTt99Q4ns/U5G2uyWRxD+pp4UVWgnsfW9FRymN3cZa
	YQCJy9uRuTpHByN3hv4rsM7XMrjiwvKqBIeFkm40J1CuKkAcRPiVpriD/WFJRjQ26OFxFqy+bVJ
	RkwFr3szJawzIYNl3gsfkSSUg2obyag7y8PEx8c5+4DaCUfi/jhJsujQ4R+HdKcD/JiQjEW6P/J
	svqMUC9yVWZXor51dFf34y+ZTGnNOiIrlX7U0oCJmreUVKGubxwwNJ+Q5ag2KRwOWPPyhP/aWqU
	SbgvbygaQ6A2DmKFM8Y7b97aBW3QMdA4x+/YY+Qi8H/6kwiVlhn530ExB4FwT9Vw95Q474EeTCX
	rp0zjfAFHoj1r6+pqLlFbXNSkWg8ElyOZ8elo80f5yRm49gu0HX9wlhEhn4YJcRVD1r+HHybQ6j
	7GiBPo1LWdwLwep8h3sdE91GmISklYDeszVIXBibRLx9eca1TuiZlbTNi3aZSDjQ==
X-Received: by 2002:a17:902:da88:b0:2b0:c0a8:5000 with SMTP id d9443c01a7336-2b2d5960aacmr44299205ad.14.1775840415704;
        Fri, 10 Apr 2026 10:00:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b2d4f1e4dasm2302665ad.33.2026.04.10.10.00.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2026 10:00:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so3187733eec.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775840414; x=1776445214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4muxIAPUw94/gS1wtcjYpBOll/D/VUQFDQMiW/Xhw+g=;
        b=eFvEc984VNTWdyS3qNGt0es50/IA5eAQt7h4Bur427ePenhy0ngTG3vRzuj0RpBDWP
         +VutPASE2stYkGzQDMdvT6pDUEYu0SrSy2FWv8GSO5avDS0NLPNuKusoy3QcXIUXxliO
         AQyPiGABR8v3HSdD4rp8piisk+mMQXwDTij8o=
X-Forwarded-Encrypted: i=1; AJvYcCWL7fFYVL1BvJt4mrtIojgMtkZs4gKziS2BfN1hIAODWPP09ul0WXaADeNV69dXh8nerH1ov94=@vger.kernel.org
X-Received: by 2002:a05:7300:7313:b0:2ba:6819:2e9b with SMTP id 5a478bee46e88-2d586699573mr2355090eec.3.1775840413414;
        Fri, 10 Apr 2026 10:00:13 -0700 (PDT)
X-Received: by 2002:a05:7300:7313:b0:2ba:6819:2e9b with SMTP id 5a478bee46e88-2d586699573mr2355057eec.3.1775840412769;
        Fri, 10 Apr 2026 10:00:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69casm5961297eec.2.2026.04.10.10.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 10:00:10 -0700 (PDT)
Message-ID: <8ee8ce9f-cf85-44d4-8a8c-ea78bea6ec69@broadcom.com>
Date: Fri, 10 Apr 2026 10:00:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: call phy_init_hw() in phy resume path
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Biju <biju.das.au@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
References: <20260410142904.439666-1-biju.das.jz@bp.renesas.com>
 <adkOZl4gt5UoGv-0@shell.armlinux.org.uk>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <adkOZl4gt5UoGv-0@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277492-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[armlinux.org.uk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,renesas.com,vger.kernel.org,glider.be,bp.renesas.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid,renesas.com:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7B1A23DAD5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/10/26 07:51, Russell King (Oracle) wrote:
> On Fri, Apr 10, 2026 at 03:29:01PM +0100, Biju wrote:
>> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
>>
>> When mac_managed_pm flag is set, mdio_bus_phy_resume() is skipped, so
>> phy_init_hw(), which performs soft_reset and config_init, is not called
>> during resume.
>>
>> This is inconsistent with the non-mac_managed_pm path, where
>> mdio_bus_phy_resume() calls phy_init_hw() before phy_resume() on every
>> resume.
>>
>> To align both paths, add a phy_init_hw() call at the top of
>> __phy_resume(), before invoking the driver's resume callback. This
>> guarantees the PHY undergoes soft reset and re-initialization regardless
>> of whether PM is managed by the MAC or the MDIO bus.
>>
>> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>> ---
>>   drivers/net/phy/phy_device.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 0edff47478c2..8255f4208d66 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -2008,6 +2008,10 @@ int __phy_resume(struct phy_device *phydev)
>>   	if (!phydrv || !phydrv->resume)
>>   		return 0;
>>   
>> +	ret = phy_init_hw(phydev);
>> +	if (ret)
>> +		return ret;
> 
> Do we want to do this even when phydrv->resume is NULL?

Seems to me we would want that, but this gets into the territory of 
potentially creating many soft-reset of the PHYs, something that I 
regret having introduced years ago.

> 
> Apart from that, looks fine to me - it seems some paths call
> phy_init_hw() can be called with or without phydev->lock held, and
> this one will call it with the lock held which seems to be okay.
> 

Agreed.
-- 
Florian


