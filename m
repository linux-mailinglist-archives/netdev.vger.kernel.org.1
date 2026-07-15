Return-Path: <netdev+bounces-307679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ne+CCt41V2qiHQEAu9opvQ
	(envelope-from <netdev+bounces-307679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:25:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2B275B681
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:25:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=O8T0jeKg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307679-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307679-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41E5930015B4
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9B531A570;
	Wed, 15 Jul 2026 07:25:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF88379EE2
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 07:25:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100308; cv=pass; b=bG8nUC+H+gCbJKYfT+4BSewQk6WidAx56IRpF72vwQBA8yyRJlWjGLaz/Dtod9L7MnRhRgL9P7EUZRkJV6pws8lO8igEbkj0u2za3/QYMODKoQTsjH5wrKt7Iaahh1oAm3562eWhYvVC9puxxaQLrlvLWRKkcI6mKmcPJVjMn/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100308; c=relaxed/simple;
	bh=CiUQnep/ElStnuBv4veoEXO9yRsbI+gfwEOXFAkI0WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMqLbsZcNwDMzVmq7LlD5WbMblLFzKt2o4rXh3d4vDe9efrHHN9YDpitTwp/yv3Wxjuko3JONkz937bJhc/Dqmi8zljg4Z9Dq027sR6HPHsKC/sQFXHzOaVNwoIZ/davjJzksHIpru4IjD5GgYpJJj5sFaKC8o98na8YjIdoqKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8T0jeKg; arc=pass smtp.client-ip=209.85.218.43
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15f020a223so677469366b.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 00:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784100303; cv=none;
        d=google.com; s=arc-20260327;
        b=IpAerUhlaaSkDWYLJXEXmS0SncFQGdw56kwri8+a70ZG14Wchxzvvs83rtLZiI4M8a
         QQD/EnC3hx70Dstf0f0uKrGZIGYy/LMRH5VLyAXr4YlU4GfqUdE6vRtfiuy7acW8HCwx
         /qT/8ZpaDu114pCU7NCqvgKaGTN8vvmv/OMgfcWYZL6xQzA6jo4uis4cvJMeqYv3DX3J
         ZcnRCDfi7MEWdtOK3FwYJ5jqfOgnTgE4jofLbECb3Ch2Pxo5JA6ZPFRMJgJw4bLUR/7Z
         oTKwT7VmEN5W7P+Re41Tfufm6HEuPcjMG1vc7OjDT6GzlYg8l0YkQztJfTOQe5daDFHB
         l2NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1RIX6W8fS2utVbAhfV0W3+IeWwGd9NcOFd/862WXhnk=;
        fh=LwzvBwhI9uzA4fC8xkNOfBUQKu2x6RDK5+DUArnRlGg=;
        b=kzHCE9YR1ClDuMaBp589AVz6beAZY3k9Y/ZgeGkwQqAeiFQurRFI5YjIpefsjO1SQv
         sve8gs8DGEH6PJ7ucSg2tWepZDH7M9/oXHayUB5MoOT0ZBvOfszWhy50OQHx2IVZwbr+
         dxImK+mvAGc2e1cQqiYh7hdeQIEdMqzLCVl2nSGo2oksh89BaP5iirhN+H0z4T9uRUHd
         wO0QVFnCyhClRLoaZ1AL/Phut3D/ta0CHsGWEXhP0ft+H/EU/qcdHwg/qAulgYx8+Ncs
         GvEpGf3UT1LxyPNeJNOf+597WUwc0yTry77DPonD5BMiyJCTw2/GEBH+srvGuLCdvmwT
         xEZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784100303; x=1784705103; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1RIX6W8fS2utVbAhfV0W3+IeWwGd9NcOFd/862WXhnk=;
        b=O8T0jeKgo3tvxlqdivaBmn7Khl993/Ym67sQ111HunvTZvwOf8XrhFtN+fPRwrNLiC
         e/8jjkySMbc71LBxLs0hnpjR+jG+AxgE7+VXUqCql43aU6BrGuyzOETgpwPE84zbcg36
         tHfYnK/mvN+nRXVSAhqiyQHZ8knP7T9dc6n5JOsSz/c4iZOrVwbDtvbxHMg1qjOzC/Ro
         51ch1LZlq7TsM9tCKcE5qTmfXXnouPrZXhbKfjr3+saJj5s8c//5TXQwpazgM2TwucIh
         8epgvI3gKd+qMq73iYGgPYzWO922V8Eq9JWU+oFIOuIbtsVpgEPX8Kt3WS8/hDkFdjwZ
         7nvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784100303; x=1784705103;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1RIX6W8fS2utVbAhfV0W3+IeWwGd9NcOFd/862WXhnk=;
        b=AB9Smm6fVb/4Xa/b0Neeu+WjA2wkHfnUm+/EbQPQzDb9ity33kXucquZs2HLhlDncn
         Q1Hu9vs7TeOC9iEbMSn3ZRb7MWuSl34wNJZs7LF20mQGXQnUBRb6U4J+LRb9LE3lwssT
         WPpnvdlqKe7vvj+SfMghfbifoyXH7kfFQ5xIJbPurjeM9225Qa7a/cMXWuiHn1z76Tg3
         n++ittQqldRC/OrvZ1v+32NYNWfeJb9WU0muBGzGwcK0N11TNjlcpGLUPHbVgJM1/+mi
         rKruZshm4GpdhgZ5W8OfiQGQzo3txZoy305kmUA4Ag8nnqsSZksU9od6TdzLiIGu4yD2
         Gepw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6bWiD7dLr4ofLLegS3irMNpLn1XWDtbf+ccQguP46FP2tNQRNhAHSXztzM1gB0Ahos5GwI6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyonlTSZruJ6kr5GdiPQSn5jxJjze3ZTZf3/8Q95IFGY0L6/9+C
	mD7nwgf6HuNNlEBXXMDCf0EdutOGyLc38wRqCAd5Vi4SbWra9OBBppBlqCD0tgSSSzl+P/zMRna
	z/2y6Z/vWQi2lfvQUaTYMbo3d5Q6phg==
X-Gm-Gg: AfdE7ckVdl2zgQcFpzo7m40YLOkWn/D7KJLoOQFTZQFdJpLG0bZ1H/sOpkJc/zP+PbK
	euM8h1Nhh153Je9/VMzgWX/IA19wcSDD/bqfZxyHoi2Q8I/oUc9mLe97KZE7x99v40vMd1Xq2O+
	FuhgbAZ7yEWwK+YZMl1wLznijfTLdpDLu+g/PBiHingbtbjO4KYE7hw4UF9fvE32sfOhruOoqwe
	sXTJ3d3dWaf6Kr0a+qvsaILW67jfKyFvsm7dFQQyUyx5QcwWnjHYl/8HWSfH24Aeg1JJZCVJfjU
	zXy8YOc7l9TijqstrRuVUPBZZu9FGE5CIq3gY6ZkQcwEcVJRSl7MBhTNd/sVyUK2dKOZ34zEM3v
	jiztSGw==
X-Received: by 2002:a17:907:720d:b0:c16:29eb:e834 with SMTP id
 a640c23a62f3a-c16679e62a5mr305750166b.21.1784100302760; Wed, 15 Jul 2026
 00:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714081025.89163-1-mhun512@gmail.com> <1708246e17ce72f3b30d77ccb54d79b8d0909a8f.camel@codeconstruct.com.au>
In-Reply-To: <1708246e17ce72f3b30d77ccb54d79b8d0909a8f.camel@codeconstruct.com.au>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Wed, 15 Jul 2026 16:24:50 +0900
X-Gm-Features: AUfX_mz1IhjasnfviMVJX7rwsglx8jNov7blwkiLwxgjKnCA2GBhCIbpumNDBzE
Message-ID: <CAGEsz8GCvxs2Bi690QksM2e-uVuNTnKicg=w2XAuBsLXy9YDHw@mail.gmail.com>
Subject: Re: [PATCH net] net: mctp i3c: clean up notifier and buses if driver
 register fails
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-307679-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[codeconstruct.com.au,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:jk@codeconstruct.com.au,m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ae878000@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,get_maintainer.pl:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B2B275B681

Hi Jeremy,

Thanks, agreed. I'll remove the unmatched i3c_driver_unregister() from
the notifier registration failure path and send a v2.

I generated the recipient list from my Linux v7.0 checkout using:

  scripts/get_maintainer.pl drivers/net/mctp/mctp-i3c.c

Since I passed the source path rather than the patch, it only picked up
the MAINTAINERS entries and missed Simon from the trailers of the Fixes
commit. For v2, I'll run get_maintainer.pl on the patch from a
full-history kernel tree and add Simon to CC.

Cheers,
Myeonghun

