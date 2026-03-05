Return-Path: <netdev+bounces-264382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMTNMop9qWkg8gAAu9opvQ
	(envelope-from <netdev+bounces-264382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:56:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352A9212307
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD86A3083015
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 12:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD9939A7FD;
	Thu,  5 Mar 2026 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcK+iLwI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rvAfqYF/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4184539E19D
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715269; cv=none; b=GJAf3K6Ol7vywmeI9IblMPSJ2KwZg7y8tss2ckHVkcHbfneWe5a4wGSDkMv1MekIh+ckDBNBll5bNYlo23D0AmoHp+l8eq3jgmiChSpX/3lNYLgzk74/cKGRBvSbdTzV/oAXTk4V3W+Bc83k/y5BT14UZ+GdTIpA4yOifjRgGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715269; c=relaxed/simple;
	bh=ZkqqxNAsdLLOBBCCtVYLv2vL79nqgo/zs6NdcEtLMU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t//oceWZKGoUd4P95sFc/Ng9n9RUyJylBnjkmHe63kbR8kKUDbOyWwoc4P5S6dDqrEY9l9crWgjpM4cAITUimH18JOR9LeguYv1brMqBg4C8dNV3dBvku8ccUHI4b5VjABig2zOMNzTNkk57/8yJgSu+MeNHAuHRq8EvWGYyLO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcK+iLwI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rvAfqYF/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772715267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ozPyRLvFVo7RkDuja3Q6t/+2zK1nnxP+IcGjhg3LBE=;
	b=GcK+iLwIq1CBzFFZzgleJYz5UClczGCjcMVBIyt5epHYgRVPqi7ufLPR+m4cQ95NErOMuu
	ujtqAKfvDC2eKyRWwX9iAYV4XAugKRK7frC2Ohinde0aPHhPdOgGZWoiyb9hLIN/JPmKt6
	KpPYKfJP+pYaWjz9INZXoidmVTh//os=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-0lHYQIvXOgGOqRvKG6Eb5g-1; Thu, 05 Mar 2026 07:54:26 -0500
X-MC-Unique: 0lHYQIvXOgGOqRvKG6Eb5g-1
X-Mimecast-MFC-AGG-ID: 0lHYQIvXOgGOqRvKG6Eb5g_1772715265
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-482d8e6e13aso65211385e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 04:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772715265; x=1773320065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ozPyRLvFVo7RkDuja3Q6t/+2zK1nnxP+IcGjhg3LBE=;
        b=rvAfqYF/Lj4DuWyOMzjh86JFlV69QA/r88Io7Zaz1wPd8xLvvxqo+K69CRIAeYhibZ
         G7Gf4BJxcD152VzZABSK3XsjYVXXqIpVBzegCczM04Zg3OIJReTSEJmBn/viPM4Abqwf
         VN9xtFE739f7MLR9kAgc9m/wX+rkfViNepPdcskK3jKrvEHn6fm65StFD/nw1XI5rJJ8
         g9qCRDyym5BMIh5F8mi9RuUjTfcNFMoEhZtRLjSp5qtk/piOAPnq8NI2lkR5BXcmY7ht
         SDuIGQyr2VFf46w6yThy+t13/YqQ6ZAlFAjmxnBKv5LVP+qTxDzSfv0nOK6INwRKOaKT
         E9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772715265; x=1773320065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ozPyRLvFVo7RkDuja3Q6t/+2zK1nnxP+IcGjhg3LBE=;
        b=UtuGUSWtvpc8LF22EfQ9lxif+513muexDmg1kRJhyq5wbIaCQBWBECJ0fOb2OcUXSf
         zrUl8uVWeC2Mjf+MeUCI5TitTr2VZHlVkVASPnezqw2rmLp1OGdzD8buFtJa4T6hxAGm
         ZfdYOaxr8JRAyub6PE6pU7PYp1oMc1mt0QMTK0Tp8JbMH/2Pvha30QdbNuwwoKeQPhnX
         rpcc1HW0VT64TIvqrbBGmKHHMJ/912qbkqw9kfjuzu5evf/UkHA2J85r1IZgb+DY1f8j
         2TiqmjdlZCQ5Syfs5usJ1HmgDgDp8ptWCj4+A6mdebJaSz+rrmZMH8Q4G+WDZnX3shwZ
         T9fg==
X-Forwarded-Encrypted: i=1; AJvYcCWfXLTjjUrryE1CUghb2Kue5T5TcgkUQeQsby+Fb7QFSyR84Vf5PEuIk9js5EXwc0XIsmSLAkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz66FVpNMj7//NCCHqqlgLpGQXbuCxSsIZfwJXS5UaQ/TAQwvPj
	WAxrYSN0pBJf/o0pqWBMQBWpNry544CVjTMYrHd6sLowKCo7Mwl7SEocaigPaYmOpYhjzUbt48E
	dXxW+v1kWCbaL4plq7KG7leqDcYiLD+vIuRa0LuwxhnoCOKzYEFa+4xDelQ==
X-Gm-Gg: ATEYQzzkhE/p04XVlSs4WVrZTX+M8qZzF//lZEI63S+7lyFZZ3y7lu/bxUw1ERr9u8N
	HhyDpxZHhEqvW4HmZG5ZGomzGZ5IIN0NqaK2jlrnew9/gYSkeKYPRfTtvCFK/8oTgJTdc2vCFd2
	mC4u4dER/6m78WyKoyU+hThhmMmzOIUMfaS2qMOvcU0IjZQhN9KuU4g+4F92xvHSARY0eydPtcJ
	hU2+x1fmcnY+Hqy33imflExJz9r3UIeS2krVLEWc9J4h96YclDD4dPgGN0eDEOWrv+CGJwtvsdB
	dfxIpwBNomd97SocDda3cQM0YoiFYj0oqs8zwvXr1AjK2mOeDUeKoq3+bFT2KT1nb8XZPqZIFC6
	Z2moIAYHRDQhHBKuz0gS8kKHzkw==
X-Received: by 2002:a05:600c:4e8a:b0:47e:e9c9:23bc with SMTP id 5b1f17b1804b1-4851989fb4cmr84510285e9.30.1772715264977;
        Thu, 05 Mar 2026 04:54:24 -0800 (PST)
X-Received: by 2002:a05:600c:4e8a:b0:47e:e9c9:23bc with SMTP id 5b1f17b1804b1-4851989fb4cmr84509955e9.30.1772715264550;
        Thu, 05 Mar 2026 04:54:24 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b0549600sm36034668f8f.35.2026.03.05.04.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 04:54:24 -0800 (PST)
Message-ID: <5d147ef5-8f46-473f-9c9a-455e52ce9541@redhat.com>
Date: Thu, 5 Mar 2026 13:54:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmgenet: fix bcmgenet_get_eee() clobbered by
 phy_ethtool_get_eee()
To: Nicolai Buchwitz <nb@tipi-net.de>, Andrew Lunn <andrew@lunn.ch>
Cc: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260303153918.538902-1-nb@tipi-net.de>
 <fd675389-b044-4783-be16-c5ba34163ef2@lunn.ch>
 <a899e5a0addb1e58d47fb7f41e4d8a55@tipi-net.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a899e5a0addb1e58d47fb7f41e4d8a55@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 352A9212307
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264382-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 3/5/26 9:50 AM, Nicolai Buchwitz wrote:
> On 4.3.2026 22:57, Andrew Lunn wrote:
>> On Tue, Mar 03, 2026 at 04:39:18PM +0100, Nicolai Buchwitz wrote:
>>> bcmgenet_get_eee() sets the MAC-managed tx_lpi_enabled and 
>>> tx_lpi_timer
>>> fields, then calls phy_ethtool_get_eee() which internally calls
>>> eeecfg_to_eee() — overwriting eee_enabled, tx_lpi_enabled and
>>> tx_lpi_timer with the PHY's eee_cfg values.  For non-phylink MACs like
>>> GENET, these PHY-level fields are never initialized (they are only set
>>> by phylink via phy_support_eee()), so the ethtool report always shows
>>> eee_enabled=false and tx_lpi_enabled=false regardless of the actual 
>>> MAC
>>> state.
>>
>> I think the MAC driver is missing a call to phy_support_eee() to let
>> phylib know the MAC supports EEE. Have you tried that.
> 
> Thanks for the suggestion. I've incorporated phy_support_eee() and 
> tested it
> with a Raspberry CM4.
> 
> After applying the patch, the PHY correctly advertises EEE, negotiates 
> it with
> the link partner, and ethtool reports:
> 
>    EEE status: enabled - active
> 
> However, reading UMAC_EEE_CTRL directly:
> 
>    UMAC_EEE_CTRL      = 0x00000040  (DIS_EEE_10M set, EEE_EN = 0)
>    UMAC_EEE_LPI_TIMER = 0x00000022  (34 us, hardware reset default)
> 
> EEE_EN (bit 3) is never set - the MAC does not actually enter LPI.
> priv->eee.eee_enabled stays false at init, so bcmgenet_mac_config()
> never calls bcmgenet_eee_enable_set(). The result is ethtool advertising
> "enabled - active" while zero power savings happen, which is worse than
> the original bug.
> 
> Likely root cause: phy_support_eee() sets eee_cfg.eee_enabled=true, 
> which
> phy_ethtool_get_eee() -> eeecfg_to_eee() then reflects back as
> eee_enabled=true - but that is PHY eee_cfg state, not MAC state. The
> fix should override eee_enabled and tx_lpi_enabled from priv->eee after
> calling phy_ethtool_get_eee(), since those fields are MAC-managed:
> 
>    ret = phy_ethtool_get_eee(dev->phydev, e);
>    if (ret)
>      return ret;
> 
>    e->eee_enabled    = priv->eee.eee_enabled;
>    e->tx_lpi_enabled = priv->eee.tx_lpi_enabled;
>    e->tx_lpi_timer   = bcmgenet_umac_readl(priv, UMAC_EEE_LPI_TIMER);
> 
> This correctly separates what the PHY negotiated (eee_active, link 
> modes)
> from what the MAC is configured to do.
> 
> The deeper problem - that the MAC never enables LPI even when EEE is
> successfully negotiated - was submitted separately to net-next [1]. It
> initializes priv->eee.eee_enabled=true in bcmgenet_open() for GENET v2+,
> matching what mvneta, mvpp2 and others do.
> 
> Given how the two patches interact, I think they should go through net
> as a 2-patch fix series - if there is consensus on that approach. 
> Sending
> the fix alone would ship the misleading "enabled - active, no actual 
> LPI"
> state.

Makes sense to me, but it's probably better if you wait for Andrew's ack
before proceeding.

/P


