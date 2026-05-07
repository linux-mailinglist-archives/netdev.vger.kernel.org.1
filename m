Return-Path: <netdev+bounces-285480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIW+Ezfx/GlmVgAAu9opvQ
	(envelope-from <netdev+bounces-285480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:08:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B7A4EE3E9
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A78633006451
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 20:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CD535E950;
	Thu,  7 May 2026 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QJXUAH4Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5745E34EEE3
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184498; cv=none; b=QPOnc2pj4fvPNS9QKWqDTLzzdsOCCyxcG8n/Cizt/axtW603zzPk5MSUojKxsTl7SSGrz0sadL9er/1S/Bg76XIidmTe2jkOD6qropR/MexxiZvEZTqOrNQz6dkKa9vb3Wqb+AgeNqN8XEPPs+tZAIsdaVAnYLY6Bhh3KUsHfhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184498; c=relaxed/simple;
	bh=L48XIUh9/zyDEd8hB70bdZ2ukdLob+0IqyNkKj+r82s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDEUi1ZCKtFtP3+HEs5g5C/PU8kzlG05inRqGkcEfoMjhJzuS8MtTRfjiJ7VgTx3TrlR5i4WRRSJnnMKg5b8L2WwhUQ9b9L5lG9GFGu+OuefZMxPWBb1N6LxmpJjNVajHHNfExPcGslWC5hBySNJd5LiB/Cd/xl4jUHTwumtaRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QJXUAH4Y; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7dbcb467f2bso1150432a34.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 13:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778184496; x=1778789296;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKWToCGXCKgQRkzt5sNJfp3GLiMOU5hFpDOPpnaTOL8=;
        b=H5QTZUtDyqnX72+fZp5Qu7SjPXRkktURbHGpXbXuTfSy37q9SykHIlNhcV5Zmdl6Oq
         wRQ9pf5kUDfFAPozEeoZFjlK5hjgdSrZ3QCKvzJ1dxjPFg91utsgbRFpdcWlL6vw8P8p
         ddO+nT/V1tfLU1yI+7mnXCQADGTYqz/ut/9kS6xOokVLv+JimFvADo3OgJOEXm8On/Gg
         RUwt+uUZJv1eZ6A3bs1Nbv1HRdsCYxITApwyWCDEP4mF3fxQF7Uuz+8ukYq5HDhQJNCy
         QFqqEvBQFL4JW7LVCNKXRkwTNttzprg0Z7DoE02BqpFlAOku8THcx3c1yiAzzFgOfJ9T
         lBoA==
X-Forwarded-Encrypted: i=1; AFNElJ+9ieV0REpXTkFoeKK7tBNJ5XkQ/J4Kxa33DCBDpSk+C/MRjuEW9Ur57BuZ4WNtqwr2XxlZDF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDDKdH2Xux/NZQpl9h5SxBgBE6Hj9SAgGhvXEYXKZLY+F/WPuK
	bPw3Syae4YE0ZACTQzE3J2CLbYg+OznepbI6bLsSD/PqfNMsKmk2oc7ids+qMtDQUb7D6YwKswj
	L/lnU1JnyfCZN6lLsypvHxaZCfmeofWkYrdyshqkryk8WS2lrUUAnmMlJ+2D+6gBGTeJhD4QeuF
	/fB+zbbrXTfwV+QAGb1k8bf9C5qFQPKKAZkCA+rJqDAZvLNmcc0p6iMDrBA8VGQodpm42BbkVAU
	8iLGrEzhkynIvOj
X-Gm-Gg: AeBDievXVptaPDaH8PTBInck/SZSCl+UXCMf6ancx6Owxg/PyI7VKJXTGkqEaGkolaW
	sbvytG2c9gs3Cl5kS0tCq8W5GkPuaQJOArkpm1xk5gNoaJRp6xHoAaJu6GfY4lJNTZvxuHk1Mnj
	k0MCTRto+mHEvnvgBF0FU0knYCAojNIY5RoSUNErkH3RLBf5hFEo1EJAqMudY3agmEsduUl4Xun
	PPITPoUnqbgh0NYI+c0uZ3ITBMuBuhlfeYenU3KPHkvPxwSyoCcykLNE0+VSpFHLbvb9Q4cHSr1
	po6psed8tNaVgF4GfmA9dM24Cn5I/MJeSK0PcbS09xFXyHh/Pj8ViB7SCTSNiK72qsORxt/UeFP
	Y1/ZTIjPFYN1lWFjv9j3yGVL4Y0R301h26eeIIkuZ7/Aaz8/Qvix5A3Nf+fTlwBR3ZHBNhkbsjp
	FY4d60SQZMCw==
X-Received: by 2002:a05:6820:1806:b0:694:91ab:ec94 with SMTP id 006d021491bc7-69998d1e374mr5199263eaf.38.1778184496121;
        Thu, 07 May 2026 13:08:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-69b20f09541sm19008eaf.26.2026.05.07.13.08.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2026 13:08:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2f3eb8f3419so4809217eec.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 13:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778184493; x=1778789293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rKWToCGXCKgQRkzt5sNJfp3GLiMOU5hFpDOPpnaTOL8=;
        b=QJXUAH4YJ8Bcr9sScmtmjJG9PCNJ782Tu6igs4DdQVzijfTOEkiOFz5GtFqgfP2ayD
         s02pGiYXdXlKCbIXAp0Kl8+V33YD/+MxYWyKG4baETIkiSAqATVpRkA1OOAiMaaLhW5x
         LlfdoN7B3SC0VaxZGvzkfbNRA0kew1oeP7pFQ=
X-Forwarded-Encrypted: i=1; AFNElJ9f3HKJ7l59vaSXFHVS5ZuBspUOv9zTgYFnRkn0p9qLTEvf3B7B8B5mbhx/ikAEE2TG8ekzE5o=@vger.kernel.org
X-Received: by 2002:a05:7300:6d08:b0:2f0:c8b5:3dc7 with SMTP id 5a478bee46e88-2f54ac74b06mr5141720eec.22.1778184493339;
        Thu, 07 May 2026 13:08:13 -0700 (PDT)
X-Received: by 2002:a05:7300:6d08:b0:2f0:c8b5:3dc7 with SMTP id 5a478bee46e88-2f54ac74b06mr5141694eec.22.1778184492699;
        Thu, 07 May 2026 13:08:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f84cf3c53csm32103eec.11.2026.05.07.13.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 13:08:12 -0700 (PDT)
Message-ID: <a594315d-f79a-432c-a9a0-41927720f491@broadcom.com>
Date: Thu, 7 May 2026 13:08:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: bcmasp: Keep phy link during WoL
 sleep cycle
To: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
References: <20260506213114.2002886-1-justin.chen@broadcom.com>
 <20260506213114.2002886-3-justin.chen@broadcom.com>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Content-Language: en-US, fr-FR
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
In-Reply-To: <20260506213114.2002886-3-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: D4B7A4EE3E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285480-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/6/26 14:31, Justin Chen wrote:
> We currently more or less restart all the HW on resume. Since we also
> stop the PHY, it takes a while for the PHY link to be re-negotiated on
> resume. Instead of doing a full restart, we keep the HW state and the
> PHY link, that way we can resume network traffic with a much smaller
> delay.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

