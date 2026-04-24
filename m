Return-Path: <netdev+bounces-281002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C4NHEyH62lBNwAAu9opvQ
	(envelope-from <netdev+bounces-281002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:07:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A2846082D
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF4A4300EC40
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCDB149C6F;
	Fri, 24 Apr 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="to4xshY9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDBD26C385
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043225; cv=none; b=SEvp3zHYhdSKUo3qJcKrHp3Iueo5aeRPiTq8FJIJzfpB/QcxSyQRpZ5OiT3Zwo6nQU98IxVUe8q/X9lSNuY/CeGfznnreUkRAwseuakzkYaoLgsnVjHT8frOW9NQQw81fW87YraatWhElhNKorRJepna6PKRnYFdJwCGg+SYw0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043225; c=relaxed/simple;
	bh=5jT5H/QG6L8I7pYvk2YQPYQtGs4o9CQ5dFTXrvJ4tmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6YYoSduwAhHLRlTC6RAumElleR1p+JVcFGhlRQSIzp/en1tntvlmPlEsJvn9yc6Gbpup/k4E7/KRUbnhOaO4GYXw0gIb9XQDq4Sh9HHteB/kgw0NXjvyRu3BDDCuONpqoBk8eM+2/vmmdkFT+WaaoDjmbseH6dKx1pemQn+9v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=to4xshY9; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso8369443eec.1
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777043223; x=1777648023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSKuWY7Ef5OGzeiVa7TUsQxq3w/z1Yph+U/asFLajis=;
        b=to4xshY9++AO/BH+ZGLP1wz7DOZP3rFR0avrxXjGECg6HN4sXJ7brhbk9670dUY3Jj
         BUhWvMv3B4DFbMHKgx43fXG5aTpQ+v6wB5bAFD7J6YEcahYZtWdLW1/7vWvAcoxTbpJj
         cXo0N+LriMuCkTPZkQPc0+nz0S2WtySVL2WqZz48ihe8d7YkLD3S/Doo7NrdGV8JlCBU
         +Dhekva67pr4R12HAF+kN8U+9GNb7OtBr6BveR1CBLmD80K8st1ypF8OXf59WrYWdiC8
         kz2isPNXQ+/Jg17TovX9dL6upfx2FTDbdXXnV62qMHFeMDbdYYa0kqs2MTe9AaWQyXB8
         QBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777043223; x=1777648023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tSKuWY7Ef5OGzeiVa7TUsQxq3w/z1Yph+U/asFLajis=;
        b=UclJjXwLQZ9fxi70brw+PfzakTFzcUnXf7OU8umXh6/kur2QSNfAjiihAA5rvzVmtl
         No9R/81F7fq/IzI5o4wOnenv63RZkhXrc7i1lu/sXMuPdw53wDXIRjTP9bu4PimLR3im
         NfXmrziFXuOiFtT9d0sQAeN4cPjtpsCRnnOQR70w2FxQk+S8IJ9XhDk4frJKyfr+8EpZ
         fcXDUx4wgjSc6pznfYRIAX5BTbfIVklDQxpq0LgEJEpZnFeDdDlYoUIf622u13eOy1i6
         yqy6IwCWR9ZJwm44CVqNtkHBTYltFBgfzGQKDTNBvkajDltv9lUkYESFDarFnFp6PkAC
         9FQw==
X-Forwarded-Encrypted: i=1; AFNElJ+q80ePEcFVQvjbUCH70s9ktwSq3NKEOz62Nu8WSWZ8uYofwNaGQo7LJipEPMzzr3HKAT5n/30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4o+7wzBDUmT3jdGrL4m03dW/BhGXGGL/GZSpWtt337H+0bLH
	LfhZM9icupDdYgyff/M76gab1r9Ix14t6kSMDrL9Co5vu9jkiDq4BU8fmq3LuInnkGo=
X-Gm-Gg: AeBDiet3nhBke3Ecdkq5LwhliqHGumvAnJ2StvhFPJos1XPmYwRGJalq/BjIyEJf26f
	9y0FYKLRHUVw0y/SsLmRiCHpjRmQLRoBSS6mcDJ35KuSU1dG7UIkQjK78pK6qzCikYEuKpZwIGH
	zXG34/fCMx8fFwKrw2kW6ypx9ZQLqrgfwtmwgzLhnNoVyXInABGGQDpNHyjgLl2mWgN4JA3sQ23
	h7YVf3hWhZemkiZbRXmdSM0E/B+aFrSOTS80zbt4cyLU2vf4q9jIyeSkJ/sHQb3DHAHI6iSbu1K
	QEXbGpypIdfgFs3u6pcvYKcBpRAPhOJpkfJa0qqduyERl5EAz0m0WjRFBjQrG4Cyd/za2a/LvQG
	dM4jG6hngj+TtSn2rXp5ex9lWAjj4a0wLLcjFgNSFmfEZ6f/LZCFZnuFoO92m7dNikE/ZDemsof
	/U3kMTRj7+lboZ+kCBWnMA/7LIDY2/Yr3s+QueeCH5zE/dfg==
X-Received: by 2002:a05:7300:3252:b0:2c4:ec89:bc7 with SMTP id 5a478bee46e88-2e464dacc71mr18361550eec.10.1777043223045;
        Fri, 24 Apr 2026 08:07:03 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa244csm31704854eec.2.2026.04.24.08.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:07:02 -0700 (PDT)
Date: Fri, 24 Apr 2026 08:07:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 jiri@resnulli.us, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Dave Taht
 <dave.taht@gmail.com>, open list <linux-kernel@vger.kernel.org>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH net v8 4/6] net/sched: netem: validate slot
 configuration
Message-ID: <20260424080700.6846dfcb@phoenix.local>
In-Reply-To: <CAM0EoMmnHfUiKP1PO19sHJZpeGN5tdL7ds=_8Nma7Y-4XoSczg@mail.gmail.com>
References: <20260418032027.900913-1-stephen@networkplumber.org>
	<20260418032027.900913-5-stephen@networkplumber.org>
	<20260421131039.GA651125@horms.kernel.org>
	<87f5e94e-d354-423d-9976-6cf3fb0710b1@redhat.com>
	<CAM0EoMmnHfUiKP1PO19sHJZpeGN5tdL7ds=_8Nma7Y-4XoSczg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 79A2846082D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-281002-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,phoenix.local:mid,mojatatu.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, 23 Apr 2026 17:12:15 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> > > This is intended and explicitly explained in the cover letter.  
> > Jamal, given the uAPI implication, could you please double check that
> > the change is fine?
> >  
> 
> It should be fine; at least iproute2 will never allow the kernel to
> receive a negative number.
> Stephen brought up the fact that strtod() could return a -ve number
> (but at least iproute2 makes sure negative numbers are not carried
> forward to the kernel).
> 
> cheers,
> jamal

Iproute2 blocks negative values kind of by accident.
The NEXT_IS_NUMBER() macro looks for digit at start of arg.
To hit this you need to either use raw netlink or change NEXT_IS_NUMBER()
to NEXT_IS_SIGNED_NUMBER() where slot values are parsed.

