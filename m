Return-Path: <netdev+bounces-264899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3kf7KnIrq2naaQEAu9opvQ
	(envelope-from <netdev+bounces-264899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 20:30:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A43062270F2
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 20:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A5513009834
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 19:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30131314D08;
	Fri,  6 Mar 2026 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOfxGOVs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D5D2F8BF0
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825453; cv=none; b=F92cb5XXX6DY1JqhaAW8uGgagGy9TR9BXhuld3on5CzjTDlvi2gxwp8PPTvb0ysGx6XWuLbKy9k3GHBM5S52rIXrRS2Zxg08cfyw/tiBHcvjwyyYgopaWkVJNK0UfnWIh94K23SIpt7PGvsG9T6SItIwgJwaIhw28zPsEQc3gp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825453; c=relaxed/simple;
	bh=EchT0da9w5IibREhj+LbgZXjXXO0wrzorxZRPTcDYBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeobwRj9UU811U8Wz0nuoTGurFOUe3x4cBBpsKSPsj3yszDzgbHWg6r4J6wAIndgmm1cXLoSb/z6WtvQBvdP9Aa6b6UyIKdDcOLNnYa0YkxSV4CuHSbP1UqDb/y2bxSfkSxpi3Gc9e+TA+sjkimR3YG0TQZtIYwe/62AjrI8EPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOfxGOVs; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb3bae8d3eso881704685a.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 11:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772825451; x=1773430251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3wjXAaKQjkorxyfVDfGCmfFQL9B2H7Q6rvnAEIO44c=;
        b=hOfxGOVsAcIgMcHqX+CAGMCLDfySbXhbnmC5K4UBglknygZoL9+iWcGrEx6P8s5FH/
         UWK6FNj4A8wWPF/SWO3CcpkuTJur0m4KPa7mIwtgPx++97WUROK9llF8gUtVMfTS8Wa2
         LEYbvoL3wocXP7WeWyqbSJSEBIiqwBcmWSY1oZxjG4+gR2zUdrVePg1upl2gneL2B6Ul
         Pr85UQnZSLQgF7B1vKGD4j4OjYjXzPx3obTfLtjtIqeBDu7TpptGFrs+6ZFYJU9ejfyM
         pDtiy5vaQpOcQ9i/nAdAROey1M6s7uivbdC0krubWJVt5sEhuaTVGyc3wpkLIKRbqKIJ
         7weQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772825451; x=1773430251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3wjXAaKQjkorxyfVDfGCmfFQL9B2H7Q6rvnAEIO44c=;
        b=lvrvvlDNjMOSkdNz3sfjpp6N2/FgCZp2PTYM3oUcfG7hkiWRLGU2HfYGT693cWCTBm
         QuxRKtMcYYrZaKxPVs7pJpvO8/GMZnnUfmmoodVDK3A3x5+LBh5iq7S8NAyD08UCZ7Ff
         M3znsaG3TkM6XF1cmCS5+JWogVnzeFGMAw92QHFMZ7/yl8EDA0zt+AkPR9CjSTwdr7xs
         pCZGxUh10bdvT2RbE6kGnp7KCgoyU3Fp+3kUqa4d1ma9YDDjsas+pdSWwIkjXJ6MSPpR
         yTnLWI/3gNeKfb/05+ISyhv8X5HzPzzKypp6jKXKcG06ojQEMEEoFTGmHU8Pt4HKxLiR
         MtvA==
X-Gm-Message-State: AOJu0Yxvt2vRkXTC9Asm2W4LmMdIgigMQzxd/S3P2G8096mPMNbgo6KA
	nzhE/PQ/lth6JUXbRv4Vh0CeSiyjMxVXSGznpPm/d9XxURZULhBjvl/y
X-Gm-Gg: ATEYQzwaQGEIEEjyjgWiDrwgklr7c/S5EJm91BOtXEA3HeBBJS1VVd356Y0XWwBmo4P
	dzMwUapOgOCbYbIuq12fFKuyDeWy8z7ixQk3K283Xw6DOytdVnKQEls5NPpgqVr/soORsd4l33V
	SvELHmxgczfVTEGv7qK6cZWC6l/qFcMVHel0i50s6C78hI7vOaBgv96Cgf61u8PNDXwwoh8DP4V
	DvikS/TSU005z6UgARD1wvMiSHAnq9ZAAnHCyL216mr43oiCi3fv9TsL3Zb7wDSV+wdzYcuWcK5
	jvAU1K+2BviSrlvZ2DFtzR66ZqdNZdEx9Uz+ddqp419zPIXKCCe/4IlkR+zRAivNl67Icu7UBVZ
	J1GeEjCnCboxllPrXt4gNtekFXcNTa9wWQm/YNsatp0pHY7BBHgwcO28t86evQe281b6Vo8MMq5
	aj7omWkvliYoW2xE3XjmHm+zCgqgFCjx9TlH/ebI2ZXY0pGT1RId2avvmLIPlaJqhC4n0=
X-Received: by 2002:a05:6214:262c:b0:89a:2fe7:91da with SMTP id 6a1803df08f44-89a30b0537bmr48369906d6.56.1772825450597;
        Fri, 06 Mar 2026 11:30:50 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316ea1b1sm18023336d6.36.2026.03.06.11.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:30:50 -0800 (PST)
Date: Fri, 6 Mar 2026 14:30:48 -0500
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>, Lee Trager <lee@trager.us>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/5] net: export netif_open for self_test
 usage
Message-ID: <aasraFh4WkH3hSE8@PF5YBGDS.localdomain>
References: <20260305150947.16893-1-mike.marciniszyn@gmail.com>
 <20260305150947.16893-2-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305150947.16893-2-mike.marciniszyn@gmail.com>
X-Rspamd-Queue-Id: A43062270F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264899-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,trager.us,gmail.com,linaro.org,kylinos.cn,fomichev.me];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.928];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PF5YBGDS.localdomain:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:09:43AM -0500, mike.marciniszyn@gmail.com wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
>
> dev_open() already is exported, but drivers which use the netdev
> instance lock need to use netif_open() instead. netif_close() is
> also already exported [1] so this completes the pairing.
>
> This export is required for the following fbnic self tests to
> avoid calling ndo_stop() and ndo_open() in favor of the
> more appropriate netif_open() and netif_close() that notifies
> any listeners that the interface went down to test and is now
> coming back up.
>
> Link: https://patch.msgid.link/20250309215851.2003708-1-sdf@fomichev.me [1]
> Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
> ---
> v2 - no changes
> v3 - no changes
>
>  net/core/dev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 43de5af0d6ec..d1d5694d1ff0 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1724,6 +1724,7 @@ int netif_open(struct net_device *dev, struct netlink_ext_ack *extack)
>
>  	return ret;
>  }
> +EXPORT_SYMBOL(netif_open);
>

There is an issue with the v7 code base.

In that code base, the dev_open() behaves like the old netif_open().

Mike

