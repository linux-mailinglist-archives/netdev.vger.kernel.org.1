Return-Path: <netdev+bounces-275661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHFVMM/r02nInwcAu9opvQ
	(envelope-from <netdev+bounces-275661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:22:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B253A5A65
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55AE8301AB8A
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B7E38E120;
	Mon,  6 Apr 2026 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IP+Tp+fc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314D3372B5A
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496132; cv=none; b=EMuhEyB87PwXXWbv3v5rwMT4Sy3+1LVGX6Nc0mLu4zN8vMUPsR9lIn9WO+HscPObXiNH36CdbJtEMmqP/QTN33CT78zVAUGSOyI9lQatJYuVI51zJ1o1oje1vBIrT6jxVXGZmRmShUObtEot/KuBSBOoTf1IqjaN2EjhcdsyW/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496132; c=relaxed/simple;
	bh=WfuMCEoItKRep1b96WzqTVNcTzp1Eg4IFNJG3F1hgIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cU7gAxsa5m4UOHcCbHfopVtpRIiVs09HZVT9kbO58BIf1i94mKrE+XgKmVa2vgcL0Dj3RAMs/cMf2FL66wg38qCaqSPECvxG61s3IHJHXt9iuk/RubBgC3bWvCd6VeuJK9mEeJxmphYJ/caYrycotiMvvehnM79uHOSfm20Nhyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IP+Tp+fc; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-6501c4857b2so1766234d50.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775496130; x=1776100930;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KZPyrAH1/pZMd1gNEecdyNA5qMgHpZZXyuSSEngXuII=;
        b=SYF3PR56ShEwZ4jLhFdKFyVnD5ERT8becTBuaJo3JC6K9UDqxfSiRf1zfUEm8Gi+HI
         DVr8pK3I2crErkIpczsbSTZjmJJVsma8CI7gatm0YZcKxiSsg+cYvH63O2lN/KKl/TtI
         h+VmsDBshAi1iTLiAzw9Im1dII9J1rfGc5sCEVn0iBZ2qZDjpzM3i2c4CJ0GwxUXnOM1
         ko8JaXbQulAfWbxQdrRW3twnlMDkKFSmnalnPBOsZambr7JqHW+SHXvTCKa0Pqhe/Huf
         mppH9/aCJjD7g+qR1f9qsIfKesV/WI8j8QG2+T3z0UEygOrJ89ytT1T1LvvXknka+NNb
         We7A==
X-Forwarded-Encrypted: i=1; AJvYcCWfTIMgcTChXCxIqXzAoWbfoJTXP15LGHBvMgJrtxyorpRyFL4WlP8be1OZsHanV9QYMR+3C/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO4xr9B8eujUmuNMj1uTmhZX1/GDCNFKDIvTgT6jhVPsWrFUyv
	AY+v+zAW9iO+MRgPL/RQpFAiQYLdpRoyMo5URL38E4Ob5ghbQ8KfLudL+PNYZEimnWeyY7nnF0P
	ZiTd3eC6nuBzAp6UzIkvWKXDnykPYAUT0/50plCEUDa7/A51QQ0sfVduRqcma3BpOIsc1N7Y2Dg
	mVG+El18Guk22/kcRkOPijXV+x8wttAgP6D1wkJXIzsZTjCtgpOD7hS43phyCIQtgamvOiscC0j
	aJVRPT4pd3wW/Of
X-Gm-Gg: AeBDieusbx5HmQ477A7mTtbuVbPSnO2/vQG8c4HGHC8eyhV3fLHx1+fFD2n9aLUXAJi
	st1bv7ZP0ZE1uzwzQiCsgLC+6vkbqex3fT9TTm030HcrTwJM4MkINvlMsHXTLlHjQIUzcpUALpv
	Z+ot+z/7nPwHVpCcRhpsUJz+LU/ebnI3IgKc20MWUsx+Y28onA8+eP6KflUaqsNTn9xtJVSarOE
	IxW/AubNlS5gE+zXC1XYd6a7FuXN1WE5uz8/Qj5DSVbFb+X83taPvt1MyIk885PclX09EUuPCNM
	wGxxgLsOUb6wydf5+uroD+so7Xikqf8OIgyYr/MBzsdP8VSgfxV1qfA8FmbORc3P9grsJ3mIlyN
	wHxDMdmKV/d7cijJABYuNWhEzehDaTgaTNUZ/QLF0KI2wQfxo78EJBFskqmq7eVUIxIQhPR7ii5
	7WHN43jv/WLXPgIoKxmWRgWgwHJnuEkZxZjEC156DxbUxMics32dyYG/JL+3RPrA==
X-Received: by 2002:a05:690e:1586:20b0:650:379f:3580 with SMTP id 956f58d0204a3-6504873f163mr10097632d50.21.1775496129387;
        Mon, 06 Apr 2026 10:22:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6503a80a3c1sm828041d50.2.2026.04.06.10.22.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 10:22:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2c4cfe08c9dso22973779eec.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775496127; x=1776100927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KZPyrAH1/pZMd1gNEecdyNA5qMgHpZZXyuSSEngXuII=;
        b=IP+Tp+fc9a8wVg4ge/xEuA1LaEWhE/eAZ0tfZfR+RBU9+9wMgg8dEfkXM3/CKsca3J
         rIxVU/9vg57NIMJxkdIIR+3bmtqB3L59ZJTpSF4iNgb3r7Bgqlm7yjNsZeVQeemtC2mY
         rey0Bfp2nDhd04bUblPJY8RSCORI2/CFT4ebU=
X-Forwarded-Encrypted: i=1; AJvYcCX1XVDwTki0hkKvs2enpTNhRuXBylV/+i3Vm5x4ejreOddQ+pdmEEg0NqWK0V0gE5SVjJ2Gi0M=@vger.kernel.org
X-Received: by 2002:a05:7300:e78d:b0:2c0:da6f:55e0 with SMTP id 5a478bee46e88-2cbfc362ac8mr6057412eec.27.1775496127454;
        Mon, 06 Apr 2026 10:22:07 -0700 (PDT)
X-Received: by 2002:a05:7300:e78d:b0:2c0:da6f:55e0 with SMTP id 5a478bee46e88-2cbfc362ac8mr6057379eec.27.1775496126727;
        Mon, 06 Apr 2026 10:22:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ce39d13decsm6017020eec.8.2026.04.06.10.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 10:22:05 -0700 (PDT)
Message-ID: <eb33745f-da92-4182-a1f7-5167a2917732@broadcom.com>
Date: Mon, 6 Apr 2026 10:22:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/7] net: bcmgenet: register xdp_rxq_info for
 each RX ring
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>, Simon Horman <horms@kernel.org>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Doug Berger <opendmb@gmail.com>,
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
 <20260406083536.839517-3-nb@tipi-net.de>
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
In-Reply-To: <20260406083536.839517-3-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,lunn.ch,google.com,redhat.com,davemloft.net,iogearbox.net,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275661-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 81B253A5A65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 01:35, Nicolai Buchwitz wrote:
> Register an xdp_rxq_info per RX ring and associate it with the ring's
> page_pool via MEM_TYPE_PAGE_POOL. This is required infrastructure for
> XDP program execution: the XDP framework needs to know the memory model
> backing each RX queue for correct page lifecycle management.
> 
> No functional change - XDP programs are not yet attached or executed.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

