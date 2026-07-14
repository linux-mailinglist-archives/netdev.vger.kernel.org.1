Return-Path: <netdev+bounces-307373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4CKRMyzhVWrGugAAu9opvQ
	(envelope-from <netdev+bounces-307373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:11:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D522751BE6
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:11:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linaro.org header.s=google header.b=dJCfxaMG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307373-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307373-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linaro.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7C0B301E014
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 07:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E5C3EDE42;
	Tue, 14 Jul 2026 07:11:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CDC3ED5B6
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 07:11:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013096; cv=none; b=l21FbH1+XYweqMxDhi5S3dynn8oa78mBHw+7Br+BbrKA4g1PPFjxZw05ZiyqWFXxAKEEFszw2mP1xqYKiI4+L5d9TAXNBU9xIUyEzTi8rOeYRS23bKN/Yzi8EAUbIGZsM6hTBjXQygrtAXFpHV+v3bxp+CjEgBTcoQr1UgocqlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013096; c=relaxed/simple;
	bh=coH8VC94/khLrpGYl34wxhGzd6kX96i3kKwq65dq3Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKIGI5MT8ewIamHdwCe7eAT/Y9pqGDjOGsN5QSqtaljDKJtWRha/j2MbJrZjx17oyKvrrL7wbDqDhlAvN863p+dR0BHaH/Dd4cLNk1JtNbVWg4vjOK947F4/NVeM6Hl+5tlNlnVFHp5qSxkIYNIcMlfBwTdqsH8sZQsbYhAcheM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dJCfxaMG; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493ec555a26so25449515e9.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 00:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784013090; x=1784617890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LZwJYLmaCN63FrHksr4D9gyqJ9UQ3ZjFepwTLBT+MyQ=;
        b=dJCfxaMGqNCJqPHbVgLWA/hi3TkJGZKcyjwXHE/m6i8L8iVd/Cxty5flV3LKYdsstu
         9OolDHB/hJiyNCYjGWsdoNzTcYIns1cPsBP8WyDpX+g/zRHzHbdsq7biQMhl52NPKmEE
         QOtmF2Xo3t6MW0DbzwbOddzOdhvQEG9GMgLEeFZbNBLnqoP32B72TNAPiHAx3E8++QU7
         NpEcT6ZhhmrS3Wd7Bign4MWfped67BJW++u3G3ddAILPJFGWKqfU4jEJqjoTwSC0Quoz
         bW/To/lm429juJFAGknIORTLflKE99m091k3xYK+k0Pk+LJu1v2jiuRTH6trIT8wxpdW
         vMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784013090; x=1784617890;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LZwJYLmaCN63FrHksr4D9gyqJ9UQ3ZjFepwTLBT+MyQ=;
        b=Fqv6ZSdaS/vqwT+lZa8qT9V/D9ZRvTUQEM/ar0FZpt+rk1xA8RrKc5wgSXVhr82etW
         IxJoXdgao5FHNXnqozfYOsGGxrdt+zCtxuuMotVSWqBnjcjAnSmZiGJ2ANcZSUr8UZR9
         7NISbTyt5Ib9gHvFBmEsFLWRVvMPdp5eIeDquvOt5EoCfALuaL2cVzzoog9+GmkXvq5t
         cjivGPN4tLemsCwIOgvMkNQWjwikiuMgus4Y5LVQ3VJh0Q4OGvHFuy1C8j2FQsXhcw3B
         T6IsfzLNhsFyicvx5POE1Xw3TKC1PhnQmwhHQsccL/v1anWgVUPRQIsEoRxEqIO3/sf9
         eORw==
X-Forwarded-Encrypted: i=1; AHgh+RoVLTNctVkv00dOiJjfMLVMBCICgVcgJhWiTOGPz81AC8CB5Tc+rUk+AoTR9okK70YQ/DSJVwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvaLOU+Xjpu0VM0pl1RGTZ/t31DwJoshmSGX2vAlVVBCeRJVls
	DnZNDPVaRPxZnKuq6HAMatVw8kdHCVyinrzoJGBRz/h+hoCSTG/CIJYunOkzxYxDRL4=
X-Gm-Gg: AfdE7cn10q3g7vmFeZ9t7263z7gGrprHXjbys9xnN3xZOrTT/wionsq/inVC13zjNVE
	sDdBw85MBBeARrXybsV6zRXIvzkfNL0FPHWwK/HoXopVE6uGScGdjYNgPVy4jlokaD2cDcQ+145
	dh5ITTo3rR/J9HolM3DV4whvUcRG3VIprfYZh10LvOSSENUIKOZs03jmqj5nSUdfaIoWhh0uZYe
	aQRAYJYhP5y4WVjryJSEhWS7RQm78VXUXYi0/jyooiy8htMd1YD5muEU5XI1t0mbvZxZTF2Ku7Q
	IhuqJ6Xi6TXBtI8WfNmZHVz5R+n8wzaM/eCmGLMP1ZPHRSyUGb8+rI1P6ItyZKqFMQSyNB1NbtS
	/hfZ7biKs5dpZ2msgIq1wMK1nZqjKibzopoi8He+3QJ1LCH7JZOsAMtv8lvIAKbFbQ82GUowaAE
	k57pQlZ6QWWhDKoMtdRrn2dQj8
X-Received: by 2002:a05:600c:4ed4:b0:493:e946:c0fb with SMTP id 5b1f17b1804b1-493f87804fcmr139236605e9.0.1784013090553;
        Tue, 14 Jul 2026 00:11:30 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:6c30:6cbd:7b12:2745])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49506a1fbcesm58016765e9.0.2026.07.14.00.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:11:30 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:11:24 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Cc: Stephan Gerhold <stephan@gerhold.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	chris.lew@oss.qualcomm.com,
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: qcom,bam-dmux: Add
 qcom,shikra-bam-dmux compatible
Message-ID: <alXhHH0mGvFeUMd7@linaro.org>
References: <20260714-qcom-bam-dmux-vmid-ext-v1-0-3f29da7cca76@oss.qualcomm.com>
 <20260714-qcom-bam-dmux-vmid-ext-v1-1-3f29da7cca76@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-qcom-bam-dmux-vmid-ext-v1-1-3f29da7cca76@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gerhold.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,oss.qualcomm.com,gmail.com,sipsolutions.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307373-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vishnu.santhosh@oss.qualcomm.com,m:stephan@gerhold.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chris.lew@oss.qualcomm.com,m:deepak.singh@oss.qualcomm.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:ryazanovsa@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[stephan.gerhold@linaro.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephan.gerhold@linaro.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:from_mime,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D522751BE6

On Tue, Jul 14, 2026 at 11:02:31AM +0530, Vishnu Santhosh wrote:
> On platforms where the modem DMAs into the BAM-DMUX RX data buffers and
> the XPU enforces per-region access control, each individually
> DMA-mapped RX buffer consumes an XPU resource group. With only ~16
> groups available, the per-buffer mappings exhaust the table and inbound
> transfers fault.
> 
> Add qcom,shikra-bam-dmux as an additional compatible for the Shikra SoC,
> paired with the generic qcom,bam-dmux fallback, so the driver can match
> on it via its of_device_id table.
> 
> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>

IMHO (the DT maintainers might disagree) this is not a different
BAM DMUX hardware block on Shikra, just a different firmware
configuration. I'm sure the existing SoCs also have those XPU blocks,
they just don't make use of it.

Personally, I would rather describe this with an optional "qcom,vmid"
property similar to your bam-dma patch, allowed for all SoCs.

Thanks,
Stephan

