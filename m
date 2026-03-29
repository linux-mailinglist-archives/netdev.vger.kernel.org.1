Return-Path: <netdev+bounces-272871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JyRXEiL9yGmUtAUAu9opvQ
	(envelope-from <netdev+bounces-272871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 12:21:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3697335189F
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 12:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0D863007AF1
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 10:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFAE30F803;
	Sun, 29 Mar 2026 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nh+q+ldF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A67D2E11DC
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774779674; cv=none; b=GuMLeJsGiKtEEO8Qznd8DhCf3y3ctUTcs61GxPmH3GAGhyx2p4BFJP6P6h/CQli2WMGC3RPkcnN+5xIbDJYNl2thd7g9RTifYYQeR/1rpFe2vM4ebdjXyPGGdH3bucPT9Sr0/qSevZRtGgzbqJUrea5wGtyLQVygjAJTn7l2pmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774779674; c=relaxed/simple;
	bh=qzG8RLfPmELC6KxRzEhkhBNjnyPshpzlMsgMvd5ia6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dw/M2D8fXAAjp+7EitahO8k5ZyTn0FP1sZxs/dxzI2cCzZOrvrm9YfRlJFnhpusbV6paIuzDqom1vc0Y3JdUIHIZqOcZgG5vVZN/WSRd9z1bNioE6ZF/UfrQH/0jDzo93OJSdBXZlj3OEodI0K3uRiPmJpGDak8WnJ8fD45bc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nh+q+ldF; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-89a465bd7edso30308536d6.0
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 03:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774779671; x=1775384471;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G9rQ4z3mdANFa6EYCOLGxKlSRAb/efBoqcuMoW/JXYo=;
        b=CUkzk2z+oJJckFRL0rhGQuN5gBuOsO+QQjC0xyQGIrH2189A0v0hwH0UEde7KuHnBZ
         z4DOpA5DE5LYXWD3QIE5j3KhSfRiEJx8G1Qnr9Vrv4LNYdFOQzjoq/Qm7yR1sKECU6dY
         uh8J+8UCHwku005mf+kZeeYPcuN78qKCRMm/P14f4KIpg5AL6TzpFzELnq7KF5tmkepH
         Qgq8MOhXgiO03vbZDK47k39pXr/rPE/XCL0yxZSA1O169Jx2wiX31FHRhIprUfmlRf8X
         7aeO8S76JyMMLjmA3tX4akeqhkG63uUFMtMsrho9aNo3rqzSHEPJv0jcfQToaM9sTl+l
         4fBA==
X-Forwarded-Encrypted: i=1; AJvYcCXaQCOn9lzhLupTR8QNZxUBJkmPYI2QDHS+x6P2UQDOzlBcWum4EWAPjHTv+qegvj7dzPLrypQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj75lipur6RCEo2I7cp9tw8eBCktvk/OBpbbqcBUUoQ8/RGaju
	64OCdrMlKrCyBgDTI4T5WTm0vT6pI3B22YwaY89J9d+O8MvKFVif8n8sdwOq4nh6iFW0t7PHGgj
	FXj7QiIll5w4iBqpu2QRVOOIUIXVkP+E6UV0BbFcl7e6mTAy+/Wub3ZMHGxcMcQ88XidxfQ+dmk
	UBoIOOFUmVUzrH04fkGuTiNY3MkFOLwCcjWVMzVOWcDZL0l/d345XqjrssXY+5S8UvsHaJ4r8w9
	xyBXBe8VkmzPWq+Gw==
X-Gm-Gg: ATEYQzz0uZAhKcpalk2AHJ4hwciT4/NTrqR2A8KC2zgFsoA0wORa4nFwuoS1EPb6KF9
	59K1peQ/GfwdOLksvtcwJ/h6rZD/wS38g5+Oyri41xtpSj9xRq9FAFIP+1MnlZ0Wq0JGiAkleJk
	eZP3mYUedRtXoeXNG/W7KknJ8UlRd0U8z3bS/tJ8Mi7jBfCWEG7zK3T8J9ITQ3FoqYi+dh7hY3K
	7orm+VAgEyLoYT+PKlh0hXLLCoRjQNg/CWksT1zbMAaeIfSHUdVXpHr7iggfxW8MYNKud2ea4xH
	DVCn+FVxftlDIRUahD2o7NL+KzTZHMt4G7rNjhmyOIBlJQ+iKlM9v9fqPeeHu1CjjPadPvmCbZR
	6i4Y86jOYgskTe4xqJLo6UheUIEn6PqKkRK0zdc988Db1zhxYo2yn09oinJEK12zDH22+Y0M3eI
	TV2o5ShYrQyco42aTn33iaciVY7nFuE4i6d8GvsqsHv1CgHbrFgVMyD9Th7CF9
X-Received: by 2002:a05:6214:6114:b0:8a0:f0d5:6c9c with SMTP id 6a1803df08f44-8a0f0d5718bmr3227846d6.55.1774779670922;
        Sun, 29 Mar 2026 03:21:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89ecd72ed6fsm6143836d6.13.2026.03.29.03.21.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2026 03:21:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb706313beso543295085a.3
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774779670; x=1775384470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G9rQ4z3mdANFa6EYCOLGxKlSRAb/efBoqcuMoW/JXYo=;
        b=Nh+q+ldFLHORukf97v5sNx13UgdJ6YXq2jZy4DKNZ0D4l360dW8swTHHhFkZlBcnYe
         3xxDDd8kNXvxmRPW+R+LCvNUf0v+cDAL+OU4jQTls46ohuFmUU/95+JOeXph7aNAtjDe
         9isWDZ7PiQvFXRkayuSbEjrQ1BRXi1Bt5pu60=
X-Forwarded-Encrypted: i=1; AJvYcCWE00fF33r5mDiLu5i+HAD9bAPismKM6hqV8qa6XezrQjwBiMYTcv78nX9VVprIkX00CDGKvRY=@vger.kernel.org
X-Received: by 2002:a05:620a:448a:b0:8cd:b3ad:63ad with SMTP id af79cd13be357-8d01c7bf5b9mr1132610285a.34.1774779669882;
        Sun, 29 Mar 2026 03:21:09 -0700 (PDT)
X-Received: by 2002:a05:620a:448a:b0:8cd:b3ad:63ad with SMTP id af79cd13be357-8d01c7bf5b9mr1132608685a.34.1774779669365;
        Sun, 29 Mar 2026 03:21:09 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027edb6cbsm353491585a.3.2026.03.29.03.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 03:21:08 -0700 (PDT)
Message-ID: <32615f87-9e7d-41d0-b7fb-abd1d7ae7423@broadcom.com>
Date: Sun, 29 Mar 2026 12:21:06 +0200
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
 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
In-Reply-To: <20260327-add-bcm43752-compatible-v2-1-5b28e6637101@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,aliel.fr:email,microchip.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272871-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3697335189F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/03/2026 10:36, Ronald Claveau wrote:
> Add bcm43752 compatible with its bcm4329 compatible fallback.

Hi Johannes,

I moved this patch to you in patchwork. In response by Neil Armstrong to 
earlier proposed patch it seems he prefers this to go through the 
wireless or networking tree.

Regards,
Arend

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

