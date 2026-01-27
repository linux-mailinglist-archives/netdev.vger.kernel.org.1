Return-Path: <netdev+bounces-253872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICNbNL29eGn6sgEAu9opvQ
	(envelope-from <netdev+bounces-253872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:29:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E751694E71
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46DF33003738
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710EB357A35;
	Tue, 27 Jan 2026 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRgkNs9J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55E4357A3F
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520566; cv=none; b=H7juspksVfe3l8acvthQGypETi5G2ZikY9EygdSljDAejgYkqdz4uKYqG0WMrz3ZSpuKegA3ouFnb/Inw5bMUSexNJiR7Y9l5StHH5TAze9lhAuL9ZewYBd5foxANqHGz92fsyKMoAjAGxHxcHjzeNeqk65K1k4TaUwHd26LmOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520566; c=relaxed/simple;
	bh=smGsevBidp6lvL3N+EjJXFvkf/ydPnWcHyn+m1Q6l1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6BA++35s8e4zHZ946hUC96SZ4JXMs+QNZLwIm7NVfnIm5B2Wkw39Ueoy+8m6BRyQFy2Sfs/WBOoa5PANKB1LmeKWJk94NQohHRcRUjIQ3PE61NOFYP6dkCW09mTS0He4nS5bO7Uu1BY8rxX+Ot1UHR+8tCNRyYJBFLok6PqGvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRgkNs9J; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee787da37so3254125e9.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 05:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769520563; x=1770125363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QF8ATHMJV8PnE7lxV4E8FT+gp9jYV8d5HM1G8a/8ZcU=;
        b=HRgkNs9J5YjotaDdSvdI5mUPF3w8DE9IGjlCrsIoH/s8Vh783irhX9fOkp/evGQIiA
         wUZ4K6YZkyVFKCwDKaJxjdbO+XxkOUf+3EdNYr737RiQ+mEcM1lLzhKQXDnbambdVd29
         5wS43AKKKEFMsh4jrzhnovgPHTzDfU3+avo+ZcnreDEG2Lr2HClvhBHFPVeBeOHfy6Ip
         AEN35JU9iI+SqAZXvBo6LTZtSCyRhcHSBe2ZuKjKdbXpqfEPEUT38v0ujdBPpgiR+a3o
         eZA8IxVGp86UWUIYZGiO+rr2o5025u0419oGrrK8D2XA/GAqrTIBH/ZKtmApJK7sX9gN
         AAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769520563; x=1770125363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QF8ATHMJV8PnE7lxV4E8FT+gp9jYV8d5HM1G8a/8ZcU=;
        b=EVlOwCgmpZYbUgM12Njj1Hjgn9leU0a1LO+mpJbtnyw2Nr9a6Pmuj8d7UU6HAG+8tm
         jVui/FTuq41YDmGECDpdh0uxFfuPIFtjGaFJYN73ZkwRUWKf3yLYrDcsTIrJkDvXuDT7
         POGiX5JmKC1/YTaw5WhOXVUIMc9lX4REUc1D25KpArwrDLlwPbJyWqlHEzMckuSOzGBQ
         c6zgYmGL1bSH7axG1lpihx30nqgmpYvasE9MyW43NflpIvUbUMSYetyXX9wg7V778hVH
         BRyMw3CLy0NN44WGG91vrpSJ5jN9giODSadqOGazmA66bD3MuAHz/IKnUyeKRdBcYM7y
         Ep4g==
X-Forwarded-Encrypted: i=1; AJvYcCWEOBTXJm/MiFY/S6DfoODW1LdkTZIAicCmrEGa4XbBpcBsGQMqiCb2pw1TKfoZbYRpqJQhycg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/QkChDRIKZg/bbYdz4jnS8Ybe9fyj8fZHdw0cuspJ/TR/ly9o
	Y2DpasxvAe8hCbKW5ET+cbLsHz5x9AaIS12GrDKRvQcz5oN3TgfzaJvp
X-Gm-Gg: AZuq6aI2ZyH8dynUmMNcBdMWytlQ8kw5F8JZmZCRyV+U5uJ92qwOJcuJrzNCkVk0Nl/
	yOTPqk2q+m76PLknyXm2xRCubIHcZU8nyXyX9tPaD6tcCw6Ud9MHkLbigvSvZ7KsO3yJVPOwmCy
	DKsDuYICnUjTnTEWxgbT/1pxhxLcEsodOaumiArLbvW/EEYTt7olIPcfVTngWzStuSr1S6A/oM0
	tWqxuebu4nlfUFBrQmcCGTj9/ysBit34eiNskxjoBxg10oN7VCW8NS9SbSEXikmL8FLItUInuH6
	PBSwhMwjg7ir54FV4JJ7Hap45YqYCp5M3BuPms2o/6sxB2sEOzXaIyWcLYrdVQ09PY8vM2CS/60
	sNU3oGbqFwZM6fEg7nBvckt3/vpAxTyJr+orvc+x18VMUPUh/f/dNop1yafosS95ddctRO4Qc0S
	qV7os=
X-Received: by 2002:a05:600c:3b19:b0:47d:3ffb:39ed with SMTP id 5b1f17b1804b1-48069c5b9d0mr12505905e9.4.1769520562766;
        Tue, 27 Jan 2026 05:29:22 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:739c:1012:de93:325c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7474csm39117010f8f.37.2026.01.27.05.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 05:29:22 -0800 (PST)
Date: Tue, 27 Jan 2026 15:29:19 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: dsa: lantiq,gswip:
 reference common PHY properties
Message-ID: <20260127132919.xsvapgqc65f44iah@skbuf>
References: <cover.1769519758.git.daniel@makrotopia.org>
 <d9b6212ad5137feeb58b28e9b0784f1084c813df.1769519758.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9b6212ad5137feeb58b28e9b0784f1084c813df.1769519758.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253872-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E751694E71
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 01:18:37PM +0000, Daniel Golle wrote:
> Reference the common PHY properties so RX and TX SerDes lane polarity
> of the SGMII/1000Base-X/2500Base-X PCS can be configured.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> index f601e5f9fa6a..bf199b096dc5 100644
> --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> @@ -105,6 +105,7 @@ patternProperties:
>      patternProperties:
>        "^(ethernet-)?port@[0-6]$":
>          $ref: dsa-port.yaml#
> +        $ref: /schemas/phy/phy-common-props.yaml#

Is the PCS integrated into the port? have you considered whether it will
ever need to have its own OF node representation?

>          unevaluatedProperties: false
>  
>          properties:
> -- 
> 2.52.0

