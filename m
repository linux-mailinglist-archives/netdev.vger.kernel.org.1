Return-Path: <netdev+bounces-284601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIwELuF6+mlePQMAu9opvQ
	(envelope-from <netdev+bounces-284601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:18:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFED4D4A52
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EDBE3015E1D
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 23:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985823016F2;
	Tue,  5 May 2026 23:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H82UGju+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5FDCA6F
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 23:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778023106; cv=none; b=ow0syGbdf5HISQWH0d7dCZPazFLJsgME+3/WqAa+PlRxeqJCcZqB2YpDTJmY8bv+yXOuuKB/c4AAVnKzW7E0pmYJyqUAtpoZfD5mkvgb01XMQFkyeEofLOXladIzxvLkw3DgSJpwpbaZpc7CdP2Vj7x1dzG5F1QH165RBoU0L38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778023106; c=relaxed/simple;
	bh=3mfR6NoD7UrN/KzpsQu+vynPzgtINheSSsoyol4T4gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vcxcep2kDWTo7xgBPIZNRnkZnK26ERjlpCjX3W0PK/VIH/+pfTMxDeDQTlbDqTf5N4AMssUgFI5IQWaK3F3s+eaxFAlYvUsnlupeudTQ/CKp93q1pBLRUm/hWbdaAuOKs6bbZYsPeNv10AOjoHApL7HEXTh8yVRHHovgNLVn9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H82UGju+; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3654ebfd57cso1972891a91.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 16:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778023105; x=1778627905;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e/rsz44tmb1leX1rs6u34tnv9eVD0StpLHHizoyXcB8=;
        b=oGcU7t6KWOkgOYgBJxsCIounCqD3cKZO7tTT3kRc5A+8I69DN7s22fx8rbO+La4BFo
         5K9AXsJgNBcIucxmSiXiKHYU0GKqE8VjJwpM+x2cNAlK8HPlpI6DOOLwkiOZbiwYX7OX
         93p1f6VVoXpsog29Whe/XY6cIQ+jj7KjMOmUsi2zvhYVZXmUk4NBkHmwANSn7W51eCFu
         tw2vnt5NMFVKUU1s5MdrFJiNJaIPaQU+C/r8TRwGc3bUPmemVBZ+7VDRPZfxpFL/LAVf
         +007A3oPG9+kFQ0OVbjKwq9zG+kiHo5g1FRDHLLt3a7sntk2mfFQxIbULAszw2JMz3uI
         po2A==
X-Forwarded-Encrypted: i=1; AFNElJ+RjyRkXGIBeuuWu7oDga2WRNQt8rglZz1Lh8dV7+Zo/plYid0sPzpaJRa2URAYMR/l3jUkJBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiBmJ080EFJR+SmxLkjv4xEpg0Wq53tBgloRGM/xc+vfEAQrdh
	4bEEih+7zlzQvsoeogXkCFH2bvqCfsRY6cD8xi++Y1hR4gEzcA5JDtFM5Iktgy3jXs+t1l4f7cF
	HcW63rQPWl1HCk3guH6hWV96FUj7U+LG6RXgMkVwWuNA3Qvsjxtoivvt21lDK9hH2cDEo6Pm4x9
	jOitXnH+Wi4XzPNFKenH62pDk6o62WWtEHmysaYasKB+fBWFMq/9vqNAQCeFkDJivTKB7jivQEQ
	xFC50uuXXMxS+8J
X-Gm-Gg: AeBDieuSBweiRYa5mWynp0gaqyZhGICX4rUPNahfskQFZEFbJNCp2Dd2A2doBWzPbms
	uwEcwnczJT3NlX9zPn+w0s8QENGk9gl9DGa4XgTV3n4O75x6xblK6lXuCWk4uLvTLhbvpE3s/Zi
	iheSlu+KNwN9EG1m06URfr8VsGYCtfNrI8L0ZrOjKOAev4plUcBxal48XKNiDmIc8diV07eQz2e
	UyCptGwini3kU5O2QLwYvRH34oEl+aCLaa0H23mpXdakAuougAL+KKAWq0I055sOPQkVBhngA9Q
	L8Lm3gNwsciLuRNYNIXXHF3xzweScUnQDXcen+gB/seSRkhCHQQvyMijLnuKxLSF0UqYJERpIkQ
	c+XD6tBucEjMFup7gnzr2ct41chaeFcD7/xq8hRJ0fi8jO3fr6jIL38tCI+ent2MHZey2U1ujSS
	kaK5ZF21BRvkGApqigrOuS
X-Received: by 2002:a17:90b:58ee:b0:364:87dd:b2c5 with SMTP id 98e67ed59e1d1-365ab9b8caamr812172a91.3.1778023104580;
        Tue, 05 May 2026 16:18:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-365b4c425afsm6225a91.6.2026.05.05.16.18.24
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 16:18:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7bd5c421975so4535987b3.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778023103; x=1778627903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e/rsz44tmb1leX1rs6u34tnv9eVD0StpLHHizoyXcB8=;
        b=H82UGju+IIrT68oMJCtDMWPYTfNMjA7yt3X5QV/gPTj9XfgdQrsycXzk5+v10M3aCY
         +TW6Qt7y12NrA7qYcSJTwo6rgcQq6+pkdRZm6JdPmKeLbDo/Tw+ok89N7qsKrLjy3Zn8
         udAYm6PDY7tsP6BG3UJ0Imt9MpzA1aAyOzxic=
X-Forwarded-Encrypted: i=1; AFNElJ+XLyl9lUhR/mFpA32+EfUdUbFUONYDHnruYtur4jx8JzsxMPVca2HJD+yodnrw3SkgF6uXcK8=@vger.kernel.org
X-Received: by 2002:a05:690c:dd5:b0:7b1:fa45:72e3 with SMTP id 00721157ae682-7bdf5d651b7mr16584147b3.4.1778023103239;
        Tue, 05 May 2026 16:18:23 -0700 (PDT)
X-Received: by 2002:a05:690c:dd5:b0:7b1:fa45:72e3 with SMTP id 00721157ae682-7bdf5d651b7mr16583777b3.4.1778023102769;
        Tue, 05 May 2026 16:18:22 -0700 (PDT)
Received: from [172.16.1.137] (107-214-104-235.lightspeed.irvnca.sbcglobal.net. [107.214.104.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66896398sm70444747b3.48.2026.05.05.16.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 16:18:22 -0700 (PDT)
Message-ID: <4ed8c3c4-9522-4c09-832c-25028d89540a@broadcom.com>
Date: Tue, 5 May 2026 16:18:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: bcmasp: Divide init to allow partial
 bring up
To: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
References: <20260501185625.422361-1-justin.chen@broadcom.com>
 <20260501185625.422361-2-justin.chen@broadcom.com>
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
In-Reply-To: <20260501185625.422361-2-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 1FFED4D4A52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-284601-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]



On 5/1/2026 11:56 AM, Justin Chen wrote:
> To prepare for a partial bring up of the interface during resume,
> we break apart the bcmasp_netif_init() function into smaller chunks
> that can be called as necessary. Also consolidate some functions that
> do not need to be standalone.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


