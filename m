Return-Path: <netdev+bounces-298769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FgqALPBRLGpsPQQAu9opvQ
	(envelope-from <netdev+bounces-298769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:37:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4BA67BC98
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:37:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Zk5Fh91g;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298769-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298769-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5415B3498CC8
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9CF32AAAB;
	Fri, 12 Jun 2026 18:31:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF582F3632
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 18:31:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289096; cv=none; b=H6YO+fFZkoSJ847vgxQaL/vBPrcjQEEj8l3m1uDT5nQmypjKura6uYSrVw+kbzxrT5KphS8BnzOqKn7HlnXXfdzD76QVxz4Uezau+hZtOmSsgdLjS3XxnRg0DQrszRZ44rMtOh0Qyd8K4/ES3IHqDO9pj+UxZ+oB9e8XjP8rWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289096; c=relaxed/simple;
	bh=7yn0/utgYVTOzUs+vb5c05ZV/Jxy6WpLqXn0DYdLdKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XjH8xsyQCM4+4lr0rbMBBkO/tR1o7g6QUS8Ob3LeNAQPdqQi1dAWd9Ycwj+d58ADlBM2SrXeoCuUlxlC4POtU40Pta+OF29zqZJT7bydIn3GTTNZ7iGrmbwKydSInrzj7rWOJU24dfwvv3kJOnMDTRXjj15UOAMTorcbXnuZRi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zk5Fh91g; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso10268105e9.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781289093; x=1781893893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=95AvFvq/SHF/XMgHFAPH0gEXz2BnMwa+fdNSG/EQyq4=;
        b=Zk5Fh91gSl4XTJRJmoM0if8u9PfmlOEE8uKaDGRYI4WTzE6LgYbi8eo+bmf3SCT/Je
         8x5IvZVP78knfKgo0hmeKMHQrynb7mdhXddEiz+cJW9PasQlNBrI8hgrxTALX46Zfjkq
         of/k//95hGUziOspiMxBKvjylZwXflEaka+ddd9JsVsj5O+DX8aAgUg8baFCJTYR60dA
         J/dUpuVkNBpYtwpliX2xoyDc/8UnQQyshogqRkpxCJ7EbzfowkrZT9lOV0xFC4PFcBIg
         v8r40Zv3Voa3wbH6Xw7obKOVwSwgHWiY+DKOK1hzzL3mouI/tF2mb0/fRz3tPu0u1ZWG
         N1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289093; x=1781893893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95AvFvq/SHF/XMgHFAPH0gEXz2BnMwa+fdNSG/EQyq4=;
        b=kD6BeOeTccMOF1G+k1nAJ9SuYuxI5nABm4lCOhKqEFk6TlMb3t75eGY7uvBVKkmliP
         FHRRVVmGQrzwvnS4sE/k0msciP+k6p0mWHepJmSXy5oPMEli94YwGsLNkTw77nPufInR
         3bWPv8DL9m10jg3ZwiHW65VnEqH2wecNXmO6zL1s/GUhNOBFKIENs6uyW3x+goz3OkNb
         05SSabLPPRh5vXgWESonpuxxpm3rtl0AIDXss8bI2nYJLvpKS0glnjfBSYQk8SDmNeDg
         qeYsoczpeTdTfEvBHW4/28BFEHUrOWuP9eNvlTQjgpCb4o5hAhnszBKV6Tt7JJvnadNS
         3GTQ==
X-Forwarded-Encrypted: i=1; AFNElJ+KicR/2q3K5w3Ewx7oDiPy6MaWqRNXdeO4dNxzstqJ2y73aickmERYS3JYzZWjtXhdzgA3Ofg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwItQ87hw1+ovgtJhRxuWLtAQx3T1o8kyCfY84R02S6Z3K6twQO
	pasO+DxoMPk7S9AV9o/VkYIMS10Qo608ZjzZboORFEajbfz6kfv8+l27
X-Gm-Gg: Acq92OEb+N1TDrzG24LNG33dcGsAe3RkJBFAWFp2T0dTMMjUzE53Ut0OX5LvhcABfEa
	v61L0aZVGgUg44LO7CU4b+S0zyzdlZcSaWitNXKHhXjJkFz9xfh9zVRpFx6dQIG28werPeTzkuZ
	ZcuY4e8gvAc5iCMWf7NEm+qOAtsJ6SPuAwRDjKfjl5VeJMFPt8BjfmCfjk0s2JgcP+ZXpbVuYwZ
	8PuOwHKnAA+QhYCPqKY146d58/2mcX/iejA8Q9WYxnSbbrYKYj5XYvQupG5R85yM2KoK/1ZKDeo
	QtIINgKMu8zRntmJwQod/CBdPH1EHQY9BHwYN3ssVPRj2fFb5Anj9temKLvZteeBzf7OylOjniW
	537+xFDr3Fylsua8B/aeMxDv7g8BjoEj4Gwe+fa0nFrrwfI7vPrgXpICZ2yngc7feKS6IYo4yT3
	HWGyKiwGh7Zx52WzpWOPonK9bJXefyEaRICsAsSFNIxl/r0UiWzifsHZ0QCweS6ViPpFt/30Yxi
	GA=
X-Received: by 2002:a05:600c:214b:b0:490:bd1d:472a with SMTP id 5b1f17b1804b1-490ec4d7879mr37936905e9.15.1781289093399;
        Fri, 12 Jun 2026 11:31:33 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:742:25a:e03e:6c9c:49d8:2fee? ([2a00:1fa0:742:25a:e03e:6c9c:49d8:2fee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203c0801sm6310585e9.10.2026.06.12.11.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 11:31:33 -0700 (PDT)
Message-ID: <3b7ce952-d653-4957-ba20-a14f932ad639@gmail.com>
Date: Fri, 12 Jun 2026 21:31:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 5/9] net: ethernet: ravb: Replace gPTP flags with
 callbacks
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, Paul Barker <paul@pbarker.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260610102432.3538432-1-niklas.soderlund+renesas@ragnatech.se>
 <20260610102432.3538432-6-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20260610102432.3538432-6-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298769-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:niklas.soderlund+renesas@ragnatech.se,m:paul@pbarker.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:netdev@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:niklas.soderlund@ragnatech.se,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sergeishtylyov@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[ragnatech.se,pbarker.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,glider.be,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sergeishtylyov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ragnatech.se:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D4BA67BC98

On 6/10/26 1:24 PM, Niklas Söderlund wrote:

> Prepare for adding Gen4 support which will add a third and new way to
> interact with the gPTP clock by replacing the flags for Gen2 behavior
> (info->gptp) and Gen3 behavior (info->ccc_gac) with callbacks.
> 
> This will make adding Gen4 support cleaner as the code will not have "if
> else if else" sprinkled all over to handle each generations special
> cases.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>

[...]

> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
> index 013ced6dcf29..70bef3b31d38 100644
> --- a/drivers/net/ethernet/renesas/ravb.h
> +++ b/drivers/net/ethernet/renesas/ravb.h
> @@ -1034,6 +1034,27 @@ struct ravb_ptp {
>  	struct ravb_ptp_perout perout[N_PER_OUT];
>  };
>  
> +/**
> + * struct ravb_gptp_info - Platform specific gPTP behavior
> + *
> + * Each generation of RAVB have slightly different behaviors when interacting

   Well, I haven't seen the word RAVB in any Renesas' manuals, have you?
   I personally prefer calling it EtherAVB; the manuals had "Ethernet AVB", IIRC... :-)

[...]

MBR, Sergey


