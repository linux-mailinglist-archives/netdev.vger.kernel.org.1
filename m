Return-Path: <netdev+bounces-264791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC7BH4DUqmn3XQEAu9opvQ
	(envelope-from <netdev+bounces-264791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:20:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFEF2217A9
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79742303B4ED
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 13:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE8F3921F7;
	Fri,  6 Mar 2026 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RyueQTB7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCD38F7D
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803197; cv=none; b=pGoA3JCP50F4zcp3H/aXlGyVwJfMR5jufoxDHnQRXPSkhM2me7BKajKxLNCeb6M6IHvu9VJeD0CF639aazhorYOpfXk3lKm6udnq9WCuT3VZEeOJtczMlQXDVH3wMWt//v4usP0C3RQP1LgEbQFZRXyc/+0Lrxq/75+jbmjjUWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803197; c=relaxed/simple;
	bh=YAN3zX6k38QN3ZqpOCTj8ybcaAgX5y2uZkCzL+UzSlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYVZfj/l2k0nSKJAa4u9Sp+fTitytHbVDIrvLvboUjUBtqy/7AnyBBHHRtr9xquUoMyxL6vz7CgCiI+gEeKSarT1HeYjDRvMVmvYvWAM95HlTaZiYFjM+MGVVdb5NdCvwAgJBMtp+6bkg6UQP3hYiBC201kHAVaV9bBzNbCMPJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RyueQTB7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48371bb515eso137104825e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 05:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772803195; x=1773407995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WH0SOE1yPGM5d8oENv+7AwzPu1v6mjGPGbIBBCX+Bqs=;
        b=RyueQTB7V6zceVpiVAXGNj5ydtIk+0sV9UiVbc1d//NZjEhoNIZQ6G2EIarjGJju0U
         4od1uQXcoJccB0SzJb4upescOESA7XOAWzxJsOvC5OIuGjqFQCRHOyLU6KBEiKV7oKpr
         vZZL3m7M95WdLQyNnnQ08j6Oj0wOvOahniSjQB9b9ZgqSk8+jzSJglqQXdXOzkmCJHDA
         L5vCY0hzJ+DUtBUXv/7QNCcNSBG0qz/hlUgvwRqANHEAsqaX3u4fuQwNmbjcpIQYtjTn
         TsO3VYDCKNobzR2MRV5cV8bMlm1VF0b8JREBERsacnDWzIZFCXVYF4aDvApnIOA8GMvI
         tP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772803195; x=1773407995;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH0SOE1yPGM5d8oENv+7AwzPu1v6mjGPGbIBBCX+Bqs=;
        b=vitILQ3S6yk2dnIMR1E0Vk+lRHo+fSpWQfq2o+mLk8eur9rO3LXJ6eUBxQK5wZkQFp
         HSewzYPEErVS39ne+u9ZfUTrNmAN9CsH0TlO7iRvonrIInkQsx4/bpeyVWNPGmzy3vCF
         7m4Kcz5ljPDSilpSJqLCeBhuyyTs1OvG7vYFzmKaSZcHW+S9px2zTsWKvtNb6hi6N/hD
         +pl8sBvboVlpmEgaRzmKVUfjI+OnJit7TOjm8bkw5pCRRN/5MGwUw11vqcnT89net1Hz
         gAfnxwhQYHrSsezKENer/s8Yh2wRs/HnRfFvsDD2WyP7H9y/TDDHc5lyZu3sCd/OonZo
         GYfA==
X-Gm-Message-State: AOJu0Yz/BZyc80uDeasvoqD2xzPj76/FLG1ub6dk0cc+zUPpIwbndMOU
	2nK6aoXsvbKxtackAq1E/71+9t4SzPFZVaDICFghEYq1W7fiIcS00dqDcplAMB3YQmw/UzP1pEl
	hIMdI14mTzSmLtlRTqhHMDVrmaB5OUJ18mTZSD10aiMR1fW1AP2c=
X-Gm-Gg: ATEYQzwRA7jW4+ZdqlHRLGL3Q6tOhBu9RgeM6i5Yc8HRj3K2fTGAJqzFsMbdq30/244
	oH8aE5B4y9fSLB2sOSazS/gb4rI81yykB+O9hbGViAC68xW3QXwpsy244ElMCw+b2gdSDwCspue
	O7N6n94yYvBU1pswXzYV0WsduXiO1rxXm3VPdygHN8EjfmAuVgDHkLfl5iVG2SdwjqQq6yYzN1c
	W9QYP69WZUggP3zIoyNu6OkuOxYhZ0oQzZlbNzGw/fTGF0HDN8msHS9CMLNNhr4SKJuGLOwEMnf
	lHpojYsHco9Ewc9eEngByxlLgSYwx0VVrJK9M0pa/AEds7Uon/874HlTTzq/1DgCDLpfB2h1hBA
	0KuEMgsMAeXeJScmHqWSpdKtwrPDip7ctChnYuYjAcfhR26klastEJpDUGcCzC6CDpgyo8/ifhY
	t7ReuvCMvuZhh6ua/BR2Vq70UMxjXsTrMFC9skHkXihUP5SlcARR8+9ACfrpjvvA==
X-Received: by 2002:a05:600c:1e2a:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-4852695819cmr32763805e9.20.1772803194821;
        Fri, 06 Mar 2026 05:19:54 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:e1e0:441c:b462:d279? ([2001:67c:2fbc:1:e1e0:441c:b462:d279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48523817244sm18887205e9.10.2026.03.06.05.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 05:19:54 -0800 (PST)
Message-ID: <029b28a3-2375-46ba-bfe4-6eae82301fd2@openvpn.net>
Date: Fri, 6 Mar 2026 14:19:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/9] selftests: ovpn: check asymmetric peer-id
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 horms@kernel.org
References: <20260304230643.1014-1-antonio@openvpn.net>
 <20260304230643.1014-8-antonio@openvpn.net>
 <20260305192001.1e70393f@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AYGGhrcHM6Ly9rZXlzLm9wZW5wZ3Aub3JnFiEEyr2hKCAXwmchmIXHSPDM
 to9Z0UwFAmj3PEoFCShLq0sACgkQSPDMto9Z0Uw7/BAAtMIP/wzpiYn+Di0TWwNAEqDUcGnv
 JQ0CrFu8WzdtNo1TvEh5oqSLyO0xWaiGeDcC5bQOAAumN+0Aa8NPqhCH5O0eKslzP69cz247
 4Yfx/lpNejqDaeu0Gh3kybbT84M+yFJWwbjeT9zPwfSDyoyDfBHbSb46FGoTqXR+YBp9t/CV
 MuXryL/vn+RmH/R8+s1T/wF2cXpQr3uXuV3e0ccKw33CugxQJsS4pqbaCmYKilLmwNBSHNrD
 77BnGkml15Hd6XFFvbmxIAJVnH9ZceLln1DpjVvg5pg4BRPeWiZwf5/7UwOw+tksSIoNllUH
 4z/VgsIcRw/5QyjVpUQLPY5kdr57ywieSh0agJ160fP8s/okUqqn6UQV5fE8/HBIloIbf7yW
 LDE5mYqmcxDzTUqdstKZzIi91QRVLgXgoi7WOeLF2WjITCWd1YcrmX/SEPnOWkK0oNr5ykb0
 4XuLLzK9l9MzFkwTOwOWiQNFcxXZ9CdW2sC7G+uxhQ+x8AQW+WoLkKJF2vbREMjLqctPU1A4
 557A9xZBI2xg0xWVaaOWr4eyd4vpfKY3VFlxLT7zMy/IKtsm6N01ekXwui1Zb9oWtsP3OaRx
 gZ5bmW8qwhk5XnNgbSfjehOO7EphsyCBgKkQZtjFyQqQZaDdQ+GTo1t6xnfBB6/TwS7pNpf2
 ZvLulFbOOARoRsrsEgorBgEEAZdVAQUBAQdAyD3gsxqcxX256G9lLJ+NFhi7BQpchUat6mSA
 Pb+1yCQDAQgHwsF8BBgBCAAmFiEEyr2hKCAXwmchmIXHSPDMto9Z0UwFAmhGyuwCGwwFCQHh
 M4AACgkQSPDMto9Z0UwymQ//Z1tIZaaJM7CH8npDlnbzrI938cE0Ry5acrw2EWd0aGGUaW+L
 +lu6N1kTOVZiU6rnkjib+9FXwW1LhAUiLYYn2OlVpVT1kBSniR00L3oE62UpFgZbD3hr5S/i
 o4+ZB8fffAfD6llKxbRWNED9UrfiVh02EgYYS2Jmy+V4BT8+KJGyxNFv0LFSJjwb8zQZ5vVZ
 5FPYsSQ5JQdAzYNmA99cbLlNpyHbzbHr2bXr4t8b/ri04Swn+Kzpo+811W/rkq/mI1v+yM/6
 o7+0586l1MQ9m0LMj6vLXrBDN0ioGa1/97GhP8LtLE4Hlh+S8jPSDn+8BkSB4+4IpijQKtrA
 qVTaiP4v3Y6faqJArPch5FHKgu+rn7bMqoipKjVzKGUXroGoUHwjzeaOnnnwYMvkDIwHiAW6
 XgzE5ZREn2ffEsSnVPzA4QkjP+QX/5RZoH1983gb7eOXbP/KQhiH6SO1UBAmgPKSKQGRAYYt
 cJX1bHWYQHTtefBGoKrbkzksL5ZvTdNRcC44/Z5u4yhNmAsq4K6wDQu0JbADv69J56jPaCM+
 gg9NWuSR3XNVOui/0JRVx4qd3SnsnwsuF5xy+fD0ocYBLuksVmHa4FsJq9113Or2fM+10t1m
 yBIZwIDEBLu9zxGUYLenla/gHde+UnSs+mycN0sya9ahOBTG/57k7w/aQLc=
Organization: OpenVPN Inc.
In-Reply-To: <20260305192001.1e70393f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CDFEF2217A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-264791-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:dkim,openvpn.net:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mandelbit.com:email]
X-Rspamd-Action: no action


On 06/03/2026 04:20, Jakub Kicinski wrote:
> On Thu,  5 Mar 2026 00:06:25 +0100 Antonio Quartulli wrote:
>> From: Ralf Lici <ralf@mandelbit.com>
>>
>> Extend the base test to verify that the correct peer-id is set in data
>> packet headers. This is done by capturing ping packets with ngrep during
>> the initial exchange and matching the first portion of the header
>> against the expected sequence for every connection.
> 
> AI asks
> 
>> @@ -2204,15 +2217,15 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
>>   		if (argc < 7)
>>   			return -EINVAL;
> 
> The CMD_CONNECT case was correctly updated from 'argc < 6' to 'argc < 7'
> for the new tx_id argument. However, was CMD_NEW_PEER also updated?
> 
> Looking at the usage text, CMD_NEW_PEER now expects:
>    new_peer <iface> <peer_id> <tx_id> <lport> <raddr> <rport> [vpnaddr]
> 
> That's argv[0] through argv[7] for 8 required arguments (indices 0-7),
> but the check at the start of CMD_NEW_PEER still requires only argc < 7.
> 
> With argc=7, argv[7] would be NULL according to the C standard, so when
> ovpn_parse_new_peer() passes argv[7] as rport and calls getaddrinfo(),
> the NULL service parameter would silently produce port 0 instead of
> the intended port.
> 
> Should the check be 'argc < 8' instead?

Right. Some rebase went wrong, sorry about that.


-- 
Antonio Quartulli
OpenVPN Inc.


