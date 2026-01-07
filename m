Return-Path: <netdev+bounces-247551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8C8CFB9CB
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56F2C3048DB4
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BB8226863;
	Wed,  7 Jan 2026 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oy1bRYHq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E545922541B;
	Wed,  7 Jan 2026 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750046; cv=none; b=uxj0SRhiyU+rhGNnqDHlRYOKUfUlgG/m3uFIMNv9NPhink2/jHLMGhE+H82llQdJysh+AvmSPSf957TWH04vJDcviVFicsdEfK9xbD+pcW73xeXhlf4L4nAQrHkW2wjR13ITIqSi/IbQ1LTjdb4fFJKhuxUA39LThOKqlROBzYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750046; c=relaxed/simple;
	bh=Vgz3eNzehydfX8dRTPL3vHw5TUaEERyHm+xbZdpHDs8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8udWce5uv23ua1T+vSbNcbyT/oY8ckf2uQdgcGiM1oCDanttOInrtDlsaiRTMr6NVomlVttJlbbedmeRPeBBqsPT9e+c6Fe7Y/rsc3T5dog0zWGL6fQ0dPIq0tUV6w7xh/vh6bSOlfjbjIbpbG3gdb5Znjpe77NGiIT8MVwByY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oy1bRYHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571B6C16AAE;
	Wed,  7 Jan 2026 01:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767750045;
	bh=Vgz3eNzehydfX8dRTPL3vHw5TUaEERyHm+xbZdpHDs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oy1bRYHqmKsD5UP7FcuKSc5mVTL9kyNIP9IuH/03LvDGfDJmFOLJ71Eh2hsIvHwJw
	 h/IY8OzJvsqEDj25psRDu7Ep1ULVACrmOcH1vpIUJ034T36xCKs8TAwnoL2myzV1PV
	 9qh33yqnAiEjGdpVsMA3B3Cob3Y7q9IADBvdBor91XmDPEaJLawzE4o+GzDCWJrieF
	 eQ+GY6B42RmuGzcojnlt+E88ab780bvWiskuhZJK1YLaKXPji7ueweiawVpNYzFaFm
	 nQ8Xb7NhH1TU8XmEDwd3uXmn3sFf85uQiiMl7wAQtYVAs6T0Bt9ovtxU1ndK8uRSQ0
	 ep7THRzeedSfQ==
Date: Tue, 6 Jan 2026 17:40:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <sgoutham@marvell.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 00/10] Switch support
Message-ID: <20260106174044.3a13cc84@kernel.org>
In-Reply-To: <20260106021447.2359108-1-rkannoth@marvell.com>
References: <20260106021447.2359108-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Jan 2026 07:44:37 +0530 Ratheesh Kannoth wrote:
> Marvell CN10K switch hardware is capable of accelerating L2, L3,
> and flow. The switch hardware runs an application that
> creates a virtual port for each representor device when representors
> are enabled through devlink.

Please make this build cleanly and repost.

https://github.com/linux-netdev/nipa?tab=readme-ov-file#running-locally
-- 
pw-bot: cr

