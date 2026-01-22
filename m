Return-Path: <netdev+bounces-252519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SORfKFl+cmmklQAAu9opvQ
	(envelope-from <netdev+bounces-252519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:45:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F296D2F1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ADDE301AD30
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BF939BA47;
	Thu, 22 Jan 2026 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PGm7QofH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3183563D8
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111044; cv=none; b=jDVfDAOa6iCPe+Mrm60/gEYmVaI9jkPANq02XWgHWgVjbsfOjNlGi+q8ag0pmk8MwHVs8nt33/usP03UofkyH+gap6c1Ii5SlttbmdsKUBzg9PmeWBrpUTO4WYb89Eo7mooF2JLdwipMcgMeh85NYuwUuHeLi4xVNAUh0JM0jIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111044; c=relaxed/simple;
	bh=MHbM5qArsq4AiGMP0WY68KeiazP0ZIO6VByGEituqiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NywmGgzrzBZVRymM0/XrR+2LiWLniLMzCZ2WYte+Kma8nspQNaR2NZbjKCEkxlgZq4c0lyTV1g4DkThbKPtpTkdO1HPpZzvrAP/zCZj/J7IivOLidTDHydPjRLkCm+GWShKtWiNbi9jfExdfs+tc/Zh9GvfInxe1GPucvx/tfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PGm7QofH; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-89461ccc46eso23264936d6.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769111033; x=1769715833;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K5HzPefHeskVd0VLsVXw99SpGx5L8PXc6SxjNfQbdPg=;
        b=Uz1pk8Fug2JP+vbAhhfUTsUtMsvzc/b42jmqWOWBT4r7MI/l/elJ5Dsu7IqUaqSi02
         XLJdKjNodWaJCJR9MgVk36L0FG8tG+HX38fl3XO7/Tkifpj4keAYIF6tlVp8PX0pvGPH
         n9KPk6X5jSK1P8Mpwxajc/93G11t07NNCWwvr1c/yp82+ztAe2WzZhfaheCkoj/TUQQT
         gWAN89CUECd2zuN3nj2e3258Z5poSm4SZMoUpHyeHaM+AzK6LvvfVdkEnXPnE6ToSbCk
         I4hI5Hl8+/xe7J5ez2ZqCDC49d48+A9nlm7S8zsF+6l+7+9qe+66pf/6R+SkdSClojJZ
         MA1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8pnN6STwAVUh+MX94QgIL4r9vALhT/npGJTl/XTNnIViU/LMURvCxkEDXEGf+OAZWZHQKhUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwURZqXDwsXZ6gmfk4vrognN5o2AwNPISw7MDtisPkf0KUHx7uq
	5Pi+sb4EcFj/WsX/zUsiYjqwkmdEIOmeJZgKyDR7//3AdEJ994XVvkQZKBz+4noGgdOg8BeGw19
	v0BetRYMiMJwX2T7OHfP1uRRlqmZod2HCOi1MAEvPiGwUWXom+6D2jmv7jS/Bf04cpm6JfAKQcc
	hXBntPKfh8gQo33HedgIVWWwVxQHn6UIpOWG6jR2MAvaYgxtLLyiepxf3El/ixx2xDM0+UwwU6J
	r0lR5sT0mQnBFIr
X-Gm-Gg: AZuq6aJx718b9Kmw9Rj9H10ZcyBcIL7QljcuPk2MHOpQ8Z25n26JZF8chyOpU6qx5Od
	NtN7wHOTGs5WBTNVYIoFjceuCktJpPg3B6NgkWQKmtKPI2lR7dX7JYvZU6MzR9gQjZNdmxGLrG4
	mJCOrWWIlREXLocAZa+l2tT0wCTJMBbgcEJWYCVXKYwl7dUj80c/vc93h3cMOX4/Kc/nyWI2kbG
	zYq5vClr1d6ggGnufbBMZOvaHhRSPqVe9JxC+ixB8PbOIDLR1ToUVuN2M8mPZyeHdcYM8hcd29h
	ZxF975OR/0FaLV8va09U1tyb65eoOXwEAVlyFr2B8TmeVY7Mvfl2Ro/8larOZ4hNwZez6Cl5EWU
	CwEJT5hdjNgZ9DZ1mixUvzARLNXq9oRB+ug++Xhb0ef6eZsIEbc5wKQr/QT7FHceYKD18T34Juj
	pRVRNFfI3TqpkqsOe9vVXB/1RrupIDmv2p0cGyuz04S9xaffk=
X-Received: by 2002:ad4:5f8a:0:b0:880:4a49:75d0 with SMTP id 6a1803df08f44-894900b525fmr10013306d6.0.1769111032771;
        Thu, 22 Jan 2026 11:43:52 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8949189d12asm202616d6.30.2026.01.22.11.43.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jan 2026 11:43:52 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b704019c98so1488312eec.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769111031; x=1769715831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K5HzPefHeskVd0VLsVXw99SpGx5L8PXc6SxjNfQbdPg=;
        b=PGm7QofHV5DEqNpIEcYaCudyUHHS2qjUcbStuafi3KD1HVC5UbTZLx3gxoSPpQ5eU4
         GbwFUVgrASblKET4Cf3oZ5xW5/ER6kMhJdUnXZ9A5wkqvB3/5ejSJLQZ/jh0zab7RzjY
         yKEPZ1yQFzPvu7TTv6dI3YKVEwnqSt11tEQlk=
X-Forwarded-Encrypted: i=1; AJvYcCWHHKgyINTHu2GBy9GWRvlKDntb+FDFRT0kZWziYnZA+gjob+daai/l/jxOzoct9Ip2qWhNveM=@vger.kernel.org
X-Received: by 2002:a05:7300:2155:b0:2ae:60fd:6f18 with SMTP id 5a478bee46e88-2b739b73f70mr262061eec.22.1769111031045;
        Thu, 22 Jan 2026 11:43:51 -0800 (PST)
X-Received: by 2002:a05:7300:2155:b0:2ae:60fd:6f18 with SMTP id 5a478bee46e88-2b739b73f70mr262042eec.22.1769111030538;
        Thu, 22 Jan 2026 11:43:50 -0800 (PST)
Received: from [10.63.25.133] ([12.75.221.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a9fbdcesm450149eec.25.2026.01.22.11.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 11:43:49 -0800 (PST)
Message-ID: <19c5a96d-e45d-42ad-9ad5-a967e1dd02a2@broadcom.com>
Date: Thu, 22 Jan 2026 11:43:46 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bcmasp: fix early exit leak with fixed phy
To: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
References: <20260122194001.1098859-1-justin.chen@broadcom.com>
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
In-Reply-To: <20260122194001.1098859-1-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252519-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E5F296D2F1
X-Rspamd-Action: no action



On 1/22/2026 11:40 AM, Justin Chen wrote:
> We are not deregistering the fixed phy link when hitting the early
> exit condition. Add the correct early exit sequence.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


