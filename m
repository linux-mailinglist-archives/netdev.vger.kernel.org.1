Return-Path: <netdev+bounces-268258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJMtE7ZWuGmKcAEAu9opvQ
	(envelope-from <netdev+bounces-268258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:15:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C3C29F9FB
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 732EA302DB55
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F4D33C186;
	Mon, 16 Mar 2026 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YPjYEWGq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ADC40DFAD
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688499; cv=none; b=ZVkzwXBPySa/8vCa9YXWU7h8U6YvKhwC7QVPxXniu8r+dRazZFdTvzrt4opyqcgI+IWGisLl39bPY98VTB32YjIGQE/iHiWvDshuuBkNXIQp7FHPZj6u1Zp3/N8r/c1xogc+MsLXZd1HhK4JNLwFB1kW/GJbPUYyCKK1RRNhlFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688499; c=relaxed/simple;
	bh=l2RUckc+LA+qYeS2PCfv5ll2OoQ7cg0zAcJflcviVVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHL+Y7qHXbJejKy0ho5Siq4teCqmwkyKs3uOwJJtbh4ioHzFR45O9HhkbO0zGu6ufqw1FUjHSZHhtNsnUWwE+1Y0KbyB1M0sS1tQITAbxKlxOEQSZOXqIc6Brkwk58qN9XlA+jxDTQtUklNoneULOxR4VQrkDdCexcJCu3ao/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YPjYEWGq; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8cd7284782dso320806185a.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773688497; x=1774293297;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+W8/RIjjg4WP9hrfNS+7/4D2wAv5/ZjcISe8mQCT/9U=;
        b=QSnANTV4gFKor2e+oo/0YDVs1x8Kg5sTSWiSvHzEMRWHefgM4D+vWIMbAYb73/cpwe
         veEJHAI0VpbqPIOH1la6dFD0i+X7JQCszIR0VlQln0vaiBtYe22+I+ta/zTbmvu8ldbx
         aevvOJuytgi3Z2Fp7c9/zwrDczuCcy8G3PgjTKPaPCtzSMfLsO679qYuZu1sxX5bJX4R
         OKpjLpRB/hpdZqWDgyh6EAlhGghXo0jp+FL/r3caS6oRjSGHI8j4WeR16+VXhdfkUftD
         zBHWvaRLkICpKPkjBjk9c3W22jAPaJrx2cIOV9fR1e/XPmClbuM95Wt2dwxxaM0h5ffJ
         Lw7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyA25fMfDNauHoj3WPnZ9v48eTHCICLWgKagDWr4o1edWh+ZHHt7QqMhApDuWRzWr0Mp3zzKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEJgZV81q4l5jVVga15xqYlvea5yfdxZUHu8CfhwGujiLz4Yi
	UaNDhvzVJvlEamvF9Q8TmAFlUTd/WTHCCZJfvH+Ma0V1yo7KgIqHJMSszSqdVopdNThU+0SAWzZ
	gNsjqj9DNFXhw4eL+5fbYpoMDzptdLKK9a2JLWXjUhKrQOdDHvcheyNz2od9P8ynp0ITPB8rcPp
	s+6jamJ4XrPqo3lb//93287hifSuAfCeYSpW3sdj9y9K1kzZWRtyj8flcUbUnN6FFmBfBAhqIXW
	zTFLwhZlKmHK/+G
X-Gm-Gg: ATEYQzwodFOYxX/VeSTIcHHXNbSsn6qbWG7OyMMQGNkFYTGbHB7UxXzZa4ZlOQdfivc
	/g8Ot5U07Uai0z7Xk0fBS3L9BPOVzXubNMSs2GzGUpCshIUuT6kbv4j+ObMHQR++dcs2T9Hw19P
	ZL87gDDyXJQnmUdfwJYVDIDp8ijL9Krg4vdAYf57CbKc/4OmwLpNVi18XSr/e9DrDzvNKOtlU7I
	+chDsIvID2/OPlnNtxHDPSqopwszVR2yR/uoPKTCnWt84Re9roBaORCTtK3vXDnDsNlot40CeSA
	v8bHAVW9cymcyk9jRiGS5OlvfHKQm8T5XvLk949p+IOa45zBdBFY6AoSYHLtZ5V42K1E2/hmi7K
	Xty8E670twfycbMFyYZBoqjeDbIRWXmtXNofsMxNuJm8ze4tY4EXakyuFdzfnLVhdrmsrpJfGN2
	/moLVS5L4Ovoh+CKe3DFdxKmQVIFVo59J8cu7/fXDlhUADhtUFvvaC3awi4C2dZQ==
X-Received: by 2002:ac8:588a:0:b0:509:21ce:1a9 with SMTP id d75a77b69052e-50957cb6081mr197065271cf.10.1773688496764;
        Mon, 16 Mar 2026 12:14:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89c5482a471sm2873176d6.28.2026.03.16.12.14.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2026 12:14:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12721cd1a2aso21463840c88.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773688495; x=1774293295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+W8/RIjjg4WP9hrfNS+7/4D2wAv5/ZjcISe8mQCT/9U=;
        b=YPjYEWGq4t58Sx456JjeCr3vZphoMVLwk28Hcp/zT+Lx5QPbSVzw5kXzSMql95080R
         7tnryauC808jUyTXat2/Mi5jwtJUNzxobrSZ5T7pw6CZreFH0P+VP3N0jV3OqJPe905L
         ixBgn6SF72V+srqYefqYmzw2GGn/9gMJTFgaE=
X-Forwarded-Encrypted: i=1; AJvYcCWkoQhcjMahHFnthVzD2hIGwbGOczqTiyIBef9QKHYkYuZ3lnQIKaW6Gpm1QOWX/tLR/wJEEL8=@vger.kernel.org
X-Received: by 2002:a05:7022:239c:b0:124:9dea:188d with SMTP id a92af1059eb24-128f3e1280emr7688096c88.30.1773688495343;
        Mon, 16 Mar 2026 12:14:55 -0700 (PDT)
X-Received: by 2002:a05:7022:239c:b0:124:9dea:188d with SMTP id a92af1059eb24-128f3e1280emr7688062c88.30.1773688494513;
        Mon, 16 Mar 2026 12:14:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62837ccsm17024146c88.3.2026.03.16.12.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 12:14:53 -0700 (PDT)
Message-ID: <b63ed1da-ea55-49a7-8e25-03f85535d51c@broadcom.com>
Date: Mon, 16 Mar 2026 12:14:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: bcmasp: fix double disable of clk
To: justin.chen@broadcom.com, netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
References: <20260316180202.3371477-1-justin.chen@broadcom.com>
 <20260316180202.3371477-3-justin.chen@broadcom.com>
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
In-Reply-To: <20260316180202.3371477-3-justin.chen@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-268258-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A7C3C29F9FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 11:02, justin.chen@broadcom.com wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> Switch to devm_clk_get_optional() so we can manage the clock ourselves.
> We dynamically control the clocks depending on the state of the interface
> for power savings. The default state is clock disabled, so unbinding the
> driver causes a double disable.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

