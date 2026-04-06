Return-Path: <netdev+bounces-275704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id s4wODwz+02lbpAcAu9opvQ
	(envelope-from <netdev+bounces-275704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:40:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9682A3A64B8
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C268D3010242
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1937B38C437;
	Mon,  6 Apr 2026 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Y99bQVC1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD507175A9E
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500809; cv=none; b=a2e5+/moxWgIvy1N17CQPLR/Ja0o0N2j1jplGRHp36Fw4Q4LX34/7n+io475ymSKZTPhKaw28auozE56vS4w2lO8p9rUOERNtx9zyNLIAa90LqjUAiNmc9fYanJfxsFAeSIe8soN6F/GxpvCKnah8wNXlhkFnWYAeKfS0vBvnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500809; c=relaxed/simple;
	bh=aiuAcaV4yFLMn4T00LhgcC6CWWrzG8beixwMz8mRQNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvHp+FyE/H/Zxb/jWvtJ4I2PwMinuVlX0OtfLhITg0ePBksz9HVI6gAsK1a5oyijySyUm98UIrZxP3paxPchfNMn1crZpawPCmbkwFfntDRqLmjLhsCXFH3Wc0kZP7MJGxi5q6BZoe90GbZGUxqzD1sJjc/SLFFygu4koEEqxkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Y99bQVC1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-827270d50d4so3735831b3a.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775500803; x=1776105603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrfB4KDD6LfKQBg0YyaAbizVlqsEn4FOH33HJy36dpM=;
        b=Y99bQVC1b1uezk/QloHoNNwb0uu3PpNro++LwKWAwTMfUZSMRc4XqFRgYlGk2EvkPB
         tIAjwlycEX4tURbmI7wp3MLQyME62aYDHQSIw4fTozajymqwe7Nr6aKLof5Bcd/fl6Sw
         KLKxu1WZQX9dxdbjCQXqr7fokDX+tVUVZP/5jH2A8g01E/uGVyPMKNWu3ccTr+CE6tq/
         UU13OO37iE8EWTHJ3ay4qApQlcfzfiOxDx1XtRBp6atuiTOBn/NrCBy5XYuinDU80Wis
         aWjURqpnj1/NFmlL/eUM9DUu0mb2SnqIQxOdiAuBImqmGjegdVa+nC+xMAapfS7C1Qiq
         C3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775500803; x=1776105603;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrfB4KDD6LfKQBg0YyaAbizVlqsEn4FOH33HJy36dpM=;
        b=N2C9J6ibiwjanZyVCK5gSGFoWPkRfgcg6pgabrOtOYawKxI4jyI3JEHZsT0WpYKCZi
         m8xXinRpyOxfikQktIIFYsbflL59fduC+PJLtqWgotFXcoxq9ssGVuNKlHLnoptB/cfo
         o+u0yvUGdolL7CVJyxbuEut39aftMLXNOLl6hrywHS0IxMX2RAH0aCPCN5mIfc+1Qcmb
         hT9St6eu3MdjJLTI4UYrqZGKp8uFHTwYgwlM1owrMahAAK2qgk1hqCQo860AJw8lMANi
         rY1G7IQfOz2ZMUTf6WGiHvWHoVfLoiHfl6YXNv98S13w80Wtj1ElAg7ij8iczYe3cJf8
         gUJg==
X-Forwarded-Encrypted: i=1; AJvYcCVylOWpQuVTt7IRnIMWAvng340Uz6pNHyRWJldgCoC1S1dZ5PEH3YHrkngAQHnj6RChIya1loA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzioroWUoIjrPyaWcb6ePXneZDrQObUgu51koIKCPuAyYwpqeaW
	AUOEMLiKcsJn8vDdwMdYLmkHdUSCo+w77kn/jmksaCXY/tDnrKb5ye537qR7ccMTKJ4=
X-Gm-Gg: AeBDievx+LgURhuXrIaX7h2kr1/rnJ9OlU1J6W0NI4TWjcF/eiaJZB/xJaOK5a203VS
	eyf4hIZ/bVBXM8AIZd6UGoH5XSfDbWOMpyuIWPCsofalzJxzMuWONxk/l3umnFXkDYxgXzTKB58
	kQb5x/eqKFHv7JN6fw7sy8bhi5Pl0uELqzEA8o1pFP+horgAv75zzhUMt2/Widz8CIyYttE+j2P
	GuIxZ4DPvLN2A9ayBHN4OndGkG+ddHlVwmB/J2zQUjQAovwW0Ddklm9BpMs1ZtLpxqK9pXQmlut
	10+wBn5t5Y7XVbUIv0SFEcKdhBP9zFjRyEJSlG1TNoIr2krHBmWIl4pnpcsdWPlhSESWH1x+DC1
	TtYuMe7KSfF8r1Lk64sTBropXrZokN9TF433f9FPsmfNnz0fLpUfidqavDv2YAVDMvaLAI7PD49
	rf9dIKvJfkn4jXoHM=
X-Received: by 2002:a05:6a00:3306:b0:82c:2555:b9b2 with SMTP id d2e1a72fcca58-82d0da4fe1amr12187358b3a.10.1775500803251;
        Mon, 06 Apr 2026 11:40:03 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82d11f76c09sm10655900b3a.55.2026.04.06.11.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:40:02 -0700 (PDT)
Date: Mon, 6 Apr 2026 11:40:01 -0700
From: Joe Damato <joe@dama.to>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/2] net: pull headers in
 qdisc_pkt_len_segs_init()
Message-ID: <adP+AeuYK0eq0q0V@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
References: <20260403221540.3297753-1-edumazet@google.com>
 <20260403221540.3297753-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403221540.3297753-3-edumazet@google.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275704-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lunn.ch,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,dama-to.20251104.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9682A3A64B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 10:15:40PM +0000, Eric Dumazet wrote:
> Most ndo_start_xmit() methods expects headers of gso packets
> to be already in skb->head.
> 
> net/core/tso.c users are particularly at risk, because tso_build_hdr()
> does a memcpy(hdr, skb->data, hdr_len);
> 
> qdisc_pkt_len_segs_init() already does a dissection of gso packets.
> 
> Use pskb_may_pull() instead of skb_header_pointer() to make
> sure drivers do not have to reimplement this.
> 
> Some malicious packets could be fed, detect them so that we can
> drop them sooner with a new SKB_DROP_REASON_SKB_BAD_GSO drop_reason.
> 
> Fixes: e876f208af18 ("net: Add a software TSO helper API")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/dropreason-core.h |  3 +++
>  net/core/dev.c                | 51 +++++++++++++++++++++--------------
>  2 files changed, 34 insertions(+), 20 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

