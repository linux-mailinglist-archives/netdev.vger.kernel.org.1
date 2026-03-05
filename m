Return-Path: <netdev+bounces-264273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBX7BbNYqWkh5wAAu9opvQ
	(envelope-from <netdev+bounces-264273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:19:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F367120F984
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E9603019819
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D2937EFF1;
	Thu,  5 Mar 2026 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkHcxDFW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67337F016
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705968; cv=none; b=sY92ooiHkB5LV6o2ZUwvcopWnckerxmbo0QwKIOaOi/wU09ZNKN5ry80Ry6dF3FM7fu2nUCV36+MeXdAbnLNSCg2B1YLfMA6LtxRgCUoMTLqDg0NAcZ3EkqDagCInec88ZKBOCSuAD5x4D7aFfDwgKC1C0nq8P1bNJ7Iv6xPLDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705968; c=relaxed/simple;
	bh=3BgC+3tspTPcNiUbBhv+YYUPNouNOqfwkVDg6AxXl9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siGMRE3i9xPu8FiyVRNY5eMIDaDflK4Xycuvuq9oz0JaS/uJv4vlQzEJyll6Fa+lCvT60tldQyQO8sCHf1AFzPNwC/O1bs+ztx3uQlsKgIppSogaUkUjFCczMxf7/n9xYM7IRjo+jvMZZ1oix+iaUC/HMA/ZZuHW2t1pZv/dEZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkHcxDFW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4806fd9033bso13203955e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 02:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772705966; x=1773310766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEt2GXYapCF4HiN9XPn9MG/e3QqGItA80CPWlLUgqns=;
        b=hkHcxDFWL2nOjL+vG92Y32u2AW0LcGgcbNI6kFvXyX0KOn7z0hYrt3GH7R56EvyXJw
         TOlnNrYebE02rRNAPGUb2EAxr3KiheKp++wF33A77Uhf81EPJvq+lNQuM3PhyG2rm6lK
         EiexH2IV6afsYpOql2D81WZloZkM/0HEvE8XFYvbJlj2s1zsNm/dRGOUX0QS2izdDGZ7
         5XYTDqVpEFmke0x+zLkcGOumZDH/b74HkBeVsnHmzjb4qvx0AgEWOUnZRxtc4W0ETE7U
         LgKPcdLvMvXZMvMSkppkfG5a82BvTr+SCAQT9/iuf5MmOl1gyltcpVl7CukmzPG8x3dW
         FjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772705966; x=1773310766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEt2GXYapCF4HiN9XPn9MG/e3QqGItA80CPWlLUgqns=;
        b=M8hAwidaSKOnhXIQMmmXZy+FOkYt4gdwStOQjocFrWXIHyHRZQLbs7bTXTG5zP0F2E
         BglGoeIizPoeMyh8X5E4xMpgD6nbOWlqkhIdDUlnsNg6u+RLjJrz8ZbYgTvf/sR5zD2P
         BUEsfoJz6Irqx9uNV9XgUg4RrUKg4CzSQx0BWDTGPQ9LqQU4TyqyopoxXozDq75Y+5hZ
         TBqg6+/qFX9iJN9G4+yHK5boke6TltP8UocJiB1YYvaudG68qjGMiR0iqxvxGG0qAAx/
         cKw0+RkvQVjVITN/4sfBet+XwO+grM1lbW/g4WFQI25F5bhA3cKifTStykm7m4E9+ddQ
         yxDg==
X-Forwarded-Encrypted: i=1; AJvYcCXSNPmM7y23aW5g54Y+uzdvxtTQRYbxYMcl9lSHM9rYegl9bs629vt/TLQv9NO154DYUoT6+rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN1G9GeKG68Iy3rmPnfGGfSbCBvGMc+rnB+UIY+Sw7eAumiZq8
	ej0cDaLsJsklCRxAYgntELRULAwYOu9t74B5SoXOsoTMY2GDDQVU/Vpz
X-Gm-Gg: ATEYQzzGrYwIM29TDKVUDLz7bch5GHgwYLrHJ9IwFoIHfZDYRIzJFC+6pIgNXrp2pJY
	RyveDbs37OP8Xj2FzqWMwOyG4RNPrII6JhdQDaNm6W/udNR6b9AL25aTIN9k3ORNgUHyGI4tGZc
	JLsHFgWxClHeqs/5NhrwbeHLecmPn5Keb/ARK0ZBf36vktxRB8XYxXWXRzFCJPRf9pxIXevt15u
	hxk42t2Rbm3ySFqb0krfKnHJlO+4wMBN9HfvxDh6aBXYVOGe0c6xs5XpwGoL98MteNYS3wRoO1W
	kgst3xQPlGcrC2LqYbqJYZC6xaofiOOe8HnseOOgH10pZh/SM/ZmFqKIPObECArqlUX1GXEIV/I
	Wmmt7asEt6C2tFQDOX49iitZtlvahtkgbJTNJpy0+jma2R/rX0GipU58i1mStLFOKSgxZ3bEoDt
	dw2KFzaPPT0eTaGFg=
X-Received: by 2002:a05:600c:8b32:b0:483:7d93:9f8a with SMTP id 5b1f17b1804b1-4851982c755mr53275245e9.1.1772705965528;
        Thu, 05 Mar 2026 02:19:25 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00e:3600:16aa:c9ad:4288:9dcc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fa87e56sm32969995e9.0.2026.03.05.02.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 02:19:24 -0800 (PST)
Date: Thu, 5 Mar 2026 12:19:22 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 4/9] net: dsa: microchip: Add support for
 KSZ8463's PTP interrupts
Message-ID: <20260305101922.lmkbooqfoeeg3axy@skbuf>
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-4-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-4-3f4c47954c71@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-ksz8463-ptp-v6-4-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-4-3f4c47954c71@bootlin.com>
X-Rspamd-Queue-Id: F367120F984
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264273-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 11:18:55AM +0100, Bastien Curutchet (Schneider Electric) wrote:
> +void ksz8463_ptp_irq_free(struct dsa_switch *ds)
> +{
> +	struct ksz_device *dev = ds->priv;
> +	struct ksz_port *port1 = &dev->ports[0];
> +	struct ksz_port *port2 = &dev->ports[1];
> +	struct ksz_irq *ptpirq = &port1->ptpirq;
> +
> +	ksz8463_ptp_port_irq_teardown(port1);
> +	ksz8463_ptp_port_irq_teardown(port2);
> +	free_irq(ptpirq->irq_num, ptpirq);
> +	irq_domain_remove(ptpirq->domain);
> +}

Teardown in the exact reverse order of ksz8463_ptp_irq_setup(), please
(port1 vs port2). Place them next to each other so it's more obvious.

