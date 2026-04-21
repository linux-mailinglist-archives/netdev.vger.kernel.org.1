Return-Path: <netdev+bounces-280026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DwMAJ8o52mI4wEAu9opvQ
	(envelope-from <netdev+bounces-280026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:34:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5173E437A94
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CF42300A383
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D303738757F;
	Tue, 21 Apr 2026 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUkZ17mi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLpnRslt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850D428000F
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756558; cv=none; b=ZRn8SdcnKZJy6BxU6UnC02wQ85qhd6Oqzg01PCL3UV+sWYcg55xk+gp+SiDJhqxApti+GMaYYe2rx0UgjY8KchBbcb/GSUWy16KKzwldC4jIdzmaV5LXUeP6EB6Ji4B4bRCQEwzzj0F0yV/aS6wj48EL/QVM+RYGNmzNQJQTN4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756558; c=relaxed/simple;
	bh=EFB5UkHyueGfQTFQHUNylRK3bf8BxDDdh3vlHZTjHpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNL+zYA+dKUBnw0xtiRCQVp1j/s/6c8s5tkzscA87Z601F+sK5DiXIP59fQRJKcBK7uQXo2RKEcRO552bu4tNdA0BGVMHX4f8g+un8oa1ICPxFkqVUZFDOEdPtLbaAdns8kxJov1GYFdgT4vFucmH9B6gQXccGZ/V9c97vlSLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUkZ17mi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLpnRslt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776756556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRLdvmbBl0X69xNsqP6IUVqffOA4KBnsa7u+Y5umkmA=;
	b=TUkZ17mik1P4jnYkfTSrJM7Z08StXKbHVfywnGgqCU/VnrV3Vt7Kpxkomy7MPyvdQsHIr5
	rY4PtK6uyhSUtJRVMKrMIcg6H59d4AsC5MrpKTaaVe/hhUT0XFAfVox8OaZdimIkSCEzcX
	Cml/zRhawLA4dJvVK0WfORvlH3EGPj8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-0lZM__6FPROCSVfEJfKDOA-1; Tue, 21 Apr 2026 03:29:15 -0400
X-MC-Unique: 0lZM__6FPROCSVfEJfKDOA-1
X-Mimecast-MFC-AGG-ID: 0lZM__6FPROCSVfEJfKDOA_1776756554
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43fe4674d3eso4000758f8f.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 00:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776756554; x=1777361354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iRLdvmbBl0X69xNsqP6IUVqffOA4KBnsa7u+Y5umkmA=;
        b=aLpnRsltrztVRlCtjci8FSoUzVYgW+yjAcPGJkH7+yvK+Ef3fnpQW1z2IjmWvj2tQd
         T6CGexBxk1fNVZkaX+88hhB0Oufjd0XOp9IuYpXeFXhPk9hfhXUbzRB1TVwsmPO1IQ+Q
         42HydizFHIcWf7BGQMwOAp8U8dDbsOdBULmqX20RMduOYUbXdOkX2LFS14MNxWwML1DC
         by3YVTzgQY7mt88cz96zf3c8uqsDCdOuobJqrBrWXsTovoG37Fz7qxwIboBNhs0rTWbx
         V9fzzLm4GcPlJsZN0aCl4x0hu+IZHhqvCNJJuvRlyFSOO71YPqT6SLltT7/K8EPx8cQd
         hwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776756554; x=1777361354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRLdvmbBl0X69xNsqP6IUVqffOA4KBnsa7u+Y5umkmA=;
        b=XmC/I/sbLOVC1Bc8DS32USXEgOEW611J3BYtxrBMrgOlUK+/TPHAudKUuMrfwAlGAi
         SMMsjegFlDAMzm16HXN4cpHYHZrygdldvXDLIjkZECTKQCRtjJS74nOYLqY1LQ/aqJr7
         1rysHsKea4/ezzVxU6vuoKt5X8+t/Xvj93LLygm1zNQpOQ8skDFP6eqMVdc1IW+rjXp8
         tAsL4ingCM6UusMJUSkUCExFWDghE8BC9LOHf6GXcnLy92ZqkiRjv4UUC2ba7wjMB2vv
         N4Twjfajw22eK6PVSySaZfssnmekVMjY2/dLWchsX9065AKrW7n0erf3F+4epR3aV+AD
         sy5g==
X-Forwarded-Encrypted: i=1; AFNElJ8woMHPKpfULoDx/S9JE1y8ECOutfd5zV5Tj7u3JzilIFsS8E/DaHyP1Em1LHD8/A9TJL7xASw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi+VEM2IVWMpa5/uLJxlQe9X+97FuL2S+2jeRyv+cmiahPxl9v
	QmEZVPZUrMxJrNLk9F4HZ+wnR/d8FvS6zF/c9eX5eYCVRplLmEuKUlsd5jy1cGn1aU1e0K2RhJQ
	mWZDaSU+j1Z8h/+JUpGL+4Z7HCO3k7AvSZKs0n2OLNr9jFVuLgqARKwzU5g==
X-Gm-Gg: AeBDiet2JN62qPwkoCn4MiEU36DhTedUojOxs1kv/ZrXFJ0/7QvWb3QlsKAwvLL7Z50
	0pMpsjtRAHCks5DzezXO2sjoCezkxQ2sV8awrtKOwe7pqrPg+z+R6RGnIbpsPWk+iqHT8zJ9wnd
	ORq5EJTzYehNopaUyRNttvfjV+0E2FG/oEAk07dp+Ail7ueBBOefAf94OttQalkXkTM0MjS3VX8
	YZOnGTllbxe9O3ok4v4e4BKTQGZvVWeQGnJVxYV+kFbeApEMdT0mAuSoV5kfnTY79ZM0ZpEpHMt
	ju1/IVABr/YiQew5toFj2V9uVKcXwUZxBRfuNFtGUO/bVq/vt1I7sSbaCxgG70gSwhEFrfXQOic
	JbYItfgd32PqV52iE1DEyEsznECHnSzoAA7Rs6SkWreuD0yqRMAma2IcBppbxOH8aF/A=
X-Received: by 2002:a05:6000:2289:b0:43c:f793:f1c5 with SMTP id ffacd0b85a97d-43fe3e0c63cmr25969215f8f.34.1776756554227;
        Tue, 21 Apr 2026 00:29:14 -0700 (PDT)
X-Received: by 2002:a05:6000:2289:b0:43c:f793:f1c5 with SMTP id ffacd0b85a97d-43fe3e0c63cmr25969163f8f.34.1776756553771;
        Tue, 21 Apr 2026 00:29:13 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb135asm39362379f8f.6.2026.04.21.00.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 00:29:13 -0700 (PDT)
Message-ID: <805a8583-6a84-4dfb-a4d4-53f80f50effc@redhat.com>
Date: Tue, 21 Apr 2026 09:29:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net] net: ax25: fix integer overflow in
 ax25_rx_fragment()
To: Mashiro Chen <mashiro.chen@mailbox.org>, netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org, kuba@kernel.org, horms@kernel.org,
 davem@davemloft.net, edumazet@google.com
References: <20260409025026.24575-1-mashiro.chen@mailbox.org>
 <20260413204921.70463-1-mashiro.chen@mailbox.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260413204921.70463-1-mashiro.chen@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280026-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5173E437A94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 10:49 PM, Mashiro Chen wrote:
> ax25_rx_fragment() accumulates fragment lengths into ax25_cb->fraglen,
> which is an unsigned short. When the total exceeds 65535, fraglen wraps
> around to a small value. The subsequent alloc_skb(fraglen) allocates a
> too-small buffer, and skb_put() in the copy loop triggers skb_over_panic().
> 
> Add pskb_may_pull(skb, 1) at function entry to ensure the segmentation
> header byte is in the linear data area before dereferencing skb->data.
> This also rejects zero-length skbs, which the original code did not
> check for.
> 
> Two issues in the overflow error path are also fixed:
> First, the current skb, after skb_pull(skb, 1), is neither enqueued
> nor freed before returning 1, leaking it. Add kfree_skb(skb) before
> the return.
> Second, ax25->fraglen is not reset after skb_queue_purge(). Add
> ax25->fraglen = 0 to restore a consistent state.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>

we are moving ax25 out of tree:

https://lore.kernel.org/netdev/20260421021824.1293976-1-kuba@kernel.org/

please hold off until Thursday (after that our net PR will land into
mainline), and eventually resend if the code still exists in Linus's
tree at that point.

Thanks,

Paolo


