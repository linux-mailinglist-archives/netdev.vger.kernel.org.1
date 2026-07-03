Return-Path: <netdev+bounces-304338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wyLFCv9GR2ryVAAAu9opvQ
	(envelope-from <netdev+bounces-304338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:22:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A76206FEAA6
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:22:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=h+kVEf1z;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304338-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304338-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EFD93027129
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 05:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932BB346FD2;
	Fri,  3 Jul 2026 05:21:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB28357CF8
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 05:21:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056108; cv=none; b=B1TvYTE3I0VsWJcEAC6Ig9qQjK4D10wPP+uVW3JkOuKrvDjlj7XFDghTDHhX4s2exlKS+0JjjOGfaDKrKtiTSW9Zd8L1pypwb6StVte4K18PEr7OL9w5ZuEsNeOhnM3Ad4b2pI52FgE0ZN0hDrQLYiqXLtYMm7vtOX78gBFHWnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056108; c=relaxed/simple;
	bh=ungXM+pGccTPmY4MYi+TOmQLabp5apMUzorBXrm5qVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZzHBeSGwDta+1MAGqjrzHbQNQjTp1M2rQdW8/ZPmJ8XmgRnYz5VLqbz3Czhk23COtWL28e0t1mdT2FZlOgsbt5YP2IRIEfMyCWQAheHC2gmEh9+oes3K/rpgUPb09LdhKYUTdrkLqIEPS9u6xTv7ogVkS6iwTinSHy9gcZig9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+kVEf1z; arc=none smtp.client-ip=209.85.160.49
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-44ce674ed17so115320fac.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 22:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783056101; x=1783660901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rbrF5PgluXo296yF8wu1iDrFOX+6QVWi9u8cpBpxPXM=;
        b=h+kVEf1z6+OUrrAyxKRdwJjeEEDGg+rG8cF484EV4vUNX33SgP84/tqzO/tWZcxZZG
         lLqZtJMpLTplvc5dNg09j5raiJ0qFSOMpngjR1Cv6YoO3+WP1vyenhsHoRMwIuZ05Cni
         lC4VzpI+njML3iNw5w0E1aZRA2T5eOaRJU7uJAUCKhYf19vVLw/ZrcnDdS+qUtIZ/QG7
         N/lOKYdlgHJeQ/VntPRGTXyJ0y94ci6Xk0T3JrQKK687yEEQ9s31ZApWcpdii4Y2hIq3
         OLRIe7iHrAQScSLI1sg8oT89oDNPl+JGr4b4NaU7P2mZTofRTSCTvnLQK1JcV7XKomx9
         Pzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783056101; x=1783660901;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rbrF5PgluXo296yF8wu1iDrFOX+6QVWi9u8cpBpxPXM=;
        b=XXRbKqTvLmgxNcZQxBzU4VeXZrQ2RgIetsoF0BHPS6ymp/OZWAgwHQJ43j7vacEW9r
         Y6n/hJXq6TgoG1TopQQYDCqTzCfMoNALbGlUu4kK9Uffa+t4s5IndQEEGf7BnsqmaQ0y
         o3mYuF6ZWsfRzSwOsl593S5JMcKo7MapvcUFZ+ZLbQ/zjJAc5KxrHIhvYDszqa/EPFDU
         w9HSr3C1hegCZjjc5PsAU4tTRAHk2QtwS/gd6aggx5YbtMrhIyaL4d9zxgLQMQt0p4Zl
         KwYvtxcPnwVRjJpIPwnRokC9P1bzMUd84Zfdf7yszupNMbmYxNx566zoqZsqe+TtfWEc
         lKmQ==
X-Forwarded-Encrypted: i=1; AFNElJ930Ja6owq8Kdxl8SiXZ0lkFknK+5Pnx9yuaAKMrwdZT7WvoFTa6zvGixnn4F8WXYpzvPpNTrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj0PGT9FrFZqIkNn89sWVlsd5abi7ZHbQK1T9R3V0g22z0lKqP
	35RTqgKH/j32PLZkqZlUmYmIpM+sdBSwMVVev6n9g83h2BSaRoAad6EQ
X-Gm-Gg: AfdE7ckYzTVBMxbWlXrA4v5TZ3i0nEyLPnGpAo3qj+2mmDGsj29wpXIY8JCb+Yyko9d
	u37X0fz/o9+mtBgHNWvVGmM32ZJ8BZhXJApIcAco+Dm+I3E+IOKO+ThJwp4hIuttbGuU/wQXotk
	N6Dzs1BmDB/CnaYqy4e6IhNBKHXKCGobP1ehQ+vXxPFrr9nz+I6NGaswhTfYcStQ8BueKXVfnpI
	G+FBMGNAqCjQ9GI0VPGvK/KfWH2zjY3cycDtpBc3alVxU+XINLwJ+rr4KYsCDQtcI0fc8uAkNfZ
	tUcog3AQKD1kSszmphmk/D8UC4L7V5wru8k/On7R7jJZQbGs46C5sW6q9vf+RQsFqcisCRdhUyg
	YHILfJTgIfMZUt5LTyJ6gCIvvxGErm2l8N4rD6a8pSBU3RcZrrbXviB+CaCjA2MuRq3aeQpBHck
	ZFK3CdgD9egzGgUWoy+8Bd
X-Received: by 2002:a05:6820:4c01:b0:6a3:9ce:5412 with SMTP id 006d021491bc7-6a30d887c40mr4436494eaf.38.1783056101413;
        Thu, 02 Jul 2026 22:21:41 -0700 (PDT)
Received: from gmail.com ([2600:1702:56e9:4b40:ff21:65e6:6e3:5b43])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb1d011asm894391fac.8.2026.07.02.22.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:21:41 -0700 (PDT)
Date: Fri, 3 Jul 2026 00:21:38 -0500
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-tegra@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Thierry Reding <thierry.reding@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: media: remove obsolete rc.txt
Message-ID: <akc_pO_ctTiZmbFw@gmail.com>
References: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
 <20260603-b4-remove-redirect-stubs-v2-2-c8c19876ab64@gmail.com>
 <178052520503.2279647.12293343206224505400.robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178052520503.2279647.12293343206224505400.robh@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304338-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:kuba@kernel.org,m:jonathanh@nvidia.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-input@vger.kernel.org,m:hkallweit1@gmail.com,m:edumazet@google.com,m:devicetree@vger.kernel.org,m:horms@kernel.org,m:mchehab@kernel.org,m:linux-media@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:conor+dt@kernel.org,m:lee@kernel.org,m:andrew@lunn.ch,m:krzk+dt@kernel.org,m:linux@armlinux.org.uk,m:linux-doc@vger.kernel.org,m:netdev@vger.kernel.org,m:olteanv@gmail.com,m:dmitry.torokhov@gmail.com,m:thierry.reding@kernel.org,m:conor@kernel.org,m:krzk@kernel.org,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[akashsukhavasi@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,redhat.com,vger.kernel.org,gmail.com,google.com,davemloft.net,lwn.net,linuxfoundation.org,lunn.ch,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akashsukhavasi@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A76206FEAA6

On Wed, Jun 03, 2026 at 05:20:05PM -0500, Rob Herring (Arm) wrote:
> 
> On Wed, 03 Jun 2026 15:42:19 -0500, Akash Sukhavasi wrote:
> > rc.txt has been a single-line redirect to rc.yaml since
> > commit 7c31b9d67342 ("media: dt-bindings: media: Add YAML schemas for
> > the generic RC bindings"), which introduced the .yaml schema and
> > reduced the .txt to a stub in the same change. The .yaml has the same
> > filename in the same directory, making this redirect unnecessary
> > for discoverability.
> > 
> > One file still references rc.txt, forcing readers through an extra
> > hop to reach the .yaml. The stub has not been touched since August
> > 2019. Update the reference in hix5hd2-ir.txt to point directly to
> > rc.yaml and remove the stub.
> > 
> > Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/media/hix5hd2-ir.txt | 2 +-
> >  Documentation/devicetree/bindings/media/rc.txt         | 1 -
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> > 
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 

Friendly ping on this one. Rob's Acked-by has been on v2 since June 3
and the patch still applies cleanly.

-- 
Thanks,
Akash

