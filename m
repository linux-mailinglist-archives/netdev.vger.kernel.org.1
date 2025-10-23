Return-Path: <netdev+bounces-232209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FA7C02B00
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 19:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C447E1A07128
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3808730E0D8;
	Thu, 23 Oct 2025 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VMNfS4Ld"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3B729C328
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239703; cv=none; b=P5rwPvfisRSrhcexiF4J1bzGLqqUKm+81g2umyV6TxkS0BRXVbdJhPuQSc2ln7TP4qFR0ezSJhLYE2k1LyiSZo01OPvppXTWz6xRrwjNwal6iCcL/Nf4MzanK74qTqcfJRH6ozgID+bqzm05y/bIfrtp4kIQlIEfiqP/+dZXvN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239703; c=relaxed/simple;
	bh=xpyqE4urcjM8D5/gcCoUVHV0uooFCUzjPUtot4aamHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1lJNaOT5/956wt4oJSfzD60vX2ro+eDsAXV9GDOFkUHihX7qdkYeATTLEulV8yfVVr1d1sg6tfp0qWXeZ/nikigCLlm9RrcnPS6XrzeeuDZgvIuqeSyHQkw0bmvbRPXg4EtOANTEOO8VJzC2VVd2NlXOYwqdWJ9adUme4fzlI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VMNfS4Ld; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-893c373500cso113549385a.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 10:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761239700; x=1761844500;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPxNaEMIYukDTxjz6Ki04wfL1rNKy8pXkq3mZiePbWY=;
        b=ogeHUkymvWM8O8tYPwdnLhdWiSYU2B4VUeMnoNnZaFRSSD+L1loS1HCzSsKd0++Ikd
         aXKfbPHd5jvjewkQ7Am0x1xG1TZRO0+umRDU4GjBDbqbbvzAVCOxW3+Y4tFhx0TiZbaC
         9gKCWnqSUvcqdMorFEM6QkhxWLuxKgVgYLMjzAd19XSVio8IvvINoHHNQUP3UJtaNTE/
         C9IwiHxrMAeOC6oTJUocL3ND3mhuRj+RzhqBlNXB/G4asCKbtWA3Gz92MxQOFXPJVHs7
         fn3cufX8Z/XZRyptftnIae0yTY49JKSi9hJlshJsqfaErrddjPbY+4kjPFUbFbc9CvF6
         mrQw==
X-Forwarded-Encrypted: i=1; AJvYcCUURSp8n/hH18wWGi+twa1a2Ahdcj3dgVAPoinqsnrnbftLRsCrBi2hR3ZspCIiGPVEvrfiOfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUi7BbgCpFsi9HpduYEbjrJpFVYFPZFkp+NDTXIyuCGaOPy7rt
	JDBNqqjDLtcZhgR76i/PeqfpXwMd0mrE+XANI1jZKs1bUVmjl1cB5ZgYwerHKI7ZK9oYPdvidWS
	6nWoCf2mOk4zq7UE1NdlEXTocIzCu69uVgiCLHvx/18+NjdHRkkg0PiCDFPb2Y1P7/2RM+z1zET
	oHrWtpCuGXJC8F4azWLdLxE4YU/sUwAiJ0i0nqlUqfdIyPb/B+kdCL9SPPPr4HMNIb75Zdl0OTZ
	aHkuR2Lk4mneK/h
X-Gm-Gg: ASbGncuETHj/L6+CCuNCTIUBE4h3zBXkJs4mlZPhnLm2q8XA0RlJvkk09G4JX1ZSWdw
	YHGHw6MS+GRqI5A3mMSxyk+6C+Z6+kNzz+QDtiXWwXx3J4B7yTeBWEUsGx93+X9czmenw2WOLgu
	7sbwNxYD78GSRQuqr0BmkQB2T6vfx0klDtolZrYBoBdhGGjrB5I8LcbEZWgQmMsyMiGHMyiB/+w
	uHO7Rd6fPriuw8sAWmQH3Zh1lXdN6pyqzrbem7t/fZNhRzJi7PU8mA9jmuv8MrvPo4+uob+Zj0t
	K8k8vii7RM0LQiTOTm40YPQUPs4edmbO6x2xbVsiW2XuBgSkPi2ZUScvXmYoLfdgZlUhLLgzKH0
	aaeoBlbklq8iyH1yyoJ3TUTvEan5BwYuKXmGqYwGa8h99sZYZcBlaMf3So5nuoffdgOytagqTjl
	AMZHn4HcpUdrUrQD6VQa61AXdWTOvEjpgWvwQlC5A=
X-Google-Smtp-Source: AGHT+IE3YygTaa/TvS6tk0Sctfou9wwNipTKBTvrWkpIp3bQmexZvhbojQIms357Tp5p8OLKg8q4EpBzYZPl
X-Received: by 2002:a05:620a:700b:b0:7e7:fba9:4a79 with SMTP id af79cd13be357-89ae1ef1909mr765489685a.29.1761239700129;
        Thu, 23 Oct 2025 10:15:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-89c0dad3777sm23978385a.1.2025.10.23.10.14.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Oct 2025 10:15:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2909daa65f2so28095885ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761239699; x=1761844499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MPxNaEMIYukDTxjz6Ki04wfL1rNKy8pXkq3mZiePbWY=;
        b=VMNfS4Ld27o0H8H5ZwjXaNkCF/q6+VaTpZlc3lm+t7aU8hkCyn+pxv6ulUiN1EFr6p
         9CtAxDvqYkfy4SewazHUYNgfwOl1uU433MLWfrps/BSuZk68mZLHmf2B8fxFGs06xKYp
         jFM0RtOBd+o41i7BCGz8CvQmJBSIlolo4SiQc=
X-Forwarded-Encrypted: i=1; AJvYcCWjUxdtqk/TLRUV/ttnt6HXxpoSchnOg7N+rRdf2H7+1w1LUc7hPhsLyFUY4ISmhD7DYlIwF60=@vger.kernel.org
X-Received: by 2002:a17:902:f54c:b0:269:b2e5:900d with SMTP id d9443c01a7336-292ffba2f54mr98563595ad.5.1761239698887;
        Thu, 23 Oct 2025 10:14:58 -0700 (PDT)
X-Received: by 2002:a17:902:f54c:b0:269:b2e5:900d with SMTP id d9443c01a7336-292ffba2f54mr98563335ad.5.1761239698532;
        Thu, 23 Oct 2025 10:14:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddeb47asm28968535ad.25.2025.10.23.10.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 10:14:57 -0700 (PDT)
Message-ID: <1bbaa5ff-0819-41f0-9ca5-73de287c9d08@broadcom.com>
Date: Thu, 23 Oct 2025 10:14:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tg3: replace placeholder MAC address with device property
To: Paul SAGE <paul.sage@42.fr>, vinc@42.fr
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Michael Chan <mchan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251023160946.380127-1-paul.sage@42.fr>
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
In-Reply-To: <20251023160946.380127-1-paul.sage@42.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/23/25 09:08, Paul SAGE wrote:
> On some systems (e.g. iMac 20,1 with BCM57766), the tg3 driver reads a default placeholder mac address (00:10:18:00:00:00) from the mailbox.
> The correct value on those systems are stored in the 'local-mac-address' property.
> 
> This patch, detect the default value and tries to retrieve the correct address from the device_get_mac_address function instead.
> 
> The patch has been tested on two different systems:
> - iMac 20,1 (BCM57766) model which use the local-mac-address property
> - iMac 13,2 (BCM57766) model which can use the mailbox, NVRAM or MAC control registers
> 
> Co-developed-by: Vincent MORVAN <vinc@42.fr>
> Signed-off-by: Vincent MORVAN <vinc@42.fr>
> Signed-off-by: Paul SAGE <paul.sage@42.fr>
> ---
>   drivers/net/ethernet/broadcom/tg3.c | 12 ++++++++++++
>   drivers/net/ethernet/broadcom/tg3.h |  2 ++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index d78cafdb2094..55c2f2804df5 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -17042,6 +17042,14 @@ static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
>   	return err;
>   }
>   
> +static int tg3_is_default_mac_address(u8 *addr)
> +{
> +	u32 addr_high = (addr[0] << 16) | (addr[1] << 8) | addr[2];
> +	u32 addr_low = (addr[3] << 16) | (addr[4] <<  8) | addr[5];
> +
> +	return addr_high == BROADCOM_OUI && addr_low == 0;
> +}
> +
>   static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
>   {
>   	u32 hi, lo, mac_offset;
> @@ -17115,6 +17123,10 @@ static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
>   
>   	if (!is_valid_ether_addr(addr))
>   		return -EINVAL;
> +
> +	if (tg3_is_default_mac_address(addr))
> +		device_get_mac_address(&tp->pdev->dev, addr);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
> index a9e7f88fa26d..9fb226772e79 100644
> --- a/drivers/net/ethernet/broadcom/tg3.h
> +++ b/drivers/net/ethernet/broadcom/tg3.h
> @@ -14,6 +14,8 @@
>   #ifndef _T3_H
>   #define _T3_H
>   
> +#define BROADCOM_OUI			0x00001018

There are multiple OUIs that Broadcom has used throughout the years, 
they are documented under include/linux/brcmphy.h, to avoid any 
confusion for people looking only at that driver, I would rather we find 
a different constant name, or we just don't use a constant.
-- 
Florian


