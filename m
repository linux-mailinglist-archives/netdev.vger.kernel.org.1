Return-Path: <netdev+bounces-303293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J2EqGozpQ2rflQoAu9opvQ
	(envelope-from <netdev+bounces-303293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:06:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDD66E6412
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:06:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Vzea6TKO;
	dkim=pass header.d=redhat.com header.s=google header.b=Va5mVaEw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303293-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303293-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B754E303D57F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14320472762;
	Tue, 30 Jun 2026 16:00:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57732AACB
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 16:00:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835243; cv=none; b=mEGb6tfpHE+uj9x0IIHnqRA8OAnHeyUP8MPFVqHyOrsCVZJdLORYNOrN6c9CVCQdbPfmSDDaun4d5mfpnDMcp+s4D/dbdJtzFRYokc/d4nZSl3LIyP/3IaPMPHtDeP0j7c4/SW5Fp5uEEez1tKGqY87QlYXVe61veWCgIlH+fqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835243; c=relaxed/simple;
	bh=tW3qtMvvFnDKgDvHYU5phUQc6h/oVrf6P+3Hrwh/XyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k43mQZrcqB1hEsmjE5XvnmOkgbSNGV6DoQZ8VJAVO1EZFt4CsQDGuC4NGpkx7ip+rAU9H9+GrfJLvQYZC4SJycWjbm+2X2tjOt0amPKZ9xqs6WoeLbYzv43E6gZSP1KxTx/dKSxhJrD8GiCCCS5K51oC6BG7l3mgC93pEWWVMYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vzea6TKO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Va5mVaEw; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782835240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUO71mQJ/xpSXzdbrU4yXAytuZin9tKfet6HTCc59ZY=;
	b=Vzea6TKOlSHqpUx0U1Y3tdp+WiJr5rkTNocD8YdBF5+K9LVQJem9Pa+veicR/3j0eGFGrj
	bu6DazFkkUSKWzdm4H1o6540OrGDqxALTZbyu3S2h1p7tXjKC7QO5l0/GuIpqaXTpDiS5s
	9ktR7ok8DHoGFSH6sJDG04y3LO8lm7g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-iqO57n2qOcu4sL8nhnqRbQ-1; Tue, 30 Jun 2026 12:00:36 -0400
X-MC-Unique: iqO57n2qOcu4sL8nhnqRbQ-1
X-Mimecast-MFC-AGG-ID: iqO57n2qOcu4sL8nhnqRbQ_1782835235
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-473e18559b2so1383134f8f.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 09:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782835235; x=1783440035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xUO71mQJ/xpSXzdbrU4yXAytuZin9tKfet6HTCc59ZY=;
        b=Va5mVaEwOQOk9FeBf/1ROcrjJHR+I6GfCF+C9x+S3aG6ie9GOlOqTCThbOaZdJ1G76
         B4IDyhFlc27/BDzKQbiF0CbxCdv6RZInDHTwXc6icj1DCif5QoUFXtZ05JxuM7LGvgIe
         IwCbeN+C07E83hyFbFbbXlVd1oAU1QshQEN+1sv9zthfP+7kQtarMiLtgYYk6UEpC34W
         VK2ZApABASp0RgQFV/oQU/R2T0wK7loaMEJn1WzLSXYYcafXCHN75ng/cWloPJc3Luse
         9CPqjIYggyax9v8OnVEHr9SDYlKgiQHJxSTf1s+pUpq1JU1I0/gYrsZvau1Mm5q6cgrk
         vpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835235; x=1783440035;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUO71mQJ/xpSXzdbrU4yXAytuZin9tKfet6HTCc59ZY=;
        b=B73uq2YQgcyF9fha9CWM/rri/MW4LJfzayY81GgdPP4DOtsRcoINlxzTYcjmbd0paK
         6fsXpf/k7n41/j7C1tCywrJBZiv8kzqXDNuJnCMINEDGdzT4Cf6mRoyi/PUYePN0XBYf
         Qxweo0PYy7jxP3VUnRf/y5h2m6posGjWgIW7u11HxnWsgWqMEB5e+Jed3CZbfwv4GPVa
         d63DbOS+8MxZAyKJT6YXOES9zP1+li5DXe0pVsZU5F4/nERtQbWTdjm8tUzu/P38u8zx
         BDZKMSR66OfqMOKaR4+vei5JnKg2jWifG3KImq7yF0/hkPK1PF+PdK4Thj4rVBPmAYW2
         Biow==
X-Gm-Message-State: AOJu0Yx/F+8Bh5O0inLsWzH3mpypuyJKktrrELo/qzw5mkLDMLmqUgtO
	IpqihciIFQBpAkSMJ1vulkxC52QPdsEE3rptCNV2gRNMyJfYjUodqq3+yL3/bUWxgBLK6QfIgX0
	9MkNnz1fc8/SY+clHCFkDHxu7qd7O7ba8qqDkW23kuFfTW3ooWG4H8erirA==
X-Gm-Gg: AfdE7cn2+s6yS6bpZbtyMqlspAyIzPjy3zTVaNDev1hdj/+p58kSqNfF4NBrKqBJHMW
	56I/AmONdf4qCpK4gH0EmKgVaRP6DGu465EGtHLufaYjeevZfXOgGlpbj498M37fSi8/TizjBmO
	FKDZX142ra1YefhCIAMgpV17gVqWzSf6xrB6IBC7yv0GEGyaJYQi9GW7XjuuhlAczxpYZJtxnir
	6PZFSTqzOSeS9QcVBzbRVMg3kNYuxMV62CSYSFuE2Gc0M56SbsmjcE6PH1PORhZd72y+W3M6+hp
	mJ4GxjmNU5T5wyS7jQNGBlX1PR2OtKtutVPHLbeCPmUYQRFhrdR48LKYAvDEoJNA1Pa0yw+Iv6q
	T1hUaxCkOjVYSOE90tMUMIeue/tNleP0z5g5lEpn0WQhf5kkceUFds/yEtBWKdcCUe7G7bTKPKN
	G3Q80GwW4oSw==
X-Received: by 2002:a05:600c:8b30:b0:493:bc4b:b8d with SMTP id 5b1f17b1804b1-493bc4b10a3mr33966195e9.39.1782835235349;
        Tue, 30 Jun 2026 09:00:35 -0700 (PDT)
X-Received: by 2002:a05:600c:8b30:b0:493:bc4b:b8d with SMTP id 5b1f17b1804b1-493bc4b10a3mr33965695e9.39.1782835234903;
        Tue, 30 Jun 2026 09:00:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810bafsm3900195e9.10.2026.06.30.09.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 09:00:34 -0700 (PDT)
Message-ID: <08ae081f-3d4a-49b0-8cdc-2c53935de31a@redhat.com>
Date: Tue, 30 Jun 2026 18:00:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] fsl/fman: Free init resources on KeyGen failure in
 fman_init()
To: Haoxiang Li <haoxiang_li2024@163.com>, madalin.bucur@nxp.com,
 sean.anderson@linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, florinel.iordache@nxp.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Breno Leitao <leitao@debian.org>
References: <20260625004834.3394389-1-haoxiang_li2024@163.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260625004834.3394389-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303293-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com,nxp.com,linux.dev,lunn.ch,davemloft.net,google.com,kernel.org];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:madalin.bucur@nxp.com,m:sean.anderson@linux.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:florinel.iordache@nxp.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@kernel.org,m:pavan.chebbi@broadcom.com,m:leitao@debian.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,broadcom.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFDD66E6412

On 6/25/26 2:48 AM, Haoxiang Li wrote:
> fman_muram_alloc() allocates initialization resources before
> initializing the KeyGen block. If keygen_init() fails, the
> function returns -EINVAL directly and leaves those resources
> allocated. Free the initialization resources before returning
> from the KeyGen failure path.
> 
> Fixes: 7472f4f281d0 ("fsl/fman: enable FMan Keygen")
> Cc: stable@kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Breno Leitao <leitao@debian.org>

The PW bot is on holiday, no automated notifications for a while.

Applied, thanks!

/P


