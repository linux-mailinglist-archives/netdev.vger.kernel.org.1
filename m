Return-Path: <netdev+bounces-275659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJX+OlDr02nInwcAu9opvQ
	(envelope-from <netdev+bounces-275659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:20:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F653A5A12
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 406E3302DB70
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D739F390990;
	Mon,  6 Apr 2026 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TfymV7/O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB5838F243
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495970; cv=none; b=TIY/rlA7PE+N/pwZHBkQzS6R0kX9gcIJuaC8ezCdury0tBZM3ypw9nekLYK9owyb89d/VWAXxB427G6mq+xhpLpqE5783x0yrY0rMNyvSWVJP4sQqJK5YLR6OhWn5T/S69tiL4RQVNgBb68VFH8aucma39eVNkzd/hwsP7bhPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495970; c=relaxed/simple;
	bh=Ss6WTHFJk7o5y0YnMAozv3+vHvaa9XtDF+7OYIRVVEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frheucArJFQUK7vzVs168mrhCX6MIjgMlQLcYi5O/jXnsumegNXRl5DXOq7vkIZtbnBqb9wBwAl7yy+yJnpkZ01FKY+8A8RYk+6QlL4M1Cfu8wp1HIZ5PNk0LAhEVKsc8LkeySXYsfjNca2xLrgy0Ulyg/WdOfFvsaSNdr3zMDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TfymV7/O; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-35c1d101355so1644799a91.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775495968; x=1776100768;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FRkVSzhsy3jVbqKy4UiNeOSWCmccE1QBrUWtrVbAuS8=;
        b=bHLt+Z09A8d9MyL/jh0nqsfgC+ZYGmhWH8nlhkjVOUPN7wls8RRk+C8beQs4kiiA2Y
         XoK7LUxYxGLSZnVrqWxWcpd6UW6HAmV81D1WlwgzxEVO6NXfp8N3rzMFPCKdOFsmDXPc
         RBPt7/ATbxg2Zkl8H+bzCXJ1a/oA6QT51bUv9AWKbQHxvhmfrMYK0apEEufR6+twhDcJ
         vW1GGjw4AWcsCLIIe5aT/cfOJtNjW+m/t76ZBbH7ORyKGYP9arw/xBGtRCYORIARCMF+
         s72N891NzVZi347OIgedF5GietuCj58lzCg4IfxoaE1dfjH1w4VNJ5i+U3P6dt/OrRDW
         D2GA==
X-Forwarded-Encrypted: i=1; AJvYcCVp/HLOxcJ8DHCt84Yc/rwJFborWoGZke+gOoGJj7RHbVUGbXgkJg7itrZDBjd4xZPLoJPIDy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyegB4ABoeHsgbOryGAx4dIkhz6SCx6Zcb2OECvaU8TVbI3Qr+y
	6giVcGrFiwruE9G1UMa30AS2YnL/UtFpdDyCkHwqkKjWZRNhU216wV/zCvIEGGmO/8KkdFwUox5
	CoMU/7kEA/wo8fUJrzub48f3xghmMinQLiYiAzlXXXUOq2BQD6RgGpXyVF++xf6Z82UhPBI2o2R
	hSyQomi4uHfjdStU917KM359g2iZR6Xs/Xpdgv0x/BANA//qt9gDzVh496PNJZifQbEsIgTckpQ
	FbAvYYUN7xYlLle
X-Gm-Gg: AeBDiev/d0q++f7WYu91f680y0LczFeOn58Cp945psqkcXaI/jNPgAmWIldpUDohqXX
	q8PgQKOA3dmFupPwrf0K16qw6fUeS0bOW1fRQWn4yOWheFTESZQqLJQpd4sS+GO5DUWsrFcjjSX
	e0h/+Itf+sr/Jqf7YV8ABuDpD4eQC+Ekia7Evf/vLNruyzaAR60GISgjVo1/gIMmyHCbzL/rwNZ
	2lkk600nsEO5gJGGKAQXzXlS2WFnUAnoMFGCVNn2M71P21fgcnjmNIm3tLtaPjDrhMqj/DXTG4V
	bhEhOIGGc7cyS6WWQZy3vNSF8hAlleCi2SU3QafX7sxbZgWMxYAiO+dxQeQsfkmuhlaaybHA0S5
	cs7FK8/HAkhBFa8Xom1ernsPWdM95qgNrHNI2lHGP+HEiREl5RRFMJ3/ft/SQ5CSYXjc/plBcv2
	wFv+nhgXuqYnm4QfUfnZnqS4wKhHj9QhRUDZhDA8Hed9XItIlJu8kvCSJPHdqqiw==
X-Received: by 2002:a17:90b:2b4e:b0:35d:a78c:1194 with SMTP id 98e67ed59e1d1-35de680d5a0mr12696377a91.9.1775495967811;
        Mon, 06 Apr 2026 10:19:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35dbe60d33esm1504757a91.1.2026.04.06.10.19.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 10:19:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2c68a134df8so3927587eec.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775495966; x=1776100766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FRkVSzhsy3jVbqKy4UiNeOSWCmccE1QBrUWtrVbAuS8=;
        b=TfymV7/O7c5eFmfvkZNxWGl0ZGIArH3eeaKvulbhnrW+UCXAM0umeF7y7htvp7NVXu
         XtAPhNjWe7uaQXg8pf/HN31wG5A/CQDukHGpS1lZALutKx7ETiUwSK2+tyo7vVpvNBzY
         iqzmkmwd80uxFTpC8yPz06v72V1r97kVDA2Dw=
X-Forwarded-Encrypted: i=1; AJvYcCVtc5KXTGLla1xoKV6/Kt42X4kvm/qtTd1o++Z0wxIX3VowATkVtbRVFRQOnWVj65sMBhP2MLA=@vger.kernel.org
X-Received: by 2002:a05:7022:6881:b0:11b:b622:cad9 with SMTP id a92af1059eb24-12bfb73e381mr5511738c88.21.1775495965626;
        Mon, 06 Apr 2026 10:19:25 -0700 (PDT)
X-Received: by 2002:a05:7022:6881:b0:11b:b622:cad9 with SMTP id a92af1059eb24-12bfb73e381mr5511704c88.21.1775495965035;
        Mon, 06 Apr 2026 10:19:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bede7f542sm12020430c88.14.2026.04.06.10.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 10:19:24 -0700 (PDT)
Message-ID: <967f597e-589d-41b5-9b03-b91ecd2d3ab0@broadcom.com>
Date: Mon, 6 Apr 2026 10:19:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 7/7] net: bcmgenet: reject MTU changes
 incompatible with XDP
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>, Simon Horman <horms@kernel.org>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260406083536.839517-1-nb@tipi-net.de>
 <20260406083536.839517-8-nb@tipi-net.de>
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
In-Reply-To: <20260406083536.839517-8-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,lunn.ch,google.com,redhat.com,davemloft.net,iogearbox.net,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275659-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 73F653A5A12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 01:35, Nicolai Buchwitz wrote:
> Add a minimal ndo_change_mtu that rejects MTU values too large for
> single-page XDP buffers when an XDP program is attached. Without this,
> users could change the MTU at runtime and break the XDP buffer layout.
> 
> When no XDP program is attached, any MTU change is accepted, matching
> the existing behavior without ndo_change_mtu.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


