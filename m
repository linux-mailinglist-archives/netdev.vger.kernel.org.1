Return-Path: <netdev+bounces-257168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLoAK2OdhGmI3wMAu9opvQ
	(envelope-from <netdev+bounces-257168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:38:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DC5F3616
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EEA80300251C
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D6222FE0E;
	Thu,  5 Feb 2026 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="xs+IQunU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2280222A4D6
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298718; cv=none; b=jRlZtcQxJvE/9rqFV5xLAtIoHcmNyPABGYutKdur3ig4aahRjgxfzxXrFeh/LE1cLiXriqHzupG83bR6tj8nJMAbnlu6IiQKZ1c0SSUt7ZmKAUAnU34x3nrH7cNiFgB2bCMjCwyHFnSdXxrp/ZuipUQvFaZQVE1FkyXXixqaW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298718; c=relaxed/simple;
	bh=Z6L3fl09q9kSrubjFQ88R/6yrh72aTeNMdVC+nRTLfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpSm00NP66If3mldHI36XR24R4K/lzcpjG27IL2DqytQev3PSy/8schD15DmKS5YeQZiN82OMZkhedwCUl3FsEzQFkVo6nbO48X4Mwp5Bk5pJiuBEePJ+0bG3L/O/DL1fmUbECADnWwdkx6PRXyx1Yk4mlJUrFTVa6HdgGB89K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=xs+IQunU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43596062728so1476917f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 05:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1770298716; x=1770903516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02iWfztf973elI54X0voRTm4GyeDYKJI/pJtF0EYb1U=;
        b=xs+IQunUW0ewWnaS/QzrLa7nEmdLnPA75CewTe7vq5eNs6GBj1hpb+KlPPuE3kKcA4
         TO8Kl0YJrMcPS34PymPDjU7QieDqRlaOCLb9uEpSSxLGegVfd6HQOgtAW4TOM76P9eih
         bZRbjdKe1Cd6VGwRkEvPpIr1apgRP0ytNeJxBZVeRdB5pq2yzJKW7W84fZ1VRIj0cQ36
         vm7nYTaKgRli6iVpUx66ZZtQ9tm2tLICW2HXTtE1wVL2uuyvvt3lXwORDQnaIAHKT4y7
         oUE6pHxIEqdWZS5hRXJJgDgA5joyFvfoohFPOl1l9xPv6Ml62s7c5/r8rYBjLBN7Evwp
         wN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770298716; x=1770903516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02iWfztf973elI54X0voRTm4GyeDYKJI/pJtF0EYb1U=;
        b=t7pS3aKd1GO/4rDIyBKYxRWGQXCRCSDhmuVZ7kpWaZzYagz5lVlniAhbBPSaJy+jJZ
         D0Y02JsSO+9uhDkm5HigNb01QzEYRQm0gfvkYOJLyyYAYDgSRoRFY9JjuXeVz7oD9dla
         d6oxZRhGnYgtMgejeE6yFGy/Te+w1l3Iq3ATu6zIUylVsZl8KjktGcCG3zIKta6lvcEQ
         a/1NVX3KcgSZvmX52jLFiX5zcD0wAU3l2shcgOYwb1xDqKVBWZmAnw0msDRltkdGt9+z
         PjZlCEgLko36qhSZ7U+CH7f+usC6AwIvSbwhUNLMPNFpp2aaoVLBnxpAzCoJhnLN4dh6
         /1Ug==
X-Gm-Message-State: AOJu0YynTAS5TCBXS6VBg9nm6OztnOkihGpCKBOcB0XPlz9dHt7TWnn0
	bSBTd66KDcvBLFdJGrmtDuPEeSezUuecyAgaqQaqwmJXDKeIg6B4gC8I1oOvH1zm11c=
X-Gm-Gg: AZuq6aLH4aD9dIXg+JDqBzbbYyMHRFPjd9++mlSleJJSOzd9oTiZ/OEGqo/TdPVek+M
	p4j0v0YDSv6fGhxYVH7jsdd9senlTZZxVBqj4WbFxw8Q9bJMIHRq5pP30I17CynEKo153LntUtM
	8jQu7TBk6321BodpS0aiGIAGZf2xd/zbOPwG/AwMnk8uAR7zKlTNticyknOsGKRGOFrmVWAxc8j
	eY6tXAWeVI2U1vKzLVv661NCxKPSw5BwzaqFUewpwvuX547zEw8UEPwWLbpkmDc5NbZ92+OaJZj
	FeRNSdYt5Z7eT6nhFMuN6AN5N/vON/izwHg0MDdtYp1LBQjAXHSKe3rkSB8pDBbsJqz7gZQwibU
	G03TTMN4d3/616+7vK19AklLOu6Pxb4Q/EtWhd4LDSsvuLOk2sKwcrRiJI/EKcjNZIEqUIERgbX
	wlehFjtQ3ycw5TixVnpgHEmEkeAlNXOdt3ToTShr9XJXYnw/E=
X-Received: by 2002:a05:6000:2887:b0:425:86da:325f with SMTP id ffacd0b85a97d-436213eb7d6mr4362010f8f.27.1770298716349;
        Thu, 05 Feb 2026 05:38:36 -0800 (PST)
Received: from ?IPV6:2a02:810a:b98:a000::b3d5? ([2a02:810a:b98:a000::b3d5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e38fbbsm14752532f8f.13.2026.02.05.05.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 05:38:35 -0800 (PST)
Message-ID: <25ff0841-545b-433a-8e88-6e463ea718e7@cogentembedded.com>
Date: Thu, 5 Feb 2026 14:38:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: renesas: rswitch: fix forwarding offload
 statemachine
To: Michael Dege <michael.dege@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260205-fix-offloading-statemachine-v1-1-640224a531d0@renesas.com>
 <3b1405cd-6c7f-4883-95fb-151cab223a68@cogentembedded.com>
 <d6a9356d-6fd4-459b-9c5a-2f3e20368bbd@cogentembedded.com>
 <TY4PR01MB142829D9748A483ECAF19FD3D8299A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <TY4PR01MB142829D9748A483ECAF19FD3D8299A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[cogentembedded-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257168-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[cogentembedded.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[cogentembedded-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikita.yoush@cogentembedded.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cogentembedded.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4DC5F3616
X-Rspamd-Action: no action

>>> if (rdev_for_l2_offload() && rdev->forwarding_requested)
>>>       rswitch_change_l2_hw_offloading(rdev, true, false); else
>>>       rswitch_change_l2_hw_offloading(rdev, false, false);
>>>
>>> since rswitch_change_l2_hw_offloading() has internal check for the
>>> current state and returns early if the requested change is already applied.
> 
> Unfortunately, this has a side effect, e.g., if you pull the cable on tsn0 and the link
> goes down, you will see that the offloading is disabled on all ports connected to the
> bridge and not just on tsn0.

Quite strange, is anything else logged?  E.g. some messages from linux bridge layer?

Nikita

