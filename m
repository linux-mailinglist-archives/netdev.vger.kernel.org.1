Return-Path: <netdev+bounces-270611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E70AOx2wWkQTQQAu9opvQ
	(envelope-from <netdev+bounces-270611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:22:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9467A2F9D08
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DD7332F2E87
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5A13B8BDA;
	Mon, 23 Mar 2026 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lttW7s0j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4874C3AF672
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283470; cv=none; b=ONRFdK0ZULFVXApjXPAtH/dv1yS3veOEoVEj0bADttOf/2tjfk6AxoAIAgiZdTtRm0YuwYXwQALJaG8aUstGmw6Aq2Z4KIqDfgzQ12uLtBGFt3uruhqTSmLtmTkCaVtmKeje0F7SqdyW/49kBOVR1W0MedsfkNPtQBpPyxqDByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283470; c=relaxed/simple;
	bh=KLm6b7EJSgDbO8wAQ1vgmKDFikErCUASdQ5Z4cJMfhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaVUfzaDJeoJKQPMtk1lnZZVJLlnPiM+Sgwe/xmhGFNmkTJ5k5fGDcQ+YvOMpJ463RbPg/JNECjyf458TNgVSMCaMikIUA0j8OkcMiX1KqLyt1hZSsJtm0kFXl3Osj1jGyU8jKtfpTkSqB6x3FNyRjceqMiAgr+rOrPmE3odudA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lttW7s0j; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483ad568d68so6299935e9.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774283468; x=1774888268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Snr3E4k4Xc+6SMIOwrn3jZd42/HG4jCfgy6iiScpIyM=;
        b=lttW7s0jDhmdaK5tNG1T23W0FLQkrW7N8nrvcRYz2SQ6vpK7+qgqhaEtAvEXqc0jRg
         V+nv+wpyRJ1s/0hMpwtLdHMbm+DRSh9kKlaYcfYFZkDTfonEziB0F+b4jwbnOTYPS8A9
         pPaVAbVdfTr03mngzBcqciz9hWK02wtMCtH/ULj8lHqFWsQpRNprH3am/ZjXOchBdwWE
         brsA1UwkV0RfuTJjqfHWfwvWu5h557BdIG0zU5YmFldmUO4ZMKRsbQxULDAB0CHUUshQ
         2LXhmbo7AtPZKYDtcu5T9c7CY6c0Vz88vGACabfg2Ol7dzgC95zRt4CMsf0RQF05nLbB
         PMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774283468; x=1774888268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Snr3E4k4Xc+6SMIOwrn3jZd42/HG4jCfgy6iiScpIyM=;
        b=gsGZbREYlvS7Yyw9DN10K7+d9vHBamO/GwH2+52m5AnjodtgUk5OKEVFL9oUCTAQPb
         hcIRq20Kl8+2n5tkyzE1fPWLBe2G9QwewuB+OMscPXGBM8dTzd/g//vhPNBAP0jQ/UYq
         c0BbKuB0nNXc/KP1B1DAf5CDF42CTCeEiinE8P6dBpBgEkOg63ztGRXGdDxQgdmq7SeH
         FmjW8WIKFukRyA3PXCbflszcZnjMMjEEM76GSPR6Ejf6T3q+EPEsqt2IxugK/9W+v4Hm
         RatVwUlkItCukOXuM8p+wNhhRYnwieLupbVeIGmeuaEaMdgimLgPEcnWx0lT9okdjuTe
         KtKw==
X-Forwarded-Encrypted: i=1; AJvYcCVleu93zjDLGr2HCcy14Zk6U8m+fsja+9+1pICUmOXBuV51SHLcKTRT6wNMEm6plZddgY1fL1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTu1EjhQWR4H+5R+LDYC4Ghq0Z0A0FKsJDKViZM9g/VFR83dIV
	ajGV8Qn8WDGK/V69WKC6gjnv1cEJR1+LwNBdqZpje+EOBK07jRZbn4z3
X-Gm-Gg: ATEYQzzi7sWcwm2WAAmWIpkAFWDRAO1xLc8suJmzkyaZbLjRny28j723L8VK5XgUWPl
	PwBnapomJQtn1zuYw5II9iLmTXc6AJLp62aI51ceuSg6Ps63zRY2egND1wmDLHhX/E5GhHywlat
	uPK3TTUcBqiTTNel3oYJXkk89LroOjEUAcb2NLcYvY6dOLpywhXlhT8Vy97sMh/Vcb1W+4KVg6S
	PFRyWzIb/CWikq4GCJPKyfXUGMMnvHobNkil9YYdlbuWkDyiiB5HK3LokP4pEUcYrwPSjLqhr/q
	jMNF7jQQf5lcp8lxu+tPvosqbXC+CSu+XbT4h9kbwbog+eSz6+Eg96g7htTk63cEVM7XJvlbDeQ
	LiT9aglLxd+VOq+NMFkd4eBUeKTRuWXUMaDRTPploFyyNlDWzs89r7SW6TIgn569N5hfcJ01XOx
	D9c/Vm92Ki6CTvwA0=
X-Received: by 2002:a05:600c:c4ac:b0:485:f1d6:2b1d with SMTP id 5b1f17b1804b1-4870363da8fmr77534665e9.0.1774283467595;
        Mon, 23 Mar 2026 09:31:07 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:653e:51cc:7cba:e6df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe8359acsm290068055e9.12.2026.03.23.09.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:31:06 -0700 (PDT)
Date: Mon, 23 Mar 2026 18:31:04 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v6 2/4] net: dsa: add bridge member iteration
 macro and port mask helper
Message-ID: <20260323163104.a2d2hbs7jfgsptj3@skbuf>
References: <cover.1774136876.git.daniel@makrotopia.org>
 <ff936ce4ad3044102c367c55e7a455ab0020e4b7.1774136876.git.daniel@makrotopia.org>
 <acCllYmKczZrDgv9@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acCllYmKczZrDgv9@makrotopia.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270611-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9467A2F9D08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 02:29:41AM +0000, Daniel Golle wrote:
> I wasn't aware of the similar and equally named function in
> yt921x.c[1]

Yeah, I did request from the beginning for it to be moved to
include/net/dsa.h, but I didn't follow through with the request (I guess
I forgot):
https://lore.kernel.org/netdev/20250825212357.3acgen2qezuy533y@skbuf/

> Patchwork CI has loudly uncovered it and I've learned my lesson to
> always test an all-y build when changing even the most innocent
> looking things which technically may affect other drivers.

Since all DSA drivers are all in the same folder, technically you may be
excused if you just enable all those when working on infra, instead of
allyesconfig.

> I'll move that function as-is, in a dedicated commit, to
> include/net/dsa.h as an inline function instead of the helper
> suggested here.
> 
> A second commit will introduce the new helper macro
> dsa_switch_for_each_bridge_member (modified to use (struct net_device
> *) as parameter instead of (struct dsa_bridge *), and make use of it
> in dsa_bridge_ports().
> 
> I'm also planning to introduce dsa_bridge_for_each_member macro in
> addition to that which works on (struct dsa_bridge *) and uses
> dsa_switch_for_each_bridge_member.

I don't like the dsa_bridge_for_each_member() name. You are likely
not considering cross-chip bridging, where a bridge spans multiple
dsa_switch structures. That is also a serious reason why your
bridge->priv design is not viable (two switches can't lay their eggs
in the same basket without overwriting each other).

