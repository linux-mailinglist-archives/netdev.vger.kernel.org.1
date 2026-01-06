Return-Path: <netdev+bounces-247500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C63FFCFB5E7
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 00:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B31B73000DD0
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 23:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF8630AAAE;
	Tue,  6 Jan 2026 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyG1me8Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867B30C361;
	Tue,  6 Jan 2026 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767743005; cv=none; b=OLvM581iAXTituJNv0VjMCaGjb4RCWOZ6T+xIYWiiqaJd39R+/kWTXhVbzvXwnKSNR27/wtyRFR4pea/qnWDYek66kRTEvGivZ0on9obqthC/vo15LN6hOeaSO9OgUE7vAfEmdgaAGpMpmSm0a/W0INCpteF0dpUT9LMRJOdMn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767743005; c=relaxed/simple;
	bh=94VudyfOqqs7+gKw3wftjyOBIwMjD50Wl/MMtQG+Xb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8llLRvDR+s9tzLmSE1CcxLbrYauKbp4nXr0cafRFgCK9P0vUuM9n6RXS22GcP++BPkKELoHzxWg6lA8oMacD50raJ3WfjfxkmcYOL0hdXBBJ+HrjR4HnD9YFxEw2FYghTzzsNnICUmqjsPS9brbgEP0d248EGZtayXaNuEPpjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyG1me8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C1CC116C6;
	Tue,  6 Jan 2026 23:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767743005;
	bh=94VudyfOqqs7+gKw3wftjyOBIwMjD50Wl/MMtQG+Xb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gyG1me8Zd9iNe7hdtpiGlZy2gwKjDCaiA8XNSnWc6KoTELQb5KmOPtl8vQOn+0MXa
	 biRBHRakppeK2SF1fub70LnCDVabXJtR+PSUewouT59Bf5Ye6CaKWQtrRzOZGDjSlF
	 MzusZY7qWelKzpx63wP5kwcWuv8vvFdPz5897Kl7vbdmFM0MyeuTf9c1unM3UAfRhL
	 BHgdM5um/LBqXQjroQXupJjrHKcG3ykleWsBOljjjsq96vH4WJLDc5Ku/+fEz+9St1
	 Qdo322PBSY1CTBKb96A/5DRR6+ELPtrSNq8XPlcBhsn1bo7HvkUkzqgmKm69W8cVnp
	 Yfr5hIaTNoj6g==
Date: Tue, 6 Jan 2026 15:43:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: Re: [PATCH] MAINTAINERS: Add an additional maintainer to the AMD
 XGBE driver
Message-ID: <20260106154323.21706c07@kernel.org>
In-Reply-To: <20251211112831.1781030-1-Shyam-sundar.S-k@amd.com>
References: <20251211112831.1781030-1-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Dec 2025 16:58:31 +0530 Shyam Sundar S K wrote:
> Add Raju Rangoju as an additional maintainer to support the AMD XGBE
> network device driver.

Applied, thanks.

