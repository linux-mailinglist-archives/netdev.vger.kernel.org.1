Return-Path: <netdev+bounces-290489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC+CGCUZD2qLFgYAu9opvQ
	(envelope-from <netdev+bounces-290489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:39:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7075A7737
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55D0C32AD683
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38D53F23D7;
	Thu, 21 May 2026 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sz3T/M20"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B83F1ADC
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372795; cv=none; b=ZDCGHVOk31680naTWlrKe5RoSSkB/ikdpYy9W7aKcQbM1c54OZIcrxspZdK3KHirGIijYe+jWkiK93sfRU2JK96jaMnNpFAzs8mpSmECmaKGtvteRx0OYiJdXp3i3493Yh61h0Wgo0Mud34gc32fkUPi2KygaNwqVyFDYSHtAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372795; c=relaxed/simple;
	bh=RUXhdu3A/5Y9NzHNYpLYuiIiXuy3f2lK9W2KiI0KTl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eD6BjjHQDv9j1VQ8ICIK4n5Cmv+z4TteyxDT/X15GYzj/R/Pn3SNkLfOKbmmsX/FPNhMdlVm9XMviywV8BIw3aYn1uVr1NFKvgnD0lBdEckfch0jDR3wtiNV8pISqZVu/UwyZH033Xz7Gs5lC5KkKYArIx1+wt6oPTA2k3VdU8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sz3T/M20; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3939d2bd739so49615661fa.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779372792; x=1779977592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nU1KLRskLNe07l1ENeGeB86Y/M2JwprsvHaEqJucuEU=;
        b=sz3T/M202Q5wZdzs8YZycHfmEpXDVelRUw6si6QIRkh/5Vp19EKg3AkXNGUmirLklw
         vxsqWjcn/BzUwFni7orZGT3uJSSH3NSWdJUEHXyWctmaWXJu4mFghMmocovboPpt4SnZ
         qtVfEKhWqnQ99g8W2ZEuaJtLl7FjZECzpf9BGxSnLaKod32VUJMu1laAjsgoJ4z2co1O
         Fwr8tV7SadaoO2bncTK4jqfZkvMQyzmxI+hGHsHY53nNnR7oDZbIXWQP3wehSeR6Ft+O
         bPkiBZ/Wn3YwYkSbz09/Q5F4BSNuCX70B31AZyVLmr3o3w54P9ka432ZnbzbcsUTYg6L
         qBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372792; x=1779977592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU1KLRskLNe07l1ENeGeB86Y/M2JwprsvHaEqJucuEU=;
        b=pR4nfdF4YhIiuUhf2M7LozccKaOyvC9mPkmhiWMwne2/TB7YiXcuFCuQQv7w8kRx0b
         j3prAABqQu5dJdinqqPqBaxHFNKpckLXDiXwK32HMjgzJ7KpM7V/dDJ6rKGyKQSGUmoM
         moqvbuCnfX3wnBX300O9d17VfLOS7NJ74kBKylo1nIVsE2rH40Ou27W2L/uH9H9U87B0
         VAeowhS2Rpy+3fSG2rOkJTiBhH5Y9o5Jy1fjJp/MN4MILT5E2YK1JWsgiMYJncLj52RG
         ISSydAq0OMpqp7qqTkWG75HICbEZBwgn3tQjmQ2XDYzjVpIwWtyYusI8vddfB8M3r+Uc
         KJSA==
X-Forwarded-Encrypted: i=1; AFNElJ9TKeDQD8iIn3/NvSdRfdoruXF4EwzIABVIybCns5pAEd6eO73qwP4kbTkzj4MK7H8BR6sdwmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRyhuMQwOoU3DfWHx44SaFXz8u3bRGdm7bauVRkyY1Whl5IYW7
	9wI7TYFfHR+vLWMIy0AeJ6VyjglU9XNkdXtZHJ/RpVWMFPr8GiCWqyrA
X-Gm-Gg: Acq92OEnKmI3MijM79pxmmpFJ2AY9lksItfdDP2oGdJrQb+o7qQ+3ue2/x54NTry2v7
	3OTEGlq3kptSNyCco33rjiH1eTLajaSBPwWk3cB0gOEZceYqDa9HXczKi9IsMY2Xq0Cr8CRZXzC
	bgaj+yDevPX3Bg1KXk9IGpq3aNiiFxZrXHPfMDlc4oQ8FZX9c8CQ334BVX2AfCC7yKqpTEmRXLj
	jjH02+5LBjEuyQF+N8bJtc6jJCxkNjN2dLPsr/Li9c6y3ePo8Unhl1WvM4WbCkuwud92YCJugrX
	2H9VZ4k3f/MfZDF26D7NxuIHVvfPmEbKwZXVXKZYgi++SGHTi3fn2kIO4hyMGDSOtorTm6GDQUk
	XocjtB34/q34U28XzMJVj4+E7Aj6faCthNfCEVIfOqXJMXGdR6DAeSdzuHmMbjIQ3PUZhF3W8C6
	/SpHmdpk336vNnfwD196TnAzAgOMpR6bDqv6Eb5km6BEGmp8stOn7mV47H
X-Received: by 2002:a2e:bd17:0:b0:393:71d3:d019 with SMTP id 38308e7fff4ca-395ca60e1cemr13617271fa.15.1779372791941;
        Thu, 21 May 2026 07:13:11 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.5])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395d0b49073sm2787241fa.31.2026.05.21.07.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:13:11 -0700 (PDT)
Date: Thu, 21 May 2026 10:13:06 -0400
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>, Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>, Lee Trager <lee@trager.us>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Chengfeng Ye <dg573847474@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] dd LED support for fbnic
Message-ID: <ag8S8p-znkBc2WTP@PF5YBGDS.localdomain>
References: <20260520200337.204431-1-mike.marciniszyn@gmail.com>
 <48c64757-dc3c-4d05-a269-fa4f50c299c3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48c64757-dc3c-4d05-a269-fa4f50c299c3@lunn.ch>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290489-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,fb.com,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,makrotopia.org,gmail.com,intel.com,trager.us,oracle.com,linux.intel.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BF7075A7737
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 10:14:46PM +0200, Andrew Lunn wrote:
> On Wed, May 20, 2026 at 04:03:34PM -0400, mike.marciniszyn@gmail.com wrote:
> > From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
>
> The Subject: of this email has an off 'dd' in it.
>
> > The second patch stors the max speed from the firmware dialog
>
> stores
>
>   Andrew

"dd" should have read "Add" (truncated by copy/paste).

Correcting the subject I think would mess up subsequent revisions unless
I retract the series, consolidate the ID mechanisms into a separate patch
and follow up with the led class patch wrapped in a better cover sheet.

Mike

