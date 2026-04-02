Return-Path: <netdev+bounces-274773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBdcNlsAz2lIsQYAu9opvQ
	(envelope-from <netdev+bounces-274773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:48:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EFA38F4EC
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F31333014A1F
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B93A392819;
	Thu,  2 Apr 2026 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZFZCvAQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015830DD3C
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775173717; cv=none; b=m/HPe5BGfPIDbO4AGcDd8lT9GCDmpihhvvv0uiuO1U0D8RnDtZtpNpw3n5TotPVcUN1IrDx4IkuSoiLAxfbDonTWBBz87eXcgzg2VdG6xN7YszLezimEYy0HE/9AcRdc9zGsPfapEvKufH5FOiT+NWj0dSDpqKXKBi0oKBQPBXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775173717; c=relaxed/simple;
	bh=y95f5QlYUMwAz4Mebn4afYMRuQzmkG7xApZVnf6syFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pA2FndexPTBC58hAdZiZ7EGtSPN1x5C7foCxc0Ha2yVqaltb4WCeX/Rlv0Z7XyLFmr6G+Fn91ZqHWNlliA0olvNpGX4N/CdObt2N4+0NbD20GU68s4NgfoFJBwPbJHMAaqTDeglnvMtQ3cO+3w4kX+a99qag/Z8Tj+DMPb8ceOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZFZCvAQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775173716; x=1806709716;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=y95f5QlYUMwAz4Mebn4afYMRuQzmkG7xApZVnf6syFs=;
  b=XZFZCvAQGrOpVrl7nzGVcRMn4Tec0b1xuJScr2m7qF9IMuk9U0/HklEv
   9Gev2Tbl/utKFLihhBeiBjQDg4VIEFCKlLo/myA+bibPRHiVOz/JO/h1E
   2kBDshsa7/nc+cjyIrrmFoq949xcCc9M0hsRpFiXYsmCWVZWUEAr3ME4F
   DL71Fm6tkdtEkHlU4IqI+PJ2Px1sQJSoU8y36IM9M3elZOZS4+LCeHbYn
   IqBCBrQzyfBEFF480ZQF72Y9cEha/ATtJkrexULIgyggbkz082Mq/WY57
   eI1JjfPLEC3OFYa6tNiigyfmDFfgiCgoXcZlkHcUCb+SamKx0zgpK5vPW
   g==;
X-CSE-ConnectionGUID: BhQLmhoOQjyPD0XyKAw4Mg==
X-CSE-MsgGUID: 8PH571KyRbqZujLxU9ObZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75961995"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="75961995"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 16:48:36 -0700
X-CSE-ConnectionGUID: tjSrim2+TJqzeTDkrUgoWA==
X-CSE-MsgGUID: TiOtLPiUTV+8RW4wpIPixQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="227361270"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 16:48:36 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Bob Van Valzah <bob@vanvalzah.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, julianstj@fb.com, jeff@jeffgeerling.com, Lasse
 Johnsen <lasse@timebeat.app>, Ian Gough <ian@timebeat.app>
Subject: Re: [Intel-wired-lan] [PATCH] igc: fix Tx timestamp timeout caused
 by unlocked TIMINCA write in adj fine]
In-Reply-To: <CDC20B85-E83B-4AC9-9261-24B3D967DCA6@vanvalzah.com>
References: <D1C3B3DF-960F-40C7-BBD7-994359F0C8AD@vanvalzah.com>
 <65977d5b-16eb-418c-995e-6a918f67707a@linux.dev>
 <B22CCB1A-15FE-4233-9F47-7FE522C8D6FF@VanValzah.Com>
 <CAD61B95-35BF-4BAC-AC26-6AC043DE6FC1@vanvalzah.com>
 <CDC20B85-E83B-4AC9-9261-24B3D967DCA6@vanvalzah.com>
Date: Thu, 02 Apr 2026 16:48:35 -0700
Message-ID: <874ilsyld8.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274773-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5EFA38F4EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Bob Van Valzah <bob@vanvalzah.com> writes:

> Vadim,
>
> Thanks for the feedback on our first patch. We've spent more time in
> the lab studying the igc TX timestamp behavior under stress. We
> understand the failure modes much better now.
>
> You were right that ptp_tx_lock was the wrong lock =E2=80=94 it guards th=
e TX
> queue, not the timing registers. You suggested tmreg_lock instead. We
> tested tmreg_lock alone (v2) and found it doesn't fix the bug: it appears
> that the race is between the software TIMINCA write and the hardware=E2=
=80=99s
> asynchronous TX timestamp capture pipeline, not between two software thre=
ads.
> tmreg_lock serializes software register accesses but can't prevent the ha=
rdware
> from reading TIMINCA at the instant software writes it.
>
> Our v3 patch (attached) takes tmreg_lock as you suggested, and
> additionally disables TX timestamping in hardware via TSYNCTXCTL around
> the TIMINCA write. This prevents the hardware from starting new
> timestamp captures during the rate change:
>
>     spin_lock_irqsave(&igc->tmreg_lock, flags);
>     txctl =3D rd32(IGC_TSYNCTXCTL);
>     wr32(IGC_TSYNCTXCTL, txctl & ~IGC_TSYNCTXCTL_ENABLED);
>     wr32(IGC_TIMINCA, inca);
>     wr32(IGC_TSYNCTXCTL, txctl);
>     spin_unlock_irqrestore(&igc->tmreg_lock, flags);
>

I sent, a couple of days ago, the link to your report to our hardware
folks, waiting for them to take a look.

I think that this workaround, even if incomplete, will be interesting to
them as well. Again, thanks for the detailed report.


Cheers,
--=20
Vinicius

