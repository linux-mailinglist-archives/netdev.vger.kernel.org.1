Return-Path: <netdev+bounces-276649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OBlK9aG1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:48:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F24C3BF10C
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D84830470DD
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFB53D3328;
	Wed,  8 Apr 2026 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCRg0nq5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDB13D1CB4
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666620; cv=none; b=ZryH7QHTf2sRL/GZvYaWXEEIUfsdeTgIQn8xGtsHHI0zSp2cf5rQYcSkUK5amBrVUwPTQXk+EtZ32qFPzZYFYGIZtEGhmbZ/ndY86+XcSk+Y6DjyNmMtk4nC70wqI3PgS42GrUlg/w5JmKcXYT5nanQm8ZbmoFC9VyTILw39MbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666620; c=relaxed/simple;
	bh=ZsmZkNWjvfLQnLUnLwC+S9ery1VMukelPAc+HmzPAQo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdaU9M6BVqCY42UOcfaiI9Tp3tk34cxkATyxlBZhu2iKIIinNcfy5vCjXItajIEwLvaIF7FLr4Iz3yl6r6yW2L7K20otg+6sMhy02iqTqVivkB9jo5kdI1q28E+oxhGbyDka+MTg0TXCSOlt7PltdywAbxVGiD+PoR89hW1H7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCRg0nq5; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-471618e202bso16930b6e.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 09:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775666617; x=1776271417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ExRf4HLhLOoGUxPF6JxR6INr+6Sdip5p0HRwO8b3SNs=;
        b=cCRg0nq5ubGqUMmJyTfnX7B+hbsMbebQIpbwuIKBO3g5eDjXOQdPNPTBRyu1gvVtKd
         owpnkNoX7lSkxObnxEp2EzFFNr1WbhSkOYeJcW3GqpC/dXJv1msL8YGNwjy+rlo3CjVF
         8EmpMni/Vgaidd6Kli9RqmcSsuc9c8gWRi9VSMgptpWW9mueEW3MTWLS+fLlqe4ZZN47
         aF0rVa6E74ZkNWEXhYEWvfV6379/26rdUak1BEfDNuB75BP8Ds6aDgDcNnbXnt4WsCbL
         5bEmDLHcQZp+J4QAxw/st/eoSdDHZ1Uev1xV8aciIatK3AVzyoSEZm5NaTQ2cDRXwot7
         3fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775666617; x=1776271417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExRf4HLhLOoGUxPF6JxR6INr+6Sdip5p0HRwO8b3SNs=;
        b=ABOg3GxSAQXnArDWwnGIfYq9zhuLdxzZkyyyMhED+R7a7/2IZgI3pRWczaM+Ugt7Ot
         jrjhPbyySycZBFc/4XdEIgMqANFOPsDsIcK3oXU/BkgZhGwI2/o7QwlYlH/Jmu8G3g9X
         IsxBpH5+WFOe2VVNojUBMXQBw/Tjh92ArA8Ay6YWui4/lxWgVnm8VHIJC03YBmX2BQJX
         mESRvFaBJnRdgx49YN1awDFrYNTaHPrPWga2eGNiIpuO681okdMYKiEPN3tcrpf8Td4f
         kPCZh8iELljAPqbaeR24gpn8PVkT8y8uIqkDJJ84SsbH4VJvRCxsjsm3sAVTNzXoSP4I
         SWOA==
X-Forwarded-Encrypted: i=1; AJvYcCU61vf/IO2TXJJ+SqVh6ySsPZI9MxWxeQyRiTuDfiCGMp60u7RbNqgh06ZHdLGX8Z0C7xuCzVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnLUsYBWnRw7uliCjg/PPnbXHUcEh3/iK/gaxRiQqqxDrYUqII
	08XLYAsiu7V6sDD0up9fq69xpSeQNHgK4YI8UYeLmFER9q4fZOBbyJL7
X-Gm-Gg: AeBDiesRjdwgjKjRvj8aMW2uyeTM5p+tni/4uRzlP4eK4zXJzmnYVK7xAS9AAhuaaUc
	s8x/8eA35y7gDayV1QTsfh/0W+Cyd4nsKx+XRKdMD+f7vRmQRiO4sH7P1Q0UPe21HfkOew+zS2k
	zbnhmqvSVl35K+l4z/M3AQmOBHgN6VJj/SOT4vPeuWDLZato4Oj5jmWhoITunMMeHiUgm4Cc8dO
	3boDxXuv+Y4N0+XADRJY2RhZ1CRBXYHZgQ+Ugm/rIK5qbzmz4G+NPYxxy8aZ0jzCC3E4G8VY6iU
	K/NjLOMe9EMZ/rH3bZPH7isg1eflMgEm7tF2NmrfHoUdxvHS+FBuhgO8Z9J2XwLljs4/AyAPxmy
	fxqjewjIwMzAJL0I6zg5/XdvKCrHggOJ7yusglfc0av+EA0SxxysXohdWa6N4NkB5RsxO9ZtdHl
	7VYEli7aoCwRhTOHBj0IpJQApT8dTJ
X-Received: by 2002:a05:6808:c183:b0:45c:925b:5848 with SMTP id 5614622812f47-4772407f243mr200072b6e.45.1775666616928;
        Wed, 08 Apr 2026 09:43:36 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42356d581c1sm8153584fac.4.2026.04.08.09.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 09:43:36 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Wed, 8 Apr 2026 09:43:35 -0700
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] ethtool: strset: check nla_len overflow
Message-ID: <adaFjwkOrPoBgzoc@devvm17672.vll0.facebook.com>
References: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
 <20260408-b4-ynl_ethtool-v2-5-7623a5e8f70b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408-b4-ynl_ethtool-v2-5-7623a5e8f70b@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276649-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm17672.vll0.facebook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F24C3BF10C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/08, Hangbin Liu wrote:
> The netlink attribute length field nla_len is a __u16, which can only
> represent values up to 65535 bytes. NICs with a large number of
> statistics strings (e.g. mlx5_core with thousands of ETH_SS_STATS
> entries) can produce a ETHTOOL_A_STRINGSET_STRINGS nest that exceeds
> this limit.
> 
> When nla_nest_end() writes the actual nest size back to nla_len, the
> value is silently truncated. This results in a corrupted netlink message
> being sent to userspace: the parser reads a wrong (truncated) attribute
> length and misaligns all subsequent attribute boundaries, causing decode
> errors.
> 
> Fix this by using the new helper nla_nest_end_safe and error out if
> the size exceeds U16_MAX.

Not sure that's the user supposed to do? Does it mean there is no way
to retrieve ETHTOOL_A_STRINGSET_STRINGS for those devices with too
many strings?

