Return-Path: <netdev+bounces-293807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KpIKH6mHWr5cgkAu9opvQ
	(envelope-from <netdev+bounces-293807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:34:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F17621D2A
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6735A30C3367
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABC73DB326;
	Mon,  1 Jun 2026 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4jOWQCX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3940619C556
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327213; cv=none; b=oFIjXW+Al3KU8lksBQDL9Goy99h1sJBRYYY14/tAWNEn1LPj/AdE43jEEKM2BrYRgV5mqfuhZXK86biXEirKLDzzcW1IaWyaJMza2boE+gK3NutXE0ibf9sa9RysXC/VGuktdkx2Ldmg1dYQ2/QsxM4sbIfi7hX0DT/Tbgz41ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327213; c=relaxed/simple;
	bh=z2vzzUU9AdhfZh4TpPBi0E2NHAyN0OiZYk7GbkDEDFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeEY2lFq/sluNqbEx2MwIMc/xk0OovJEWMEocztdmfecBMWUZM6ydbMbhBz9OpnfoXQXbZYGkmxzJaDJD1ROPwoRgnAAh+OOUFUFRDRnwiBSFs7KFkHtjmm6jOoJMkKDxsuZP7twwc49Ym1Q8WtZl6af6iELtSPAkhWFfMocJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q4jOWQCX; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43b7e186a0cso3026787fac.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327207; x=1780932007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXR0o/ax1hkvEGDJ8bUniOsmAfk5/s8y29rVFNL4VdY=;
        b=q4jOWQCXL/6NF8DOYVv1DcZfxifD9x0jWVDcKB3Ifvv6dnpVmeK6F4VjzNhpUrNA69
         wY9DB2JEl2S9onADA+Or57F/TjZLWQGOso5JhPmylGS1ZvaRU8rBwP+hvDvPtLGLP+h7
         SLHuS3/0NPDI/UwZQKe9s7PfdqIZVdgBfKnXpIVLmOXM5Q+cI7QgMgOPUUwJ2yuY8m7l
         yoFaoMxw4PMR4jFj+jIh1hrIvF41DX04uxRCBUD2vx6SZqR0Eqm556iDrWav2r98JZ36
         vZ+sAVmxZpfoku4XdjvvVHG0sSVQ+OiBOhDGvEEDEEViYTpCai4V0PN/brscato8SINi
         N4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327207; x=1780932007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXR0o/ax1hkvEGDJ8bUniOsmAfk5/s8y29rVFNL4VdY=;
        b=L+byz/ah4E1jxWb2f16blqnDKkNZvXDksO3o2EHU1nu5KHG2zPYw1T9pyTFRG7xitU
         tFFcYH7230rIGNuUZmLdJ4D6H+YLkyeij1dR3SJOvYSJtpvka4j4aSvvkgdpEmQhcmpn
         kGmY5iJwI0JWF0VDqv1FgFUAida+SoXLDXCOgiCsd8roqzfN8TeglNT8B+iuOlPXU6GV
         QxVvIlXn8CRZ+Z9wEHTN1Qy+LieJBhn/iaayCrYpu9w6YxdjZsOekE9IBvXtY1WrxTWo
         H1YKBINsSI20WJbfYTmrS3KU8Usfj+6IpK6XSnvs05mY5LIJcTauEXkfAvyH5UKqChqk
         rdKg==
X-Forwarded-Encrypted: i=1; AFNElJ9ZserNMJRmjaSRDBFxqX8WbvmgOXSXKdA7Z78CzAremzxXMDGABh5YaWtILIcuLBnhslNObxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cNBzVJU2vh7F7DSM27x3KifR6XAH3I+QRAC9bJ6HZj8mDx6Y
	0bfGpwmzlxU+Kw7g8TH3lSzIa9TbN6KB/FznPGYePkbLUV/wiw8TFkft
X-Gm-Gg: Acq92OHrOUhbXxXgjSS4egFvLWlskPbABG5DsyZOe6Hwm96+v9ZJh3JRi/uj4197GBL
	nQwR9RW3b5wIQkWiZTGApKewyNT3gHXG6X+Asden4FqckzNkmagwHya6l705wvCzbuI+6yEPtTY
	N2PE3yKJx4pSbtNrtgfRjSH3KDI5HeazQ+NzpPKdmO/UJ4nfStEWUd793hA987zrayP/tyCo4Rm
	vY5iY3Bhd6bm9hnOo/43pGcrKEanA8R8Ku6oJOBvvyzsICls3oARqfwdt1ZSAuvL0h7Uqk9Eo6j
	JoflsoqvQFuthuOGoawi7YvqDrY/ltxPx+AeXtdvfn+KtM89MSg7i9v0JZI6QWbDgg1wY5DmOLD
	wTPA71xpCR9Vnlqql7maqekPVcBXPwA1/GesSab7/Z2jkg91chxF9l4wCBr/EmYPyZrOf/aaNVo
	q2A5pYtDruHyJ6MtR6BmvPGqoHH0OMQvFYu60Ku/c5VxzZLy2Lm35i
X-Received: by 2002:a05:6820:c82:b0:694:8fb2:2c35 with SMTP id 006d021491bc7-69e104765bcmr6510105eaf.2.1780327206868;
        Mon, 01 Jun 2026 08:20:06 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e06587eecsm6357598eaf.0.2026.06.01.08.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:20:06 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:20:02 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Wen Gu <guwen@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>,
	tglx@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jstultz@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	daniel.lezcano@kernel.org, sboyd@kernel.org,
	vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
	jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
	yangbo.lu@nxp.com, svens@linux.ibm.com, nick.shi@broadcom.com,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, linux-fpga@vger.kernel.org,
	imx@lists.linux.dev, linux-s390@vger.kernel.org,
	dust.li@linux.alibaba.com, xuanzhuo@linux.alibaba.com,
	mani@kernel.org, imran.shaik@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
Message-ID: <ah2jIt2DqI1ZZJx8@hoboy.vegasvil.org>
References: <20260407104802.34429-1-guwen@linux.alibaba.com>
 <20260407104802.34429-3-guwen@linux.alibaba.com>
 <20260412084704.743482ad@kernel.org>
 <4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
 <20260412095301.4fe1fe65@kernel.org>
 <ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
 <1088b07d760491deb461d6d01abca631e8f8d86c.camel@infradead.org>
 <ahzQZg_v4bxFfGdj@hoboy.vegasvil.org>
 <3908843460c4864eef79cced40d897f793c7ae2a.camel@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908843460c4864eef79cced40d897f793c7ae2a.camel@infradead.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293807-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,linutronix.de,nxp.com,gmail.com,linux.dev,linux.ibm.com,broadcom.com,lists.linux.dev,oss.qualcomm.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardcochran@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hoboy.vegasvil.org:mid]
X-Rspamd-Queue-Id: F3F17621D2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 08:03:26AM +0100, David Woodhouse wrote:
> If we move all the plain non-network PHC drivers (which, as noted, is
> basically *all* of them) into a drivers/ subdirectory, then perhaps we

Sorry, just catching up here, so the idea is to have

 linux/drivers/ptp/drivers  ?

Thanks,
Richard

