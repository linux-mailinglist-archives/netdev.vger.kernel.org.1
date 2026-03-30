Return-Path: <netdev+bounces-273339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Uw/VH9/zymmlBwYAu9opvQ
	(envelope-from <netdev+bounces-273339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:06:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 737A5361BD5
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 221EF30148A8
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5603A9623;
	Mon, 30 Mar 2026 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P4X5DeVZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A4A3A9608
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774908374; cv=none; b=sBzKhLZmAoH/v9Ocn5nPr84EFjidASbNqQgMLWK1169nhEXlntMVqZ/Fj2U2hl9eopAYDz0dphkQ9HWw4/GylQuGfHvYmi2zb/tE6PFz4trJv1OTLGDUedhYiEtZwvPsTOntSrIyR2uSPuq1HwoxFc8zKC4Lplq172qSSOZ88Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774908374; c=relaxed/simple;
	bh=/nlF0x6bBiFja0NOJnYySQcEMlNQ05KgKCz/9OtXkfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eekz9U3aHlok25L9hjUK8npkm2EG4+389klsUHSCAg+OvJfPH7mvOm36/KsvHYvDBkz6dlB7z2N2zfUCKcFiYD85pl3PDJRpS0x2f/V1ebtP6FqRHyq9S6ls6uUsyw+8VCqwuJA0ADBgyHTmo7LuQ/lmBxJ2ag3pjtpgGcG84XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P4X5DeVZ; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-56d3fa1ea69so1485575e0c.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 15:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774908370; x=1775513170;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wazMMCQ25eiP79G9aIROHWVXvvxGSf4JuL+1u5LyYKw=;
        b=AJo6QsgP2YjB90cL6oxeC1+KtW2PjKEBOQJWhV8aqKudGUOntmU0M+2bkZDlvp1R+/
         qqhvd8mokNqvhHy/Fyy/MD9wZkHPEXE2dBaEMY87x+egHJprKVzvOj3tcO4z2mXB9AJ+
         eKfdImc8t9GFzvgbARjL1lk3pQaVSF9NYuX/Wo9evbL7sIJHt0OB7Q96gCBdROCcteuZ
         /3vryC9rA/LWf6PFR50FwxKQsaNrcnWuB4TvhKFvAQ5hlNsdUQStAGsKJAHYDv7Br3Cg
         34nu5e9A0lHWpY2D4hFKFj/W4Weyb5e7FF64e3U+OjcUfEXNFMdkdbN9RkYvr2J8Qr5D
         tMhA==
X-Gm-Message-State: AOJu0YwrpEXQNbWDWKLVv869Vrhm1jaOW8EZC0OR6y2Vrgn8BfuqQ6rk
	S5NgEAqIkH5jAO8FreDxeuRKVHoJASlZTcr2+aczyL+rSxjsgyhOxSv932cSetv3PqzSdOkyLxv
	h4kSl6Xex6S7x3Wrv1TTPC1PGE0JgTGYnWPgIiZXL0VcdoItQGhIXuIAplZ/LVpa97kUFqVuXhJ
	01edMp299lAipSCJgHq1Fap1yw4USOZuVMw9Q+O0ufUY0r9LVgx2zYRd69s+6WkRPeCrGMZqpq7
	/sCrqo+ecfMNC09
X-Gm-Gg: ATEYQzz1mEeHAer8Eayebh7MQ7H/N7mAJVU2fIZkx/Ch9jlMdyv1OsQvEEwjZmo+ARO
	uu45dqBqXO0j/QD4WfgTG+z+k6mu822tLUmcOUN5iUUXiwT4Bixi9eS3ybFr3GQptdWPBecr92X
	m3SSE0nQID2dj5qlEjZWnxC0KppMJStNQ/Cz2miBmEoYUqi+e4bK3pTUkhZi9QeS8DWjURZecr9
	P/2Bp+PcbiWXQSR8cuD2pcK4hoqLkXm7MzYW6+cAIvnOHwja2UvHgi2gdU8d00svXODzouAN3Jd
	pT23W/VZUgy3i/BoLgpyiiJyrxIoo27VbxQzZ1qIf/7R627vMvRQaUVIdCb0BQCTrzpKts8HNSf
	QMZ3mt79bkpMpkAPPshLg5PQ2fMB9AsuWUfSjGLLLaANd+nPc57ovOD2r93VEQVITgPzFU8EABS
	BIHoAe/nYARtOH5GiPiLMLMELWcPY7kC2di/xUvHL01PqZRir9blHHVfnlBVfj/w==
X-Received: by 2002:a05:6122:3a0e:b0:56b:9083:4335 with SMTP id 71dfb90a1353d-56d4a68aeabmr5990562e0c.16.1774908369827;
        Mon, 30 Mar 2026 15:06:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56d589e69ecsm1119230e0c.6.2026.03.30.15.06.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2026 15:06:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso5266368eec.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 15:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774908369; x=1775513169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wazMMCQ25eiP79G9aIROHWVXvvxGSf4JuL+1u5LyYKw=;
        b=P4X5DeVZU6t2nP/KyI6c8nBmLY2DXHH8ZYx9YoqLFMp2vaDEWjvWbc40Fqn+gx/qlp
         GfPaB7vmWeGLEaUUEM8I+zeqZjD+XNFg7CCT95nP4YRqEXDbnmZiSCQ5YNXtPqm/qXbT
         dxHaGwl0UDm0n/5KmozkwOyCtQZEs0HzOE7RY=
X-Received: by 2002:a05:693c:310c:b0:2c6:cdb3:bd67 with SMTP id 5a478bee46e88-2c6cdc30cd2mr2625845eec.22.1774908368703;
        Mon, 30 Mar 2026 15:06:08 -0700 (PDT)
X-Received: by 2002:a05:693c:310c:b0:2c6:cdb3:bd67 with SMTP id 5a478bee46e88-2c6cdc30cd2mr2625818eec.22.1774908368152;
        Mon, 30 Mar 2026 15:06:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b249fsm8196653eec.19.2026.03.30.15.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 15:06:07 -0700 (PDT)
Message-ID: <99062602-05a3-418f-9182-f60a83fdbe3b@broadcom.com>
Date: Mon, 30 Mar 2026 15:06:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: bcmgenet: add basic XDP support
 (PASS/DROP)
To: Nicolai Buchwitz <nb@tipi-net.de>, Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260319115402.353509-1-nb@tipi-net.de>
 <20260319115402.353509-4-nb@tipi-net.de>
 <1d551008-3c42-4b7b-9507-03072740a54a@gmail.com>
 <56270d59e5e5e79fcd3d104817679d70@tipi-net.de>
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
In-Reply-To: <56270d59e5e5e79fcd3d104817679d70@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273339-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[tipi-net.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 737A5361BD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 15:01, Nicolai Buchwitz wrote:
> On 30.3.2026 20:15, Mohsin Bashir wrote:
>>> +static int bcmgenet_xdp_setup(struct net_device *dev,
>>> +                  struct netdev_bpf *xdp)
>>> +{
>>> +    struct bcmgenet_priv *priv = netdev_priv(dev);
>>> +    struct bpf_prog *old_prog;
>>> +    struct bpf_prog *prog = xdp->prog;
>>> +
>>> +    if (prog && dev->mtu > PAGE_SIZE - GENET_RX_HEADROOM -
>>> +        SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {
>>> +        NL_SET_ERR_MSG_MOD(xdp->extack,
>>> +                   "MTU too large for single-page XDP buffer");
>>> +        return -EOPNOTSUPP;
>>> +    }
>>
>> The MTU check here is great. But I do not see support 
>> for .ndo_change_mtu. This would allow users to change MTU size AFTER 
>> the program is attached.
> 
> Good point. I had planned to add ndo_change_mtu in a follow-up series, 
> but this leaves a gap where MTU can be changed while XDP is attached.
> 
> Options:
> 1. Add a minimal ndo_change_mtu to this series that only rejects MTU 
> changes incompatible with XDP, default behavior otherwise

Option 1 seems to be the simplest yet getting you a path through merging 
XDP support.

> 2. Reject any MTU change while XDP is attached
> 3. Defer to the ndo_change_mtu follow-up series
> 
> Thoughts?
> 
> Thanks
> Nicolai


-- 
Florian

