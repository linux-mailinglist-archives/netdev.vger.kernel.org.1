Return-Path: <netdev+bounces-273947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JpNOGzLzGlFWwYAu9opvQ
	(envelope-from <netdev+bounces-273947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:38:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CAD3760D0
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C742A3158CEB
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FA63806DA;
	Wed,  1 Apr 2026 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj2YXAX2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4AE37EFF8
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028471; cv=none; b=a41h7qg/6uJxT1fEFa0AKNCzZX3e58JEFc2E01eoUBgK8MBFQFBbCxwvQ9K7sgEOLi+K4FFluCHKier2nJMqWDHx63ZrD9MbQhi1/jyx2vEV4W4FFF4yBcyKAUOELM4uGR3dvyfzMYiMGg9SZ5/C6XSa5c6RA3m53E85NxivRyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028471; c=relaxed/simple;
	bh=lLMrZQUEbteA7AyBPy0hIsvctO++LyswbB2GaC1xGhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFdm301JX+DHiIt4BaIWYtb9T9yM4SUaprZdJc2wZ2D8WE6QQaftwfd/VO5lbHczgAC64hBbhux7LMx4E19P/b4EHdiiEWtvRlpvnSmEVQ7UQcET1/HSa6b9Hliz1BrcaDYpfrYIe+UJpKkOomUaSQzuLvhZV71LAWbPXvrb2Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fj2YXAX2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82c28f0a4ecso4589920b3a.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775028468; x=1775633268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAcfd5pCRSTlq7Qwg9y5Tc9lUEvaQc2W4YX+tuMIqpI=;
        b=fj2YXAX2/U8I6L+UcTX/bJGSqZEcIX9woIDs0Za2b8vT7iE4XLCNeB8QZtGoVaiXOV
         GHSwwvn/RmPuKo9ZxtXGjRECyJniPYUCovkULDDzoA0OBc3WFqux8iQDcyalixuOM6mO
         r3s+IHhAvqgdWaDVnnpnx9nX6LV6eRRMXdsVqaKVllAOQQo5QVBNzE5HpNM7ziG6gtGr
         2kdrH02mDHIVczMByD9SjPh7mKHEB0jFSgh6S++M2Am1n0VVhS4eoVlMRZSqLSRUMke6
         u8odBZDpdNHM374pHpGrxwIsBAmkP+BDvaiy7Xrr/h0CjIFF8+VV178zBSho39GB6Z27
         Yp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775028468; x=1775633268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAcfd5pCRSTlq7Qwg9y5Tc9lUEvaQc2W4YX+tuMIqpI=;
        b=ks5UdScoWpCS+teTZVgBz2Hkchrab7NGEmlyzZAxGjRnAJnyaLKop3sil/q7IAmIJM
         P+LEsUnD7+k+DHIqi3o1HZ2CtSlfGn8D1pRlcy9tRJABbqzXwkwKZQjjDbbtaqKuCWPH
         WByuazP0/SrOIvOMM3zADGBjPMqnm7DFDU2kGBAjRsRL6oR3tarLFudYKY/eduHZ2q83
         bSxJGG390pTR7G70g7dY48FjTmc8NjTX0Mj1fMRjHkJxLBjAiWiVYTZMyfl4g8fLKzu7
         Curv863YbPqwo1DvqPkmB2a0bXyBfdPrgDzfZcUGh3XpLS0/dtDA48oysZgdO3pBXZnM
         YM9w==
X-Forwarded-Encrypted: i=1; AJvYcCWsX+tLOCLI1p7NFC65pyUzWMZp8myvj9/gZwM4H+YNDwT667mWmzQHBK7LePsjOjvOiru0+zE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5T0Vv5Rv8jXFnzxmIMyaLTgKHhF+CmSjUFsTQbHkOrvTs9d7
	G7xOrqgehr5/ba7a//JGVye7RZ+FZaIVCqfN9x9PHl/DmJY5WvSQgMUs
X-Gm-Gg: ATEYQzxekbUVaRd+LseLDC3dHNDN6N9IRl3r4yNQ/n5P0dJ+7s1/Ez1syN39l7EzWko
	3M4XToVQhxFX32uLpEpEV14Cfq9LYFkYX5Eo+60YJzRCs5ziUgck9LFVtCB9fVwXeNpkJddGgPN
	d5SCOpUeI/ttEX78umOSvJVYRhRpNAeCQFMZJ5xJMQKgy0K044eyP0QCD3E9DaEZG1TdHwifMAc
	mgBN1AuIGdFAT2tS0gEfXWFN4GoxN8+/Gszuxt3Ha4ODRFbVrYSwigzEHchBQznxEtpmzcFEBhS
	s8GXvNdpcjVSKEBQe1qp4urgdHt7VrszkcsQkb95W14FW9we0EjUXDMNxAAEkLqTcFaB0hquhVc
	XKpuXxUhn7VHBHDx0iKpfseJRMakUxL70c3h65GGZplx1WLye6wyxf0YkniNT/Nv/paFud73Acb
	ztqFUE6SIffDvTwTF5Gy49BYEpmeY=
X-Received: by 2002:a05:6a00:bd12:b0:82c:9c90:54cf with SMTP id d2e1a72fcca58-82ce8ae8343mr2708723b3a.43.1775028467978;
        Wed, 01 Apr 2026 00:27:47 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cdd04bb0esm4192403b3a.38.2026.04.01.00.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 00:27:47 -0700 (PDT)
Date: Wed, 1 Apr 2026 07:27:40 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] ethtool: strset: check nla_len overflow
 before nla_nest_end
Message-ID: <aczI7FfIScrKhBGQ@fedora>
References: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
 <20260331-b4-ynl_ethtool-v1-3-dda2a9b55df8@gmail.com>
 <20260331184637.58b968ef@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331184637.58b968ef@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273947-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40CAD3760D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 06:46:37PM -0700, Jakub Kicinski wrote:
> On Tue, 31 Mar 2026 11:56:13 +0800 Hangbin Liu wrote:
> > +		if (skb_tail_pointer(skb) - (unsigned char *)strings_attr > U16_MAX)
> > +			goto nla_put_failure;
> 
> bit ugly, let's add a variant of nla_nest_end() which can return 
> an error on overflow (without the warning from patch 4) ?

I was tried to not touch nla_nest_end() as it is used everywhere. But it makes
sense to me to add a new function to check this. I'm not very good at naming,
maybe `nla_nest_end_validate()` ? Or any other name if you have?

Thanks
Hangbin
> 
> > +
> >  		nla_nest_end(skb, strings_attr);

