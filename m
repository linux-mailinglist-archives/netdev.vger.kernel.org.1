Return-Path: <netdev+bounces-289354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKYrMCQyDGrdZAUAu9opvQ
	(envelope-from <netdev+bounces-289354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:49:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDD057B9EB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DBFD303ABE3
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43F6403138;
	Tue, 19 May 2026 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDSG61+i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ab2SFtRZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63853F54C6
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182955; cv=none; b=M3IQ2TdxRHB2VH4CDVC+jw+ff8HJ3aP+/sQPL4/kXI/YWJT6ySRMNOrwmJZsr9BGJxnSCZryfxLCAsJHddf7BNwM/U/hDy6h/m5TreqHm4HLQjKHFNjyYQlZo3DZcO551UiJRZN2pY3g7+5fyzrvQEc1LdwXMjIC3tFF+afeKY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182955; c=relaxed/simple;
	bh=tCjZjgBY3r9OZllLAP22YI2f1t7uM28nGSzAOg+D+qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqNbr+H2KlNdZNlSWCr1OE7YH2XIXA1SklZIK9okXyCXL06L48MowV6Tf6PRcZLAFYzrJrhpFwIRipzDEKu30TgqCwwmtXM6niPHMuZ4r9HHokRAuKH4DzoPJTMUiQKzGCIx+HUABGl+nj8B9SHnKwCebUwMvj8c0+NIi2pTJlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cDSG61+i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ab2SFtRZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779182947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WltqGyX6LSgbCxoNJFtaPsurvESE3OwLgIknpaUUGUA=;
	b=cDSG61+iNJxw3fpNbLApEVbHBRcYuThhBFmX9dgOpvxffazG/X9XPfbJ39G+HVnRv/zbeR
	BnaxY6yprSmUUIM33wJRE4aFjb1FpsPS3W3vg42r5rgjT+enV6J4V58UbPvzzScmS3/s9R
	f7rZ4lticuwJvOUNiwQkDgiNAKcX+eU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-rU-oae5KPA6XmHeqj-cyyA-1; Tue, 19 May 2026 05:29:06 -0400
X-MC-Unique: rU-oae5KPA6XmHeqj-cyyA-1
X-Mimecast-MFC-AGG-ID: rU-oae5KPA6XmHeqj-cyyA_1779182945
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48919890a95so17647355e9.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779182945; x=1779787745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WltqGyX6LSgbCxoNJFtaPsurvESE3OwLgIknpaUUGUA=;
        b=ab2SFtRZ/aUymUZUeseGZxWW3HwrKtlly5cy04cAV5CiTR9HG0xC3bca3h8R0bmd1U
         IkIUdqhHuhkGiNKVdpXmfprJiFw3E6JGcVL764sMHP196X9Pu6HdNiIdDezXV1wY7FUA
         759iG83jlzXt+oi2Fu050BVFzMV1OeqVpPebln5/yLqze0Tk6vavDLG9OfWf5lXkeYHB
         MwuQ1SZT65oeVY0mBXsbmrbq5vINX01xTG6z25Pr+GIyqFXW/r6Dgjc1kpFHOGKhW4dp
         yfo8sxnJgvjmEAC03O04yYdlffkJll21gWbwIlCzuuwolELbc4m5fEvZdaj9P7Ri0LIX
         itAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182945; x=1779787745;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WltqGyX6LSgbCxoNJFtaPsurvESE3OwLgIknpaUUGUA=;
        b=AsSbEQpNVAgLjlxAkjY7sU3v2kP3FvWBK4I488/NQSgq4cWIuGhdKjvp555sjpcUfV
         xVDe5MYETztL/XI1NwzSZncfsh4HEncvMypd420MfK+diqIr/Svdzjcu0QlEaTVifYds
         /7yXATpeXnD/jSPq0yDGyJHmxOHiljiYhfKFE+IlmjT2IuNQmS5AGo10ZhAYfna0geol
         hBXphb8EsExj0Y1c3EV2PUus6EW/i75VHTxB/+PzM0a6QR9uS//Z7ms49lfyyw6NNwzT
         yD+FVkoHqXfoQXI5Lp7ZwzX8nF+5QKvMVYUsWA3VP7QW+vkU5PxNqjjYdy91tSk41/ri
         8Hng==
X-Gm-Message-State: AOJu0YwdILItMQU2DnbNNlMjJzZW75zRTlVHpRD3w0F1lEl2yjh34B38
	P0cPOM3+7t67+/GEw3KTEXxErNBbTJzwvQ1KhCYreE0ddQvM68CRrJ3nhf1S5nO0rEwbz2MCmfj
	vpgIwk8IvlWYn5Hqa17qBjnklXprtxZsd5GunrrFS94Opzostu3fd7b9O6A==
X-Gm-Gg: Acq92OHoSWr6Nncty7mA1XtLS/vZux1LIzWwEtK5mzeFW3IU/4scQUxHWM3zR7gOVMU
	QJVAh+g0Fd4VHyXBnp2Cs8dMnjzQiNk0cuQGCMC07BNU8ywwS0cxzugK+WwYgXVl7sIFi1OHHLG
	hYSvyIZxyAmvhcH6NZr9igBHKtuNOEv54oVDgR1YcpXzbU9BQ+mviEfVGLctMK1goGQfrCpFxd2
	yAjLLXewQU1mBHny9ozVy8PYpoYEuWKY5RXga6fhAAK2QxNk8vmHlYWK7nCwB7XzVfxBuOMs+S5
	4UeVX997tGX+cLTRq/pqUVkKifo3vrZvup4PW+Ar4djULqMYVGFwmRGiO8vldc9Ud+aSBmEVFB3
	zOlIso1MGqk1D4V7QDAJhJ9lyhASFxw2H7jZZEDsbSaF5O8z0zrRS02g=
X-Received: by 2002:a05:600c:34cc:b0:48e:635a:18d7 with SMTP id 5b1f17b1804b1-48fe59b047bmr317369575e9.0.1779182945107;
        Tue, 19 May 2026 02:29:05 -0700 (PDT)
X-Received: by 2002:a05:600c:34cc:b0:48e:635a:18d7 with SMTP id 5b1f17b1804b1-48fe59b047bmr317368795e9.0.1779182944663;
        Tue, 19 May 2026 02:29:04 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febf81970sm144760595e9.8.2026.05.19.02.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 02:29:04 -0700 (PDT)
Message-ID: <b0e8121c-e2aa-476b-b8b0-3c799e712e90@redhat.com>
Date: Tue, 19 May 2026 11:29:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: ti: icssg: Add HSR and LRE PA
 statistics
To: MD Danish Anwar <danishanwar@ti.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Meghana Malladi <m-malladi@ti.com>, Jacob Keller <jacob.e.keller@intel.com>,
 David Carlier <devnexen@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20260514075605.850674-1-danishanwar@ti.com>
 <20260514075605.850674-3-danishanwar@ti.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260514075605.850674-3-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289354-lists,netdev=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sin.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ti.com,davemloft.net,google.com,kernel.org,lwn.net,linuxfoundation.org,lunn.ch,intel.com,gmail.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BCDD057B9EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/14/26 9:56 AM, MD Danish Anwar wrote:
> @@ -201,6 +201,16 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
>  	ICSSG_PA_STATS(FW_HOST_TX_PKT_CNT),
>  	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_PRE_OVERFLOW),
>  	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_EXP_OVERFLOW),
> +	ICSSG_PA_STATS(FW_HSR_FWD_CHECK_FAIL_DROP),
> +	ICSSG_PA_STATS(FW_HSR_HE_CHECK_FAIL_DROP),
> +	ICSSG_PA_STATS(FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES),

Sashiko noted that this statistic name exceed the ethtool string limit.

/P


