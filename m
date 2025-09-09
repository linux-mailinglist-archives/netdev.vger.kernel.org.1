Return-Path: <netdev+bounces-221050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF739B49F50
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 04:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C00188E6A7
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33181253356;
	Tue,  9 Sep 2025 02:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmNIMQxs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2E8244669;
	Tue,  9 Sep 2025 02:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757385563; cv=none; b=Iu3HqZY0HFx3phloDLMSaUb21JKA1tqm+q9CdBRZ07DDIYjbJ0yJsejxF45ouhh2Lts7sWKe1eKCR8GVle56ux6QEG5Vy4fEtfXcXwpysdtOydsdMm706adsl8QAVMTzP7XJ8gS1A/Pz7eeSHSyf1waTKhcsFgZqD3Hy/pgmoZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757385563; c=relaxed/simple;
	bh=js5BqEjpcuNX63ezALrd2QGqm0ec8WiRQdlQ9uiWBQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrMJPBFXa3XxgXkXL4JP71k2DuhoJ1MkfXdbAA73fu0cQDmW4BrGr+BuGY/hfR2YN/2cKCt2l4BtqIA1MXkqMvwfgDVI+TcMBspmZrjN4ftFJ0IL/Iir0G/tAZ8gYt6pai0dp7IJh3z4iyZLgTnVIVcqOG0H40OANbJGMFEPXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmNIMQxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44718C4CEF1;
	Tue,  9 Sep 2025 02:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757385562;
	bh=js5BqEjpcuNX63ezALrd2QGqm0ec8WiRQdlQ9uiWBQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NmNIMQxsI/I1ozX+3TYLj0ngftvR21reXL6Ff8DVXHD0v1QM6e+WtVtBvne51HdjC
	 F6iQZP6cii6ylqu2P5YWLIc96gfCB0xBg+Yo9j9ULzrGPB2V/Xs5oLuuWAOj8P80UC
	 FP7ZFzrclnR87BDMSJoVpT/+FRIO8EwtI9avB3MGFrFDUg7/dmz0Rz2+GNtNTw2kdu
	 aWlGHYS4W9hVU5esNvSqA2MCKN+TKkUegbtrFtTW+iLLd/SmizDiTRTYeobFY+lM+Z
	 87LT8SmPpriGA5ap/Ra+sJ9h+tTr56aoI0WvZCkzyBceAHrz0rURFY2rhjcPlnEbS5
	 x/PtwOG56gu3g==
Date: Mon, 8 Sep 2025 19:39:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, Vikas Gupta
 <vikas.gupta@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>
Subject: Re: [v6, net-next 07/10] bng_en: Allocate stat contexts
Message-ID: <20250908193921.0c1ae935@kernel.org>
In-Reply-To: <20250905224652.48692-8-bhargava.marreddy@broadcom.com>
References: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
	<20250905224652.48692-8-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Sep 2025 22:46:49 +0000 Bhargava Marreddy wrote:
> +static int bnge_alloc_ring_stats(struct bnge_net *bn)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +	u32 size, i;
> +	int rc;
> +
> +	size = bd->hw_ring_stats_size;
> +
> +	for (i = 0; i < bd->nq_nr_rings; i++) {
> +		struct bnge_napi *bnapi = bn->bnapi[i];
> +		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
> +
> +		nqr->stats.len = size;
> +		rc = bnge_alloc_stats_mem(bn, &nqr->stats);
> +		if (rc)
> +			return rc;
> +
> +		nqr->hw_stats_ctx_id = INVALID_STATS_CTX_ID;
> +	}
> +
> +	return 0;
> +}

missing unwind

