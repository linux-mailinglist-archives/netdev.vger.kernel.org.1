Return-Path: <netdev+bounces-243136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A53FEC99D57
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 03:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C029634505A
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 02:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BD9224B15;
	Tue,  2 Dec 2025 02:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgGu3p5/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2101E136351;
	Tue,  2 Dec 2025 02:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764641488; cv=none; b=dNcRL/cBgppS6Pv4OqJkCod9OA0sTjqwsxZwadEIlSciLe011QVBl+NQq2EPRii+Wr6DjpICKbFQBev+fs2uS639qyuTfbu8hPjYfcJiFt3QmUftf03QtRH7Z3uIEpLCDyuifMQwa++IvAYkTW4BsmaANxhprXtLh54kbNlqPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764641488; c=relaxed/simple;
	bh=fX1BXIg//i6pZxmO37/8m6XfZRKYZjau7eRh7qCM160=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FSjZ1Bosi+tmOU9NdUSoXlA5mnXjEUVikn7cDWZk8OMMq9hPpY6v8UvUF2OS9+jUBHhfAfqZ3sm+F+9h0yXHIqhf1geT+6veNGfRCFRKkfHwREzUAL6mCodvx9/3RXKH4jW+9asZK6r6WrQsXROpRPLQIhroaFRBhRTi64boxhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgGu3p5/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764641486; x=1796177486;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=fX1BXIg//i6pZxmO37/8m6XfZRKYZjau7eRh7qCM160=;
  b=NgGu3p5/XxnSVyyo3uqVwMwRVUAJUFvzl037oByBoFoEP8lkrEaHlJIp
   n7q5xKa9+id87EGzTdqtVVM72bl2/Sj63jbSoHRrtYLWLw0hJ6pX6aGU5
   fy/AdERGAXsvquFVJS7Xi71eizloK2f0n7+H4VSxv6b19XuFFXE9zv8Mx
   eec2tWM2Xy8Qun+ZfFuHjYm3DEikDf7tqWAZRbeZ2EqBX9joEHO2H7i4R
   4i7S2vEDdCqom5SW8AQUa2QoPjn5XSHOs3cgnfYB+i17akwBS9vbaNmwz
   A+SEowFBXPIsm4YEzwix+6CcCrN3xo6YUYa/jqXwl7XodCvko4wNCDGef
   A==;
X-CSE-ConnectionGUID: q2mK1SCISRemszYRR1o3nw==
X-CSE-MsgGUID: lDjvhJwLSpaTXMa2GERtsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="77283620"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="77283620"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 18:11:25 -0800
X-CSE-ConnectionGUID: jqqmvzb8S2SjR0RGPY2ohQ==
X-CSE-MsgGUID: ldENihELRGm7y21uAcFcNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="194226978"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.140])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 18:11:25 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Chwee-Lin Choong <chwee.lin.choong@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>
Cc: yipeng.chai@amd.com, alexander.deucher@amd.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Avi Shalev <avi.shalev@intel.com>, Song
 Yoong Siang <yoong.siang.song@intel.com>, Chwee-Lin Choong
 <chwee.lin.choong@intel.com>
Subject: Re: [PATCH iwl-net v4] igc: fix race condition in TX timestamp read
 for register 0
In-Reply-To: <20251128105304.8147-1-chwee.lin.choong@intel.com>
References: <20251128105304.8147-1-chwee.lin.choong@intel.com>
Date: Mon, 01 Dec 2025 18:11:21 -0800
Message-ID: <87zf81fx9y.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Chwee-Lin Choong <chwee.lin.choong@intel.com> writes:

> The current HW bug workaround checks the TXTT_0 ready bit first,
> then reads TXSTMPL_0 twice (before and after reading TXSTMPH_0)
> to detect whether a new timestamp was captured by timestamp
> register 0 during the workaround.
>
> This sequence has a race: if a new timestamp is captured after
> checking the TXTT_0 bit but before the first TXSTMPL_0 read, the
> detection fails because both the =E2=80=9Cold=E2=80=9D and =E2=80=9Cnew=
=E2=80=9D values come from
> the same timestamp.
>
> Fix by reading TXSTMPL_0 first to establish a baseline, then
> checking the TXTT_0 bit. This ensures any timestamp captured
> during the race window will be detected.
>
> Old sequence:
>   1. Check TXTT_0 ready bit
>   2. Read TXSTMPL_0 (baseline)
>   3. Read TXSTMPH_0 (interrupt workaround)
>   4. Read TXSTMPL_0 (detect changes vs baseline)
>
> New sequence:
>   1. Read TXSTMPL_0 (baseline)
>   2. Check TXTT_0 ready bit
>   3. Read TXSTMPH_0 (interrupt workaround)
>   4. Read TXSTMPL_0 (detect changes vs baseline)
>
> Fixes: c789ad7cbebc ("igc: Work around HW bug causing missing timestamps")
> Suggested-by: Avi Shalev <avi.shalev@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Co-developed-by: Song Yoong Siang <yoong.siang.song@intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>

Patch looks good, my only concern is this report:

https://lore.kernel.org/intel-wired-lan/AS1PR10MB5675DBFE7CE5F2A9336ABFA4EB=
EAA@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM/

It's not clear to me how/why the different buffer utilization is
affecting this, but at least seems worth some investigation and
reporting back in that thread.

> ---
> v1: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/2025091818=
3811.31270-1-chwee.lin.choong@intel.com/
> v2: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/2025112713=
4927.2133-1-chwee.lin.choong@intel.com/
> v3: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/2025112715=
1137.2883-1-chwee.lin.choong@intel.com/
>
> changelog:
> v1 -> v2=20
> - Added detailed comments explaining the hardware bug workaround and race
>     detection mechanism
> v2 -> v3
> - Removed extra export file added by mistake=09
> v3 -> v4
> - Added co-developer
> ---
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 43 ++++++++++++++----------
>  1 file changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ether=
net/intel/igc/igc_ptp.c
> index b7b46d863bee..7aae83c108fd 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
> @@ -774,36 +774,43 @@ static void igc_ptp_tx_reg_to_stamp(struct igc_adap=
ter *adapter,
>  static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
>  {
>  	struct igc_hw *hw =3D &adapter->hw;
> +	u32 txstmpl_old;
>  	u64 regval;
>  	u32 mask;
>  	int i;
>=20=20
> +	/* Establish baseline of TXSTMPL_0 before checking TXTT_0.
> +	 * This baseline is used to detect if a new timestamp arrives in
> +	 * register 0 during the hardware bug workaround below.
> +	 */
> +	txstmpl_old =3D rd32(IGC_TXSTMPL);
> +
>  	mask =3D rd32(IGC_TSYNCTXCTL) & IGC_TSYNCTXCTL_TXTT_ANY;
>  	if (mask & IGC_TSYNCTXCTL_TXTT_0) {
>  		regval =3D rd32(IGC_TXSTMPL);
>  		regval |=3D (u64)rd32(IGC_TXSTMPH) << 32;
>  	} else {
> -		/* There's a bug in the hardware that could cause
> -		 * missing interrupts for TX timestamping. The issue
> -		 * is that for new interrupts to be triggered, the
> -		 * IGC_TXSTMPH_0 register must be read.
> +		/* TXTT_0 not set - register 0 has no new timestamp initially.
> +		 *
> +		 * Hardware bug: Future timestamp interrupts won't fire unless
> +		 * TXSTMPH_0 is read, even if the timestamp was captured in
> +		 * registers 1-3.
>  		 *
> -		 * To avoid discarding a valid timestamp that just
> -		 * happened at the "wrong" time, we need to confirm
> -		 * that there was no timestamp captured, we do that by
> -		 * assuming that no two timestamps in sequence have
> -		 * the same nanosecond value.
> +		 * Workaround: Read TXSTMPH_0 here to enable future interrupts.
> +		 * However, this read clears TXTT_0. If a timestamp arrives in
> +		 * register 0 after checking TXTT_0 but before this read, it
> +		 * would be lost.
>  		 *
> -		 * So, we read the "low" register, read the "high"
> -		 * register (to latch a new timestamp) and read the
> -		 * "low" register again, if "old" and "new" versions
> -		 * of the "low" register are different, a valid
> -		 * timestamp was captured, we can read the "high"
> -		 * register again.
> +		 * To detect this race: We saved a baseline read of TXSTMPL_0
> +		 * before TXTT_0 check. After performing the workaround read of
> +		 * TXSTMPH_0, we read TXSTMPL_0 again. Since consecutive
> +		 * timestamps never share the same nanosecond value, a change
> +		 * between the baseline and new TXSTMPL_0 indicates a timestamp
> +		 * arrived during the race window. If so, read the complete
> +		 * timestamp.
>  		 */
> -		u32 txstmpl_old, txstmpl_new;
> +		u32 txstmpl_new;
>=20=20
> -		txstmpl_old =3D rd32(IGC_TXSTMPL);
>  		rd32(IGC_TXSTMPH);
>  		txstmpl_new =3D rd32(IGC_TXSTMPL);
>=20=20
> @@ -818,7 +825,7 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *a=
dapter)
>=20=20
>  done:
>  	/* Now that the problematic first register was handled, we can
> -	 * use retrieve the timestamps from the other registers
> +	 * retrieve the timestamps from the other registers
>  	 * (starting from '1') with less complications.
>  	 */
>  	for (i =3D 1; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
> --=20
> 2.43.0
>

--=20
Vinicius

