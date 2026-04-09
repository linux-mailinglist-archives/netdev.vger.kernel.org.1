Return-Path: <netdev+bounces-277123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NFUHZ4O2GmlWwgAu9opvQ
	(envelope-from <netdev+bounces-277123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 22:39:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AD03A3CF911
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 22:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F3113005322
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 20:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56EB32A3FD;
	Thu,  9 Apr 2026 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV+dpRB0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A576239E75
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767183; cv=none; b=JfuUvOYm5A3S06XmXo9By/IAsuwkV0BpL0t2HtIdbpr03Ot0gPVKWQhwO7LswKdTM6a2nvE9FK+Pt8uFiLKOwyAKiHttd0L1cxPxRjPjLHVgNYLI22GlGdKE2HNPHZxm2Zh1iRowbSEZBHSSAaK9jxqV+4e3jG5Cyhg4K5TW6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767183; c=relaxed/simple;
	bh=I6om3OEZGkpPFZjSPD54Qu+bAXoJ6oSuuv5lmOezLdY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ij59ZF3AS/Sg2r/B/CcBkInPQ2/fP8zMKKa3EDU9KBtDGE2aoQDmwAtiq60j0afvL/eUKK7XZFvYt5UJQNZAH7J333cwt2JEmJEgAhbva1dI8hkPupVfjT/i6d4GeSFOkiQooeaN2SfmgqAdaTLoEDdb08T3t7+ir5J8pqb9m9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV+dpRB0; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7dbcd61429cso676989a34.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 13:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775767181; x=1776371981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3gxGTAqT3EkLbothhbi5OZZyjvwP1p7B/VxIjHUK88A=;
        b=OV+dpRB0f4cStbE8GVIq9f/bQLbMmvUgGd/puyNisxsbbP6xZiSrhDd10BFEo0ehGp
         baeCRMv0f6vubqKxURzZZsoPkSQlLn+YrP6kXJkOFFLD9he8kb1hxSNzD3L877H94BaQ
         7wl5NKAygIG4Bm73+kY5c+4b1xykLLZYRFi+en96kuf/LlEpZNLiz5/SBT766s3TTzZl
         ET+gDsqJjfIuw9xNz22TsP0s5eOjpU+MgJ8hZQluEMUJ4FD50XBl6xFQ2XtLIJd8d8Uw
         XJ/Lka10Bi0+pYIiRl5oxTzkAuIm9/IXbWwhnKtUHTm23ac7rV26jtkR6oaghBAGNQRA
         wHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775767181; x=1776371981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gxGTAqT3EkLbothhbi5OZZyjvwP1p7B/VxIjHUK88A=;
        b=Z5Kn+D0BA8jTJ5YufbwyVdDQHZIWIentqZVKvponoUoIGwmM8urmLCKmi68pgLGfH+
         YaDRhVzUvAIsy4hFpT/+q1OllvbJVbg2+36Pbqyvrhy8NcDisxC+dMJeaXOKhS+kK/Qo
         B8eRW3rLOAbEPj0Dtl7Hj1vr72B+Ap74/m9XFJRo/G5sgjHgDavTCOpn+IFr3mQGBTam
         t7cWMF0wS6rYmLUZWYysA/ZjKrcIoVXUJs1j+pyliGnFriCH4zG+xUNqVJD4ozT1UF0t
         FAmZW8n/FoedYixFDoxm4LZ0xSpfWHIYkGD3UA01TPUlAq4R/4MNbAhtZIj6ib3ko6Zo
         nneQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw1+Lo34vQAn+j/aZ9LcB4V27aYPxTq/BYXNuJ26GCUqdugOd6MaUc39ww08r7oYK4gXizQcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2B9ZCOfzL20B5Om16l7jmAP0lFuYxFp1lyHWRRpw3c5IS5RlO
	6TtFXJafAYMckZnN/Z+wdisOKbmrZwgWV3R2IP7SxP61xf59zWn4r1c3
X-Gm-Gg: AeBDiesnmcIN7mMqI9Nd187vrxz5RuGxsx7XN/WkEIAxU4q8Kp0uvCeu8seti/OX7yb
	ZjsKAj2DCX5dC3AoQXGFzd5+TBZmuKrHFH8blEA97vqf34RtFcTlbz0b2pRCNlUYBRqeLE7T+9c
	QFbEUbbamd26baz/EHxQ8UA1m/6/F+cceELd4FeK2RINmsFLQ+Jsyjv4JL6eueXmJ+krkgjfXIE
	c0THaYZH5Xlav0XAEC8s1CwZBLRnP7x1wu5n7lPKTX8H8+DohuDFRNA6PfV1yRi9Ja3LCqmLCGz
	99IllQM9ALRknAPxIj5+MzNXhymV4npI51yGkEnKLYSRT8hR19c/fHyUGBnVupWCR5aSmdALHxf
	vn1HF+1kieneSdAwZHIDKPt/L+TF2+W9XwFoz7bvl70SNPrelLuWufterhJzC/93xfWW32rpYAN
	GhSLMv8ICrhhMHp7gcvA==
X-Received: by 2002:a05:6820:1ca0:b0:688:c97d:bfa9 with SMTP id 006d021491bc7-68be5b5ac6emr306577eaf.8.1775767181463;
        Thu, 09 Apr 2026 13:39:41 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:43::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423dd396960sm614963fac.2.2026.04.09.13.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:39:41 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Thu, 9 Apr 2026 13:39:40 -0700
To: Andrew Lunn <andrew@lunn.ch>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] ethtool: strset: check nla_len overflow
Message-ID: <adgORjV4nZH0RLx-@devvm17672.vll0.facebook.com>
References: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
 <20260408-b4-ynl_ethtool-v2-5-7623a5e8f70b@gmail.com>
 <adaFjwkOrPoBgzoc@devvm17672.vll0.facebook.com>
 <20260408173943.2c239ae8@kernel.org>
 <adfG99Pb-4QewoQ7@devvm17672.vll0.facebook.com>
 <bb2e7087-aa36-4556-8778-b65d11354779@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb2e7087-aa36-4556-8778-b65d11354779@lunn.ch>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277123-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,devvm17672.vll0.facebook.com:mid]
X-Rspamd-Queue-Id: AD03A3CF911
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/09, Andrew Lunn wrote:
> > I guess... Should we update ethtool.yaml doc to tell the users to prefer
> > ioctl over netlink for strset-get and mention this new EMSGSIZE?
> 
> No. The ioctl is deprecated. It can still be used for drivers which
> need it, but netlink is the preferred method.

I'm with you on deprecating ioctl and pushing for netlink, but I'm not sure
how we can recommend this specific api call if it consistently can return
EMSGSIZE for some devices? Or am I reading this whole series wrong?

