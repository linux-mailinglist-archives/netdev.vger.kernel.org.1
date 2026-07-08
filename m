Return-Path: <netdev+bounces-305672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hQNGALb/TWq9BQIAu9opvQ
	(envelope-from <netdev+bounces-305672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 09:43:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BDD722C2F
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 09:43:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UdVixJQY;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305672-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305672-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66D2130074A8
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 07:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31BF3F8242;
	Wed,  8 Jul 2026 07:43:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90803F5BCB
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 07:43:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496607; cv=none; b=cJSl1gU1+FD6Ay9MMIIFZ4RIObmG865OO4Rzx0a62q8W52Hlqs70PjNw75BzT1uiXeUnMh6kfOTc/RdsGhzpfj+HDjnhFuDuU/58w3p1ZTsgsLNQ0d8I+nqdCCeTTDlgFN//mEsRjILQVPECXZkWsImW1ARWmFN9P9NU5onsOxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496607; c=relaxed/simple;
	bh=wqspe9peDUDf7Lj0Ckvg+Ou41duj870AZXBlowe/bLA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXypPKKMkf43oEni2uaudlF9rvh95+/ItL3hIy5jNLE1KQskVNw7iYxLC/5iv85FJxBQjGQN8Ivev3Y6TPWt/ng3w8t3i4Ascx1HOFQC1UiXYlcSiZhyi4ssS9T7aE2YOMxxZEr++q8qtxxPRAUsLaRg86JlSsUjc2SDSe1zzEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdVixJQY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EA41F00A3E
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 07:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783496582;
	bh=wqspe9peDUDf7Lj0Ckvg+Ou41duj870AZXBlowe/bLA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=UdVixJQYfC8sGwm2LkLtOuhdj8rGXYZvhM/nEvj78/GfwKlgApbA2mM7v4TKCDBtM
	 TkD+j6IdxnEthYn0jShnTGRcHvUl3uWT0ZDhmk6v26dbgga280PtMUZDwzHv6zk6w9
	 Yi8sszDGyw24AvoZisXpI7QNHqYDfzKTPKFdZGUiCUBuP3uOnWP2zicuVvIaA40jxJ
	 EVB46mt6atPqufA0m9s4aa5bEOsisUWJKTjqkHfv44JLBSqWrvCACa81iSvV/e8lQX
	 OTmHzverjKM3OU5lQEPWgn0fZKvlavTlsO4QonPQHPIENoNkOtr3nIiF1feGEE3W9d
	 dt2lpEp1ZXFPw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aec201b582so435671e87.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 00:43:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrq9nbWbmIvzurYo0kYQt/TqyTes8+WcgcmwIkO+Vn2QR4DUynXU+IZRJo3eS9UjuO3wFW5E1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA7Ps7bK3hu0C7SwcEj95OF0hT1wfcxUb0che98BkkIZpv7g0R
	NUg2sIS9q2s8v3T3OLSRvvdsMm3BEPPxfFsfekTa3duWruEWrPii3C/CdJQqB3gTBnlUAsSXCjK
	ofdQUGxiZaVHxtTjBPUgsSLNPVqJ10/QuGegdN+skHg==
X-Received: by 2002:a05:6512:3a8:b0:5ae:a9eb:c5c3 with SMTP id
 2adb3069b0e04-5b011478162mr274920e87.61.1783496580641; Wed, 08 Jul 2026
 00:43:00 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 00:42:58 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 00:42:58 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ak0jyUbNonSRiP_g@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-5-1ff028e33779@oss.qualcomm.com> <ak0jyUbNonSRiP_g@ashevche-desk.local>
Date: Wed, 8 Jul 2026 00:42:58 -0700
X-Gmail-Original-Message-ID: <CAMRc=Md7-XMBKpdPuZ4=epfTn6F-PXKJBZNPGuz5xbVy58BHsg@mail.gmail.com>
X-Gm-Features: AVVi8Cc97SNnhCE85729H_fOi3Wx8wY1APMX-PhjHPSFVtKB-jxewFEQvchpN2c
Message-ID: <CAMRc=Md7-XMBKpdPuZ4=epfTn6F-PXKJBZNPGuz5xbVy58BHsg@mail.gmail.com>
Subject: Re: [PATCH v3 05/20] driver core: update kerneldoc for platform_device_alloc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, 
	Thierry Reding <thierry.reding@avionic-design.de>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	mfd@lists.linux.dev, Manuel Ebner <manuelebner@mailbox.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,opensource.wolfsonmicro.com,avionic-design.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,linuxfoundation.org,linux.ibm.com,ellerman.id.au,8bytes.org,arm.com,broadcom.com,nxp.com,pengutronix.de,intel.com,linux.intel.com,ffwll.ch,crapouillou.net,ti.com,kernel.crashing.org,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.infradead.org,lists.freedesktop.org,mailbox.org,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-305672-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email];
	FORGED_SENDER(0.00)[brgl@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:lee@kernel.org,m:broonie@opensource.wolfsonmicro.com,m:thierry.reding@avionic-design.de,m:sebastian.hesselbarth@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:srini@kernel.org,m:gregkh@linuxfoundation.org,m:vkoul@kernel.org,m:rafael@kernel.org,m:dakr@kernel.org,m:robh@kernel.org,m:saravanak@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:andi.shyti@kernel.org,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:ulfh@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:matthew.brost@intel.com,m:thomas.hellstrom@linux.intel.com,m:rodrigo.vivi@intel.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:peter.chen@kernel.org,m:paul@crapouillou.net,m:b-liu@ti.com,m:p.zabel
 @pengutronix.de,m:luzmaximilian@gmail.com,m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:krzk@kernel.org,m:benh@kernel.crashing.org,m:brgl@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-sound@vger.kernel.org,m:driver-core@lists.linux.dev,m:devicetree@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-i2c@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pm@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-usb@vger.kernel.org,m:linux-mips@vger.kernel.org,m:platform-driver-x86@vger.kernel.org,m:mfd@lists.linux.dev,m:manuelebner@mailbox.org,m:bartosz.golaszewski@oss.qualcomm.com,m:sebastianhesselbarth@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[68];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0BDD722C2F

On Tue, 7 Jul 2026 18:05:29 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Mon, Jul 06, 2026 at 02:44:17PM +0200, Bartosz Golaszewski wrote:
>> Users of platform_device_alloc() + platform_device_add() must not modify
>> certain fields of the dynamically created platform device object. Update
>> the kernel doc to say which fields are affected and which functions to
>> use.
>
> Consider using __private checker attribute for them as well. It will make
> sparse scream.
>

Sure but let's leave it for another series.

Bart

