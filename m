Return-Path: <netdev+bounces-271754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHsbCWxbxGl0ygQAu9opvQ
	(envelope-from <netdev+bounces-271754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:02:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9696832CC21
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A6BF305D5DD
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 22:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8055631D730;
	Wed, 25 Mar 2026 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LARMHMP1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149082EDD62
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476062; cv=none; b=LznGaQRVlG0VoixyXaSOjhQXEtnU1x193pSTU69p2lUNx46MF4hWKGzXJJgX+dOZsCCoJjn8YRB0mq6Tnrak6qkn2Wrmc1qNYTbvzm7HEV2OxufyuaYUJY0T2I8ZFj6z5qLP5UXf9kzNVY1Yp3CMaKoTR2iaKdpLSh8jpdAMmD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476062; c=relaxed/simple;
	bh=heLo29k5Gqc4s2pKOGHON23MDXea0bAcFzNY9WI40CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brPWIIzrVUwJyi5gn1INGJvPn0JRhyHBrxd+Auj3MMi0sk7VsWzMjMbH81WbCA3OFa9P9oCcPU0GMompqpr//2W/j1BFpAZVH44tRJPRsQsint7wPB9QZH/1GL7dLXnHxa0ojK2qx5lfHVE/qYqtVYhIJnD6S9KecA/UlF+4TnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LARMHMP1; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-7986e0553bdso3400527b3.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 15:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774476060; x=1775080860;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DHr/4tUP5xCjyAhDTO10zC1EePRkH538BoAN7B/0/8Y=;
        b=Ye3pe+HIo+2Iw7UhSt/sflxJ/+4xYqLLQ7fMTOLaWIv2Mpxv5JoJOGcpx8EI0XrjQw
         t70LQXKNE/KMbmpgUVHSCEZ03wm7IjJkl8148JZ4UmWwOuT2s7PwdeNvvkIYg8izgDIm
         6WsPapw+H3ATcHCIcwn64Thh3ZDEUqCI7WTX5PhwoSC72VQ/y3q2AyTR+8k+LyN2/ryP
         b5Yf3FYG9Mwud86RsocJbFts8aXAv3O5T4P+qmJGk02cN27yI7B9betAbSNzb1gtA2hA
         xOLPgYQFSkI6WiENg/2uYWz/eLlvI5Uj4GoVaNqECyPNau5nrGANwS1ACrOLWBcLU6pp
         Mg1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAvyz4lxc8ew8BsObkCyDWYxGeC2CDS1NpMHyGA719FfahFogpokOyHbL6Jx93bPtAf3EQ1M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLapY3IoCmut+aidd1AVJEokGZf2EWDjnqcHIClwVCiS/cuz/s
	KN8pz2hq6BRLjyPow3bxFL7usAnkslrUGFupDf/nvfCOg77A1XEU2NKVS+vqAOjAnMSj0tfGFDC
	uI4AaW3R2K6f0ybKdEjYbiSeEjnCwAII6Q5XJhtAApXkRzIk1t4K27LagWG/msjXBV1ISayxGot
	kyOHjQSdmzBnshe98VP3+7rkOgC4Qq4HZO56f5igevhGTEquv5vftTBVCX2P04Jc+jrnnZHLDGU
	4Z6tVXu8TDfwMxp
X-Gm-Gg: ATEYQzwbRO/im+vyHa/RnEfJhHESdXecVy2ytQRPeZBym20s9I6ahFMx2P0jtrHC66n
	VAD3kfFl1n/fJ8XSx3X76X1/QbMhxRwXuzTQyC3eSi61NQ7KZaHV29U1SYBLGAWU/nVM4/6TPqi
	WqAMFpEk6mf96nWl1AoC3amAjumHbm0r4PuIK/mD4wTfBXfdweQ8hnpkI2JGIzs+CjdvOj3CZjZ
	hKAnGqv48zEcijcptohugOvJGHaXUQJdZiGg7U3q45MRDHZEtd8en524BKVcbgxWVvLjQE3b5hf
	18lOPsEL/JbZAHMOoyDJMejNLa/QX7ACvBtoMISxGiP+DtvGZKBhFWuTe8wOTs7kSSrpFILNpJP
	nu3NdtpbZ5mdAFfYAJ6j58SbcAjKzzJU8Hx15HF52UEQ3P42+E+n3LrCWItxgP4uQ/JBrwdNBoR
	mf8uE4JAg959/3/2EhEEE1BeUEnk0q4TVVaGkEBdfk2gNMS5ct4LYx8kf14wSnxg==
X-Received: by 2002:a05:690c:6283:b0:79a:b824:ccbb with SMTP id 00721157ae682-79acf6b3d88mr53687867b3.42.1774476059786;
        Wed, 25 Mar 2026 15:00:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79b17e2b490sm550737b3.7.2026.03.25.15.00.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2026 15:00:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd767c51efso64038285a.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 15:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774476059; x=1775080859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DHr/4tUP5xCjyAhDTO10zC1EePRkH538BoAN7B/0/8Y=;
        b=LARMHMP1C3QNxxL8p5DlkKpUjYPeHfIlqhF67hAc7b9CKaIw4iyBqJ+75qhfSU3q9H
         K5P8j9gZ1iKAGZLA6kNBrFzhj0QrYG4t0CYEaKWm0dxxgeDV7P5I8FYvjSqVFoD/cKUR
         BOXavRlbB0cMR59ZTe2sDPrYp29tnYhgvtb54=
X-Forwarded-Encrypted: i=1; AJvYcCXJFf0FbUs8dHSSm6NAxHljAF3rqvN/bHccm1C61yAr78Z7Djf+lGo6aup7lEUfIdzIctPgfU4=@vger.kernel.org
X-Received: by 2002:a05:620a:294f:b0:8c7:a53:4d17 with SMTP id af79cd13be357-8d000f538camr705267685a.21.1774476058760;
        Wed, 25 Mar 2026 15:00:58 -0700 (PDT)
X-Received: by 2002:a05:620a:294f:b0:8c7:a53:4d17 with SMTP id af79cd13be357-8d000f538camr705258485a.21.1774476057968;
        Wed, 25 Mar 2026 15:00:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e39ee3esm112326285a.4.2026.03.25.15.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 15:00:56 -0700 (PDT)
Message-ID: <77801f99-517e-4b60-846a-f26469a7526a@broadcom.com>
Date: Wed, 25 Mar 2026 15:00:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net] net: bcmgenet: fix leaking and racing timeout
 handler
To: justin.chen@broadcom.com, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com
References: <20260325173602.3676778-1-justin.chen@broadcom.com>
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
In-Reply-To: <20260325173602.3676778-1-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271754-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9696832CC21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 10:36, justin.chen@broadcom.com wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> The bcmgenet_timeout handler tries to take down all tx queues when
> a single queue times out. This is over zealous and causes many race
> conditions with queues that are still chugging along. Instead lets
> only restart the timed out queue.
> 
> While reclaiming the tx queue we fast forward the write pointer to
> drop any data in flight. These dropped frames are not added back
> to the pool of free bds. We also need to tell the netdev that we
> are dropping said data.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

The first bits in bcmgenet_tx_reclaim would be fixing:

Fixes: f1bacae8b655 ("net: bcmgenet: support reclaiming unsent Tx packets")

and the other part in bcmgenet_tx_timeout() would have:

Fixes: 13ea657806cf ("net: bcmgenet: improve TX timeout")

Both fixes look good to me:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

