Return-Path: <netdev+bounces-124119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F5296825F
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29808B213FD
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 08:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E3D156C4D;
	Mon,  2 Sep 2024 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRmLM7FQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A8B143889
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266962; cv=none; b=JipcBYTwy7AzbK5xi+Cq6dK2TEVqWs/Br5eG6Cl5h30TXbeGLB8UQtsFwJddl5iY5+4f6WRqn9ZVpV0P05mcmGg7SMQwrE0dU7VIFmJdJO20H7KpyL43rFcTyrjuQu/5fuRTnE9xEt4NQ3Ce1a6sp2xaNDZKg/ANXOySrooxiyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266962; c=relaxed/simple;
	bh=d1/KMQQr3fp9PZdagK+xwKJylQI0EntVlebQ3EFFMCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdVP8hMgQkjP1yrDEbgzaqx/6cejfN4vAjSmjd+KMWRDkxain0vLHZqtofsXfFVr6hXLX/CCuRE6hrt9AjZW9+mkXJGaBEyB1+sjFLG52z7IM/1NE3sJokImk1wKmO9HkKdvKaGMo1NcS2MVTD9wxlEulfoNU4CX0oXufSzdsw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRmLM7FQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EF3C4CEC2;
	Mon,  2 Sep 2024 08:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725266961;
	bh=d1/KMQQr3fp9PZdagK+xwKJylQI0EntVlebQ3EFFMCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRmLM7FQNHhxRN0c4VcxoPrXOhha8/AKkVACxwSdZdQxfFGqjkZbgAHkm4f4yUlGs
	 y9sDvV5pu6vfINvCXbRaBln5HuUm1lvCC+woGiH3z0wfEtV4ujVK0iH0dcTQR6WhwN
	 pDmu8OwD8F1G07/JRt+rnlIfNhDV06LKuQt7ZqUDS24+NP72toSl53PSiLJye/hig3
	 z/okx3/INUWxVgtt84cbPtZit+ciYF2zsCD27u8S40hMt3+cV5Cd3Ive4ibAAe46YF
	 5ytLFSZcXi87E52yAnlgM5y+MWEHAodMEzyUiQ+WJ2218AUfY1PUEA4j3Ws1Nekii+
	 TVGVBuaXHspPw==
Date: Mon, 2 Sep 2024 09:49:18 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pavan.kumar.linga@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] idpf: fix VF dynamic interrupt ctl register
 initialization
Message-ID: <20240902084918.GD23170@kernel.org>
References: <20240828223825.426647-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828223825.426647-1-ahmed.zaki@intel.com>

On Wed, Aug 28, 2024 at 04:38:25PM -0600, Ahmed Zaki wrote:
> The VF's dynamic interrupt ctl "dyn_ctl_intrvl_s" is not initialized
> in idpf_vf_intr_reg_init(). This resulted in the following UBSAN error
> whenever a VF is created:
> 
> [  564.345655] UBSAN: shift-out-of-bounds in drivers/net/ethernet/intel/idpf/idpf_txrx.c:3654:10
> [  564.345663] shift exponent 4294967295 is too large for 32-bit type 'int'
> [  564.345671] CPU: 33 UID: 0 PID: 2458 Comm: NetworkManager Not tainted 6.11.0-rc4+ #1
> [  564.345678] Hardware name: Intel Corporation M50CYP2SBSTD/M50CYP2SBSTD, BIOS SE5C6200.86B.0027.P10.2201070222 01/07/2022
> [  564.345683] Call Trace:
> [  564.345688]  <TASK>
> [  564.345693]  dump_stack_lvl+0x91/0xb0
> [  564.345708]  __ubsan_handle_shift_out_of_bounds+0x16b/0x320
> [  564.345730]  idpf_vport_intr_update_itr_ena_irq.cold+0x13/0x39 [idpf]
> [  564.345755]  ? __pfx_idpf_vport_intr_update_itr_ena_irq+0x10/0x10 [idpf]
> [  564.345771]  ? static_obj+0x95/0xd0
> [  564.345782]  ? lockdep_init_map_type+0x1a5/0x800
> [  564.345794]  idpf_vport_intr_ena+0x5ef/0x9f0 [idpf]
> [  564.345814]  idpf_vport_open+0x2cc/0x1240 [idpf]
> [  564.345837]  idpf_open+0x6d/0xc0 [idpf]
> [  564.345850]  __dev_open+0x241/0x420
> 
> Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

Thanks,

I see that this now matches the implementation of idpf_intr_reg_init().

Reviewed-by: Simon Horman <horms@kernel.org>

