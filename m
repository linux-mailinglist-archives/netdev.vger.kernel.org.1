Return-Path: <netdev+bounces-117805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3829D94F634
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 19:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2FF280E50
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F35F18953E;
	Mon, 12 Aug 2024 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLSX5kkP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42613189529;
	Mon, 12 Aug 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485552; cv=none; b=sUO/ONMEmwL5FpP7K2hzPPxzDRzbKV15qs6L/yNwIGsxRyF9VyFeHFRSauaMB0v6PdsT+hv7MXxgJ7Ic6FFYG5afhOb3zs9rDyXMzdFLPEifJZMtOrAO9Ha2aBfw9EKnahg6TRwr8lGfmJNn//HibWrSdqdNCkW11Vkn2rvH/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485552; c=relaxed/simple;
	bh=89tBf3JaxrUSUgE4DeBjSLiEkLK6rYWE9SbgQJLHxL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CMNeUTJBjUkwFtyCuq0N4GnpmyvxL69xM9T5h/PSI9bvTy/8xmuHetbZqK3KUaQx+GV8op6ooaCy4VIbiqkp3UqyKar4eTCaj0U8UnL1ci6da7X4wWHkyThB6RWrw+rpq3pLQjJ6qZMiZo5ebDQZg/87JRN9l3hd7Eab7MmM9W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLSX5kkP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723485550; x=1755021550;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=89tBf3JaxrUSUgE4DeBjSLiEkLK6rYWE9SbgQJLHxL8=;
  b=VLSX5kkPr4lOWgLGPvQvheoA6kuC8IfB9WlP1QyV/9mbu5vaWS3TK/0R
   h7P5mQGFMZ7NQ39QnVBMNCq4HWUeP/VxYE9U5KfB12whMbxHM64EgTd/k
   CX1L9ZiukekvG6+dYv9V0OK/d3eUIvKurDliAM/iCn0KxbYk0ZnXSYQif
   WO5wTf12Q4ievu1d8YyCijqyOC6ED95nTwTnE3pp/bqTX1KgE3PyfhV/K
   3ZMw7zwK5S026llJ0auPbFkBxX79CR2srqpeB9ETrxgGqam6TkAAS3vNH
   Eg9pcsE+ilAuVFAjLTlFIPpj73gZ6QHVCHk3LhrvkVy9U9dVC28MM38yt
   w==;
X-CSE-ConnectionGUID: s88eXRiOTDaQReyJ95e6tQ==
X-CSE-MsgGUID: VxyrW8bhQJCy823or3+FGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32232751"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="32232751"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 10:59:09 -0700
X-CSE-ConnectionGUID: lqmqNyJRTvaXvQIVJUa3Qg==
X-CSE-MsgGUID: VMuQJ5CiTWq71zcqj1hqfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="63201380"
Received: from unknown (HELO vcostago-mobl3) ([10.241.225.92])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 10:59:09 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Daiwei Li <daiweili@gmail.com>, Richard Cochran <richardcochran@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, sasha.neftin@intel.com,
 kurt@linutronix.de, anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net v1] igb: Fix not clearing TimeSync interrupts
 for 82580
In-Reply-To: <CAN0jFd1CpPtid7TGJcgzajRXQ5oxYN1LjLjLwK7HjQ1piuZ_XQ@mail.gmail.com>
References: <20240810002302.2054816-1-vinicius.gomes@intel.com>
 <Zrb0wdmIsksG38Uc@hoboy.vegasvil.org>
 <CAN0jFd1CpPtid7TGJcgzajRXQ5oxYN1LjLjLwK7HjQ1piuZ_XQ@mail.gmail.com>
Date: Mon, 12 Aug 2024 10:59:08 -0700
Message-ID: <87sev9wrkj.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Daiwei Li <daiweili@gmail.com> writes:

>> @Daiwei Li, I don't have a 82580 handy, please confirm that the patch
> fixes the issue you are having.
>
> Thank you for the patch! I can confirm it fixes my issue. Below I offer a
> patch that also works in response to Paul's feedback.
>

Your patch looks better than mine. I would suggest for you to go ahead
and propose yours for inclusion.

>> Please also add a description of the test case
>
> I am running ptp4l to serve PTP to a client device attached to the NIC.
> To test, I am rebuilding igb.ko and reloading it.
> Without this patch, I see repeatedly in the output of ptp4l:
>
>> timed out while polling for tx timestamp increasing tx_timestamp_timeout=
 or
>> increasing kworker priority may correct this issue, but a driver bug lik=
ely
>> causes it
>
> as well as my client device failing to sync time.
>
>> and maybe the PCI vendor and device code of your network device.
>
> % lspci -nn | grep Network
> 17:00.0 Ethernet controller [0200]: Intel Corporation 82580 Gigabit
> Network Connection [8086:150e] (rev 01)
> 17:00.1 Ethernet controller [0200]: Intel Corporation 82580 Gigabit
> Network Connection [8086:150e] (rev 01)
> 17:00.2 Ethernet controller [0200]: Intel Corporation 82580 Gigabit
> Network Connection [8086:150e] (rev 01)
> 17:00.3 Ethernet controller [0200]: Intel Corporation 82580 Gigabit
> Network Connection [8086:150e] (rev 01)
>
>> Bug, or was it a feature?
>
> According to https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@in=
tel.com/
> it was a bug. It looks like the datasheet was not updated to
> acknowledge this bug:
> https://www.intel.com/content/www/us/en/content-details/333167/intel-8258=
0-eb-82580-db-gbe-controller-datasheet.html
> (section 8.17.28.1).
>
>> Is there a nicer way to write this, so `ack` is only assigned in case
>> for the 82580?
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index ada42ba63549..87ec1258e22a 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -6986,6 +6986,10 @@ static void igb_tsync_interrupt(struct
> igb_adapter *adapter)
>         struct e1000_hw *hw =3D &adapter->hw;
>         u32 tsicr =3D rd32(E1000_TSICR);
>         struct ptp_clock_event event;
> +       const u32 mask =3D (TSINTR_SYS_WRAP | E1000_TSICR_TXTS |
> +                          TSINTR_TT0 | TSINTR_TT1 |
> +                          TSINTR_AUTT0 | TSINTR_AUTT1);
> +
>
>         if (tsicr & TSINTR_SYS_WRAP) {
>                 event.type =3D PTP_CLOCK_PPS;
> @@ -7009,6 +7013,13 @@ static void igb_tsync_interrupt(struct
> igb_adapter *adapter)
>
>         if (tsicr & TSINTR_AUTT1)
>                 igb_extts(adapter, 1);
> +
> +       if (hw->mac.type =3D=3D e1000_82580) {
> +               /* 82580 has a hardware bug that requires a explicit
> +                * write to clear the TimeSync interrupt cause.
> +                */
> +               wr32(E1000_TSICR, tsicr & mask);

Yeah, I should have thought about that, that writing '1' into an
interrupr that is cleared should be fine.

> +       }
>  }
> On Fri, Aug 9, 2024 at 10:04=E2=80=AFPM Richard Cochran
> <richardcochran@gmail.com> wrote:
>>
>> On Fri, Aug 09, 2024 at 05:23:02PM -0700, Vinicius Costa Gomes wrote:
>> > It was reported that 82580 NICs have a hardware bug that makes it
>> > necessary to write into the TSICR (TimeSync Interrupt Cause) register
>> > to clear it.
>>
>> Bug, or was it a feature?
>>
>> Or IOW, maybe i210 changed the semantics of the TSICR?
>>
>> And what about the 82576?
>>
>> Thanks,
>> Richard

--=20
Vinicius

