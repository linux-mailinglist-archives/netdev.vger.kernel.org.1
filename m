Return-Path: <netdev+bounces-297265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ztE3L/1yKGqYEwMAu9opvQ
	(envelope-from <netdev+bounces-297265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:09:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5263664055
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:09:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dama-to.20251104.gappssmtp.com header.s=20251104 header.b="yREL/nkG";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297265-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297265-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F79F300D78B
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 19:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F86331EDB;
	Tue,  9 Jun 2026 19:56:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BE0364022
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 19:56:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034981; cv=none; b=WW+/CCv4HseMXotwut7whz/bvc7jEO8+myrHO3KP33TBPDLrOHNTNGg88BpRtdRzems5sfHPsHd0WPwUcBAKEncUZRyqm5rpwSddAMYEh9db9ErdaMzgLM5m1k6OcwFqtraz1rMfXrkfL2Jx/aMmow0SHJmP++zbUvSPM2/XNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034981; c=relaxed/simple;
	bh=MsfSgaZcmqEq4DGFKibOXSoVKhKaUyFuJnR70HqGRSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMJD967W5N5aN7jkz79VVufE8mCLiK1zDKuIdj68onQotfnxqYKQPp7FGSMJe3z+YLus3mVlZLBP0e4yqCUEbUcCQpH9RzIXiEPsBVW77YBy7B/h8JeJLRDUxwkY5C8UykpoGf6Fb2q8AIrpazeotfwlqZEX42El9nTCswWYmDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=yREL/nkG; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36da8439078so5313017a91.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 12:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1781034980; x=1781639780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqt7ZDndbYapehX74SpkVRc0MkTnsPzQ6IaV8n+/d8o=;
        b=yREL/nkGE0rJ1Sze+/VjG+RzY1EuajwYG+chLenXBrllVb+7F8VHR7yXqqeFH8Fxnc
         s0MaVN6JwW4HZz8NnuKCmgN/5PurZC/hyYBgtkPhGFbtCqkpIICC6O6c8eQL85aPigJQ
         bszZ0lskw1RZbrS75Zr2CGGaiw0XKia1iZmF0Sk8v+jZ2thtqk/FSJ3mc/PVFSv4D6Tf
         m3848OHUKgozdUHemd2BtvrMkqnC1L3lyr5xbvnoVX0hSZK1nqCg3dQESpcwfV1MVYDs
         6AmdV3nVXjfNUtML2Q8/JXs3Due5LMN8KFhovl4m84vKXO4io7j4e60W29/KW68toBrv
         F2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781034980; x=1781639780;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqt7ZDndbYapehX74SpkVRc0MkTnsPzQ6IaV8n+/d8o=;
        b=ZOa5bTD7U3JR6KIXHDHhQ4DPT+w0D5Kz405URQKuS57HUCYEPfi4o0fIOLA+zGqhFP
         0qnIQW+5zr0lvm7600WQCY1oEm1orKdhpNSHrAr24w9vNd+SyLLJqMxJFW1soglVN8wc
         jQHvfRXMGcj3GYTFM//QuxVQvvISs+1+34hWgFKKq8Q/721tIH2L3A7+TDtmxSSaj4ra
         0YPme323bho+kXZvs7j+aXexW86K8zuC9gxfxcsKIlK+R1Tt2Q40BL74S2dyuuMInzwp
         emTX8GIt9EwNyntTrDtR2SXXjUD+iEEYHN2hpxAVQ5r1p86YK1PUQiXCOpwJij0/Fjzf
         ODPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/KuTMdo7sEXVU/W3G+7/m8UxZ2ubet7rJ+zw5DKIWjaMgsS6drwFfDDSGDD4FjGMYnd1giXBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvdB74oShLA6ZaITyw/DPu+n4VMUIcdUDhO52Aq2uf42oWv4vY
	psEbz+fH0O068SsyCUwFD5OK0Zlcr+bbSFNvWn5AJwaRcGd3E7h4WH5K9X9FkbuIk4k=
X-Gm-Gg: Acq92OEERZNG9Ekcsg8PPuf8G9ugVy4jbv0pNz/NusCvnlZMzy6B/XvZX98DZY/BFug
	fPttxki3DKhyRhyvr+GXUDBRvcyMQC+n0C/QGz6mT/iTVZH1oYO7xuBBURTaxs11j6B/kiktYyw
	z1P5ikX8nyH9/6fsRpev6Wh8lw2hv5sews7uGDjsjeHZDS78aDa5pJcDWI6ONF8DNLv84yfw3Ur
	m7Q6O+b4HIjTOXUMf8e7WBOFyRQuRHGkcPZMLgteT0u4ZIY1M/PBqtIUnxfHBkQgboNnEg4DHjO
	Z/i48AnF6gWyo81Xy+iZ+Hh6W30UK8/87ukyPmbdfMbfDzJj3T7OuPm4U3ttfNgnwleLRsxnqvx
	4rOEtVtJFuQEJD6C2314ZZxDgMIoLxhWPLdZEQzFCwiF/HOCRDQpmV3TkSxdohoFKseO9ciWv3g
	BSaayguYFjcojNexo=
X-Received: by 2002:a17:90b:3d8f:b0:36d:70c8:3a3 with SMTP id 98e67ed59e1d1-370f0772dc6mr22814079a91.15.1781034979721;
        Tue, 09 Jun 2026 12:56:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:41::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37625ed1b03sm123806a91.1.2026.06.09.12.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:56:19 -0700 (PDT)
Date: Tue, 9 Jun 2026 12:56:18 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dw@davidwei.uk, daniel@iogearbox.net, razor@blackwall.org,
	sdf@fomichev.me, dtatulea@nvidia.com, bobbyeshleman@meta.com
Subject: Re: [PATCH net-next 1/4] netdev: check for nla_put_u32() failures
Message-ID: <aihv4sSmiub69Qyo@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, dw@davidwei.uk,
	daniel@iogearbox.net, razor@blackwall.org, sdf@fomichev.me,
	dtatulea@nvidia.com, bobbyeshleman@meta.com
References: <20260609190804.1137085-1-kuba@kernel.org>
 <20260609190804.1137085-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609190804.1137085-2-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:dw@davidwei.uk,m:daniel@iogearbox.net,m:razor@blackwall.org,m:sdf@fomichev.me,m:dtatulea@nvidia.com,m:bobbyeshleman@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[joe@dama.to,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297265-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,devvm20253.cco0.facebook.com:mid,dama.to:from_mime,dama.to:email,dama-to.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5263664055

On Tue, Jun 09, 2026 at 12:08:01PM -0700, Jakub Kicinski wrote:
> Make sure we check if nla_put_u32(id) was successful after creating
> objects. This is theoretical today, the skbs are large enough to
> always fit the ID.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/netdev-genl.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>

