Return-Path: <netdev+bounces-267634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJGrHEuUtGmBqgAAu9opvQ
	(envelope-from <netdev+bounces-267634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:48:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1888728A881
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80D8D30066BC
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1746639768C;
	Fri, 13 Mar 2026 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YL+Xzecm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFDD384233
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 22:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773442120; cv=none; b=oWQOB3378xYTg+UX2Uw6UORD8kSsmSAnfxhrnDp2z4A4GuvaI+XfY2ccYwEA97qAz932AR/Sghhn/9OlTklLZO1lvfaAGHa2Zw+PfPpg9k9YHS6qX1DeOEbKBJz+FInjHykD33GiLCt5hiddlR7gl1t+CU/nKLkcty/PkjUSP4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773442120; c=relaxed/simple;
	bh=k7sRZjep4Pl5nGo253/uSYed2ycRs08gBT9ck3+RJg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEy/VNEyn/5eHXcCbsn5NjQLp1H9WcyEjKABPp/QJzpwLJKnvSLTEJ5b8IA8yOkbWdM6y3q3vZ+lFWSXU0jIqZdf2zmD/g1JFuQJs4rY7WB9MbKfPiNd3hZ9I5Dzkffiu4gpcRtW10FtEo8S/jdc0Oita3bpbqw1xAMSN0y0/Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YL+Xzecm; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-8cb40149037so299027185a.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773442118; x=1774046918;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AyfyTnnei5rK6RAUwWwpGmxvvM7+xZXb2sEOU+VWGg0=;
        b=DfwOKZSL1qgNJcRyM0ucNAjUA8WAGg561YutMeiGz3Jnl8VPZ2ZUrUB8Mbg1OU3qd6
         B6VSIiQK6asI29/5EiLOCfj2DabU++3Tl5LoUBrCnSbV1EBw6i501B3yxGfuSf0vVDny
         GlviMUrS4KaVSr2Kak/yQ4h28qEfPziqJcbibGU0oAzIN1LpGquce7RMZ23qCTpLlicY
         l+AvCtEZrZbRZoc97qlaa0DyB7watu2KGAWAojlJJDPSbvlNcSghvsWgA45oNhCAg2VN
         y+jZ7oARwhp7EGzFZoRnmJsjUbqQnkG4rkhJ0dsdTjrdEiWV3veKA2voyy3P7YVUYNYN
         vg3A==
X-Forwarded-Encrypted: i=1; AJvYcCV7rPCeu8i4ayrzu0DWseun7gN4r32Zb9Cxl13nh/o6tDBkEhoDmyw/ovF4ew8dSoWLvBFzsF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlBttAbIKva9azfvRXv45jxVoBY7G/EtKbb/xDuxqxOM69Tn2O
	84fFZuC3wJ4u/5utHhYWuCgZXbJ135Dl+cr6eKNFVRpKp3YKpctMvolCsTxvXKJydRpLzIzpFRR
	/ineCBYYu3nX6Z7EgDBMs6js/Clm7+L+pjrH4TJgfE0W1A0uvxe++gXWEIh3MVvB3kDB8dfqG3E
	bw2djaiK+E+Dfm2trDzPjRpopLhY6PfffUSkoS8cOO2U8G/EW17lsafKOI0apffxhdPB9igWJtp
	KfEiSJ1yaXKdP0V
X-Gm-Gg: ATEYQzyqVaPe4wc73gSQmzdB6vpUIJoPe8djd5YIDQgYpktkeTQVjz3imkuIOfdUAZ/
	2/gZ5vKVmMskttmgagAS7A1tg54avz41NDWeg+7yRcNhU88WSn1evg9IR2w2lp9xr74uPRL+xO2
	r5s8iM9DhKlC1LCPdNWl4E01RSzgaOFs2u9AdV+6qec/IXbxj3Vv4RTgIO2WJSSBXhn5QEjCEDG
	Suual1oLtrGIQnb165CqrfGgHPN62gKFRSat2xdP0WR0o4AYx+/vsaqaLAPd8s8Nk6LxuvoctMF
	ATZIUi+XNo83mMz5q5NKgizZFpYgafoQ+A+BgdgP3naTil0ghj2TUnd+g4m5t57Jb+hfJWRKB1W
	XBghtmUzpmUxdZGLOOAxu4kmvCYCKcgUskjmChYLhlA1/gS+n8FYn9DLdDtaqjb0pLtY7NSZWPR
	np+sIYbPUMsrynBswySVV/Qj3H1N/BXYz0VWXEwQXar3amg2By6RmGTr9bm+YfKQ==
X-Received: by 2002:a05:620a:1a01:b0:8cd:7685:760c with SMTP id af79cd13be357-8cdb5a0c359mr705765685a.13.1773442117638;
        Fri, 13 Mar 2026 15:48:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8cda20ed697sm89931785a.8.2026.03.13.15.48.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2026 15:48:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50920055f0aso184615631cf.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773442117; x=1774046917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AyfyTnnei5rK6RAUwWwpGmxvvM7+xZXb2sEOU+VWGg0=;
        b=YL+XzecmB3Ze2wyqRR745wGZp457cnrkOyebgEC9Lq4Xt5MScRYciuBFecDjC0L0+z
         zaoRU+2kQ6JGO/136a7sctJL9o5QCLZtC+M0yJoTz7kj0mFtnIA4Rzggj98NOg+bLbkN
         abGpGW+pb5RxQL+oKFg1QZFYjL+AUc6bMuYgE=
X-Forwarded-Encrypted: i=1; AJvYcCWySO2KX/NufNMpzuZ0J8e9sI5vVyNunQr5+szeiZgVKwUVOMlGjgP9oj1YGk7/9oIVSh/p5T4=@vger.kernel.org
X-Received: by 2002:ac8:580a:0:b0:509:3dfd:ab83 with SMTP id d75a77b69052e-50957b90a43mr67948551cf.7.1773442116715;
        Fri, 13 Mar 2026 15:48:36 -0700 (PDT)
X-Received: by 2002:ac8:580a:0:b0:509:3dfd:ab83 with SMTP id d75a77b69052e-50957b90a43mr67948241cf.7.1773442116175;
        Fri, 13 Mar 2026 15:48:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a11cc4esm73940211cf.27.2026.03.13.15.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 15:48:35 -0700 (PDT)
Message-ID: <e3d33a3e-9552-4f2d-99b6-76a1e203603d@broadcom.com>
Date: Fri, 13 Mar 2026 15:48:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] net: bcmgenet: add basic XDP support
 (PASS/DROP)
To: Nicolai Buchwitz <nb@tipi-net.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Doug Berger <opendmb@gmail.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
 Eric Biggers <ebiggers@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 =?UTF-8?Q?Markus_Bl=C3=B6chl?= <mbloch@rooftopnetworks.de>,
 Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260313092101.1344954-1-nb@tipi-net.de>
 <20260313092101.1344954-4-nb@tipi-net.de>
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
In-Reply-To: <20260313092101.1344954-4-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267634-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[tipi-net.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,rooftopnetworks.de,arndb.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tipi-net.de:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 1888728A881
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 02:20, Nicolai Buchwitz wrote:
> Add XDP program attachment via ndo_bpf and execute XDP programs in the
> RX path. Supported actions:
> 
>    - XDP_PASS: build SKB from the (possibly modified) xdp_buff and pass
>      to the network stack, handling xdp_adjust_head/tail correctly
>    - XDP_DROP: return the page to page_pool, no SKB allocated
>    - XDP_ABORTED: same as DROP with trace_xdp_exception
> 
> XDP_TX and XDP_REDIRECT are not yet supported and will return
> XDP_ABORTED.
> 
> The XDP hook runs after the HW error checks but before SKB construction,
> so dropped packets avoid all SKB allocation overhead.
> 
> Advertise NETDEV_XDP_ACT_BASIC in xdp_features.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---

[snip]

> @@ -2345,12 +2397,6 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>   		hard_start = page_address(rx_page) + rx_off;
>   		status = (struct status_64 *)hard_start;
>   		dma_length_status = status->length_status;
> -		if (dev->features & NETIF_F_RXCSUM) {
> -			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
> -			if (rx_csum) {
> -				/* defer csum setup to after skb is built */
> -			}
> -		}

Did you intend for that hunk to be deleted?
-- 
Florian

