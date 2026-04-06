Return-Path: <netdev+bounces-275660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPWUMqzt02nInwcAu9opvQ
	(envelope-from <netdev+bounces-275660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:30:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7D23A5B3A
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 032E63009392
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C0B390CBC;
	Mon,  6 Apr 2026 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mg0ch4EQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C52388E5D
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496023; cv=none; b=t8Aw2wH5scUZpEXXJLd+Mi8eYfLRR9AiN2VIRKywwRkni05Jcr6WHa5fr4XbyQtRELxC1y3+mlff/C0sFOwe5wlkSSxC3Y9XjVjMJXZYRn0RkTgm3NRbISNF3VXN6JL1sodSXQnk6jofdJq/MFKJm7210820DgtiYboytGIdJNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496023; c=relaxed/simple;
	bh=qzaH8m1FQQvseH1i2VcsREALPFcUfdY3t26JGB+mNQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRgHbvE7HUiXgAfjbibAfPaIwGWL4rU41ydBuimvUwBlRxhAei1Cn0YlHnGHD+exuV66YATeN8084ggTBKMclFT+l5zuE0ZKPOxa+tUloraxWL6rlxW6SLz45jAyilDYlWZzySYo5cgBaDC/LBSTdS0h/FjI6U3MndIHY7INM0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Mg0ch4EQ; arc=none smtp.client-ip=209.85.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-682baaa9f1aso752233eaf.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775496021; x=1776100821;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ak/8YrDC0eJbLQIfMmaoVpPiz4Stv8t/FxXd5vdbs8M=;
        b=AqNsYXxoybh1pT9bv6eg80IijrkZX/oDlSJj/OjI5bfeKdtRsONMeszm7yRtOBYzQh
         b+Lw4TibZAtD23p51HqwGSCb1c+43rdttG7iogxv8s4CD2mKF8H1ncyMzlVJqJZpeSEq
         OGuy+SmwUtIEUzBU4tQcShhFIVS9SfUeq1q7hULtMysiJgbONmt2eIoPZvKQnSobhXbf
         8NpMiuD3aHF+vvruNgZ9CLMtycR/hoopLI/pQIsTOdXfCUV13TKJ1Iuc8S71wRltc8vE
         4ACn8U/H9DxdjbFw4BTC7Y7yEcLnO1xnDDFDC9H6tbS3NPGjsTqA9an14YNqCzOMNUUk
         abeA==
X-Forwarded-Encrypted: i=1; AJvYcCUUeHOZPdu2TCPD+545owOsd3JOxW9rVe2SpEK6T9pNgos0y4Pj2zUxhxFVarpfA7SecikyZgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGiUT/cHVhvwR3gVZNCm7iOrFkrMhgre6ssq91JVedkycLvB9V
	/2afuoTgsnQfC+tpMAE7XYy3LZAhoLKUHxMVITVDh51HgzQ2PLnM4vlJ9HEXrBG8jo+PfMd+cLc
	knIhRGNd2MuC/8SCEE475HG6aDgsAp7/V9l2ILUFyCPZxyogxksTpwlDm2zkB4pvyTvgNCaUE0Z
	hw5ENEFr8kYaiVcyiet8cpVIyvTq5mVMSqbrmPES3acfI3OMkOQGoQbVFfNNlF6mHcry851bir3
	CX0whqz+27r6Lfp
X-Gm-Gg: AeBDietlqeDw+TqsxcgCEjuw3htX1Oj46DCfoJem/0opWn7uWptIrL+dD4YOujG8UCE
	BHk1iHJf+K89/m/H4L5qLjRmHcPAyP8K8NtM32OnSKPgD033Cg/JZKsS65+smINYMd7tapq5lGO
	sRcujMteAhmw2xA90GTQZ8odPwFZzdJvoTCmStlPWlyZEaxx2NrvA0kB3CRBwYPGnrte+Uk0MsA
	mKqYL0VrPxRAMBEI643sV4If+G2jAPMr7M4c16a4p/sjxAa6fBTKVAfVRHXpxIdgOUZ+3MRFdgd
	bDUd2VkW1P3miz2zJg/x5l1zYDt23RfX024Cmm0DZJIwtXzZbX9LJXVgIX8PZoHUwzlXvOqDhH4
	Y+yfcQT+Tklom25kRm0uZtRb3mLC+AeXFXB03uOgGqdTgvjK/M1yWjhFxNSkViQ8ZambjXg2geA
	wCg+JAdmRa7xFg9nKZb2Ynga/x9gCZk/pkfFfi7A8JNppHdbMwxugmUw0MogMjkg==
X-Received: by 2002:a05:6820:221e:b0:684:bf8:d8c7 with SMTP id 006d021491bc7-6840bf8dd45mr4691125eaf.53.1775496020688;
        Mon, 06 Apr 2026 10:20:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-422eaefaf49sm1509826fac.3.2026.04.06.10.20.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 10:20:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1275c6fc58aso6337786c88.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775496019; x=1776100819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ak/8YrDC0eJbLQIfMmaoVpPiz4Stv8t/FxXd5vdbs8M=;
        b=Mg0ch4EQkcziAVMWB0Z5nM4tRAyHFRFxAmuDD+9sCySyBPgrQpwPMSNkCftaXXDPQ0
         Z2lvQxrDyzRo6riYO45kmp0lj0+kA92sSh/J3Gl5ZMeNcCg4KFswQ73+5W93Qgq7u93W
         Ux4kwsrdtcC0FT0ZIvlYlaxTRsWdjdcyuWmKw=
X-Forwarded-Encrypted: i=1; AJvYcCXTKjtc6y5hE1T/hAmqBiKY5iKECI21dIAh1gRKBUNCd2umBSX5kb14H2+emzszGbZcT8rWy70=@vger.kernel.org
X-Received: by 2002:a05:7022:45a6:b0:12a:91fe:f5c0 with SMTP id a92af1059eb24-12bfb765de2mr5785171c88.32.1775496019092;
        Mon, 06 Apr 2026 10:20:19 -0700 (PDT)
X-Received: by 2002:a05:7022:45a6:b0:12a:91fe:f5c0 with SMTP id a92af1059eb24-12bfb765de2mr5785144c88.32.1775496018426;
        Mon, 06 Apr 2026 10:20:18 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c14a371b1sm892890c88.13.2026.04.06.10.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 10:20:17 -0700 (PDT)
Message-ID: <cfdadc60-367b-4bdb-9d00-40c24a4c92bc@broadcom.com>
Date: Mon, 6 Apr 2026 10:20:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 6/7] net: bcmgenet: add XDP statistics
 counters
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
 <20260406083536.839517-7-nb@tipi-net.de>
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
In-Reply-To: <20260406083536.839517-7-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,lunn.ch,google.com,redhat.com,davemloft.net,iogearbox.net,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275660-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 6C7D23A5B3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 01:35, Nicolai Buchwitz wrote:
> Expose per-action XDP counters via ethtool -S: xdp_pass, xdp_drop,
> xdp_tx, xdp_tx_err, xdp_redirect, and xdp_redirect_err.
> 
> These use the existing soft MIB infrastructure and are incremented in
> bcmgenet_run_xdp() alongside the existing driver statistics.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

