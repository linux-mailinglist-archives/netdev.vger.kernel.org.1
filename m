Return-Path: <netdev+bounces-267575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBtdKkpwtGm2oAAAu9opvQ
	(envelope-from <netdev+bounces-267575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:15:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4111E2899D7
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC19330172E8
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27413CCA1A;
	Fri, 13 Mar 2026 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="vt+EsFRu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506C36165B
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773432887; cv=none; b=V91VqUFLkAeWCec6yTwTSjAGYZ2ufhDbwRFa08e78cC9ceMmeW+Z4HNklziyyX0uMB37Yz9Lsyl7B5RoHVGu6yeaPnksQ4OmD3qT0dtc0cvRlp3AHnk1D5VrJWVAfddI3/I1dZA2vlMdKgnJxbNLRrPYKSqj3uJVU7cSJlytAP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773432887; c=relaxed/simple;
	bh=C6NaMAXwnq0RmKje+inKh/zM6mCLq25/URRVI50BuDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbTKTtF2NinPhlLGMboEISL51SkMD72E1gvawYUnuDEHQLTZ0YSoNrhENU9Fn+mdGUEu4xkVXqe9N34tb+nWbfSOHOjwlVodZ8h2t604gotO/a4Tuu+2sCiQRC2GNFwQh3j3eLDosoe2NKQTv0rmlu7ugG6PrcXkbTYumqSbHEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=vt+EsFRu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae43042ea7so32431555ad.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773432886; x=1774037686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2+oXD4u/vFbra8LKJvQTd92HWUFv8+tFdkTCdR+Q9s=;
        b=vt+EsFRu5qpQ2yBOrEEmENWnp9y2D+lNXCnP/IhDCCE7JRjNMHGbKfc9+cQopQQvlC
         vlSttWIBIxkmnfF0DSJFPthUUItX7dT1DrJcYz7h9hOu50PS78TiiMcNP0oiYmYAxi97
         scouOHCcvHfMdX+anQsgFms+uGvCbAr7XUILxCJ+7L3Gjc5/IXDp232TZyGx3CzC4unR
         Ajy+O2ovpJaYsyWLMjWs3WDahSeHmXzJaJYs5fclZ74GQxl2m9g+6fyIjOQ1CTTtyCNb
         F8s9jymrgsnQp+glsizauXqon7Gq2alphJvYvql3cqB6Isj1LigqpJBzHIzyvPeNlc3X
         CyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773432886; x=1774037686;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2+oXD4u/vFbra8LKJvQTd92HWUFv8+tFdkTCdR+Q9s=;
        b=fDmgzn7wZQLGLUQqA1cbDf03B3RkwJAuLJZvrabdOmzG/Sk2EYv9+47Ykb7SXB0CBK
         WExcG4xhXOEJq8VGfU+iBYfCU+XObkYi087lvaDyShuZWl16yNDohus/29ZGDRgm2kq1
         FVw1YPOH4HgYDX1TIa7i7OoWwY5iPXavn0O9sBzAsVXCEWOElInGXmCTgfbaKGCPWWX1
         lpoa9/egMuWm9M+EUXszOYaV+ynQaDpPM6K4127MdmVTNMAW5u2ocwutTY589HkmGGmh
         cuJVMCiZQUXEkKCHIq8Y1pCFaRbtLtR+ly+Ij6ILN9rztAYusi5och1pTlikElfKruoE
         K07A==
X-Forwarded-Encrypted: i=1; AJvYcCVkDkS7YIWIv7cl8cJ9xS1DyCmoj94PQoHskOZbwgQ617wNeuA9YPI3s94wxtGefcZLPqIrHX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH5/X/CDOZFcaWS5iZVshC8F9zZqsQOS6a9nTEGnAxgPOtlacR
	/vNFplMexeKYoSPAwOQNMRWRe0QNvENxZa7/vK9IlzGCu69rVBXBfT3hyf1HStlVnU4=
X-Gm-Gg: ATEYQzzNXTWBqZGUraY1xMhKxJPB78fSeFJwg4oE6cgjiJDVBsluHvaBRKQk4fwU3Eq
	l48u9yKGw5jZirYtWWw34FayJS3th2qng716klRsDmXjR+J2doLVC9vqC42gL8NarZMsJpKMMcm
	IchPB2zgnyCkkFZvyUuR3Wa8G10/MnZyPouLD3ckQTjTETSgKCEiIbh+b18D5l6NZrdwPgfjacC
	FwqmOmxRwG3Lk2iTLRoXgbd76EvZS4qDnkN12NP2LVtQaLrJjb1FjzXO6CGo4cgzO/yk5b31IHM
	5rrn3HrhmV3V1ngbteZnSe7jF5l+ZPdmMoAOqKhV7zo1gxrpPTqy7qvylfIdhvXN1DMhLIuO7cd
	04hXUqCJr2bY+ncIBsYnh7ueTa6v8+ziW0S69449knY/gKbNZsI5HVfzqRSBVPDvmV3H4PkchD6
	vyjhNeo19gzWfT0eQ=
X-Received: by 2002:a17:903:2985:b0:2ae:b9cd:d2f2 with SMTP id d9443c01a7336-2aecaaad204mr47914175ad.33.1773432885928;
        Fri, 13 Mar 2026 13:14:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb993e40sm2505980a12.8.2026.03.13.13.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:14:45 -0700 (PDT)
Date: Fri, 13 Mar 2026 13:14:44 -0700
From: Joe Damato <joe@dama.to>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/2] net: dropreason: add
 SKB_DROP_REASON_RECURSION_LIMIT
Message-ID: <abRwNEwnn5httCSB@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
References: <20260312201824.203093-1-edumazet@google.com>
 <20260312201824.203093-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312201824.203093-2-edumazet@google.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267575-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dama.to:email,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: 4111E2899D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 08:18:23PM +0000, Eric Dumazet wrote:
> ip[6]tunnel_xmit() can drop packets if a too deep recursion level
> is detected.
> 
> Add SKB_DROP_REASON_RECURSION_LIMIT drop reason.
> 
> We will use this reason later in __dev_queue_xmit().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/dropreason-core.h | 3 +++
>  include/net/ip6_tunnel.h      | 2 +-
>  net/ipv4/ip_tunnel_core.c     | 2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

