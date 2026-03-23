Return-Path: <netdev+bounces-270741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMAAMqKtwWmUUQQAu9opvQ
	(envelope-from <netdev+bounces-270741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:16:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 724EE2FDA8D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26763301C142
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7606933FE02;
	Mon, 23 Mar 2026 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyFCE8Ky"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F93B26738B
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300542; cv=none; b=IABV7w4U4/HhWqmoCCULpihE/7N7TQRjv3Mfe1LmXlTz1bv1O6Sm55nfvlqCSazsuJbz/4J8ZqzG/S8AjIkq42Z8BblVJmX5TLDrHMyGQalnl+Qd4W+1uroO3pfqIoD1EJ1ixaN+4qzxgbPVkv+SDvsCwMPfT4db7bsLLjQxdyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300542; c=relaxed/simple;
	bh=E+01s+1EWSp0rlCHpf0q/EgMSfxcqEyde0Qk59jffh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAh/VmDVwnLGXijN+b3NlQNf3vKU4nvDF14hs/P7XIwisoF9Usfdu30WjtQblqKAfWMqS9eN3ugvWVEwsMWtfhDDXm5S4hji/ScVnO00FdjjrAAwPiyDUskU5TdjQJfKgS2whBKKZCdClfbko7gXs7khm4/g4jgee1Fq1LE/phc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyFCE8Ky; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4836cd6e0d4so6031645e9.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 14:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774300539; x=1774905339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LbSGCR20NLc8Fhkr8w8sK+fxvVVcKe9jGCCUsUyT7mY=;
        b=MyFCE8KyHQgbng3c8PHxuzHtIl8EsUCwMI9oWEh82tUGhLTBWkZ4PvLI3jzfqzqJXg
         7BT+f5XNhDXc7VlG6pm0md01mfCOGDSuDA0QY77GTfMHXhPMLa9yuTHizd6TM0Xr1Oi2
         69T2/PNTz1GxJkmwyiLoIz9b5fO+heUMOj/xkIows0c4jF54Vo7fWKoMtiiR1Yt4coOs
         3W0fU/i4H8n2JrswqtrCDGObJVG+FPGrz59B1xJgExVCuLAlraGfy5yG7gTWvlE++xlC
         N/+6znUZgFTSKe4twmaY9La5s/Ef5mSbdzt48jjVsD5XhAJy4MzU9dy+GOXVXhDGS5rF
         JnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774300539; x=1774905339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbSGCR20NLc8Fhkr8w8sK+fxvVVcKe9jGCCUsUyT7mY=;
        b=LhwuyYDSuPALMJtmTD9oBm2HO8yGniAsgdEC08rhodpFz2e4XjSEA0NGeRy1f+8Sco
         kgGgDhYo4jxQNaHnR+usMvIibWcWZfOtDI8Y/qBykSTnU85lAB86pBuBvSvkvLcqm0NV
         2aMTGESEYgbi7rfMXmMSaBsvb0OVIalD4yg1ffKPjW8tAio3bJ23LALkWgsIXLn3OKWg
         vfFUGfbHhgCMWohrna3rbXbyisPSdUn1NlAyz4KejNOMz5/O8+mEwEJ6ZD7oLMEEiWQv
         adA10fTsD0zUPSwo20KDQ4G9KD3X3YFQOsBhzm0ZdTlSniDTZWa2RvDpmG7dKJeyJ2mm
         2mnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIVmHQpdm6PqzlovAlOElpn3+zU+ibSaSiZtMDHkz37DLhZ4BaqQX2Oc8k6zm0aUnqWtuEe04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFow9+9Mel3ROOwPX6NNUrCi7oRYyS2R4SiT7ZqDZiJ+OKzsI0
	4x0cg/ZMeS5TgyPe4SUM4DOTdJhFlLYMaJ2BX9oV65s83FCc5dgc5mn3
X-Gm-Gg: ATEYQzxAwM8CU2QwwxVd4uvgJl77QxZZs0LkdNsaZ1KG9qmoM4KZOBlrgEUGHUYE97B
	RGXR62o4qD2rEIQXSW/+1eS4eQTUNRhc6oH0aBcdSSOzGig+w8Mue9EOj7jojMXlEo++uLTCA9z
	I7zkUlkm0OSQFFEwNMtUvmLPy9WzBywJ3daLlvMUlq+UoM55mDcxtJFwsEDemIy4039aqH6MxrR
	qUWdqGvDmfKji1ugiLlQhAG3aUfsezIsNatDMEofne4vbTwhpc2Hl1KuMwDVQdneTX1XJFf1+Az
	FXxz+OhNM70GbmLdJ8BUdFdO1tSgHGlKZuAoi5rRuRM5/8DEl+nfVCiPeNrd1hqD++/RD/yseGf
	f8DnqCY5/qo7Ld/VbToEna7XzyydqVTACqf6RmXPjSgP0+K2P+Jq4HkxBMw81+Jp2o4NAjLGM7v
	+zX8ZK+xJLWhiJE6eGbocJjTjTSQ==
X-Received: by 2002:a05:600c:1f0e:b0:471:ab1:18f5 with SMTP id 5b1f17b1804b1-486fee2dcfdmr106265015e9.7.1774300539351;
        Mon, 23 Mar 2026 14:15:39 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:653e:51cc:7cba:e6df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871102369fsm1726375e9.6.2026.03.23.14.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:15:38 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:15:36 +0200
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
Message-ID: <20260323211536.iqopuy2zxd75pfbh@skbuf>
References: <cover.1774136876.git.daniel@makrotopia.org>
 <ff936ce4ad3044102c367c55e7a455ab0020e4b7.1774136876.git.daniel@makrotopia.org>
 <acCllYmKczZrDgv9@makrotopia.org>
 <20260323163104.a2d2hbs7jfgsptj3@skbuf>
 <acFuHka4RdmAXm73@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acFuHka4RdmAXm73@makrotopia.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270741-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 724EE2FDA8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 04:45:18PM +0000, Daniel Golle wrote:
> That means the driver *does* have to track a mapping between DSA
> bridges and hardware/firmware bridges on that specific switch somehow.

That's correct. From DSA's perspective, it's not an mxlbridge, it's just
a bridge with at least one DSA switch port under it, which is given a
kernel-wide identifier. The ports can hold a single reference to the
common bridge, but the common bridge cannot hold a single back-reference
to individual ports. And holding multiple references would severely
complicate the implementation.

Even if you don't implement accelerated cross-switch bridging, you can
still have two mxl ports belonging to different switches that are both
put by the user under the same bridge. And both switch driver instances
would want to allocate a potentially different bridge ID, and surely
maintain a different portmap, for that same bridge.

> Or is there another existing structure in DSA I'm not aware of and
> which could be used to implement Paolo's suggestion:
> 
> https://lore.kernel.org/netdev/fe46d64b-1b12-48b6-b663-e7d5122b7b8a@redhat.com/

The API was intended so that you could either use the bridge.num directly,
transform it through some linear formula or as an index into a privately
maintained array of data structures with switch-specific meaning.

I didn't question why you maintain a parallel list of dynamically
allocated mxlbridge structures instead of just having an array of
MXL862XX_MAX_BRIDGES * sizeof(u16) for the bridge identifiers, plus
maintain a separate portmap instead of walking through the DSA data
structures, but now that Paolo brought it up: why?

I see in v6 you're halfway there with the conversion, you got rid of the
portmap and you could just use the array for the rest.

