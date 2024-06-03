Return-Path: <netdev+bounces-100401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 234C98FA65B
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 01:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09B71F2148C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D8E83CDA;
	Mon,  3 Jun 2024 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDCRR4Zd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3603E49E;
	Mon,  3 Jun 2024 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717456907; cv=none; b=oYAQLC8radPt/m/ZctFVkDNbVq89LWZ0BTZCb5AAlQzda+zYafT/mVxEvzDBjRLGLT7M9HCCA409fFpSkPxtBGA7lo6G+zHkbvlSgZB1BcpFxrGAFk526eT006NvPd/mZ/djrfOSJAZET55q1nvZU2TDf6V8P9xHSVWy5D2f6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717456907; c=relaxed/simple;
	bh=9y86IdgtQzn/Qit+/DLsUeTK4ccuhx0L5r1qrXlIAgo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=u3vZbh4/zno2r+kaQj9K1NS4g+Dsrk7hcotJdEX9LLVLsW9elGN/Dl+4IS2zAS5/WgjdIiaxsp21JPaWdFYXP/ySKpuOj+Aic99nWxorQaILwfOJOqUil0GYIXG8ZrCK02G3dqXUlNcMf0k88oQE85kdd7YSppuoDwwNuNBuaOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDCRR4Zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B220C2BD10;
	Mon,  3 Jun 2024 23:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717456907;
	bh=9y86IdgtQzn/Qit+/DLsUeTK4ccuhx0L5r1qrXlIAgo=;
	h=Date:From:To:Subject:From;
	b=mDCRR4ZdkOU7AfvEV7NRRXvYbkTQt4ChmzudB+fKH3RK6siSTHJ5/wic2eHVSUoOH
	 T3gmxnui2Fl+RVlROfDGP63o0drgKGlW2f8Y9DoApNkY0/qundgP9R2NANrlrOrRs7
	 Vb4NvTEY4aIwlyWIrK/yIMrI2kT4fsGydyZqkGIRicKbkRGAogeETo8kDgKEBZZyJY
	 esLmJuUNM8yv3vHyaNggYWihpJc0cMyQGckUAKKVRJOV0i0NfpGNozBvJBJnl5AgHy
	 LHCcwdJ2q3JIfxGO2aYx3GaMMSbWxQSrQByUkWOWjAoEWi1vaUIN+urpumGetx4x3v
	 0sYck5hng2J4Q==
Date: Mon, 3 Jun 2024 16:21:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Jun 4th
Message-ID: <20240603162146.7000e0a7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU). Only item on the agenda so far is HW rate ctrl.

In terms of reviews, this weeks designated reviewer is: Intel.

See you at https://bbb.lwn.net/b/jak-wkr-seg-hjn

