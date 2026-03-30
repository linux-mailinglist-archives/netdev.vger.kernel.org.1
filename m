Return-Path: <netdev+bounces-273337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDSIJFr0ymmlBwYAu9opvQ
	(envelope-from <netdev+bounces-273337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:08:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1214361BF5
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4176D300D941
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026893A63F8;
	Mon, 30 Mar 2026 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bb2nCFnj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299A1A9F9F
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774908101; cv=none; b=TNBDRHDdiEfTKN8AwdmeDTo172bH8BoDY6W/3R4Rufkp5o0ZJVfyHVN/Mk0VrRMK42Fa5PlBNrHpBW8fSntJthYk2MV9F1UU4dD6tkFDXHNg7iYH3TbzokypclW9R0qe8lnDbbPljYa487C10jm3MPHMx8gveiHX+BAVrKF+wfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774908101; c=relaxed/simple;
	bh=SEcggzMQPlBT4VfcXD93RHhGaIq3bozFKGxfmOBi4E8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8AdC4IcVrU/7bOVcm4Apv2ojzyUpB5zaHk68s7Pi1c3CUSsN0giGA8rHF06hrXWEWYL1D7tXfH1Al3otd6Z6113pUmM2TSIiDt51gsyTEqFjUnz6pNh/Y2koCu11/FSlQQCIiL+89bjfY/idI13lJAJK8L4FCphil09n+lAd9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Bb2nCFnj; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so1308203a91.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 15:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774908100; x=1775512900;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CtdGhRlX3HJBZMrHLz+B9bjBl7r5J98b1F9YuBfP76o=;
        b=bA+HI20RDK7HkO7cU2Og2oDFH2p/LQSiGcAPeOuzIMOHi/OG3QQTSAstsSKMP6msU3
         8u2EUOrjLiBME4lUY3bXxx11oWxVwrs9SLBUGG3V/vgpIJDUgYXkg6QkjiFz08nvzJdf
         GloNzXPNaBr6R9O0NoHLOW112wJrEGkuRhVafsgAHOlj+7MoA8mlmOw2nBeokyz7Dl69
         c3kW1fQ9hi3FhFPyEDPOL6+HtOSH0+EuyZ4Nk8ZuhDUmFfiWTKbrSCs9xsgxNx4yU5/h
         HWdY8SpUwhNfe/z/kayC0hC2AZmIXjXudoIDwTC41oINE5P62hnsJ4VEvtEIy0J6fJvd
         vluw==
X-Forwarded-Encrypted: i=1; AJvYcCV6zL44EziW4umSa6NvJZp2fkLg/eIXbhAt3s2uzeavTGIUHcuiIsswplqRl6gEFvmdHlDg0v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWkqiHFgIWXJpfIdqPoAvQPSK7hvclovYMf5wVBjV24xUj15q3
	xYf9dmzUMPjXaMh6eb7JPnIk6lUPzaHKqBy3jSk0IdscFekWPd0YH8pLxdYx1UTs/nkn9mGtHXZ
	5s+1cclar+2/pL1jq8gocZIvbV95DYjBSK+4qYvAeYo+juJXxr5d4l/qvFBEb5FCszA9nILUd3K
	pfzr9lfSBH6ag8jemeQnWJJMr/w5PtOkBwD+rNyMd3GfXn8DnrRcVvdh0lI5UwFSXTbPOB+S3bJ
	GjEV5cvVMvmu8hv
X-Gm-Gg: ATEYQzxDS92aYyy4/GYLGGNcV8IL+FXCYWtvO4Lh0U8KeXPG+mKCIK+EiEjFkwsiPkv
	FrftTckdaRmcBYwAtBpIIJZgdsb7/1bRwKujabi9BoAVqVmYfWv9oCRLt1qg2+OlsHJHZ/tVofR
	tw0DiEesKWeZwXjnU17GWrNi7Z5GknS9JuVnAtiXdcJubjd10ehu3OkAKRZbqYPVWO0qMh+4tZY
	DRU5koLRu8wTc1rznybjttuMGLos9MhrpQBhY1ggEzf7xV9Mak4sSs406N3pbvs8f7U/Fwo1o+d
	/KiQsDwAZNCErTDQONDEpPsmfvo+0hm7SpikkGYP9aLFXmycZjUueHcKtFY6haEn5WR9eLaFA8N
	WrTvBulsGjc2eeNzwyZFteeseDpKuahMgadru/Pc/3aHikZrDscWIUXn07D5936d1G7sBbnflG5
	jRexs7bves0zf/3miwn+pxynf6PDQqJsPXU2+DaYflQoPC96jnEJ+y6nPP3EngxQ==
X-Received: by 2002:a17:90b:2ccb:b0:354:bfb7:db1a with SMTP id 98e67ed59e1d1-35c30145afdmr12493123a91.31.1774908099818;
        Mon, 30 Mar 2026 15:01:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35d9504f309sm1021213a91.6.2026.03.30.15.01.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2026 15:01:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so6205513eec.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 15:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774908098; x=1775512898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CtdGhRlX3HJBZMrHLz+B9bjBl7r5J98b1F9YuBfP76o=;
        b=Bb2nCFnjt03EJnlf2Q4WUWsduLMViRaR6pCrVuiJqK1QpPsSZ1Bq5be04Zp7LROIBD
         odBD3/WTx0uW7M8iZvjlllUl2drNPJSzje0+7aa7fGAIApWcjyc9lsnLI3SSmeflVBCj
         Bz11/B6NNzMVvMnQIoVGISiMR2hOioYMTtxGU=
X-Forwarded-Encrypted: i=1; AJvYcCWqon/myk44apmg4jVUuIf2sxKCWkVTOLyVDGLgsEfRz5yuQ4Aj9thg8Rwd6UkxtbsxRZmBJMs=@vger.kernel.org
X-Received: by 2002:a05:7301:1685:b0:2c1:2706:b41c with SMTP id 5a478bee46e88-2c185d5371emr8115409eec.6.1774908098140;
        Mon, 30 Mar 2026 15:01:38 -0700 (PDT)
X-Received: by 2002:a05:7301:1685:b0:2c1:2706:b41c with SMTP id 5a478bee46e88-2c185d5371emr8115378eec.6.1774908097535;
        Mon, 30 Mar 2026 15:01:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c41c1513sm8659766eec.8.2026.03.30.15.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 15:01:37 -0700 (PDT)
Message-ID: <0332755b-ed58-46e9-8ffb-9a09d688f3c0@broadcom.com>
Date: Mon, 30 Mar 2026 15:01:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phy: bcm84881: add BCM84891/BCM84892
 support
To: Daniel Wagner <wagner.daniel.t@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, bcm-kernel-feedback-list@broadcom.com,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>
 <20260324190601.1616343-1-wagner.daniel.t@gmail.com>
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
In-Reply-To: <20260324190601.1616343-1-wagner.daniel.t@gmail.com>
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
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,broadcom.com,kernel.org,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273337-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E1214361BF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/26 12:06, Daniel Wagner wrote:
> The BCM84891 and BCM84892 are 10GBASE-T PHYs in the same family as the
> BCM84881, sharing the register map and most callbacks. They add USXGMII
> as a host interface mode.
> 
> bcm8489x_config_init() is separate from bcm84881_config_init(): it
> allows only USXGMII (the only host mode available on the tested
> hardware) and clears MDIO_CTRL1_LPOWER, which is set at boot on the
> tested platform. Does not recur on ifdown/ifup, cable events, or
> link-partner advertisement changes, so config_init is sufficient.
> 
> For USXGMII, read_status() skips the 0x4011 host-mode register: it
> returns the same value regardless of negotiated copper speed (USXGMII
> symbol replication). Speed comes from phy_resolve_aneg_linkmode() via
> standard C45 AN resolution.
> 
> Tested on TRENDnet TEG-S750 (RTL9303 + 1x BCM84891 + 4x BCM84892)
> running OpenWrt, where the MDIO controller driver is currently
> OpenWrt-specific. Link verified at 100M, 1G, 2.5G, 10G.
> 
> Signed-off-by: Daniel Wagner <wagner.daniel.t@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

