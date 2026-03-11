Return-Path: <netdev+bounces-266655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIEvNtl0sWnovQIAu9opvQ
	(envelope-from <netdev+bounces-266655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:57:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6E8264EE2
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2441302FB38
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D83363C7F;
	Wed, 11 Mar 2026 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fsk/4LPU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BF5201004
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237379; cv=none; b=dS4vp4jMGd2RsvYz98V+qCZrgKiRf5iMLTL0leoxYkX8rttJTbIiST2ZMqylj+IiBfbxMFKIqG+KlHuhi9T8b0jr6zmQBOtqoGiLesXD9JqMSm9TWhm+mpOuhYUWJqdK4GDSx4+nVV8bkuQLknlkAkppt88VGEFAmeDGkXyD+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237379; c=relaxed/simple;
	bh=j1s06NDS4SJcincrj/rnkNdppUM8BFzQ+By2ee9UZKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RS8/so0tA8rep8GlpZtWbAXVpnexsBByudnsKJAkZGwqKlMBoeYE2E441pzFcjQ1TVLgWcsFHBjNJMYXOZV7K+nKg+IkMjwQ2ujE1oG2oCaozUl/L7/AU+Yi0vugwDKOy663rL+gPu2zcHyUI9JKldJNAZOx0s4W72J/pazIQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fsk/4LPU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4853a5ffc05so7061185e9.0
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773237374; x=1773842174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LqZMCv9jxmsOJ8K08ssoOAid+NS/3bIFAEMmb8pY04k=;
        b=Fsk/4LPUjQKG/DFCgW7ZN9TbE/J+igPgWriWL9JMINtveju5s2Wu4u6pg+I7T/3qPF
         /0yc6nUbsdv34HA0s9ZMN+GbpWvjFXg5XFC0jyofaRo4nONhHj++6j2JAZblducsAmb3
         Z6ou6k6Ux2axbxdcuCCA8qbIvr7hqzSF538y3/HjQ3D+GrpGUvGJGvy8Ko/fajywj2uQ
         Jx2YhJ6X+sA10FWzaRJM4jfsNcmkLaYG56fRT0KF6hZMWGVu7XIoJR7nXAv2XB8rG0Ua
         G7WxJdEaRRjagVuxPNaoFNGJCZyBrdS019yllYeAGV4GK/w1DTLP5pQFJqVhVFefScsk
         59Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773237374; x=1773842174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqZMCv9jxmsOJ8K08ssoOAid+NS/3bIFAEMmb8pY04k=;
        b=qXHdaHDlODbCZ8ooUGZe2kIWxkNU5Fn6CkgJ6iwl0q8gllct7aaeHac3twz7JdIog8
         W3dOngccAf2kaXwJbudxjuqk7hA7vW/Oh3G9FHyhcDpSdZrDYUXePDeNY9Ay52wx2KBA
         obeBa8/hvxmBgliQKlLlHXORfxYfpi+OdIs9xLw/c+FPdv4RX5LWG6BMO0nan0kYUfga
         IsIKT22KbnDy1XOsgrx8219ImxAHoeVi9yLlDd792oxZg9jxkLgIANnFkV2lQBDDJXsv
         qnSb8U+1kYjKtCyv7qIJWVN1Bm8tobTK6eN5bY4DxWkqL1d7zOOoqhcIdjAq0o4HdVwA
         C8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUz+gvqbDKTjAHHbOu48rzGPoQBjcQ0oojaak2rITDiKEP1CL96cfRoZ8OMMiE/G0gqcgc8Ilk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnn7JOltxaL0h+cjojSnyHYpCikJpACYs30Caiq3Ky0ZyHfw7R
	RN5MAznt1Qh3Ri5EN/z+KgAStgL79Nb7jmSP8IJtNuU1B3+3bVUWE6+q
X-Gm-Gg: ATEYQzxizoeVHnj4p/wDWRnHEJvsNjKPf4kKLxtVrg/cv8wBwbmAPJE17VXaVzmlMDg
	7sUEcmRaFr61FvAC30y5wiSBCH+lzCUa1sdbtZ3+aATcZB1px62PEoqcbBmKfTS6otDa6N0u0OT
	NjRCCD0+Z3YaaFaXmQ7f1AlXL+gHC6VQAthp9b/6vKjXgrcWD7hgMTqwhXsyZdeP7dHEMS+6unT
	jEOrxbEbP1YjSR0VqDHmcyvn2ijFz7MAoaTsi+l4bbTdmD+XKcZN+cg9YWkprsHtGCu6As+05PV
	9wf9AS2qZWYX7UTXPudkUFcdBJyhPP8rBIsOije/HlEX3IsxMeDv4ORdriB6YQYareHhZJmUsFb
	qOz9XSJdK48kztlWOic1li92iPWIYThCUMIQktIVFluNBdUqJ7VsXCjkEC9JF9iHJeWNozkG1Fs
	AVGEmF0Bdsj8axsg==
X-Received: by 2002:a05:600c:3f0c:b0:46f:ab96:58e9 with SMTP id 5b1f17b1804b1-4854ad767a3mr24965865e9.0.1773237374114;
        Wed, 11 Mar 2026 06:56:14 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d00a:e00:43cb:c21c:efe7:d225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f6e6sm281949615e9.10.2026.03.11.06.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 06:56:13 -0700 (PDT)
Date: Wed, 11 Mar 2026 15:56:10 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, horms@kernel.org,
	pascal.eberhard@se.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
	Tristram.Ha@microchip.com
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Message-ID: <20260311135610.oox5ahxcyvxkuegw@skbuf>
References: <20260305095656.vlyaztv6nbdqrmil@skbuf>
 <98944cef-0877-4fb9-83a0-92bbd3852f66@bootlin.com>
 <20260305125149.ejju5ptrkviqi3sm@skbuf>
 <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
 <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
 <20260309205401.bk5fpw6kqnmlktbu@skbuf>
 <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
 <20260311115356.windefb3j4kkuslg@skbuf>
 <c3812b1f-50b7-4663-92f5-14c5c6b483a2@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3812b1f-50b7-4663-92f5-14c5c6b483a2@bootlin.com>
X-Rspamd-Queue-Id: 7C6E8264EE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266655-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,microchip.com:url]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 01:53:38PM +0100, Bastien Curutchet wrote:
> On 3/11/26 12:53 PM, Vladimir Oltean wrote:
> > On Wed, Mar 11, 2026 at 11:02:35AM +0100, Bastien Curutchet wrote:
> > > I, more or less, managed to fit this PTP support in the current framework,
> > > but the next series I prepared to add periodic output support is full of
> > > is_ksz8463() branches. So I think that I'll go with what you suggested and
> > > try to move the KSZ8463 support in the ksz8995.c driver. It will probably be
> > > cleaner this way.
> > > 
> > > TBH I'm a bit lost with all these KSZ variants but IIUC KSZ8463 and KSZ8995
> > > both belong to the 'old generation' of the hardware. Maybe a good split
> > > would be to have these old switches in the ksz8995.c driver and keep the
> > > rest under ksz_common infra.
> > 
> > Wait, to make sure I understand, you said you're going to rebase this
> > series onto the ksz8995 driver?
> 
> Well I'll first add basic support for the KSZ8463 in the ksz8995 driver and
> then add interrupt and PTP support on top of it yes. Did I misunderstand
> you're suggestion ?

If we're splitting drivers, I would like to see them grouped by actual similarity,
so as to not repeat the same mistakes.

I took a random feature, user port separation, and I'm comparing how Linus
implemented it in ksz8995:
https://lore.kernel.org/netdev/20260219-ks8995-fixups-v3-5-a7fc63fe1916@kernel.org/
vs the register map from KSZ8463:
https://www.microchip.com/en-us/product/ksz8463#Documentation

Apart from some funky naming differences (KS8995_REG_PC1 corresponds to
"PORT 1 CONTROL REGISTER 2"), it should be pretty similar, right? Do you
see some differences requiring major surgery in ks8995?

Apart from the obvious incompleteness, of course. That driver currently
reports DSA_TAG_PROTO_NONE. It will have to return DSA_TAG_PROTO_KS8995
for ks8995:
https://lore.kernel.org/netdev/20260107-ks8995-dsa-tagging-v1-1-1a92832c1540@kernel.org/
and DSA_TAG_PROTO_KSZ9893 for your KSZ8463. Right?

