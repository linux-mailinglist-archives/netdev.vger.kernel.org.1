Return-Path: <netdev+bounces-254312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK4rBjcoemlk3QEAu9opvQ
	(envelope-from <netdev+bounces-254312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:16:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D04E2A39F0
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1998300533F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D27368287;
	Wed, 28 Jan 2026 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b="iCLp47+w"
X-Original-To: netdev@vger.kernel.org
Received: from mail.twlab.de (mail.twlab.de [80.151.39.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B950D367F58
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.151.39.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613064; cv=none; b=BMZpLHJCeVbMbzCt8XQGZfqAmthEgI62ZxDFjdukNG1HxciX0jUa0HyyoPxJVoul+9SRnqQ+Hs/r0Ul61bhfeAS3q3ghyspT9FtuviLy/ttTnhAgpjeAS9o14RWRqVEu07lxIKclf0LZ7VU64aqYWAJktoe0Ev+A5YQhI7VjixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613064; c=relaxed/simple;
	bh=g/Nn5BZ55Fon+u37QUg35fuJ3F5iTk/TQHYP7Heyl9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xn9EOtosj2qPRodysp7Zj32JWyQsRN930HqJ77hvcatf4Fs+qPo6s2eXKORdeMYtZOTT/8y94RRsUZlUAxxABcnZKOg8Qu/79GMEDH4nWFuQCcMS4gJv5nqsc5F4rHYLD6KYurOvZJPsXUBPepEEt3FNV2TrH/ndftn+rV1xsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de; spf=pass smtp.mailfrom=twx-software.de; dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b=iCLp47+w; arc=none smtp.client-ip=80.151.39.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=twx-software.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 344C75EAAFD;
	Wed, 28 Jan 2026 16:10:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twx-software.de;
	s=dkim; t=1769613059;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LYfTZIXY/lPb+1kVvlOpCZJZNpZxI6l2aQimOVKSrIM=;
	b=iCLp47+wbFdcL9b/mTFunFPKgscWXDkiYH8+2XlqeWlPt4b0hIbweAVoAvux+Eb3Nl1liT
	BmZ5fAsO5MxvvmV1TYiJU55T5ykXeAhEK18c86e58k+5NvXAI7hUIt+Bc08YV4lUb0VeMr
	WVyUP7s9la43BbBbxzk0zHSckpTFfvPIQjGbvxnNK9mgjSUNa9SV+jGq7ESKOfK9nV9GpY
	B8Z9/JRE7Telc/LKSonuYaJpbpIdEvtTCBs75P33yi4BF7je30MPkW3zBDUVR/e7wE6SmH
	vMLjlX1Cj3+Ye4zok+k/cN5/ZDwUY1ssnLB89YBT7W5eCjWEEnJNLyE6zO+xBw==
Message-ID: <9090d12e-e85e-4827-9dc3-5bbece12c50d@twx-software.de>
Date: Wed, 28 Jan 2026 16:10:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: net: dsa: microchip: add
 microchip,single-led-mode flag
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20260128133842.1173406-1-ht@twx-software.de>
 <20260128133842.1173406-2-ht@twx-software.de>
 <6871816c-2732-4c5f-9f10-1f9773d5f23d@lunn.ch>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Heinrich_T=C3=B6ws_=28TWx=29?= <ht@twx-software.de>
In-Reply-To: <6871816c-2732-4c5f-9f10-1f9773d5f23d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[twx-software.de,quarantine];
	R_DKIM_ALLOW(-0.20)[twx-software.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254312-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[twx-software.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ht@twx-software.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,linaro.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D04E2A39F0
X-Rspamd-Action: no action

Hi Andrew,

Am 28.01.26 um 14:59 schrieb Andrew Lunn:
> Are there other blinking modes? If the LED is capable of more, you
> should be using /sys/class/leds and the netdev trigger. If the only
> thing it can indicate is link and activity, this approach is O.K.

I re-checked the datasheet (DS00002392). The KSZ9477 PHY ports indeed 
have two pins, but they are not general-purpose. The term "programmable" 
in the datasheet refers only to switching between two fixed 
hardware-mapped modes via MMD:

1. Tri-Color Dual-LED Mode (Default): The pins LEDx_1 and LEDx_0 work in 
conjunction to indicate link speed (10/100/1000) and activity. For 
example, 10BASE-T status is indicated by both pins working together.

2. Single-LED Mode: Here, the logic is simplified so that LEDx_1 
indicates Link and LEDx_0 indicates Activity.

There is no "Manual Mode" or "GPIO Mode" for these pins. They are driven 
by a fixed internal state machine. Since we cannot control the pins' 
brightness or trigger events independently from the PHY's hardcoded 
logic, the netdev trigger or the LED class cannot be used to emulate 
this behavior.

> Is there a dual LED mode? Triple LED mode? What happens if this
> property is not found?

If the property is not found, the switch remains in its default 
"Tri-Color Dual-LED Mode".

I will clarify this in the description for v2.

Thanks,Heinrich.

