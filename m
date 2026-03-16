Return-Path: <netdev+bounces-268332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHVvHo+PuGnifwEAu9opvQ
	(envelope-from <netdev+bounces-268332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:17:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA242A1DF6
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7F0D30233F9
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB41D35F5F3;
	Mon, 16 Mar 2026 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c5AvQ3g8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F8234572F
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703051; cv=none; b=K2OY2CRT0DcZ4RwcbzgOw1ZqqL4QwRP164knpBjWuNHtdE5+PBe8r07OwBCtIgupZYb+ZWuHs3KlXboym9xoCfkyTBbXNDS8zctJ/iXfhQo5O/rOyIZyCC0eDB1eK0AD/hNgQ6BXSqklrYLZ4x4xTDI6bosZPso50nBF61ivJdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703051; c=relaxed/simple;
	bh=u23vRhoP38mirDK8Nq3M36j9TxSifKWwIhwmBqDy68I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AawZveGB8xSGIkY87ATh4m0rilx1GagH4dxsBLCyhbJ3Yl4wEqMeuKYSnoAstaWSNZVUwtsPnDxdhMiV94g43nDajXRPxLOsQeRWWWuj9XL8eTmX/QgQ9JPTcTpDxCNfwj6QTeu2q1+ekOCCx/BwQyyZgsytKNs2TQRci9Ymr5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c5AvQ3g8; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-8296dabef74so4879334b3a.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 16:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773703050; x=1774307850;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+nz+PqFthdwztwnT27UWrJGeyZrzhds1k+wT9hFZ/s8=;
        b=V2lM2zh924C6p1EuFvl3f85KxLPsvOE8it9d/xQJqVsJKWohVNP5rND85y4uonYENN
         bTgM3sI9ez+tZQ8u++GNPVJ2OCaMvg8O8RipfeWUCbwPfNiSuHPtUgVELQwg3CoPs2Ww
         h45a65bTzaGFcrjk8xQ5nO8STlbtyHAH5WMep9DHBLxKIBmDWGwlvitpMtKnWjoqKpUs
         RNRQf/OsnS6NS9lbZdE9OsXye1t9NpDip5lx7jLCxWQXMJITx/4wAoR1yfwvu6fXHdSW
         wuXhcvxotMa8r25NZKzeShRJ/Vkp+WF1Ta1eD1ruhpmegE/brKHVKmMyV3M1lSGqwATO
         Me7A==
X-Forwarded-Encrypted: i=1; AJvYcCXtGtcibk2httzNjvZpdcH+sYZ9dYex5kcE2GggHT0baN5cDBY6F0Apw0JpViguC7ke/FgQbcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0TGBk6t0bG95lkfMPnky7Ya5a85djFrpZDQ/0gV+PV2EZrWbe
	/r4sn4rz9RZjEYMSFYFSRhjeuUH0yDJRdUh2sMMA/T3JVwjEV0WPLjBh0H4/EBif5YI6WBRY3xn
	SLQ40M0rlATCX7P+w8PMGJCsV18qtGLDWHx+AyY0awG1tRc8JQ5Qsyj8zIex8Emm4oxDd1piVjd
	1Y3clLP7pUhArZk5Ygp0GIaF7+0EPnmg8FjmhtS7TzO14d7RqyLNh48w7O9Oe9jKXiQwS7V8yP4
	Qr5FnmJw668g0PR
X-Gm-Gg: ATEYQzypS48VlIELNC+/YWzfRl2XJ17TxyP+PsNN5uNpTRISOBXQA/rb6i5+PkS4vLU
	rMzZeQXCyTQhab2GjYwhEdopLNeWooOP9hm7i+au4Vofk4TUUajp1divGkOY3PvaABSEU9DR4/w
	TbfZ+lhWFGIV7CKk5rEDyYJVx56hVXFpk7693goEArGSwFjCveQ8fPAfmcXicv9o3pmV92otbfR
	z9ciVR/Xb6+tRCS67X1uvRiFJsJIOxNZsFZC0KDP109+jEdGGXjikW5W6LvAe5RF1d4U9ZdrdHt
	yFlmR+Cm50zPR3GrZw9Nw0NeGWBN2R1B4fVqTeZPMNmgPFTJa5EolFUL+HjR2xlPAmCTFTmdOTB
	78JHr2FHww2/cFSJsVhhhGDvo8vaH5BF+PsT2aFbYsi2z1S9Ese7mQFc8eERB+8mNwoQ7iPnaxs
	ahrdirQMh42dTtz3GcBld1HSlcrobxgYUM89Q8Xv2zmp5hPB9Zi2P6cfEdaeEDqsSp
X-Received: by 2002:a05:6a00:23d2:b0:823:1c3e:95cf with SMTP id d2e1a72fcca58-82a19704530mr14068394b3a.18.1773703049710;
        Mon, 16 Mar 2026 16:17:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82a0730325csm1978689b3a.5.2026.03.16.16.17.29
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2026 16:17:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd83cfb36cso1641089185a.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 16:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773703048; x=1774307848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+nz+PqFthdwztwnT27UWrJGeyZrzhds1k+wT9hFZ/s8=;
        b=c5AvQ3g8QRyoQZj0VEbUo3vwEor6jGS+TZt0iSL+ilejM5Jiwrzv/srkpOawCo0/T2
         mj5lOz0DAQuf2TdeO6KCV+EgY3Ae0osqh4MiMLwGnoHrqAu6OgAZvJ6NgkRUxm+DbaDM
         easngre2edkvsVlXfIIJneaPCtNag/1/muZnY=
X-Forwarded-Encrypted: i=1; AJvYcCVaG84Z9NUJxwKnwCQXoNy5+ftFimE2DfzQNK8Fq7VgB8IA8hiFrk8kZkBKlt6YY0txUvfOC6k=@vger.kernel.org
X-Received: by 2002:a05:620a:7002:b0:8cd:9091:3d5e with SMTP id af79cd13be357-8cdb5b7cd11mr1813723285a.55.1773703048365;
        Mon, 16 Mar 2026 16:17:28 -0700 (PDT)
X-Received: by 2002:a05:620a:7002:b0:8cd:9091:3d5e with SMTP id af79cd13be357-8cdb5b7cd11mr1813719985a.55.1773703047883;
        Mon, 16 Mar 2026 16:17:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1ff7642sm1524141285a.21.2026.03.16.16.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 16:17:27 -0700 (PDT)
Message-ID: <d6d952fe-499a-4863-99f4-3f761284aa1e@broadcom.com>
Date: Mon, 16 Mar 2026 16:17:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: bcm_sf2: fix missing clk_disable_unprepare() in
 error paths
To: Anas Iqbal <mohd.abd.6602@gmail.com>, jonas.gorski@gmail.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAOiHx==pVOOtvOb3eooRGt8EcwjTtkY-33Nn+Cu_m3pu2gVtpg@mail.gmail.com>
 <20260316132547.1274-1-mohd.abd.6602@gmail.com>
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
In-Reply-To: <20260316132547.1274-1-mohd.abd.6602@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268332-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EFA242A1DF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 06:25, Anas Iqbal wrote:
> Smatch reports:
> drivers/net/dsa/bcm_sf2.c:997 bcm_sf2_sw_resume() warn:
> 'priv->clk' from clk_prepare_enable() not released on lines: 983,990.
> 
> The clock enabled by clk_prepare_enable() in bcm_sf2_sw_resume()
> is not released if bcm_sf2_sw_rst() or bcm_sf2_cfp_resume() fails.
> 
> Add the missing clk_disable_unprepare() calls in the error paths
> to properly release the clock resource.
> 
> Fixes: e9ec5c3bd238 ("net: dsa: bcm_sf2: request and handle clocks")
> Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
> Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>

Subject should be "PATCH net", and you would want to wait 24 hrs before 
re-submitting, with that:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

