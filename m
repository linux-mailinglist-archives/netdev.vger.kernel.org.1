Return-Path: <netdev+bounces-224644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9216B874BC
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 00:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8BB1C28252
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22D82FDC35;
	Thu, 18 Sep 2025 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3Qfwpfe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13742FB625;
	Thu, 18 Sep 2025 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236286; cv=none; b=Y8fENSG6FKM81OZ0rBsPou2AgOZ4lNjaC3At2RU7H60TDh7ggvOdFxSqXZYgMRX3a9s4FybX7goo5WiTxiPnvzraAdHX3LGoUA9brsnpVVvCpVDwR2MlObi9HRO4BOPYW6mJHeuQWCmKPEijZSuCA379m3kWLm2+GsrKyQMCVlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236286; c=relaxed/simple;
	bh=IwmXQQCVEyFCcqnTQv9hOH6WRK5TuVwGwxOpabm5eCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiI28PWGrPPRuRq5Xcl4TeMjEwDaqIhkSCU6iWziYm6bUI66fSuojNN686XMC/APA392Ui95GoHnEMcmJULVbn4jspi+/dACb9rWeKGwpGPpw90AEOVJDRBsFbFlMrnyz1TxrEvAs47Sx5EKBcoz1QLEmeLZ1lLbuqbNacRcE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3Qfwpfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D156C4CEE7;
	Thu, 18 Sep 2025 22:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758236286;
	bh=IwmXQQCVEyFCcqnTQv9hOH6WRK5TuVwGwxOpabm5eCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W3Qfwpfe8SycJQfDHEZpE6tEGSa8k2u7zXEUEzrCm9v21w88sQvt/Lo2N7t4F9iWb
	 koShJk5GZu/BaHR6H29HX7ASnSkEnRX7f9ycACl6bNIcHoE4TwSpfJNpvxqwFDAqMZ
	 xeUr0JCbh3J9cBOutHaE+yJ76y+bNiqufA79wLoDbX2sAlG6of/g6iq0a7aczeDjqj
	 bYRtysYZfmj06jv/2VpkR8K88w5TUyVuQdKWZkp/zTYqyvTvTixpt4OkgU7EpO09DD
	 l6iSIhPdj3N9CHwdvq5HTartNnNZD6rpfAvpg1oYRLGuWUxqxtpD0GmBaLzdZ5AncN
	 t7g/k1wFf5X1A==
Date: Thu, 18 Sep 2025 15:58:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <michal.simek@amd.com>, <sean.anderson@linux.dev>,
 <radhey.shyam.pandey@amd.com>, <horms@kernel.org>,
 <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <harini.katakam@amd.com>
Subject: Re: [PATCH net-next V2] net: xilinx: axienet: Fix kernel-doc
 warning for axienet_free_tx_chain return value
Message-ID: <20250918155804.26fb6ebd@kernel.org>
In-Reply-To: <20250917124948.226536-1-suraj.gupta2@amd.com>
References: <20250917124948.226536-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 18:19:48 +0530 Suraj Gupta wrote:
> Fixes below kernel-doc warning:
> warning: No description found for return value of 'axienet_free_tx_chain'

There are 4 warnings of this type in the file, could you fix all of
them in one patch?
-- 
pw-bot: cr

