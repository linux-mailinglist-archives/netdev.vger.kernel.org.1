Return-Path: <netdev+bounces-252945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLYIF23Oc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:39:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B977A398
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CBDE3005164
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6301891A9;
	Fri, 23 Jan 2026 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Csx4BJ6m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B545E3EBF0D
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769197000; cv=none; b=kyy5mK46mGxCqVCkbnaM9ZlcCbHh45qFD1CCgQ6CH56OVnixPnhiafJC8f2SoDAGti0Nb4jUUKOkxBYU5RrUXwXT3NHP7VPJZST9GGIRaXD37cF7ebgejRudQKshAALF4vOmNRdD8AnaOR6qIeCgLZXf4Sek60/DH9V77eqLoZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769197000; c=relaxed/simple;
	bh=VP80TV9x7hBMHLBKbN6C6pATLm17fdgVCPYtSLNa5VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFQmRAAZFDfsuVlM6/GVffjBjPNInnKY5zixl+8d0ATgLPye7N22WOgquOuwQ52AX4YWuH8JNHQZaDJvNp7OQ7cyl+9Drs5e+NyxwqoALyCLefrVRQ6Q5c8RxhBH/oAqmRWhxUN9+/CjCMytwcJ8ZDlIp1R2R3zS2I6U+fYKiag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Csx4BJ6m; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c61343f82d7so1060401a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769196999; x=1769801799;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DNLMiJVCelOv+j2L4SUZ7y6cwqxK+16XQRKJ8SDGGx4=;
        b=orZdIqU5qiZs1Zky5RzCH/gSl99oFdpSKUTCn+Vk1gqW/2u+RBQSrC1Hu5IIMhpjjm
         xaRmGDOut2cy3Sw/wjUpSZnUBmYNoE5sWpLEFk74wMW64B8kxzS7nfcLUoR+R1LpmkZJ
         bXIXjzpmYNF8BGqup9djtAP6rrp4bIG/QvLhGtkKz3ClrQ8x+m9t8U8/krF8yvNf2JdG
         jt5rEzExvi/fXrHPtRMoRegfCI16Jwyyw7StE67LQowy1+vnN5afVgBZ8UeS1m19zhUs
         eLlAhOY44Y4RhpmKVJe0x+qMUr4tmyg5k52YrqAi/lRA0HVCrtOo7bgsR65C2IEjrPw/
         BfZw==
X-Forwarded-Encrypted: i=1; AJvYcCWUtrxhObg5zSpgaou+K8XoSdml/7eZ0yLqfBPEdLKIyEaAY/VZqahyWKpSAntwZ4XyQ6F/9BA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIVZFYX+j7ybDPzpUJwixBY+h7WgXFivx2WVuehGGYdirF723n
	mkQoH4a0Y5LqR8UvoNiul95GDO+1BH0de448XLymMbTq3dd5CnOqqxjY6zTtASZmsDKhdF/vNv7
	EaBRT5fDbHonThQ1dWvpLO+829KJbDDj8fKbL+ow0sQ1CXRbTWvPuc3fvRU8ciyUbrHac5oQyRP
	42a3nN2tLL36AZV4pEIaDx2ZRgft4bg6kBQ3uIf+nJxCSxXVPELnJhdVXT2Y35y5SGb8WSo1ddY
	+tizb5iSyTm+h/s
X-Gm-Gg: AZuq6aKPGR+2tWnFJuNXCxUYn50dd1+quC6AK53O9IwqbJBdbjkQO8CkQjkziP7wTMF
	3arLQ+cx6DqSGdT89UICoQV3GeZk6VjCItsx1vNezTZO3hDhcIKWH+vpt0WG8YSrvgJd6CZ8K80
	ph1feRrkLdj+4Z5ELJGwEUoMy59dcGbbFz6OcfdpMHbJ3CNlHR7pBuNCF0Vf2nT6/h+Gcoj5YLi
	aNatkJJRQACKS54D+bWdhG1NfjEho+X33qPcr23KSH/E5fzcUd9/Mid4lhxjL1bxoaEVGaO225f
	0axnH7iZuRamyQ6hjdGx468M6p1b/mI3gOekrW5/SWnHRMmd/LIuCVoAuUt2deYKgOoSIUHxg2t
	IR1MSjr2PSpnQjh7BmRn2xmRa9jXvyN25+WWLhkGK4z0GNj7eMqQoYixnGK3MBHVx2XsmHGjLKZ
	MceD5l/XF6bOeyWbTmePJ7Wa6gcyS7lHzVEqKtGL/66ikq1RWSdg==
X-Received: by 2002:a17:90b:2ec8:b0:341:abdc:8ea2 with SMTP id 98e67ed59e1d1-35369411bb1mr3187423a91.37.1769196998868;
        Fri, 23 Jan 2026 11:36:38 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-353354ba8b2sm903534a91.6.2026.01.23.11.36.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jan 2026 11:36:38 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7cfce4218caso8061069a34.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769196997; x=1769801797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DNLMiJVCelOv+j2L4SUZ7y6cwqxK+16XQRKJ8SDGGx4=;
        b=Csx4BJ6m/N0VRJUUv0gcczK5wl0EMC8HQBCCOZMFHRsbGVbE6n7BZ2GH2Dn6WSVXF/
         fJ3EYC2KmUYTTx5yXCWDwEQVqgsjGOSb4OhTLy9D/+EGuVeqMt8Ngw2V+zEnM+Xnp/7g
         NepwMlSilYNGpvp1HrTSPKx6nEj6+rf3iYGCk=
X-Forwarded-Encrypted: i=1; AJvYcCXinr2pSEx9isgm7gAPaXE2euq9d/4CGqWAdtfwEFDvKk12YYDKm/93rEL38YBh6NwdOk6uMYo=@vger.kernel.org
X-Received: by 2002:a05:6830:2786:b0:79d:eccc:96eb with SMTP id 46e09a7af769-7d15a64be54mr2160490a34.26.1769196997273;
        Fri, 23 Jan 2026 11:36:37 -0800 (PST)
X-Received: by 2002:a05:6830:2786:b0:79d:eccc:96eb with SMTP id 46e09a7af769-7d15a64be54mr2160466a34.26.1769196996948;
        Fri, 23 Jan 2026 11:36:36 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d15b3e2f4csm2417311a34.30.2026.01.23.11.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 11:36:36 -0800 (PST)
Message-ID: <7ab606d1-9f65-4123-827e-58650eb8944a@broadcom.com>
Date: Fri, 23 Jan 2026 11:36:33 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: ethtool: Track TX pause storm
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: alexanderduyck@fb.com, alok.a.tiwari@oracle.com, andrew+netdev@lunn.ch,
 andrew@lunn.ch, chuck.lever@oracle.com, davem@davemloft.net,
 donald.hunter@gmail.com, edumazet@google.com, gal@nvidia.com,
 horms@kernel.org, idosch@nvidia.com, jacob.e.keller@intel.com,
 kernel-team@meta.com, kory.maincent@bootlin.com, lee@trager.us,
 o.rempel@pengutronix.de, pabeni@redhat.com, vadim.fedorenko@linux.dev
References: <20260122192158.428882-1-mohsin.bashr@gmail.com>
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
In-Reply-To: <20260122192158.428882-1-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252945-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[patchew.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 81B977A398
X-Rspamd-Action: no action

On 1/22/26 11:21, Mohsin Bashir wrote:
> With TX pause enabled, if a device cannot deliver received frames to
> the stack (e.g., during a system hang), it may generate excessive pause
> frames causing a pause storm. This series updates the uAPI to track TX
> pause storm events as part of the pause stats (p1), adds pause storm
> protection support for fbnic (p2), and leverages p1 to provide
> observability into these events for fbnic (p3).

Jakub, should I go ahead and re-submit this patch series then:

https://patchew.org/linux/20251107002510.1678369-1-florian.fainelli@broadcom.com/

Looks like this is exactly what you ran into here.
-- 
Florian


