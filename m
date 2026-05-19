Return-Path: <netdev+bounces-289292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FM0KPcJDGo5UQUAu9opvQ
	(envelope-from <netdev+bounces-289292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:57:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 405A55787A2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79A173006129
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225AF3ACA7C;
	Tue, 19 May 2026 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMGNC1kG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C448A3ACA5B
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173878; cv=none; b=fTgGkf/4qpFbzsxrkA5aO7CLBhIyDOlOkp3aXPkefzvM5W9ENnRXmmRFkwVcSKYRY1KvHkTDoAlhvKQTMw4/ETXo7+JwxWYh9YEHR5lc6T7c/hveH+jf2JNQDa60Kxu+HxvjpYQ0w5kQfBFByKSqH/rdpG894FlGjazXVvWhDeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173878; c=relaxed/simple;
	bh=LhRcyosxtfl7pBM3FQKJQNYHIxd3v8xS/E0vghKZGPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j92Bnm3bUPlbIYsMpCV/RM1Zle+BmWe9CcnnJ5yTF8fQTMgsBNxwwzYcZbw74JznwRlExlDo7WtvWOkZTk9jE2mJot39UJ5g1gmw6Y24UK4uUlZN3z0pt86RXjMVbdiD6eSpXzAtU1UqaPXfA4bPHZHuwlQKl61IUk8Rq5qHH3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMGNC1kG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-369002b26f4so1580941a91.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 23:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779173876; x=1779778676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ermnUQZ+hsf72YdY1c8AhCxZM8Nonb3N9ICT3R/+dBY=;
        b=nMGNC1kGHjsbQlONyrX8wce6NmPVXr7iGJgdJ7KjmB0GrEwUryiSBy05hApUzeCBUx
         wUZaUwDSdRJoo2mn4YqW/kepsyb5fwtKsfohuddArPl119kqPqQnx1Fl6ilQwoSfW5bk
         lvEV+rTTD9YDl2lBTB2ProLbmPtILWhi7KA3hkIeleK9UBR3bEytSMYPD5Hi3vnprKzB
         Vg54B9TVflu667+EOQmZZFTlV3F7TcwewECQeERJu6rReRxGBt1EoYseaPC4LUe1oIn+
         KbEyIBFO51iC3/JRoouswN1ic1tbR8mo62tlZIOWyrrj9Xwmswyb4qTgEhOkgBo8GzRI
         fxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779173876; x=1779778676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ermnUQZ+hsf72YdY1c8AhCxZM8Nonb3N9ICT3R/+dBY=;
        b=Wc6LJaclZXbSHqwvwY8OTLAkSZa3XVLZ2sB3s72YHuM5b7mJaruhSPAv2IbPIiIv1q
         MdX37HEV51owu6kPSzmzq21zu313Hyj2q57lC48zuapfbhxJCuSqOW6hklw44iXWWKpg
         bygYj1JRd6PH0Jb7uLdh8wno97cy2jCQT7JWBT6JYWRBXTMvPV3Pwbq97C+eoIuwCJyF
         WkMxG1sSW040XzrGxDVVea6VGyrfarxxqUzIEm3mHUt7NJ+GdbkWkAkoW3ShZWoe2ps9
         F8k8RffOnXOcjhyxNh6MEJNEJ1BtEHB4ufsELUSw1VcP0PzZgsoB0APuhuJkzNZ98V40
         yssQ==
X-Forwarded-Encrypted: i=1; AFNElJ9cPiP8zLOO47q4QhDyTSpEirQ37CL7lxQnhgVHMyXbKO2g0HuTlRz+0d02u4rCRxN8Kpv24Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyMp7NlEp+HyUqw397LmXVGRhBlDkzNkF4lJailT/jda5mng08
	4gEytGYHZC0Gr8mWwSs/I7LXL5OK0ECmcAZyR3GsWpZIrwQs93NeULPH
X-Gm-Gg: Acq92OGQWX+SELb972fXieGbspiWDiyr+/9Ifdadtpzb3ACNAJ6Jo+4MhArotG2A31u
	NGKeRD0LMwbbyZ0mlfx3cty+8S6WgGmhuyLTNKi/ZjSaN/lLtM/RTdLo54ku5gAX4Y3CFHKGOf/
	h7vfFVzHHiOqL5WbjZ3L16NFG2fF2F4fR9UYBGpvy6g2ua2vJiq44W9FaxQdC5b30IEK7iL4yGx
	Pq6W37fCGjOw6rItLaRooaT0DuIJjB1UPwHCUs8e7a8XK7d41mh5ZR8rNOA4J6m1pSTHNTjNACi
	RmT9BQ/YsCwxQXm3An/s5y5DM2sa18Suza0u1US3okd2IZxkid+g88KOyGhOrhbmTGc9jMnJQbk
	eh+3TatB4VvnSeEkaTreSuRh8XQ7o4ihVAXyQrMWP0Jy9u12jfIddAIM5bZxulJ60+Ox+PkP6LD
	iH9KcYIWzPQVIK9kE8ZVC/giX9mhb9RU/weDqz4YXMQqI=
X-Received: by 2002:a17:90b:48c4:b0:35f:d56d:1c45 with SMTP id 98e67ed59e1d1-369519cc92amr17754746a91.12.1779173876068;
        Mon, 18 May 2026 23:57:56 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695157c3cfsm13451610a91.5.2026.05.18.23.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:57:55 -0700 (PDT)
Date: Tue, 19 May 2026 15:57:50 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Cc: aaron1esau@gmail.com, ben@decadent.org.uk, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com,
	herbert@gondor.apana.org.au, horms@kernel.org,
	jiayuan.chen@linux.dev, kerneljasonxing@gmail.com, kuba@kernel.org,
	kuniyu@google.com, malin89@huawei.com, mhal@rbox.co,
	netdev@vger.kernel.org, pabeni@redhat.com, sd@queasysnail.net,
	stable@vger.kernel.org, steffen.klassert@secunet.com,
	sultan@kerneltoast.com, tanjingguo@huawei.com, imv4bel@gmail.com
Subject: Re: [PATCH net v5] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <agwJ7kbcmJDdLYy6@v4bel>
References: <ageeJfJHwgzmKXbh@v4bel>
 <20260519040232.1395-1-rajat.gupta@oss.qualcomm.com>
 <agwG_G7l9gdT0BsH@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agwG_G7l9gdT0BsH@v4bel>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289292-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,decadent.org.uk,davemloft.net,kernel.org,google.com,gondor.apana.org.au,linux.dev,huawei.com,rbox.co,vger.kernel.org,redhat.com,queasysnail.net,secunet.com,kerneltoast.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 405A55787A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 03:45:16PM +0900, Hyunwoo Kim wrote:
> On Mon, May 18, 2026 at 09:02:32PM -0700, Rajat Gupta wrote:
> > The skb_gro_receive() and skb_shift() fixes look correct -- we
> > independently reported both to security@kernel.org with working
> 
> Thank you for testing. When did you report it? The two PoCs were 
> already public.
> 
> 
> Best regards,
> Hyunwoo Kim
> 
> > LPE exploits confirming they are exploitable from unprivileged
> > user namespaces.
> > 
> > Could you add the following tags when respinning or applying?
> > 
> > Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>

These issues have already received many duplicate reports to 
security@k.o, and your report was not consulted in the 
preparation of this patch. 

A Reported-by tag is therefore not appropriate.


Best regards,
Hyunwoo Kim

> > Tested-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> 
> > 
> > Thanks,
> > Rajat

