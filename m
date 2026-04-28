Return-Path: <netdev+bounces-282091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLfrAKEt8WleeQEAu9opvQ
	(envelope-from <netdev+bounces-282091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:58:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7553148C6CC
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3429B30413BA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 21:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0941FF7C7;
	Tue, 28 Apr 2026 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="II5N2TYo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20D2550D5
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777413514; cv=none; b=f/p2E+pCad4R2tv9EDZhut7eSSynepl8UAwV/NRqsx/c0TqHBud1LKUVmcZOzLGmlPnp+ktk/lhvDS0s/KJtumDHcTO1V2Dq3g8Z0Au7PBRKq2IN+U/beMgl2cdz8+PO5O+lKlZJlp8z6d1vAqbpeoI0w0pc031GkFE5T0kWzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777413514; c=relaxed/simple;
	bh=VfbO3ulILKZSKYtafxSYwqcmFKGkNhAfq6v4srABHOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToeKQV+Y7W1o2Tipxty37r3mRZdDaADknfidJ092dKqHsCVc//+AYR2kbgZEJFwCP6wkjjKSX4CKNnMmrFzGUp10U11LD+U+cqkXtggo05JetU8gcRmjRXPBxA4uXxTotj7uaCwU6ykeLCN67UE7cK3nbN6zyyvmJsrTLfK9FDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=II5N2TYo; arc=none smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-50fae4d1f85so128159921cf.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777413512; x=1778018312;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xZzMF7chzXg26f4EN6q7nTamGI5Xk5AAzqyFBI37U9s=;
        b=CcCCHOB+W3l3Ipd0mM5zBZJTdgsGH6034wGvAA8hSRSvtewONS5KNeUCxvHJIa5kHe
         OuzNYZknP1KhcnBG6iEPXcDPb7WU6ZFhZxeZFLC6ggdGHN5kS39fQJoH2P3D9Za+Rfz9
         EagcYlJGsNniGH33NhaQf8M3y2wqagjT4wjVoGDb1k3UZ+OH9iER/ESISWn4CUO+30Kb
         zngqW40xvkFyndWCBmZpRPJmFxPO0xPO63U2hx2M0M57rPXpVb0waRGqIXCjz4ARjERV
         7IyDNdcJn+iAZZ4FDQj0dJ4cviC/5LvZa52lDg44mz9E5Kvejy0IKJK5gd2GgYTa4wvB
         72BA==
X-Forwarded-Encrypted: i=1; AFNElJ9vL6q3sDsEYCzJq6fkSL8ytiXcKBLsshoLXsqZlcME/j035hIlb/n6NkAwcIRmFrhFs9cQQhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfiModeHLXLaMZTHKpfIFW0qlfgwVc9pL1uCyQKaGv/EsS7Aer
	I8vEDVoX8wiJN5ioS6kN8Q6N6vHMZ5bHWqYzJRmk/mM92zRE83AEPwXJYe8jc7l8bPZyzD8gLO3
	JqnyRs6fpMzKGIMfkn54mNxZvOtNFdQCovfC32VumyEMOEi5C8iKMaNjFipD0G/nE89fwdWznxl
	aCQyFWTXyvMw7iB6FFtkjDMpO0ybYeTXDyAnFd/WVBf8viK4S4gaC9h85haxK28DLSt/csCKBEU
	eqqUSBKa1P83fKQ
X-Gm-Gg: AeBDiesfkrK78SkRfjWSaSAQThdwN9BEiz6M1oh/R8XGvthznr1bS7b1APKr9/CzkuX
	rJ70GNB+5qLquEkTbxBkSf1eHiHZTg64Zu63PdUVQBhFkPf7a3/Xxy5CHTpyG7Go0xVkzmAW/I6
	RXgLsyOOEf0FAkCx8PG38NH/gXBBjygWjJvdgju7V0ScUZHW3S5VRjcw2Oro/gBt1VdP4eCfvj7
	upAus7a9xHpa8SBc/iB5EXJnLgR6DItvQMLnuZJawmNgIlLi+4DDKk/3enkSBosQNliA+WgF3JE
	dCkTGkgWgL6HJrgFPs3UoPPc1gKqluZCuW7oeMtJVpdrK1t5u0w693aPTvp0BgJ7LJGqsDPO4j0
	juZQC9ZDRg/NQnoNaIWq/wY7f8fOoI1Beo16BP+75CSWI9JpNtqVwAJ3Ar5QxabmVcdw9LVKBwI
	aAKunfPvbMV56GiFumG4jNRRVQTI4FEq7ufJc1pOgIYLs8eCS8ebwISMjhg4jYqj/mpko9SWIYm
	bw=
X-Received: by 2002:a05:622a:4a8d:b0:50d:71fe:85aa with SMTP id d75a77b69052e-5100e11936amr70025321cf.16.1777413512020;
        Tue, 28 Apr 2026 14:58:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b3ef7c58f3sm134916d6.13.2026.04.28.14.58.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2026 14:58:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8a3bc7f5d43so70196106d6.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777413511; x=1778018311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xZzMF7chzXg26f4EN6q7nTamGI5Xk5AAzqyFBI37U9s=;
        b=II5N2TYom/LCXWS66vqV+hlj5I4YzSqzxEHvANucndoyftxqE3YLZ9Yv8ndH7OBg3I
         z2oMUMIJFW//5vCVsnpUj7/dvlv9BlzzXirpVciE63iP7gdE0/mnu0lxxznEFGJWf1vR
         L9ERMk1m/3bg0xI6QDKmWI29hneBzQzlzmpAA=
X-Forwarded-Encrypted: i=1; AFNElJ/Xqbo6YZHVt+q11pQ9kbwqi3TepSoWmEck33D2Mrw7dVmsNIeyU5VyNCbzuAa3vQo2EbLmfxM=@vger.kernel.org
X-Received: by 2002:ad4:594d:0:b0:89c:e7b9:56d4 with SMTP id 6a1803df08f44-8b3e302c18fmr77072536d6.9.1777413511273;
        Tue, 28 Apr 2026 14:58:31 -0700 (PDT)
X-Received: by 2002:ad4:594d:0:b0:89c:e7b9:56d4 with SMTP id 6a1803df08f44-8b3e302c18fmr77072216d6.9.1777413510786;
        Tue, 28 Apr 2026 14:58:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ef71b89fsm2441396d6.21.2026.04.28.14.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 14:58:30 -0700 (PDT)
Message-ID: <4f13d8ca-7757-4952-863f-a79d10b37185@broadcom.com>
Date: Tue, 28 Apr 2026 14:58:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: broadcom: Save PHY counters during
 suspend
To: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, linux@armlinux.org.uk, hkallweit1@gmail.com,
 andrew@lunn.ch, bcm-kernel-feedback-list@broadcom.com
References: <20260428212424.1828999-1-justin.chen@broadcom.com>
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
In-Reply-To: <20260428212424.1828999-1-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 7553148C6CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,armlinux.org.uk,gmail.com,lunn.ch,broadcom.com];
	TAGGED_FROM(0.00)[bounces-282091-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/28/26 14:24, Justin Chen wrote:
> The PHY counters can be lost if the PHY is reset during suspend. We
> need to save the values into the shadow counters or the accounting
> will be incorrect over multiple suspend and resume cycles.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

