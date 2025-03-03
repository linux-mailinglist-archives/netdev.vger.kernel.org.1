Return-Path: <netdev+bounces-171094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F840A4B7E2
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 07:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A0B3AB3FF
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 06:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298411E47BA;
	Mon,  3 Mar 2025 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddOg2Yci"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E573B156237;
	Mon,  3 Mar 2025 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740983123; cv=none; b=jptR9CLIB1f4bD6ynToC4fW2XOmGdaG/0JNyaHCHFrseuPIlWnkec+Z3pufuJhBzEVTKZ4bTXVAq5EjJWJafECLABPhNgDq4d0QtvgeCDSv3H8850OSl5hPo5lll3iYy/bH5ZbJM4xdBU0Il9kFqaW9ERSAV5HP7qgJCdOoGkpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740983123; c=relaxed/simple;
	bh=QddSmenzJXUSnQaTPXNrQkvUIido0PcI4/XhapFbIgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/RtzjlEePbYZAFqzdADr20LVsMfTcsiWH2eHRUaELqZYT6qgfmxhl4hZSemQdbPl+Ay2bzcSmuyZRjNtDWtYQyKqTJeqrlo5YV4Tk/lUj+D1BY03CuaDZ/cDDHD6n02xSA1loS6aFU1dOEOrIZrIxg5mVMiR4RfobZQr0RJjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddOg2Yci; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740983121; x=1772519121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QddSmenzJXUSnQaTPXNrQkvUIido0PcI4/XhapFbIgs=;
  b=ddOg2Yci2CI/3HVVQKAtUnoqkWqdlACHdcDAYbmcDOrFxR/2b70nf4Ay
   9Q4q8RvMZlduq31hE86gG96U0uw0Cu9HrEBgMr1R+oLxaymq+1m91G1GX
   XmIjkW2P6cPM/GqoR2gEskD0GX6nAd8km5ALsrUSwtJLsDB76a2XHZ/pE
   pi+1eR0LzCzPxEVadePOJH1oocG2D84s3DWUAsgt3FJa/SitHPe7zCXVS
   yBphN9Zy6pGxOF21aIvHMNzSeKIJJNt+ppfn1SNOKdZLgOZWn6djsWsjg
   JVs/7FILgtgLpcJeLTLGYl1kwcdBFFoaL95gRtCBTVHHBK6bFN6AMWsUs
   w==;
X-CSE-ConnectionGUID: TseWQg3+RViOLV7uhMH0eQ==
X-CSE-MsgGUID: PslcPE0JTF6oPbNdRAX2kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41966654"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41966654"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 22:25:20 -0800
X-CSE-ConnectionGUID: VhVfEy7fR6607pYneT8zZQ==
X-CSE-MsgGUID: PiQGcvOfTbSSRhc5EXnUYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="123065041"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 22:25:17 -0800
Date: Mon, 3 Mar 2025 07:21:28 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ariel Elior <aelior@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ram Amrani <Ram.Amrani@caviumnetworks.com>,
	Yuval Mintz <Yuval.Mintz@caviumnetworks.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] qed: Move a variable assignment behind a null
 pointer check in two functions
Message-ID: <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
 <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>

On Sun, Mar 02, 2025 at 05:55:40PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 11 Apr 2023 19:33:53 +0200
> 
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the functions “qed_ll2_rxq_completion” and “qed_ll2_txq_completion”.
> 
> Thus avoid the risk for undefined behaviour by moving the assignment
> for the variables “p_rx” and “p_tx” behind the null pointer check.
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 0a7fb11c23c0 ("qed: Add Light L2 support")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_ll2.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
> index 717a0b3f89bd..941c02fccaaf 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
> @@ -346,7 +346,7 @@ static void qed_ll2_txq_flush(struct qed_hwfn *p_hwfn, u8 connection_handle)
>  static int qed_ll2_txq_completion(struct qed_hwfn *p_hwfn, void *p_cookie)
>  {
>  	struct qed_ll2_info *p_ll2_conn = p_cookie;
> -	struct qed_ll2_tx_queue *p_tx = &p_ll2_conn->tx_queue;
> +	struct qed_ll2_tx_queue *p_tx;
>  	u16 new_idx = 0, num_bds = 0, num_bds_in_packet = 0;
>  	struct qed_ll2_tx_packet *p_pkt;
>  	bool b_last_frag = false;
> @@ -356,6 +356,7 @@ static int qed_ll2_txq_completion(struct qed_hwfn *p_hwfn, void *p_cookie)
>  	if (!p_ll2_conn)
>  		return rc;
> 
> +	p_tx = &p_ll2_conn->tx_queue;
>  	spin_lock_irqsave(&p_tx->lock, flags);
>  	if (p_tx->b_completing_packet) {
>  		rc = -EBUSY;
> @@ -523,7 +524,7 @@ qed_ll2_rxq_handle_completion(struct qed_hwfn *p_hwfn,
>  static int qed_ll2_rxq_completion(struct qed_hwfn *p_hwfn, void *cookie)
>  {
>  	struct qed_ll2_info *p_ll2_conn = (struct qed_ll2_info *)cookie;
> -	struct qed_ll2_rx_queue *p_rx = &p_ll2_conn->rx_queue;
> +	struct qed_ll2_rx_queue *p_rx;
>  	union core_rx_cqe_union *cqe = NULL;
>  	u16 cq_new_idx = 0, cq_old_idx = 0;
>  	unsigned long flags = 0;
> @@ -532,6 +533,7 @@ static int qed_ll2_rxq_completion(struct qed_hwfn *p_hwfn, void *cookie)
>  	if (!p_ll2_conn)
>  		return rc;
> 
> +	p_rx = &p_ll2_conn->rx_queue;
>  	spin_lock_irqsave(&p_rx->lock, flags);
> 
>  	if (!QED_LL2_RX_REGISTERED(p_ll2_conn)) {

For future submission plase specify the target kernel
[PATCH net] for fixes, [PATCH net-next] for other.

Looking at the code callback is always set together with cookie (which
is pointing to p_ll2_conn. I am not sure if this is fixing real issue,
but maybe there are a cases when callback is still connected and cookie
is NULL.

Anyway, with heaving this check for p_ll2_conn it is good to move
assigment after this check.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> --
> 2.40.0

