Return-Path: <netdev+bounces-306652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PhmTKjA2UWpyAwMAu9opvQ
	(envelope-from <netdev+bounces-306652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:13:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A12A73D452
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:13:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fOc1Bbfz;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306652-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306652-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC8E730117B3
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668F0377566;
	Fri, 10 Jul 2026 18:11:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FA1346798
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 18:11:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707106; cv=none; b=Uj6Ty7V6igf7157Rkmbl7lNKIe3cbzqG7wbvrXs5lY5YAiXdPcotVdYx0kq+JtUny4OyGF30PLn24WDambG9dM92Vfj5Jo6qU5hvy/LfbqorqGrr3vpR2b2zsVMI8k0bfdhAoCH8FG4VjVbjMMspbSAX++6jF2oNYtb79MZw/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707106; c=relaxed/simple;
	bh=SRW1hyRy2MLVxxlmoOhn02LtikzideCrttxVVyIVT/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAOWfExZguN0tjaBMjUT4bD6sheHnxb9m0QGp2/w0EnQF2n8DAiBnGRU+4pAyk6nKXoGHigQWnDdwlIhrYacR1nZmjfHW3S1URfmpTusZdfi7K2AWLQ7Mb7Xe7MJDmpsPEGzArPEl5+sj5Llq0o2tzHNMBWlCZxqpbgWzPPUO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOc1Bbfz; arc=none smtp.client-ip=209.85.208.46
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso1958345a12.1
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783707103; x=1784311903; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T+3p5jzJlBIxDNBN4ODBt7dUlm5yf6OTA6BJPqQx+TM=;
        b=fOc1BbfzcXFZ3xcyomRun0nZ7wDLl4nmOiwkQ6YZfyRfqEeDP8Ayx4oQouydXwOFan
         vPc70iPfrRU+3ve85y3mFUd0IlCAr6yHJa0R5InyfZaqkycT+GX1cGg+PzGcHrU0A9fv
         VJREi/MLAVVd1d3ABaqhVIGmSr7Bk2UiSPZpvk2BhakPmlJJx8bxjyYq97rADibiYt9p
         oJlyWqP7PXVoABlXy6OcO4oy9mJ74Je6oCyPMaguOdVLTN+ldDuV6TA2NYR7+AnG7URh
         DgEIWfwGu1aIOk/0eHR8FrmIgpilfG8Y0RGcnO9kl0QBGnvmwVq0Gv7N99jRTdJpvDzq
         wsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783707103; x=1784311903;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+3p5jzJlBIxDNBN4ODBt7dUlm5yf6OTA6BJPqQx+TM=;
        b=iLEMIZU/h8St6Z722THfQAwZM40VUd+VETOGlfqvZ0r8yT/3y/Ux7klbW5p4W5KU8C
         u0zLR6RHCPD70tvCU0j6Zhgvc52h8Ba4EVEvXqfE6/Ia1yLIA0J1HGf/lDTYKTO0rRqm
         AIynsAJ15d0Z02Sja8q7lmAnx4X2z4KFHUpn+MnI5E5JWKJj0ZNyCs0k5hewNLht8fy3
         +E660IrPWp+5Jei7fU932W29FjJ+mPUL+CUsYvcTWqyZ76E6jJi/8/+NiKhzckwBUpFV
         yNN6yLn9PRkxP+WhKRZBMWhdOZyBIZWjE3MLGHvzyDnrh0/BeLtVVE6T1oG92N6Wk231
         AQpg==
X-Forwarded-Encrypted: i=1; AHgh+RrMBK+WDHHbj2UiXk0ClcF7zzbSWK/2yqmU0cedczdhanarGgxi7H0U47/gctNtpJhSTmUclj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Qry2lRwL75pCHn9pjm0HPAZUgTD5yIg5JkJK6iD1A/ztbbFY
	Ua9MAzxjxr9b8kycIUhBZpLXOn0gHULWDFGx0ewbrg1356UcxgR+dJRE
X-Gm-Gg: AfdE7cl8VTItmeY1BD1kFEZNA844g+cppRG33K6P6cEwwrSkOLiL0FbDB8L9Q4upbjr
	xd8a/coktiC9SOSdKsM48293BcWZnF+jdbCnfNtknGtU7rHh3/aVCB9NnANxP5nVxNAm14oV+WB
	N5NoEhTa27S00GbHFsIqcGydavDSi08xRVhNidixjyind6STL42QNGf52XcNtBColOhs0qqBWHv
	9/Krd5LbJ6zEuPl8aEJLDhgeoXkb3JHTaJfS/ELc9vBlqw1kswYUhIRx+8zLh+JqsU5iHTMyld6
	ci9txJ2fim2PWJFkPAI2zHm/XazB/c+VZcyI+Kt2aYyVY3JJd83bhTbws7O74MPWdqNOoWP+LVB
	oMtb/k64Z2i6xXqRpcH2dvqpwslR+FZVHDZucyaJ/APtoWbBTj36jTOhPCTQFoaJvc5bxD77MfF
	dIzyF+7I2jaHoCfIzbRPBCH2m9Use3UH7POlqu/Y353jMYL8ZPpDy3uwExlP92yJ3ZUNZm304P5
	75bnAoQmFOGmQXsQhFbZi8Mw2sPaL/ShAZEqNA3hUysE7osIKvin1yt+Srv95Q=
X-Received: by 2002:a05:6402:40d0:b0:69a:bce:f1de with SMTP id 4fb4d7f45d1cf-69c5f22d500mr200285a12.26.1783707103268;
        Fri, 10 Jul 2026 11:11:43 -0700 (PDT)
Received: from [192.168.0.2] (dslb-002-205-021-241.002.205.pools.vodafone-ip.de. [2.205.21.241])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19ce4b4fsm11209189a12.10.2026.07.10.11.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 11:11:41 -0700 (PDT)
Message-ID: <da33e486-2f01-4077-af30-1dc53a6aa2bc@gmail.com>
Date: Fri, 10 Jul 2026 20:11:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: dsa: mv88e6xxx: flush the ATU when the
 hash algorithm changes
To: Luke Howard <lukeh@padl.com>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>,
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
 Max Hunter <max@huntershome.org>,
 Christoph Mellauner <christoph.mellauner@joyned.at>,
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260710-mv88e6x41-fixes-v2-0-e23654c65aa0@padl.com>
 <20260710-mv88e6x41-fixes-v2-2-e23654c65aa0@padl.com>
Content-Language: en-US
From: Jonas Gorski <jonas.gorski@gmail.com>
In-Reply-To: <20260710-mv88e6x41-fixes-v2-2-e23654c65aa0@padl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-306652-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:richardcochran@gmail.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jonasgorski@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[padl.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonasgorski@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A12A73D452

Hi,

On 10/07/2026 01:29, Luke Howard wrote:
> Changing the ATU hash algorithm invalidates existing entries: those
> loaded under the previous algorithm end up in different bins and read
> back corrupted.
> 
> Flush the ATU whenever the hash algorithm is changed through devlink
> and reload the default broadcast entries. Per-VLAN ATU entries and
> any static addresses are not replayed, so the hash must be selected
> before the FDB or MDB are configured.

If changing the algorithm at runtime isn't handled fully and the hw
AFAIU gets out of sync (i.e. static entries get lost from hw, but
retained in the linux bridge), maybe it would make sense to reject
changing it while e.g. a bridge exist?

Feels like an easy foot-gun for hard to debug network issues.

Best regards,
Jonas



