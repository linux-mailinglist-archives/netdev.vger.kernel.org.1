Return-Path: <netdev+bounces-275657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ODeECbp02n/ngcAu9opvQ
	(envelope-from <netdev+bounces-275657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:11:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EE43A597D
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A7483012CFE
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB4E39023C;
	Mon,  6 Apr 2026 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Tn8/yZcQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB8B3321BF
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495459; cv=none; b=pRtdQIc0nu1926l9mTH1MqDk6J8383BiRvd2k0oKvGLd9APfPjfXbGp2kAak7WS+K/tcOoYRrR8U2fH2jrX8z/OG2xdPhwUyjT/6H3AWJzIwbnyKdz204FPmJk/W0DHQPvQOc3OVWUEPWVBEkdYzwxlc1OlyT6eN2Xfd6eDpbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495459; c=relaxed/simple;
	bh=0pSdF7qltzIaD1F67lD5KMoay4WFPkbvj35zXCBItfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlU187aKBaqFHdA3XfruZSoDEwPKNJkBE+WjscxGKhBoPz42EZa19r0BBpR67QucbH+EeUkrJEy29jf32Rl+uNTWbzTyKMACAAdQWUpz6xlgN5ReXN98BBqqLs/qivjZublFUd7mZrUXLjLOv4zdLp//7dR0vTuaz+ZeJMwWUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Tn8/yZcQ; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-65009bfdcfdso4274582d50.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775495457; x=1776100257;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WKkwSkgrg54xnZM99atDwyoSjpHQ8ks+nFdiA1+lKEI=;
        b=ZwtjbWSqJs3jCc9VhUzLmmJJLs4dHzOxu5zvq1/84G1Ig+L8NG3dcgG6KCp2pgAGRP
         /Tm07/LPbv4BO8gn/QhSj1tA/eyZrIzo/De/LEafSVlFAMEUjOLHMi1ZDIG6UqGTB33P
         O5rEZ9s4wBrWxCMaJ7e0aK3dy0YlredQhfDgApDMg65d8o+4+n6DgMcmdSrb5+JwnAwU
         6n/bWOub+qvEyupJhBIZiw2ayUBOWpLiPG7rU3xhYnN2w98JMJ1QkmqV26gopTrjw8ts
         4/uU9KZNDwYPMJWcPc0kMW+YwTdu+pkF7YkClYYtGLcSSPtxIlt839bKY4pP5W2iQgl3
         EzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVdxHBiuH6NdiXvUsgb0rsLvP1uSDgY7ehepSjf+idZJ+WxGJu20bkMbYt1JBYRDY7hBlS0hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnUlUP3hfE8GlJ2K6TtGjQTUjRilqmIOBjpPOf2Tue7S1OEEHi
	cf/cgUk4CAkaDaqQ0fjkhgwLHwI/RxWquW0Rp/AVfBVRK5UuSD7hs4vlLJRBUY7hPnd4uQD59+Y
	29feVEnjuYvjAHEo9QdbYwfZaH9Fh4Z1t5lQid/DIIUry1bTGQmelejjp/ZmZR5aZoOmMJmQQNa
	l6pJ5jM1eT+P0Rj8TQGd9BMF2dRJB3sOeuvqBI0Zy4WpBDOxl7awU3+y3qQvXFcKJgNb+xtAqtA
	+8JfkA6v7RLXSbY
X-Gm-Gg: AeBDiesn6/N1A+0o9321WiLYXNGhcE0n467ZywiYSKiXcotg9pa46WpsDD3uDrzjhtx
	UZlCr/EMF8jrkAvoRVbz/mDs17v5On/Q3qhj4ST5HaUMzvttdEPhQWRwKM+CBrhvG/W3RQ7OJbl
	1DjFAKNUY9zRKR2FwxBwouyI3fWkzmMrKhYdrbfhvzPvEnxUzkDY87dacgQqnDEPLHcqWBjU1C6
	1F2lLTJZN+SCDST/LZFd/kFU2REOUrTjuSDvegD1QsghmicgNmXEofIkXNR1eoSjOotO+539z/U
	Pf2EZlG5v3oBaUABxeA81cCMwl4X4Ts1X9TIBb1RGX/jBF5R3r5A5mfC5uAIowkM6QwgGxMmF2a
	1gvL3jTyj+dLCZUw4tcawvQggsVzneMi45xK+bdEMBjNV/3hkvQmRzzn+2Co7ei3yf3ibf5BsYO
	fePW47e3ej21MhEQqV41WusvoMybqs70cdZPtFwYjvI2Rdj79Bem2z4c0OxtAydg==
X-Received: by 2002:a53:ac82:0:b0:649:cd05:c518 with SMTP id 956f58d0204a3-650487ff506mr13106313d50.44.1775495456919;
        Mon, 06 Apr 2026 10:10:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6503a947352sm806242d50.14.2026.04.06.10.10.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 10:10:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso5809781eec.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775495455; x=1776100255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WKkwSkgrg54xnZM99atDwyoSjpHQ8ks+nFdiA1+lKEI=;
        b=Tn8/yZcQ/Zk+n94wNRTff1sSuor6U3xXTYHJpMDVdbB4ilFYgYz7g0LgaVxDuu6HzP
         8KVvAg8KwS0tjKHQv9DatkfT2OEhgzRSEy3cE5PNO/xSw99AKSrrmg6S5Y49oh/0LeVc
         rINpPA5hQ5HGO/wQAQn45PmRkUNW4eoIbxrF8=
X-Forwarded-Encrypted: i=1; AJvYcCVuvOcT14U+AXzwfmOB88fPz03l1ibTDBsuLjy9pRTsQ2plCHiEkRw7gukpErzRPwntMkX0M+M=@vger.kernel.org
X-Received: by 2002:a05:693c:2c93:b0:2d0:239a:23cb with SMTP id 5a478bee46e88-2d0239a26famr1645187eec.16.1775495455410;
        Mon, 06 Apr 2026 10:10:55 -0700 (PDT)
X-Received: by 2002:a05:693c:2c93:b0:2d0:239a:23cb with SMTP id 5a478bee46e88-2d0239a26famr1645139eec.16.1775495454438;
        Mon, 06 Apr 2026 10:10:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cf2be19f85sm5763478eec.30.2026.04.06.10.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 10:10:53 -0700 (PDT)
Message-ID: <b1670bb0-bcf6-4b4a-a35e-e8cd01177d19@broadcom.com>
Date: Mon, 6 Apr 2026 10:10:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/7] net: bcmgenet: convert RX path to
 page_pool
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>, Simon Horman <horms@kernel.org>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Vikas Gupta <vikas.gupta@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>, Fernando Fernandez Mancera
 <fmancera@suse.de>, =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>,
 linux-kernel@vger.kernel.org
References: <20260406083536.839517-1-nb@tipi-net.de>
 <20260406083536.839517-2-nb@tipi-net.de>
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
In-Reply-To: <20260406083536.839517-2-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,lunn.ch,google.com,redhat.com,davemloft.net,arndb.de,suse.de,blochl.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275657-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: A1EE43A597D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 01:35, Nicolai Buchwitz wrote:
> Replace the per-packet __netdev_alloc_skb() + dma_map_single() in the
> RX path with page_pool, which provides efficient page recycling and
> DMA mapping management. This is a prerequisite for XDP support (which
> requires stable page-backed buffers rather than SKB linear data).
> 
> Key changes:
> - Create a page_pool per RX ring (PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV)
> - bcmgenet_rx_refill() allocates pages via page_pool_alloc_pages()
> - bcmgenet_desc_rx() builds SKBs from pages via napi_build_skb() with
>    skb_mark_for_recycle() for automatic page_pool return
> - Buffer layout reserves XDP_PACKET_HEADROOM (256 bytes) before the HW
>    RSB (64 bytes) + alignment pad (2 bytes) for future XDP headroom
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

