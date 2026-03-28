Return-Path: <netdev+bounces-272813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFXKErUwyGnMhwUAu9opvQ
	(envelope-from <netdev+bounces-272813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 20:49:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA75834FDA2
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 20:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AB3C3021E49
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D63313293;
	Sat, 28 Mar 2026 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aJcZ9W7h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3AB330324
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774727336; cv=none; b=SWFror89syDWacqG93ZQOHu//x0OyzBdCmUmA6kHlYVmKr+3J+je9rwkuY/ITWa8a6nUHgubFAPSfCkUwYJiZqlx9l1fA+8klQeUN9ckhwzwHDnDPl/TkeJX2Hu6MHo50/25/xPSqMHOjgYYyT8jZOByCcfq1ZEwgow3eZbFIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774727336; c=relaxed/simple;
	bh=8U8obALdl8hGap4gvKVuMEO9Fn8+jHp5B2BOuQBgut0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cu2zVmHu19rm+sp6NrpuJk0V/ma+F1YPM6bi2SkoE/UgaCFS0qsRkjsA97iyXT2MGH8oquNzC+qlVBcojT/kgcPsS9XPVw9rVmfh8n6IK5+76Ldj8F+0fqPiFJsQ9XG8ktuIWq8OkQ//YBWkThHLNUlqQLxlzmDTBvzfHukew/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aJcZ9W7h; arc=none smtp.client-ip=74.125.82.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-128e4d0cc48so3889698c88.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 12:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774727334; x=1775332134;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3JcaKbNOQTHcXjxE/HgutiisVcwo5nY/ouFHpDs2PKc=;
        b=Wpz++8UQexHGMoXs05UwU48egQpYT/R8ragUVDqp5Z8JLm0f8RMzkJUc0S0/lxLRJp
         cUwwM3ckGJbePB/0fcz/hlIxHv7N1E9JRjzKM/CtTkn5gcn4Wd7cFdETtp4R2+ninxcf
         uaLSxD82VWRnrFu/BLkTS/+z9JyWkmFmTyOpNcFoEM9g5KIlQezWTnVSCGM9wlCnEmVW
         OYlXxJjGEB/6XcL5kBdwp+2alR5wD2xAxudGlmepSVP33+krCShDeixRRao4SM7rTGMe
         jUpZxnDQg+qgauSQNdlWQAKRAHnBTDwiMJJHTKgZjRCFpe7S58MMdYNIDAnSHK0bIYC1
         4fUA==
X-Forwarded-Encrypted: i=1; AJvYcCVaAUvjrodhGWEt4nzNvvqZui1W9lCt3jEjuYBG3N5wDMlcsS9iZdTivPOo8ZDfvvNQB/Jvxhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNuNMQCUtNbVluIlJ5YTBYNTwWDTWPt+IlNyWpcOKx2E46Vyhs
	eQx3piu9cKshWzTJNNy4FSgrx6zMqMwLSeIGY3CrR8eZGzgWF72uXP8/UrJ+cDANovh8yqnwmyw
	Zu0xqtA0P75t1eIr9GhUFqVynxBpH0icbvS0Ot4RmZ/R4GKxADGiuNDoGm+3ofpabCx08DbmvAX
	+P+Axg8inQI41KFDxC7GbeFKN2xL/HocrJTyM4EMb0xbryKJt+FBRzggnc6wKz75X+iuxU6REYR
	phWDtglKjCLIATacw==
X-Gm-Gg: ATEYQzwC23oW92IhrVTB8aAPqH8b+pKEDme3jj7geNp2+dm1KER8w9Ac9ceYszqcEEN
	zLXH2wqKnz3aT/VFIPD+SCsZLfl9g50e95vk+gNVrmRO1P2mb7UcOR3KRJMGz9XVDkbwifC7ghi
	DThMrPn9lpL+c3VXKXSKDdhiiLim9Hb9xT/MjmCSbtganGDFQUN+ODzp2KGzy3YF8xBzvxlHGxt
	5WtKnn5IvuofYpJJyVPumGcz/4xQfDWrnShCyTZQ1HGEDPmuvojpz0Il4bx1lZPehH1hLfgS7af
	liGGSeRFAhJlkYxnwGkYWjg6V1xi7oF5kxYdX6JHpxhIZaVgB4CX8RIPFzSwOnER3HvgcqhoYsk
	wKmrjCrnKiMEZJX53bzJEt6NSDgLb9bSrKLv1s1lIaLu7BWtU54nR+QPUbsCOcvpCyZk2iqbThs
	6M2rD4NaSpsGasHXo+jBK+cleKUVy7g7pclBVnQQYBtbJ6laU/AsWQ9uhx0VsC
X-Received: by 2002:a05:7022:eacf:b0:128:d967:4678 with SMTP id a92af1059eb24-12ab28ccde8mr4200345c88.23.1774727333861;
        Sat, 28 Mar 2026 12:48:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12ab981160esm269818c88.4.2026.03.28.12.48.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2026 12:48:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so3459886eec.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 12:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774727332; x=1775332132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3JcaKbNOQTHcXjxE/HgutiisVcwo5nY/ouFHpDs2PKc=;
        b=aJcZ9W7hhUn+fUEUbSJnojcG/I3BOGVaju6+/gkyLkDwSsPjqg1gCKDhnB0yEZOPWr
         TN7kl0GYAgRc+qqS9nJx9B+o2Znti9wSmSU4CATSAmoGca2v8qVhBB0Fjrpe6KdX01pi
         5D7o95SZXhCPyKnNzGa8MV9HLfRzM8E7ZVUrc=
X-Forwarded-Encrypted: i=1; AJvYcCXe8faZooyMqYqRy3vY5fc2lJ7iaxGWH9QLf2KdTLRO8DPAk2F761hdIb24qTAmhtzkV1zqMDU=@vger.kernel.org
X-Received: by 2002:a05:7301:d0b:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-2c185d557e2mr3319857eec.5.1774727331740;
        Sat, 28 Mar 2026 12:48:51 -0700 (PDT)
X-Received: by 2002:a05:7301:d0b:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-2c185d557e2mr3319837eec.5.1774727331132;
        Sat, 28 Mar 2026 12:48:51 -0700 (PDT)
Received: from [10.229.41.221] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b2ff2sm2791550eec.18.2026.03.28.12.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 12:48:50 -0700 (PDT)
Message-ID: <1f658b09-a293-4a38-9ff0-c530fda7c501@broadcom.com>
Date: Sat, 28 Mar 2026 20:48:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] dt-bindings: net: wireless: brcm: Add
 compatible for bcm43752
To: Ronald Claveau <linux-kernel-dev@aliel.fr>,
 Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20260327-add-bcm43752-compatible-v2-1-5b28e6637101@aliel.fr>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 xsFNBGP96SABEACfErEjSRi7TA1ttHYaUM3GuirbgqrNvQ41UJs1ag1T0TeyINqG+s6aFuO8
 evRHRnyAqTjMQoo4tkfy21XQX/OsBlgvMeNzfs6jnVwlCVrhqPkX5g5GaXJnO3c4AvXHyWik
 SOd8nOIwt9MNfGn99tkRAmmsLaMiVLzYfg+n3kNDsqgylcSahbd+gVMq+32q8QA+L1B9tAkM
 UccmSXuhilER70gFMJeM9ZQwD/WPOQ2jHpd0hDVoQsTbBxZZnr2GSjSNr7r5ilGV7a3uaRUU
 HLWPOuGUngSktUTpjwgGYZ87Edp+BpxO62h0aKMyjzWNTkt6UVnMPOwvb70hNA2v58Pt4kHh
 8ApHky6IepI6SOCcMpUEHQuoKxTMw/pzmlb4A8PY//Xu/SJF8xpkpWPVcQxNTqkjbpazOUw3
 12u4EK1lzwH7wjnhM3Fs5aNBgyg+STS1VWIwoXJ7Q2Z51odh0XecsjL8EkHbp9qHdRvZQmMu
 Ns8lBPBkzpS7y2Q6Sp7DcRvDfQQxPrE2sKxKLZVGcRYAD90r7NANryRA/i+785MSPUNSTWK3
 MGZ3Xv3fY7phISvYAklVn/tYRh88Zthf6iDuq86m5mr+qOO8s1JnCz6uxd/SSWLVOWov9Gx3
 uClOYpVsUSu3utTta3XVcKVMWG/M+dWkbdt2KES2cv4P5twxyQARAQABzS9BcmVuZCB2YW4g
 U3ByaWVsIDxhcmVuZC52YW5zcHJpZWxAYnJvYWRjb20uY29tPsLBhwQTAQgAMRYhBLX1Z69w
 T4l/vfdb0pZ6NOIYA/1RBQJj/ek9AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQlno04hgD/VGw
 8A//VEoGTamfCks+a12yFtT1d/GjDdf3i9agKMk3esn08JwjJ96x9OFFl2vFaQCSiefeXITR
 K4T/yT+n/IXntVWT3pOBfb343cAPjpaZvBMh8p32z3CuV1H0Y+753HX7gdWTEojGWaWmKkZh
 w3nGoRZQEeAcwcF3gMNwsM5Gemj7aInIhRLUeoKh/0yV85lNE1D7JkyNheQ+v91DWVj5/a9X
 7kiL18fH1iC9kvP3lq5VE54okpGqUj5KE5pmHNFBp7HZO3EXFAd3Zxm9ol5ic9tggY0oET28
 ucARi1wXLD/oCf1R9sAoWfSTnvOcJjG+kUwK7T+ZHTF8YZ4GAT3k5EwZ2Mk3+Rt62R81gzRF
 A6+zsewqdymbpwgyPDKcJ8YUHbqvspMQnPTmXNk+7p7fXReVPOYFtzzfBGSCByIkh1bB45jO
 +TM5ZbMmhsUbqA0dFT5JMHjJIaGmcw21ocgBcLsJ730fbLP/L08udgWHywPoq7Ja7lj5W0io
 ZDLz5uQ6CEER6wzD07vZwSl/NokljVexnOrwbR3wIhdr6B0Hc/0Bh7T8gpeM+QcK6EwJBG7A
 xCHLEacOuKo4jinf94YQrOEMnOmvucuQRm9CIwZrQ69Mg6rLn32pA4cK4XWQN1N3wQXnRUnb
 MTymLAoxE4MInhDVsZCtIDFxMVvBUgZiZZszN33OwU0EY/3pIgEQAN35Ii1Hn90ghm/qlvz/
 L+wFi3PTQ90V6UKPv5Q5hq+1BtLA6aj2qmdFBO9lgO9AbzHo8Eizrgtxp41GkKTgHuYChijI
 kdhTVPm+Pv44N/3uHUeFhN3wQ3sTs1ZT/0HhwXt8JvjqbhvtNmoGosZvpUCTwiyM1VBF/ICT
 ltzFmXd5z7sEuDyZcz9Q1t1Bb2cmbhp3eIgLmVA4Lc9ZS3sK1UMgSDwaR4KYBhF0OKMC1OH8
 M5jfcPHR8OLTLIM/Thw0YIUiYfj6lWwWkb82qa4IQvIEmz0LwvHkaLU1TCXbehO0pLWB9HnK
 r3nofx5oMfhu+cMa5C6g3fBB8Z43mDi2m/xM6p5c3q/EybOxBzhujeKN7smBTlkvAdwQfvuD
 jKr9lvrC2oKIjcsO+MxSGY4zRU0WKr4KD720PV2DCn54ZcOxOkOGR624d5bhDbjw1l2r+89V
 WLRLirBZn7VmWHSdfq5Xl9CyHT1uY6X9FRr3sWde9kA/C7Z2tqy0MevXAz+MtavOJb9XDUlI
 7Bm0OPe5BTIuhtLvVZiW4ivT2LJOpkokLy2K852u32Z1QlOYjsbimf77avcrLBplvms0D7j6
 OaKOq503UKfcSZo3lF70J5UtJfXy64noI4oyVNl1b+egkV2iSXifTGGzOjt50/efgm1bKNkX
 iCVOYt9sGTrVhiX1ABEBAAHCwXYEGAEIACAWIQS19WevcE+Jf733W9KWejTiGAP9UQUCY/3p
 PgIbDAAKCRCWejTiGAP9UaC/EACZvViKrMkFooyACGaukqIo/s94sGuqxj308NbZ4g5jgy/T
 +lYBzlurnFmIbJESFOEq0MBZorozDGk+/p8pfAh4S868i1HFeLivVIujkcL6unG1UYEnnJI9
 uSwUbEqgA8vwdUPEGewYkPH6AaQoh1DdYGOleQqDq1Mo62xu+bKstYHpArzT2islvLdrBtjD
 MEzYThskDgDUk/aGPgtPlU9mB7IiBnQcqbS/V5f01ZicI1esy9ywnlWdZCHy36uTUfacshpz
 LsTCSKICXRotA0p6ZiCQloW7uRH28JFDBEbIOgAcuXGojqYx5vSM6o+03W9UjKkBGYFCqjIy
 Ku843p86Ky4JBs5dAXN7msLGLhAhtiVx8ymeoLGMoYoxqIoqVNaovvH9y1ZHGqS/IYXWf+jE
 H4MX7ucv4N8RcsoMGzXyi4UbBjxgljAhTYs+c5YOkbXfkRqXQeECOuQ4prsc6/zxGJf7MlPy
 NKowQLrlMBGXT4NnRNV0+yHmusXPOPIqQCKEtbWSx9s2slQxmXukPYvLnuRJqkPkvrTgjn5d
 eSE0Dkhni4292/Nn/TnZf5mxCNWH1p3dz/vrT6EIYk2GSJgCLoTkCcqaM6+5E4IwgYOq3UYu
 AAgeEbPV1QeTVAPrntrLb0t0U5vdwG7Xl40baV9OydTv7ghjYZU349w1d5mdxg==
In-Reply-To: <20260327-add-bcm43752-compatible-v2-1-5b28e6637101@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,aliel.fr:email,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272813-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DA75834FDA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/03/2026 10:36, Ronald Claveau wrote:
> Add bcm43752 compatible with its bcm4329 compatible fallback.

Looks pretty trivial so no remarks from me here.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
> The Khadas VIM4 board based on Amlogic A311D2 aka T7 features an AP6275s Wi-Fi/Bluetooth module with a BCM43752 chipset.
> This patch aims to add this chipset with its fallback to bcm4329 compatible.
> 
> The original patch series is here:
> https://lore.kernel.org/r/20260326-add-emmc-t7-vim4-v5-0-d3f182b48e9d@aliel.fr
> ---
> Changes in v2:
> - Add netdev in CC.
> - Link to v1: https://lore.kernel.org/r/20260326-add-bcm43752-compatible-v1-1-b3b9a58ab38b@aliel.fr
> ---
>   Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml | 1 +
>   1 file changed, 1 insertion(+)

