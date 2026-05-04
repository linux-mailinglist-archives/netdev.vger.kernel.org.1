Return-Path: <netdev+bounces-283761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBoXF35h+GlJtgIAu9opvQ
	(envelope-from <netdev+bounces-283761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:06:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8634BABE6
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 903DA300ECA7
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B5359A7E;
	Mon,  4 May 2026 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="tUOR269P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE603596E3
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885563; cv=none; b=LIrSfflX6bjLMUO9b5VB3deb995PU4/URliE9kYEfwmcVMHZxVLUvVIFhPO9/GRTV8QX8X5/536kVLOG2BDwkxX6jmgPfa9WkuY/y7VIu+OLixbOmu2jVr8zT5CaEmIz0JS8z8w3/5TZKIktWjp7kJoHgCTK5croWuwqme7LEao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885563; c=relaxed/simple;
	bh=Jk8DjIwtSgRzibN3X2t/wMdUSa6oMFBpDIDWhZbYEIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcFFqOIU1eP9ctGhTU5dRZMsyxbvxgDe2swZDTdV/I3ircL7SUMZR2KyyEnmWIDwRtrwm3TejYI7HeqkH/M7Wr4KJ5gzDbWbeqGMW58o0/huc+Owc/kaU2mBYVpV4F2Sg8NXNZyPoWxRAwc4Y9l+b6ZXifFCXL2D3oeM14wlfsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=tUOR269P; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b150559bso25526245e9.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1777885560; x=1778490360; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk8DjIwtSgRzibN3X2t/wMdUSa6oMFBpDIDWhZbYEIU=;
        b=tUOR269PbqHtHZjwxbhVEueffWVgTNCl8z+rObRQV4y89f8K+mOe7RZ7oh2bzOmSPH
         VgB/7tZk+nr3AieW1792J6gcWLWUrBnp9S3lH8kRW9LTj0CstA4KAaHVAcgbkZLexQqE
         h9LKoYFGzfpxgWEoKmLX3oGMKbRqFdgHTTvzL3KnBZN41YCfkEuzfqXxP06RphXGEc6B
         utev2WuNRraycIwqt+3hS88z2T4IM8gvo4jW7gJEcgjMOhme7uCpsxhICDOqscdvw59c
         kW3H1MhTQ0VLjExWjaZdtZT39OvJG0ZMLlU2n9Q7KBYrXeLJlzNVmoFBF800uDOP2rxK
         BsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777885560; x=1778490360;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jk8DjIwtSgRzibN3X2t/wMdUSa6oMFBpDIDWhZbYEIU=;
        b=db6w9GXmGtMia12KVcEWr0+mIytbnC0dHiPG0jgL4L2h1ripErahDIhERZ+dELOQ2J
         /Y0aVprDO0zA7uTRFUI/HeObxW5hnJ52ZYPDStZm36kWfXiFhmDMGM3NuTEAyDGGA7KY
         Pa1xc0PQsoiJ4BbY92m+Zd1v/xOLjkLyzvPBimnGzDi0UnxPjsKoLgQSZIa6AvyiJXNf
         QajJLtHsQNOosQRscpWaqbES16a9wTM2kalvDevNO6oSijFh+qF4gFUplQ31pIGWe1ps
         0oxS61G/l1T1kekWFNIbQpe06WNK1v7dTbstpSKGe/aJis5jwT1yd9gG59qEnAX4mB9r
         7ylA==
X-Forwarded-Encrypted: i=1; AFNElJ/Wy3Wdqbqb6PFO8DGenv/wnUS+aoF9YL7wyV0+d7uiRIZO48LAOl4FDB86fNQ0SfgRrVRuN4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEUimw5N/euyTe36UMAlvPIhOKA1MUHxjejXkyr//VDohCsnxZ
	7w9XjoOJHk+WWdV2Zyv+j8Aq2dN44FqKp1HobqLngHftUDkINi3o5XOzNIZTcw79Sgc=
X-Gm-Gg: AeBDiev97br27A5c30RCNQfGMvcNCp7M0QWYirHP4Eo4Gk2gNTvXqsLch+C2tyIsmaL
	tco9k4lAqRK0ETRXRnMJD8eM0ximU0KHbtMVT27e2nLsDwC/SgXRaquBUdvUIzdS6f+IMsaMXTw
	XI4haeD1zVdJuBpxts67/yJI1JKs5HXTdPTv8AGfgpfZMh9HoAAmRqmaE6JU2e+cNrUQVoQBang
	DwOBs1RJuDOArwCPazxyN4a+KERh9YAK1GY03MG3yUSPTrqcmEmK6XgTFMOVrIMkbilk5R83+iG
	NPIOINLQn4peKYe84HmM0htUH93f+s7VkYsQ/4Rq6AyrlRVWjo3h84roAwGRrl4a7/tPq80hFR1
	WJNX6ngt80b5vY1YryhQvNPillUrg2iRHoSVbmYde2FnunttkGZLlZX7uMYl+cC6Mbge8vEzEkP
	0q0Um8KQv7lPaeoWqYw3RHPuhmla81BOcnmG+uvn9F2b561uw5zp5q6zFKmjS2DtGkDznJHiKxq
	vAmro8uM95dIC6F
X-Received: by 2002:a05:600c:4445:b0:48a:52ee:5776 with SMTP id 5b1f17b1804b1-48a986380ecmr140685845e9.11.1777885558358;
        Mon, 04 May 2026 02:05:58 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82307f28sm526970305e9.13.2026.05.04.02.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 02:05:57 -0700 (PDT)
Date: Mon, 4 May 2026 11:05:55 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, 
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] tools: ynl-gen-c: optionally emit structs and helpers
Message-ID: <afhgQgySpoxXFCn1@localhost.localdomain>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Philipp Reisner <philipp.reisner@linbit.com>, 
	linux-block@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
 <20260407173356.873887-3-christoph.boehmwalder@linbit.com>
 <20260412125502.3f8ff576@kernel.org>
 <adzVUdf74CVk2DwJ@localhost.localdomain>
 <20260413104939.5ef4d9dc@kernel.org>
 <ad4ox7ibZoiW-tje@localhost.localdomain>
 <20260414083548.02f76970@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260414083548.02f76970@kernel.org>
X-Rspamd-Queue-Id: AB8634BABE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linbit-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linbit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283761-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,lists.linbit.com,vger.kernel.org,linbit.com,gmail.com,google.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linbit-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christoph.boehmwalder@linbit.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,localhost.localdomain:mid,linbit-com.20251104.gappssmtp.com:dkim]

On Tue, Apr 14, 2026 at 08:35:48AM -0700, Jakub Kicinski wrote:
>On Tue, 14 Apr 2026 14:08:58 +0200 Christoph Böhmwalder wrote:
>> But we still need to support the current family via a compat path, and
>> I would much rather have two YNL-based families than one genl_magic and
>> one YNL-based. Carrying both sounds like a nightmare.
>>
>> So the spec proposed in this series would never actually be used to
>> generate a userspace client, if that's what you're asking. We would
>> continue to use the current libgenl-based approach, with some userspace
>> compat shims to make it work with YNL. Then, when "drbd2" comes along,
>> we could "do things properly".
>
>Let's jump to the drbd2 work.

We have a bit of a chicken-egg situation there.

The drbd2 work depends on the DRBD 9 upstreaming series, since the drbd2
netlink family will use the new DRBD 9 semantics.
However, the DRBD 9 series depends on the current DRBD module already
using YNL (or rather, *not* using genl_magic anymore).

Our plan is to convert the current family to YNL in-place first, then
incrementally add the new modern drbd2 family with DRBD 9 semantics in
another series.

How would you prefer to handle the YNL switch? If it makes it easier for
you, just committing the YNL-generated code without the generator is
fine for me. The old family is effectively frozen, so that would work.

Thanks,
Christoph

