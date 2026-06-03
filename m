Return-Path: <netdev+bounces-294910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B/u9H8mPIGpn5AAAu9opvQ
	(envelope-from <netdev+bounces-294910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 22:34:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E116F63B249
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 22:34:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PHoSYwrC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294910-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294910-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5DB7304B69E
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 20:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3AA39EF33;
	Wed,  3 Jun 2026 20:33:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A39F33AD99
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 20:33:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780518785; cv=none; b=oq8OBj7ja0bCd6vOpcKt37Rp5O9Vhl8B/bmD31FfLQKRuxy1kOoiACRgT2CcHOTLhqg+w5M3tTavc5QATk73WjhTD2gQS/5oANVV72J3i3VryRe9BVrKSiBMOxHdJYOZYJihHnW5U+y6ewRXCYg/k561G7iK+E1BtywcDkp2tvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780518785; c=relaxed/simple;
	bh=6GIIwpEkzht9iv8ARPH7Orn2Fu5UdwID2sGQGheqKJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=gRJ+xYl0dORLkFVMdMfiuiZBZthJdz/UxXDskTvUwd+pDsaX3s5U9bFzDFUv16phZeI6zDV8bQpTpDNWM/JrkMsBtaOPNg8t3L57xrhbXYC9MJTGfrTGGsi8doW9AWb4GHM8sUdeYGUseOZ3JIerKvXv7XDovvm5NOEpzd7Fh34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHoSYwrC; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso43913875e9.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 13:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780518782; x=1781123582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k6ouO3q0hzo2oJfZSTq0miNDQgFQmgzGy43Asqa/7CU=;
        b=PHoSYwrC7+a8/OL0KMZb1+mxXA2Yp9Yi6U9lcRH5KWPTS1dkSVWFG5wzk+oXuFDr1z
         bV8GEjlUhu8kBdo4KY/9Rsn17FIS9Xc0ixvQ70kucreYnzmrVv44fyX8APVhB9+FrTeB
         vL1yINni9sn9vxJ+2LUUgd9DV6J3wL1AzGI3tq3TC389Oyst4q11ErQJQzC4e/94dEAh
         9a8MklmcCExkIQ92A3U1L/BU3Ar5Fob8qfHesdViNaNNoMKhSRsbmRMG2Fm1Ni+ababK
         IxZYFl1fiAmvbp4QjIu2RvRDeMnshcifGhkmL0ugP52RLY/3PWRMAiNpuZuosX3oQOAR
         qzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780518782; x=1781123582;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6ouO3q0hzo2oJfZSTq0miNDQgFQmgzGy43Asqa/7CU=;
        b=LaDmdpQtplv+h04b8C6RX/WMHqJ5O8LdEMWtYqB+xYYZ4suon0Wmqx2saOAKcHhzAT
         WC0JTI7qD4EmnJ76UP94nGhgcEaKiftv0hlvn3XKV+vjSN5KDt0H08hBga6LiLZKyfv7
         VpBzBzTcKNM24GzPbCf5GyMjLNKobdsyESF8X6xD92gvGPBNYB8QTIvT6LlNb4vG10C3
         ENqIcGnaxjVOEPshMqy3KHgiZsudY4CXQwiat8NEGGH9CKVXIk6xwK6EpB+rOsbMYEBF
         PXzAbufHTG3pCDu1Jc8d6bQu91R9tL6IBRqEVOIsyjZh545k5AGASsKwEf+hyR0A3rpE
         QAIg==
X-Gm-Message-State: AOJu0YzOs+RLpNP06WibixpT0w2CjsOPf2WOr/x2pO91SACSiTY4Ku2I
	ohk+mM+J4AxKYECxlAPTtah7Sl3Yjq/Z6bHDZw1GZzn98IKE0EWtln0E551NqA8W
X-Gm-Gg: Acq92OED2SRTkfFPA/zM39Ne8d6z/w9o75y9QCq7akhYGdO55x7owDIbmbfuwG3zSGM
	3AJfKmyyX2Acv6+ODHcp4XsJTdt/0iIX6vbFm3wAd4fOO6gSCRIT36BFZ4Fpv433XT2PIqPtyKs
	aKYhcVGZzd6RfJ9dJEvuTXeSmU02QMv4u7liJG+XiezrFf6qWx4ra66+60gi8P2AjITf4gOIT74
	B5EoHqodIYBknyLStYb1siajrQTF5NM963RtGLUp7DmTGL/Ze3HvNkVRHos9WBX3vepvFI0x1s+
	6t8akfz/K4qBktTv2Ni7x7OoFqJeSv5e//g7VaH1r3oL/rl/FZiI1PuEEVLwq+DEA3Kzrn2TP8f
	msXzr8Zf2u3s4pYf2uOzOkMjMM8H6lxivU6ayCoPOV8ojnu6BbrZPCJC/CVacxMW8z7Pf662ePk
	3MIOOswY2jkDLtQrlUrIdpADh900RxmU06uOd5hoeDCbPiJFr7oRtPgr1cZuPXIngUwmssm5Q4+
	u8whn6cHaVc2w9Wgj45t04K+QShI5qOAhByX7firwHpV05tTQUfB8iZkIIRge8UbkvC+fC9+Ay0
X-Received: by 2002:a05:600c:5288:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-490b5ec3ed8mr79754135e9.20.1780518782394;
        Wed, 03 Jun 2026 13:33:02 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f24:a600:8c8a:e41c:62f0:3e7c? (p200300ea8f24a6008c8ae41c62f03e7c.dip0.t-ipconnect.de. [2003:ea:8f24:a600:8c8a:e41c:62f0:3e7c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3918fcsm19092315e9.3.2026.06.03.13.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 13:33:01 -0700 (PDT)
Message-ID: <b1bda1da-8231-4f05-94a7-7511041ae489@gmail.com>
Date: Wed, 3 Jun 2026 22:33:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 221606] r8169: PCIe AER errors and recovery failure after
 recent driver changes
To: Javen Xu <javen_xu@realsil.com.cn>
References: <bug-221606-201211@https.bugzilla.kernel.org/>
 <bug-221606-201211-LMiiKJhHhg@https.bugzilla.kernel.org/>
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, lasse@lgb.dk
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <bug-221606-201211-LMiiKJhHhg@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-294910-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:netdev@vger.kernel.org,m:lasse@lgb.dk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lgb.dk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E116F63B249

On 03.06.2026 09:44, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=221606
> 
> --- Comment #2 from lasse@lgb.dk ---
> Commit 9ab94a32af704fa9c873094283ae8744a07baf25 (r8169: enable LTR support)
> seems to be the issue. Running the commit before this doesn't give me any AER
> errors and everything seems to behave normally.
> 
Bisecting the reported issue points to one of your commits.
Could you please check with the user?

