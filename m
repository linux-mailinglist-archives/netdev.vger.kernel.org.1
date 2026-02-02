Return-Path: <netdev+bounces-255858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPK9KPWagGnL/gIAu9opvQ
	(envelope-from <netdev+bounces-255858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:39:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 048A4CC6BC
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DD87301651B
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5067A3C465;
	Mon,  2 Feb 2026 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnO9sdOS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61FE1DFF0
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770035813; cv=none; b=a6kD8CzhgE1wovAgXEv2J/i2MDhf1tZzod2jYBUefEjV/AlihlNnls2ld/Fxv0rDHBEhA0yx9CR+csdwnsuQMw9uK0a48s3j4dMziSbFUJ9dEBgeq6jzWVhZHe1B0X0RCZcRqdAaigouLKs/ImJK4XJKteY3rVlqM7J/euaTDVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770035813; c=relaxed/simple;
	bh=mtLCIrxFkXiF9q7mMSrR8B+1qONqTE/f9NbCoKgK4XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbbDSAK+Pz34tTAt7+f6QVZH25E4/li8ZhjpStNHXsu6ZqhEXmZaVpHoCjfHOq27mmLMwg7Woqdm6luNQC8E6XE438u37zf8SY0hqpXTDlWCZst+M1OEgBzEE7lpmNoKFDA90YuuPLHVV0GwDt2VoxFdpCZTuM3BU12MX/Jczs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnO9sdOS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806cd9991aso2545895e9.2
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 04:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770035810; x=1770640610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gx7i+hLNEQGkRpdhB7jkz2YgY4q7ryJmKRHbDgrJR1s=;
        b=WnO9sdOSDT+oBMnikBsxNlD7Br7OtuxLZXZQl4iLuLfwKTROpbnoV4SCvRJ8n4c18d
         qBEQJZaNvwp2t7np0PJQDUebV1kS9ndyP6N2z2nCHgg5+YeckJ/ahllJvVJk2LN1b/B4
         PI9UbVVbkbSrP3LRN6z1TtcF1y+L68lpc0UrLp3Qt/rZGOttpf/y0Td/vynpt3CfNQW8
         cIYjTVPvpXYlDbT+OTl0v1hkcIhLdgj3FBar+IR0gRfG6PPp8fjqZgOGgfnO+eCdYXUT
         PgSZHQhb7rjnPjtmz9yqEkBT4W5j6cgY6YdRMS3DyTXI8u1PDyrM5IxNQQTNUHRTLTSE
         QFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770035810; x=1770640610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gx7i+hLNEQGkRpdhB7jkz2YgY4q7ryJmKRHbDgrJR1s=;
        b=hn/P8BFpYYfRzsZCBuk6eo0aSgpgz6EK9DqKpDOouGbWN6l+o/GbKMBwUbv31CUln0
         QTN6cHcd4Fj+srpyrRZloUQqdUtApmabTx9LpH4GvylummQzNtSitD3W8YkJSRHH6El8
         QvZonJxTbnqMILGM7nJsSUhBOGSatEfQ4GXeVUeHqLJSFPkufgKlxm62cs/P295y/JnP
         Qeq89woRytI0ye4kjcFUQh3jKlGnHwxm6jTq6iQB1I0/nEsKhHwos59ri0ZTkQDLTrVH
         mmRiYVuXOA7RRiykrib3JVF+8+17+VQLoC803jvAA85TY+sPB/yYFmUN1wFp/+/n9GrA
         YFsA==
X-Forwarded-Encrypted: i=1; AJvYcCVHhbMlIeLnKvIcoAjIsywUC9fB9oER/XLXF0Ib8pH+gZ1bzR+6UAL+D5QOUbnBKWFBNLWO7Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyh4mykPdQt7cB1/DORVEQgViZhEa9wHjgaUCcyR3lBPtmQSMW
	RrIPMDTLzqbGp35KfFVcjlnZOkohHs8/zQeLLf4J68HkT1Vyzdnu170F
X-Gm-Gg: AZuq6aITOPy/4z5E/Vbc+fthNxRrR8cNW5ra7786Z+qvSp3STICwlA9u5EvPAe/0l/B
	p6POoeJXYxFvtGj190d0hk86435RsPUImNOdQkxaDFyb8F5ree9cYRQf5WdUvJfUyRDia6IrbP1
	tevBxkeYmcTnBzhBQfgFRZ8LYGbOeLHbsl8SBcDtuQrtQPpIbHuyygEHryGjESf3HARz7I73SdS
	sGzTFN9urcXywPyFfIQpWpa/4gmHw06Kgf7Z0w2acZvBT/FYUZn9f2Er0UpWoE5JaO+PJLsIsrb
	eFiKChTDW8PU1RTivtWV8xM4gODZOcTMsWE6stHAhEnbp1vo27th4lKM4551IZfxNsAb5XEESZW
	uoPA/jveAjiIVJixZnAVNxhXdjtul0ov+jpbOfQupNRSpwwcZ96OIyAOu8iM3EAOAEx8fZ0+HPI
	lLMsc=
X-Received: by 2002:a05:600c:3541:b0:47d:4fbe:e6de with SMTP id 5b1f17b1804b1-482db4ac12dmr91235865e9.6.1770035809956;
        Mon, 02 Feb 2026 04:36:49 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:74c4:3a65:f9a9:6c29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cddffe9sm567857245e9.4.2026.02.02.04.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 04:36:49 -0800 (PST)
Date: Mon, 2 Feb 2026 14:36:47 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] net: dsa: loop: remove MDIO device modalias
Message-ID: <20260202123647.xaz7drp2to2rrwct@skbuf>
References: <d9543e7d-23e1-4dba-a6b3-35dcd6a35dec@gmail.com>
 <15a4318f-50b5-4df5-874e-e387ee070a9d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15a4318f-50b5-4df5-874e-e387ee070a9d@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255858-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 048A4CC6BC
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 06:38:56PM +0100, Heiner Kallweit wrote:
> This change is a prerequisite for removing the MDIO device modalias,
> as dsa_loop is the only user. Switch from modalias to a custom
> bus match function.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com>

