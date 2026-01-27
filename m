Return-Path: <netdev+bounces-253870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HqYBZq8eGn6sgEAu9opvQ
	(envelope-from <netdev+bounces-253870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:24:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB9894DF7
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5DC2302353A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF073559F7;
	Tue, 27 Jan 2026 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMwaCinD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27D7355036
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520275; cv=none; b=DAJ6fSnZIV7u+ekc80DyruDNRiDk2iqrU2TfdN3KGebdAqGXMj7y3pQA1ntpTVzjkN+K1V9CzkIiDt3zbJGN89KAUsIJJ1KdHM28PRSDH7E2Y52zyb9g7HokJsj/UFlTE4GuYhwf+HpWQGRnKzC3LJpGs+dDVWKq1ItISff3KtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520275; c=relaxed/simple;
	bh=YUsPRyblh6OA4hJ1qIocbbGFcDb5UhdcQgBvObvpNuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYlTscpl/eZXywbIqneXbWkO0v71Gz+8k8hl5i/8E+Tldi3uoaXOtglEchkSgsSH0aIRxOlAqZd99wCEtGsYGRVwNYbxuHPf18HPicjCpaKHZI25lc3FqSY9ZkI40RZJUN3rkgdPVAnkRXOMtAGGB4FNbM6GWE16w1cnRNk/7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMwaCinD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-435a51abad1so757184f8f.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 05:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769520272; x=1770125072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Le0HfEtrH2yi44mIxoqNju3teHcv4i6mXnmZ1U+6fUc=;
        b=cMwaCinDVhV9cukSqWiuz+5rKxsKxvwhFmmquJcKwxsXDJIl46oeD4fPQ8xMdvMhM2
         KNE4buO5mZVeP4rZixsgqJ8iXg5t55otnYvc29ouxCV8Dl0Y08Na2uCfj3JIC5UKQd7C
         SYasFCY47TCyyLJGRbvwPrRxMmF9Cfrry3+A+g0BYGhBsZB6Syo9jvhIhJEmtKL2BEuR
         2xEQ4wZpIy4gi9NgMm7x2VjyApz4dTEiZnnzsVMkqffU8STabVcHJCBx41alKFZjY9mE
         d8Qb/EbFaac6bltlVMnxC47iSfS1SKDtH1VEiYh0VIv9EwIDcIyFImaj8s1VwqZC278e
         HzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769520272; x=1770125072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Le0HfEtrH2yi44mIxoqNju3teHcv4i6mXnmZ1U+6fUc=;
        b=hn9faQh4V9G2NaPGNhad2FEf1hk/nmRqucBhWjjnYl4zW8VQih9ssoSkZnNtNpq/u9
         mJHkxQR9Oj/uUfQiImI75r8dzJVhvXTVQqVKJeg4IRx0ABs9PaiM0jPH2oLOPMKezJj3
         TC0ChY3BMKQoIfci++sbSuQQSxA6f/kdcuKfeSYL8P1SfVzFIIYPMRjPkpzAARXmejvH
         JUh2D9O8q7PJVvxLEkaddcdRu28XOWb8YFZxeTu8ZJASY3JHMh3Oc+dwFKjz/sOT8yvR
         RYHrXQjocf0CntyaCSARIHch9vfDRA3dVaJMKkx4scqQOdeeceAkxuasjO4T/gOQM35p
         k/oA==
X-Forwarded-Encrypted: i=1; AJvYcCX4vWLpwHAWnI7Q2eJqAvNJYtNamnS2uZ2oFR7ccP6+jsultAn/+T/NSuuzn2R2tXhlFrUm+6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEEMUBUMN6eTK1XViFm3UhocHjY+Mv6hdU2IM+w/mworuh0cxA
	eoQ1e///3dXokQnCwvVCwaNnfKKn0waRZW7zcsudbGea5vJ3F/osgNaW
X-Gm-Gg: AZuq6aIJKZtJEvP5HAVdE1UaC0FXVPUUcv9Rwh2amuW0p/cfEXFFVu0PAbJtQe/4s6p
	vo8vPj6A51KOceYj4NljRRSigMvYMs/UbGXn03cYolMi+yd8/gVrnVOfChJSGT2iVrIhohn8ZCd
	S+eeRC5hzTiXSM5k0flINtySf9FRECUFv5rarL8vjbkhzXmPyuBa7qTQ7CnF/rsKeC2Cr+gfBFK
	JiuFPbPyyFxX3K8ZXFpeOksw8HpIQqnmLujjV95joBg3B4lHI9Xsnug4FBjlmbIbJfTj/SBMksv
	t8A2JR0JMWBMCkadRgWZiUIPx7QZbuOpdu9aspWEpM8v8EbKgnIemEx/yU3ZnXp2UpWmDGN9ib/
	Q6XLJdFh5q6M2Pv4Fq1oP8CwvizA1lLdxO+MRS0Mtj80VBIGwxi+p5C593NgQk4rjqr8jcdILj5
	p+bvU=
X-Received: by 2002:a05:600c:4e01:b0:47d:3ffa:9838 with SMTP id 5b1f17b1804b1-48069bfb046mr13949155e9.1.1769520271799;
        Tue, 27 Jan 2026 05:24:31 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:739c:1012:de93:325c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c37433sm59383655e9.10.2026.01.27.05.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 05:24:30 -0800 (PST)
Date: Tue, 27 Jan 2026 15:24:27 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v8 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <20260127132427.3yhme32ch2nanf65@skbuf>
References: <cover.1769053079.git.daniel@makrotopia.org>
 <18c6a24eef8617abb5073569fee162f1aa1c06ea.1769053079.git.daniel@makrotopia.org>
 <c2e191c4-dec4-4e42-b108-353778d9bd18@redhat.com>
 <aXinOE7KIFIm5dUK@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXinOE7KIFIm5dUK@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253870-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DB9894DF7
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 11:53:28AM +0000, Daniel Golle wrote:
> > BTW the initial port isolation LGTM, but I would appreciate some DSA
> > expert second opinion.
> 
> +1

I will try to find some time to look this evening.

