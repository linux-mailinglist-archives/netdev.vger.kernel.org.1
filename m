Return-Path: <netdev+bounces-236513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC897C3D786
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 22:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F4C3AC571
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 21:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BD4305E10;
	Thu,  6 Nov 2025 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b5JzrfDd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B72305E05
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762463876; cv=none; b=nif+F6tAGQ0p01A72CpPDELPLMpJPq8HNEDBlSl2/l9gcwu5M2i13YVKhWTFBhSo7n+z6wJ5kUHRqzLu7zyoyzj3UfGfUX+BrO8d2B9DSCGrPFC6rZwyXrQu6xGd1oPnYEIV5gl7GtpfVw5P0rsvirai+D8+trfh0keyXrXesds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762463876; c=relaxed/simple;
	bh=zeV5pygef1wyF/lJ9ko9Ct1bLGUnJuj9ngVBugT6rW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVgIhfeb8GRdGum+5KI26OGhZ+kWjJuzbthpB4FWSXHG2ZZJIvge9w8c0UEGW4WMm23t763TU2Ckt5R0J4rQn3d03KI9A/mW+iyr6Xs7xZ0Al1dz5Uc3n6LWgmow9hZ6dRfxQljOPWFOO1LVNhvBoUU5633PrRbRngfrUhTPNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b5JzrfDd; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-940d9772e28so2801039f.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 13:17:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762463874; x=1763068674;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9qh6M2+2slNp/Eaqs7CKpAs0otSPjZ5PWWWvvqphD0E=;
        b=Pw1aF/92PMR+47U2b/gXMO/0qx+ulI2EctX9qlEH1kKEWyg15SCHGHhjX4DR/Df3K1
         xDWCxuHfeOTh8kE9QmbH8nLmS3ya/KnBfhtOQrCUq4BoQTtCIxxOEhkoJ/DZoS1igvfD
         KJQhteIffnFFz2LnqPniPoyiZQwWoEeOIugd5Kuu7CIRZXLTBN1vqOXzsSu0NBZAiZPA
         F6w8IPHGrFs5hZhtipFP83vTn1GJqlDSeLliPWSf2M/x1loBTfbkeY8fAz/xseRdBVrH
         IkrKO+hCDRksCY2KUqIVU1JCjWNP/Vt9mFfGEeTqlPnEJafURLpTUXKoGLrCTl7GEgvx
         QUsQ==
X-Gm-Message-State: AOJu0YzTnEFQO8qp02cO+Wx2D2MPIR7Bhc49zk+G7sd0n0yleT8f3Yl7
	SaxBOSFbBdAVTFA3SGrYnctafHZhBrugeMt+8gaaqearoqQ6XRJVJJy4dBgvl6AL/+Ebt3gCQys
	qvep1MtbAq6CCmYVewvNrV5rhBH5iDeEKZNuIYImKV50O6jQXagWhVSJClzp8xUDU3yWSiiQ3wQ
	tfnl/bOYRPT9Q8hXxX6XyCNfrMhBbxIX/dAnoh7Gc7azzT1zyYGJlRNGMJxyVmG/I6OP60I9Gxt
	4MU9hWPEyCkFiUU
X-Gm-Gg: ASbGnct5uluJlcwOsX/uYIbpBOu+AlrnYcDBLIWuFrwyqjYDGr1AY8g7eTORiYTK5HU
	Shg45hhUuobaH0TyxgpwUSYsVlIR7bn9YfwUmvwD63rEl5ZXAnGdv47PfHEZgrbsXKQlT8uJEi1
	sKZWUYqBT++zA/2keL9yzedY26gkFi58vxwL8/v5DSC+gRM+YtmCP4sO/MYKFimsn/MWejKz0EO
	rBVv9oN3jW3mqwaaZy2TNzoK8rMoM7R4K05narG+KgWiyyekx3Mmd53q66yUENGMxm3hCYQ/qsL
	lXyUh//3oqPsLus3FJ+jJMkFBieYUDAcNYTpibnu4fqsCW5y95ZgJHECQScyzDjWxB9p5GmQHyB
	f84CBK7il89Jutd9qdP0FhDCC5JF7OS1KBOPzVi6VhJq6mS1DSpTTGu1Rf6kavCFQkWneS3R4O6
	PT6v/C4CuGHw60xvMi5es216fThq7SRlWuROpWNYI=
X-Google-Smtp-Source: AGHT+IH47VS+56wfX4UECqd64NtYXQUgzsfMqfMwzcgRePkZNg5uY8wxtsfLwlh1y9YG0w06PXCcdxLF43Vb
X-Received: by 2002:a05:6e02:148a:b0:430:c777:5bbd with SMTP id e9e14a558f8ab-4335f46f684mr13102365ab.31.1762463873645;
        Thu, 06 Nov 2025 13:17:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b7468be4b4sm419131173.40.2025.11.06.13.17.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Nov 2025 13:17:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b1c1d39066so17256285a.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 13:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762463873; x=1763068673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9qh6M2+2slNp/Eaqs7CKpAs0otSPjZ5PWWWvvqphD0E=;
        b=b5JzrfDdLeLAvFNJwlJ7KBXF32doILcZrZqRa463Mj4Ani4PEYFUe3Xf6QZ/sLe5YK
         x6iyI2MYDdpf8osrkAF5L08o4Sei1Ve3kmtgWHzqCYIgWbrm6EY0GCmZvL6ULyzVp8Xw
         N6qfQ0RDA/bQ8xHpS56j3NdZdkCy5B1Q9/CB8=
X-Received: by 2002:a05:620a:294a:b0:8a0:8627:30b0 with SMTP id af79cd13be357-8b245339b21mr164834685a.49.1762463872813;
        Thu, 06 Nov 2025 13:17:52 -0800 (PST)
X-Received: by 2002:a05:620a:294a:b0:8a0:8627:30b0 with SMTP id af79cd13be357-8b245339b21mr164830985a.49.1762463872373;
        Thu, 06 Nov 2025 13:17:52 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2358287eesm270270585a.54.2025.11.06.13.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 13:17:51 -0800 (PST)
Message-ID: <f0eae1d1-f845-479a-8388-a9351e9467b0@broadcom.com>
Date: Thu, 6 Nov 2025 13:17:48 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] Allow disabling pause frames on panic
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Antoine Tenart <atenart@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Yajun Deng <yajun.deng@linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20251104221348.4163417-1-florian.fainelli@broadcom.com>
 <20251104155702.0b2aadb3@kernel.org>
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
In-Reply-To: <20251104155702.0b2aadb3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/4/25 15:57, Jakub Kicinski wrote:
> On Tue,  4 Nov 2025 14:13:46 -0800 Florian Fainelli wrote:
>> This patch set allows disabling pause frame generation upon encountering
>> a kernel panic. This has proven to be helpful in lab environments where
>> devices are still being worked on, will panic for various reasons, and
>> will occasionally take down the entire Ethernet switch they are attached to.
> 
> FWIW this still feels like a hack to work around having broken switches
> to me :( Not sure how to stomach having a sysfs knob for every netdev on
> the planet for one lab with cheap switches..

That's understandable, we have seen it with any sort of Ethernet 
adapter, GENET is the one that we have the most deployed, but we have 
seen that with Asix USB Ethernet dongles happen, which is why this made 
me look for a common solution, rather than a driver specific solution.

> 
> If anyone else has similar problems please speak up?


-- 
Florian

