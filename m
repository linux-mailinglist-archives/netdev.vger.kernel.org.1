Return-Path: <netdev+bounces-300405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vf8HL53NM2oeGgYAu9opvQ
	(envelope-from <netdev+bounces-300405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:51:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4BC69F7FE
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:51:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=d3koL2IH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300405-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300405-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E63F0300860C
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27473EFD24;
	Thu, 18 Jun 2026 10:51:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682CF3EF0DC
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:51:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779861; cv=none; b=Gz9b/RYzWaa7NGUHi0TDZm2CdQsEX67mNXJI0SCmxXaZVyxai4CAU+4s77UXGV73rinZH4Xbn6SB6H5Jb+kNmoYTAbnev377p1AUxt3xOtk+5fwIH49lzYcYb78RtSz8T3UXflbW5k3iuiWv2mi4ERuMrGy/g+XcB+qlAX8DY88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779861; c=relaxed/simple;
	bh=imh7lzeRo7GqB99dIGp8+jvQIiP9UQhq2gWePCDM2p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5tFQL3wNb4L5OKD34EkXq+fZSaWugzi7m3UGS+aWitcd2Uxv8H47498w6OOSI4zNh+UzlcXGiQ4armSps1NZzU2s3Z22Oj9Jjpq9tmiIu8w++sX7Eyg5Jj508bZ/DsbHdVlCipqyciLY72rKvxRFd3jwcebcy6/vOisZLYzzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d3koL2IH; arc=none smtp.client-ip=209.85.214.225
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2c68190ade4so14419305ad.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781779860; x=1782384660;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J9YwjIKoRl7XSA7xmw3oT5MIvVpXzyFhlZir9vFzXgs=;
        b=WVxHq03E3cY7m6Fuf4M2q550ckgV6Rorw9wjPOqHq2V9KIlXVris8SHnm0PzClqh4U
         +Y9VbaSIkPdSq+GuUgrf2VMxckfPl1MPXBBzCKGiwlEWcJqOGqlKF+ijtW44+8AkcuxW
         u/2aGEBrH5SFo/cKznG5iNgHcJHDn2wFnjH1lsBIax7ME9Mlf0cj6RidbFIT+ByoqaVR
         dl8dWVqB+m5bJOUMN1TJ7N6jy496XXvV8+4IUvouv6gGnkwc9bn5zSjzUqn1O4PwY5c9
         mjRfGN9rh2f6ef9KWrCu82Yq3qPF4v6kAoj/HO26qjJMamJrquofbLhFJ7tB7ECX8YnN
         47yA==
X-Forwarded-Encrypted: i=1; AFNElJ8FELPKxB2eTMXeUcq56QmUCgTpVGZa5ZQLVrY6nqHHCz0J/o1proT8avJTC/lQ6+6Riz3ZF/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpCuDFm4MmpfG7YpEf3wjrh/Zb9dHFJtEDoLN+BUFb6g+js7LJ
	Q/Vk1Y3RV57dK+oKnoNVBI1OSlSNwRZ5bF1RabChOvZEq7ORjbaMlBAXc2Y+qvMWnqx3QpnuB7s
	ckajAz31GENErqLa8DpnC17gLRce/VPZOBFB61DBCFhNDJqgjXZLLTx7+b+nG6Ji3s8ztEwcRCP
	/HwDmEIeIuQVupYYRzJgWOtUUN4AWERJhOliq74v0xlnZas9RlsB1NJpt3tVtSJd9kQ4fWpLuZ/
	1ACZU8NWjCyWE2GxHg=
X-Gm-Gg: AfdE7clfLx2YglA5mW0MSuseRz51CNVJYSBb2Kjuv8OrxD0AhVDEKYeG+I8KCxHeQdo
	jXdIRxlqs/VjDdKpUUcWH+XQJX4zIaiygQFWzmXDW7D2FI8ZmavlUmWHFd0KYHLZC4SvvrIIc1M
	wVt0aCmf5htPFsFzyyCPeUgwRj4HSQmSvtmYbvDskEfJVVWpIGHXo1saZw3mqJPY9lSfamklg2V
	VzS4OU+6z9Zodit1Vzah4IiJfQn0MrpmzFy+/p3I+I2TKtnj8bRkQHHByYOXOYEeQlIpOqpfiE0
	FBO+VnhsUPXah08UIU8jPTdInA7VnoAHGViimJOaSC0iT9SsEuCzoBLsrNZ5NZRUzqNiqCt9p7B
	OwCJyMokjx2cMdsoQWQ1Yko/Xf9/Y5/km6B6oSe8tLIRDFFLv8aIIRGzCNacRCAwqJ3CrGSyf2y
	Dc5lcpmoeigg34zG6mFVn3xK2zIyfH6AX1Q9jjvgV9eHabS+OEI+eufA==
X-Received: by 2002:a17:903:2412:b0:2bf:2ea3:af30 with SMTP id d9443c01a7336-2c6de3dfc04mr30039855ad.4.1781779859608;
        Thu, 18 Jun 2026 03:50:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c432e81bdesm15991235ad.39.2026.06.18.03.50.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2026 03:50:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-462d8ccf553so577871f8f.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781779857; x=1782384657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J9YwjIKoRl7XSA7xmw3oT5MIvVpXzyFhlZir9vFzXgs=;
        b=d3koL2IHLOuluuVuoPr0rq/BXarf/vhneebJrsk6GlaoI7pl1O8/tOTicHfMqY2C4Q
         1IkZ/uEUE99zDfQ5w5FTsPJxprTA7u5p/Fiq3ok4OUbVmBeZJH83Bu8Rz3K5+r843Jxp
         75ssDeMZavUPPzVrhbeeRohf9gh1T36Y++LwU=
X-Forwarded-Encrypted: i=1; AFNElJ/JoCM54F8NH3qVF+Eam36JMvMWGdWTJda5InM1oCQhzIod1AhCe3k5DMSHCZ1Z8nXZsDzBHDI=@vger.kernel.org
X-Received: by 2002:a05:6000:1448:b0:462:6aa1:4393 with SMTP id ffacd0b85a97d-4626aa1456fmr13329706f8f.4.1781779856833;
        Thu, 18 Jun 2026 03:50:56 -0700 (PDT)
X-Received: by 2002:a05:6000:1448:b0:462:6aa1:4393 with SMTP id ffacd0b85a97d-4626aa1456fmr13329626f8f.4.1781779856339;
        Thu, 18 Jun 2026 03:50:56 -0700 (PDT)
Received: from [192.168.1.21] ([41.140.50.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619fb12edbsm25700899f8f.17.2026.06.18.03.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 03:50:55 -0700 (PDT)
Message-ID: <10979641-cf6c-4359-992e-64016d520944@broadcom.com>
Date: Thu, 18 Jun 2026 11:50:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: bcmgenet: remove dead priority queue
 plumbing
To: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260612205915.3156127-1-nb@tipi-net.de>
 <20260612205915.3156127-3-nb@tipi-net.de>
Content-Language: en-US
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
In-Reply-To: <20260612205915.3156127-3-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300405-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[tipi-net.de,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:opendmb@gmail.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:justin.chen@broadcom.com,m:ovidiu.panait.rb@renesas.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,tipi-net.de:email];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE4BC69F7FE



On 6/12/2026 1:59 PM, Nicolai Buchwitz wrote:
> With a single TX ring there is nothing left to prioritize. Drop the
> unused register writes, enum entries, helper macros, and the dead
> "flow period for ring != 0" branch in bcmgenet_init_tx_ring().
> 
> The DMA_ARBITER_{RR,WRR,SP} and DMA_RING_BUF_PRIORITY_* HW defines
> are kept as register documentation.
> 
> No functional change.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


