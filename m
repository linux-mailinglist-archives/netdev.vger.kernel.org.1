Return-Path: <netdev+bounces-298487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VpImFpi5K2rfDAQAu9opvQ
	(envelope-from <netdev+bounces-298487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:47:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2B467768F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:47:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Yxn3dhRB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298487-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298487-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33108314FA09
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40D63988E1;
	Fri, 12 Jun 2026 07:40:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7883CF698
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:40:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250053; cv=none; b=om3o/iEcdIioclZzWmdGbTEFozqHrFTnfyWRZIZHqj3Aa4+CSBBUvLGeBrMCX1ug7W7uuFiWbb8MErfR42OEtxETG9/Jndrse4vviNai+jYHkEy40700+Xv0WALb/MkiBW6xjy9VLaf4rdyIDFER9dCXdIZSEcyFcD1kso6P0qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250053; c=relaxed/simple;
	bh=E458aChsyMD9nwqT7Rdg1FYbMYFrBbLT6R4RsmY6vFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJvj2k0qHFstkpnkLct7hyOoSWXBRyx/cwwkDCJZoSRGnxBfniKI3H3GaDZdzAlJA6z/mr9f4LNSISWrISb4brXej5U2485nU5C9qcaN5/QX/yZp9qs5ZNNGKhCHtmFqPV8R59Sy7myAvyKfYqYMXzOdpUB5ShOUM+8n2THR2XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxn3dhRB; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so6775305e9.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781250050; x=1781854850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E458aChsyMD9nwqT7Rdg1FYbMYFrBbLT6R4RsmY6vFw=;
        b=Yxn3dhRBsnT1BDIFiDy4BUGPvMxnfPrr0LSUYit8ahwevgGGH9cFJFxy4NJVXpN1ul
         FpbfRDtBGTH67Vww8gB7L/sSzFEIUvshYH2WSi+XiNm4197yVX1I2z/frt+s2Xj79jlI
         pdJTjmnxb3AMd2uFngaYtW5iawSfTXzUZwKBAnjkeUtAK+RX4nWUc7+AkHnve9nqV2sZ
         8GX1mvap6BwKHFb81lcoaSQcAjwIUQUj2FE08A6SD15WRH3KzQAN2WVJGokYmOHpZibD
         iHEqKrLZpnX/fyLcfPvJxZ+f+YVyKy2rld9uPSWlVpyQw4oY8HBq/mVL8A4T1Z6Sttf/
         CgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250050; x=1781854850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E458aChsyMD9nwqT7Rdg1FYbMYFrBbLT6R4RsmY6vFw=;
        b=m9P4hJYCPI5OHbXCZiJxDobKoqQWq8u73bqs+eR1VIx3lBt1MTLI6jeZNKfUP+yj5B
         esKyTPkXV95NmlA9hIVdTBOLhInB+YtQ7FH7Ub36nQ9+x+XUYCz3W5ZAGXQSDVKQABSI
         lrbWSv8EtuixGpvpK3V5qWujQY7/hP1RChsViSW/xDbmOogSuMb1Uv0lWZM5Nj8vuT7r
         pegupUZ1rDxfp2L9tEzKAJH/58ZAo05uDqV5+OB42MY73TQh89KBvJmn7tumP0a9JYBQ
         GdTisKO9RU5/eQUc3vUmoiyzEwE+GT5/t1KE78G2kloiIPVc+C2nqBpzMEhpFrsyd3Sa
         joVg==
X-Forwarded-Encrypted: i=1; AFNElJ9ZxMygbUfGht5PdGcqJKPL7eywOQtlcys9rqj2ezRiUpGGo7m6Guw7iOfxe1KvMMqJ5NjvKio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGoh0j1MyGEq0GdsKQZPG/hudSBdXwz5K2LKrWRmKebDWir+S8
	DzWNG+qCFbVe8ZCUQ05w3/sInnSNxYv/YAbHbwRHBlm4zKl5lD3AWPRY
X-Gm-Gg: Acq92OHU4MStmbM2llmzx5/K9lo/hTb+8JL0dcKpDXkmDNdtWKYTahxAXqlq5qTcPh0
	YiFmBSyFxOyvtTYLyJr+o2Cum0ols+iiMc8YP9pMtNEayl9lh5Bg5Pa3c5GvM2584UuNeCfhkdI
	T+viPgr8pWveHqadYx1DuCtZLLsZkGv1bBP7kYE9RTyoICkA95hVLsVTPmxaOa60G5GRUl8iOjz
	DFXhUNU9bCmw7UH5VU3bEZBXZ5pSn4jCDsR0Cxc1KO8Z/5Fyv3rAE6nncZtJ34ekkUfe5521XaQ
	9pAijstqIekolVG5k1cPvWhEckTmPRdOno363TpMdjharIW6lOsxoMeRrCkzOo89egYuYflvTXf
	/3JHv1YsnZuJ7uqkRmIErTTb+lJ3tlxarWPrhuVlPO66PDfwEJr34/k+YVLnzZKISoEIaAifgnC
	ED4IyLBgO7vM6SF0TfgMkrtdhBYNNvR2fMTV4WodkdhmSjq81oX5BFwHJ2c+3rggJWn7AKE3Ki1
	bono+GYfpmIjXvrUVaxTpo=
X-Received: by 2002:a05:600c:820c:b0:490:958c:46dc with SMTP id 5b1f17b1804b1-490ec4e75d9mr19312995e9.17.1781250050011;
        Fri, 12 Jun 2026 00:40:50 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f11c:fd01:7c4e:1a8f:d89e:b92? ([2001:9e8:f11c:fd01:7c4e:1a8f:d89e:b92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f263950sm3314405f8f.7.2026.06.12.00.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 00:40:49 -0700 (PDT)
Message-ID: <3b0e7664-aa66-4f1a-b374-7e581f3c6d85@gmail.com>
Date: Fri, 12 Jun 2026 09:40:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/3] net: sfp: initialize i2c_block_size at
 adapter configure time
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Simon Horman <horms@kernel.org>, stable@vger.kernel.org
References: <20260528205242.971410-1-jelonek.jonas@gmail.com>
 <20260528205242.971410-2-jelonek.jonas@gmail.com>
 <20260603180607.353551af@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260603180607.353551af@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-298487-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bjorn@mork.no,m:horms@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bootlin.com,vger.kernel.org,mork.no,kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE2B467768F

Hi Jakub,

On 04.06.26 03:06, Jakub Kicinski wrote:
> On Thu, 28 May 2026 20:52:40 +0000 Jonas Jelonek wrote:
>> sfp->i2c_block_size is only assigned in sfp_sm_mod_probe(), which runs
>> from the state machine timer after SFP_F_PRESENT has been set. Between
>> those two points, sfp_module_eeprom() (the ethtool -m callback) gates
>> only on SFP_F_PRESENT and can be entered with i2c_block_size still at
>> its kzalloc'd value of 0.
>>
>> On a pure-I2C adapter, sfp_i2c_read() then issues an i2c_transfer()
>> with msgs[1].len = 0 inside a loop that subtracts this_len from len
>> each iteration; on adapters that succeed a zero-length read the loop
>> never advances, spinning while holding rtnl_lock.
>>
>> This was previously addressed by initializing i2c_block_size in
>> sfp_alloc() (commit 813c2dd78618), but the initialization was dropped
>> when i2c_block_size was split from i2c_max_block_size.
>>
>> Initialize sfp->i2c_block_size from sfp->i2c_max_block_size in
>> sfp_i2c_configure(), so the field is valid as soon as the adapter is
>> known. sfp_sm_mod_probe() still reassigns it on each module insertion
>> to recover from a per-module clamp to 1 (sfp_id_needs_byte_io).
>>
>> Fixes: 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Thanks for splitting this out.
> This is a fix it needs to take the net/Linus route rather than the
> net-next route. I'll apply just patch 1 and you'll have to repost
> patches 2 and 3 on Friday.

Sorry, missed that and was wondering why they stay deferred ^^.
Will send another version soon.

> In the meantime - AI seems to also be saying something the cap being
> potentially off by 1 in patch 2? We add 1 to the len? Maybe I'm
> misunderstanding..
>
> https://sashiko.dev/#/patchset/20260528205242.971410-2-jelonek.jonas@gmail.com

Yes it probably is. This should only affect the I2C path because it adds
another byte there, SMBus doesn't. In my opinion, this needs a fix in the
I2C write path, alongside properly honoring the cap there.

Should I include that here or leave for another series?

Best,
Jonas


