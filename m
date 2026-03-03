Return-Path: <netdev+bounces-263308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIZuNuMJp2kDcgAAu9opvQ
	(envelope-from <netdev+bounces-263308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:18:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 852201F3893
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB3EC3045D6D
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76BC4D8D93;
	Tue,  3 Mar 2026 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTsLqRiB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4567E4D90C2
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554678; cv=none; b=rz7fD4ID3nSSNThh+Xgc2YDAjlaSzkPssm+kca4+W1htFJ41mm+6Zrb4i2T7iJaX+JZl3VNt/l31quVWy8cGmmIbtEAbsPextoikOU1zB+NPvPCncW1PERJgYjgnbY2eOY4t0Ju1uVFbcik1XfSd/JPXm34+uFdLuvKBap4bVSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554678; c=relaxed/simple;
	bh=Ou6LdZqCzPD6VJp1TNvcfVntCiu7NT1mM5jZzyRm/Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqY+K2B//vF18QZcJNxvS4g+Uq/NVbYRPErzLEDPG0kWTScNnbcp3x8/ZUfXezKfrwlllXHvGThoCabx5hPtBhJj8nWQUU7+lIobngQJUnJvdbojHiwBFqVFItq8EJZLV5AMB+ouhLzBdZ2SGAFNYJgIFbmcRCWmCzUqkw3XgsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTsLqRiB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806fd9033bso10941465e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 08:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772554676; x=1773159476; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BpMzQ/Fm0GSVT5QTwa/j0w3V4b8dDXB+Ulw9MTc4WEQ=;
        b=HTsLqRiBLr8J/vudZSwVAa3mFTyPbLUC2DX7pbEWx/zhW2HF7yzcHrUucjXltd2bhc
         C14RtXsJ8lsJlCAj1H7w5cgs34bkimO+1y/WV8AT+RDKUxbtUEkYPqwmzhUdD23oBvXb
         RWkibjUUyfnoAatTNNiheCBJoSKJdASNcoVVkbJD+gKWQuxH6ldhYRYzWgJwMrFGcZEK
         wJJkzJVKBCGRsnHBLkCy/K4TbOcvOD37RmFQH9EaBnCIj4jmKhuHdj1sHO/0EfbDrzTi
         HVferqhFhHD7E94Dd980mls/HABjSf8iNkvek3kTe17oX9kTmUymTkkmCnyh269PRgpi
         5ALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772554676; x=1773159476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BpMzQ/Fm0GSVT5QTwa/j0w3V4b8dDXB+Ulw9MTc4WEQ=;
        b=DMQRqLo6UYdOArDFqtHnECHzd/EMVtuwC2MfjWH8lywITcPcJAIh7RNXF+ltBd1G4W
         7Z09+SBcC/CLqV1v/F095fsfWlmL+klzjxrOw9sKg7ReehW0agK25g1M/ewh7pRINwSM
         QcRKSv+eQItujx8zfk85F1dyWD/GFElzXnHFaopdNcPGKFmdag/FYji8iGCIlrEFRyrt
         QlWzKkjHEMGebRS9Z7QEf8bvHYHFTnMgzIFcpvIv7bZt9J3TiNgakHP1yQFMy22FBHG+
         QDxhNz3gtp0+b3ATaPrwxI5rSjQPk+WIGbuKbbicQzbzDupq4oAC6aCRyE8pztYkpJU2
         85KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtFsB5MdqgRdHeVWvmO3U/TBLPZrjxbmfiPazAG9uKIkDH6ebmRzkYlHozOrnF1xA6hC8FkoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAZqcK6ERaC3m91nK6nLJrfsiO2qG0Vo0bMGESl27wtQT040Ov
	tWAfceG7+HvX3yjp2MZkHL9ogARpz0TtMWGprdSvyCJwXMsMwHHwk5xa
X-Gm-Gg: ATEYQzyeDM4NHY+2Biz4qUzKcHNn6/D+XabWepqBmKKxWjF+KqEvHrZev56A/7EQP9j
	WGXbER8FWftqJP3AANIRp+wmE6jnGNBg1lSvuwnowLDs1WkT3+c75AIHesMmQpEkoARoYc2fawN
	rsfqSLDBxzahIswIMyKSQtiQDq3he1w2IBYOPOUMlP9D2S1RC1C/OyKGxw+UZ5lH6cpHxH6eiNu
	TJSXZYao7VO9zuWpwdqDfjdU/DicSglfzGpWJNeNg/vBiDFTWUt9TSgn1pk5nViUx1dQuibheCj
	7b0yVzl+nAcc5WZ7d4Wo1AW7KPSV9D0yEaa6axpxHAdqquo/o0Wj0PYTfJKnYqVRidOj3fldHeD
	CovuBqgZUfUij3vR6a5Muc44DxT8T/Iswgs4YukWiDNhzWunFEYGbWsv1nZLG4v8TON4bZlROt/
	QGxv1o8zWtfkabMNk=
X-Received: by 2002:a05:600c:4e8a:b0:483:887:6e32 with SMTP id 5b1f17b1804b1-483c9bd9eaemr168266765e9.8.1772554675591;
        Tue, 03 Mar 2026 08:17:55 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00e:3600:2472:8e4a:cf12:bb30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b346ccsm325715375e9.2.2026.03.03.08.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 08:17:54 -0800 (PST)
Date: Tue, 3 Mar 2026 18:17:51 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 5/8] net: dsa: lan9645x: add bridge support
Message-ID: <20260303161751.s4ryquinp2fus37g@skbuf>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-5-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-5-bff8ca1396f5@microchip.com>
 <20260303142048.y4vu5i57daeuezxm@skbuf>
 <930c6381b676f6c911e3c7235be5b08c7ca24e09.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <930c6381b676f6c911e3c7235be5b08c7ca24e09.camel@microchip.com>
X-Rspamd-Queue-Id: 852201F3893
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263308-lists,netdev=lfdr.de];
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
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 05:08:10PM +0100, Jens Emil Schulz Ostergaard wrote:
> On Tue, 2026-03-03 at 16:20 +0200, Vladimir Oltean wrote:
> > 
> > On Tue, Mar 03, 2026 at 01:22:31PM +0100, Jens Emil Schulz Østergaard wrote:
> > > We support a single bridge device.
> > 
> > Why? I keep seeing this from Microchip engineers. Having two
> > VLAN-unaware bridges on different sets of ports is a perfectly valid use
> > case. On Ocelot I took the driver from a state where it had an identical
> > implementation to yours and I made it handle multiple bridges. I don't
> > see where's the problem.
> 
> The main reason is that is what we support in other drivers such as sparx5,
> lan969x and lan966x. I saw your solution for Ocelot, but I could not think
> of the use case, where you would not just use vlans on a single bridge to
> isolate forwarding domains. But I may be missing something.

I already said the use case, VLAN-unaware bridging, where it transports
VLAN-tagged packets from one port to another without filtering based on
the VLAN tag.

You can't replicate that with a bridge with vlan_filtering=1, because it
would then stumble over VLAN-tagged packets which you'd need to add to
the VLAN table, otherwise they'd be dropped. And then you couldn't have
the same VLANs being transported in bridge A as the VLANs that are
transported by bridge B, because you would allow inter-bridge forwarding.
It's just not the same thing.

> The same solution would work here, but the bridges can not be vlan-aware.

Yeah, hardware limitation, there it makes sense to have a restriction in place.

