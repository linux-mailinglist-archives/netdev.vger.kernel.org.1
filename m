Return-Path: <netdev+bounces-300713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8CwFCbtANWqtqAYAu9opvQ
	(envelope-from <netdev+bounces-300713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:14:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A90916A6032
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:14:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MU0hfpQ2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300713-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300713-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22705300CB09
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BFC390CBA;
	Fri, 19 Jun 2026 13:14:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C9B379EEC
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 13:14:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874871; cv=none; b=G4qAjcLZzWjc+fiQmDagpHLS3JTTwYYzLdiDJEV6QrlcTKFEHmMIQdO0rQC/a8blfr53CIQ9x0//KrcqEujlGMEfH6us/WDyoqiiEaVqoqzNZF9ynh1HkMzdhUZ5imV1pjvkoYv3xHbfiIDbcYK1EkHGjAzD328zbyXpXIDhohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874871; c=relaxed/simple;
	bh=RrYFsFP0tXNmnqEzs6qL22aT4go6mN+DaVONZ5T1/v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2njVdLl+oZ3p/vGq3jKMQcw4xpgCmHvT2KFy9FHZKvpqrEywAEdpcQoLwt1QV+G4zcwX4CyQKhJBVpS6CxB7PrUTEria70pEu+KBdrNyMTJsgOuKNzH+F1ekfKOiQNGyX31JQXj9Y1lOUl8DHxwelfJKpKehUP3nvE31wYf7Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU0hfpQ2; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4908b92904fso26890775e9.0
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781874869; x=1782479669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Itjwnzaz3yMi0+4/X+y09zh3lVlh9HqeVBzmh26n8mg=;
        b=MU0hfpQ2zeVuVWnYSdTQJ9j18P74CjrrOYZ7+MTvfRNIZrjcBolEzdcJG6A5bTMuID
         Hna2ZoyuDPGFjco6OYCns6UfzlHA7B0nTK4tt92Np4jAFtC5FNUjyNgm8IxGcmFfgsaH
         6M4NDmGns0y2HTjMYEg6eMtYmxM9B7xYnOzWjG8kYP5MtmK1Oq4n6Db6vFSQrDCkK3nv
         WqPV2lqWJ+F/XN1W9nEQ6M2B+kEthLUGjOnejaRP3lxbO8bacelwWTPZrCDw35FvuLLW
         d9Es1Is543ZYKAI9sMguGT+mJhvPJcnS2qfhJ15TaRWZqJKcIkdfkA6pcewJjrJAWDnk
         6/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874869; x=1782479669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Itjwnzaz3yMi0+4/X+y09zh3lVlh9HqeVBzmh26n8mg=;
        b=itCQQYmIaZT/aOuTkxRR1RlOJcAvsD42OmPo1Gaqyroq7uAXyKnIGiIZg7i23+a1fq
         g1fS2ZkFVKsoJ0Jwf8r8QjiWZgzUGeo/KmyTuMH8ne+jumIYkT/5/Z3/gF8cpLMBU5kH
         ihMo9yA4Bzxn5OlsAIVA7LFzSFT5pKq0lBcgq8R4oaX0AwqtTxykg4auCHTXI/sXmM9E
         g+j/Xy4b94O4m4ppL5bPGSsgUi+AWGBpJxZL0hnjMJaTpduH1rqhdtAqAAdmZzWlMfZt
         4RDFa94ORxcneDFDBX5ocqeuiHxtgxYuMw1gaqra6n05mpKploNb1gcZWDjgoQ+5D8/t
         ebIA==
X-Forwarded-Encrypted: i=1; AFNElJ+NVzivqjx5S5mtG8A7BHrvEU8NCa6VCUgdd3y/bqtho4hQo6XEjCDGq74ms1DDTZ/ZnSroxTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YziBaZ9xfLjE0ysPUTo+gZvMmTwnHbFabGL0fJyWjDu2ITt7yBv
	q+T5ttIsS250lrxOk2pF25Px9j+kyEaOvQO28oTRYjp+GYbuB2Mm1siJ
X-Gm-Gg: AfdE7clMYugklE9Yb5y62I7C9WE4bqQklxj969qojB8PhifP/6v2jQ8DNEg+YSx7WkQ
	p0DYu2hMgBWR+3S07QZPWWpBm3govg8K7FgMgUMqbjutthrKAZQHGIPA7fh6+GzcZb6lCp1iwYK
	yEa6pUsWCTrp2AR0cYrjFGGgneElwMoBalKoD76jUBscH4FpN2XjSTVnD42eYm/F/9TlWy+v8PT
	Rvin5E+m8LXottMA/BhRTFEiPcsPshoO783GDkGngyQRyJrRdZyOOxC3F1Y59TwVQ9J5I4bbUSW
	pCu/NmSB3gaHlnfnwppWGbFwaZwuuJFaNN2WZmveREXuJbaVderZtoFv+w+6qgMpU5fkmrkrSYo
	pcBJWO+wajYu6BKN02AJ57rj07FP5jIdkfcCfq9RyMiKGQVkUQa7LJdvIRT9JNcE2gCM5I4tVuA
	vIHGYvlgFp4TL3u4wmyQw9WPf5Sbx4nAKaCcKFJlzwZ0mlthfVHW+MveDyFwPGPoylfd1ghQfWf
	0Q=
X-Received: by 2002:a05:600c:4ec6:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-492425706acmr41616015e9.19.1781874868944;
        Fri, 19 Jun 2026 06:14:28 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650c114a50sm8990375f8f.33.2026.06.19.06.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 06:14:28 -0700 (PDT)
Message-ID: <46d1effe-4a8b-4043-85f7-5ddf8803ca16@gmail.com>
Date: Fri, 19 Jun 2026 14:14:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v28 2/5] cxl/sfc: Map cxl regs
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, djbw@kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
 <20260618181806.118745-3-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260618181806.118745-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300713-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:djbw@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:alucerop@amd.com,m:dan.j.williams@intel.com,m:Jonathan.Cameron@huawei.com,m:benjamin.cheatham@amd.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,vger.kernel.org:from_smtp,amd.com:email,intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A90916A6032

On 18/06/2026 19:18, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Export cxl core functions for a Type2 driver being able to discover and
> map the device registers.
> 
> Use it in sfc driver cxl initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com> # for sfc

