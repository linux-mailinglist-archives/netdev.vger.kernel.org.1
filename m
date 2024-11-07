Return-Path: <netdev+bounces-142997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5299C0DAF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9486C281454
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7BA215033;
	Thu,  7 Nov 2024 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8AbVen8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F159217C96;
	Thu,  7 Nov 2024 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003647; cv=none; b=MF5DOxE3jRIPwbAFWpO+z7un35kY8yPS4rYg6reomX79Sp4lIyYqCu9eIM7Rra/zlq4pVeoMsg+5T9yu68fpKOum+5bUlCNklnXhdr35Y8AU6SU5lI2buGKmmX7gj02gUdXqQct+qYL+yimeOelqyJR8yEsXcx31+87D3hy5+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003647; c=relaxed/simple;
	bh=NfRPqnOEv8qgSmUY8eAN37O27hV4PrF669xF/MA5aBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFU2OutkvO3qI/5rH4vvOejCfZnxDerzKTcUyn2B0w6gK5K3uSNRtaIJrdLiAtfbfZQSciik9rlx0nAvcqeinv2N8paPHl0tmNbaYSKvqkrJH0d1GcF/WXBNOw//cXpZ0aoCb79i8oOj9GtxLSKD5uNr18Hz4On1l1RPEPSX5fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8AbVen8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47BDC4CECC;
	Thu,  7 Nov 2024 18:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731003646;
	bh=NfRPqnOEv8qgSmUY8eAN37O27hV4PrF669xF/MA5aBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q8AbVen8ryhPxWKGFTRnGe3Jh71a6EmFJ+uKqT3DsvRE+M4xvlt1//CyvX25e5Vy9
	 n5q85Juq3rdaAfgspxVmmc4FOTQ/y/nOvUJkUju0Z0PPzvvQ4aHckPy+Mp9FFRyedL
	 tPpp+1KP7kxU53CRxh/wCn24EdmjoIybyZZbSzmo9fc+RIN1TVFMNjUQVc44PTR1eN
	 wp8XWmgVxKd9DWXxIbx8/8hG83TktmhrX5A/D4VmVurW7GZZFnP5zsD5pA/Ub8lbLw
	 oTSjaneHrUnvMZFE6lQ3fi2Pmx2lUinpCLNihEdzP2WqkSlx1G+FQOUB8a2sQgIzvZ
	 EM5OK9wwW4qkA==
Date: Thu, 7 Nov 2024 10:20:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kernel-team@meta.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, mohsin.bashr@gmail.com,
 sanmanpradhan@meta.com, andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev,
 jdamato@fastly.com, sdf@fomichev.me, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] eth: fbnic: Add PCIe hardware statistics
Message-ID: <20241107102044.4e5ba38f@kernel.org>
In-Reply-To: <20241107020555.321245-1-sanman.p211993@gmail.com>
References: <20241107020555.321245-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Nov 2024 18:05:55 -0800 Sanman Pradhan wrote:
> +	FBNIC_HW_STAT("pcie_ob_rd_tlp", pcie.ob_rd_tlp),
> +	FBNIC_HW_STAT("pcie_ob_rd_dword", pcie.ob_rd_dword),
> +	FBNIC_HW_STAT("pcie_ob_wr_tlp", pcie.ob_wr_tlp),
> +	FBNIC_HW_STAT("pcie_ob_wr_dword", pcie.ob_wr_dword),
> +	FBNIC_HW_STAT("pcie_ob_cpl_tlp", pcie.ob_cpl_tlp),
> +	FBNIC_HW_STAT("pcie_ob_cpl_dword", pcie.ob_cpl_dword),
> +	FBNIC_HW_STAT("pcie_ob_rd_no_tag", pcie.ob_rd_no_tag),
> +	FBNIC_HW_STAT("pcie_ob_rd_no_cpl_cred", pcie.ob_rd_no_cpl_cred),
> +	FBNIC_HW_STAT("pcie_ob_rd_no_np_cred", pcie.ob_rd_no_np_cred),

Having thought about this a bit longer I think Andrew's point is valid.
Let's move these to a debugfs file. Sorry for the flip flop.

