Return-Path: <netdev+bounces-113686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1BE93F90A
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72E45B20FA9
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA82155725;
	Mon, 29 Jul 2024 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfnwMu4I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AE215350B;
	Mon, 29 Jul 2024 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265508; cv=none; b=h22+R9pmNM8cKU4NdiLUg+mqdeegUX5kprbtRKy4snUEVW15IdJXcNOH/GVX62JaleKy/o8h5B1S64wJ6XGUll+NETEqe4bE3quaFQ488mG9cbuAeubwmNH1LtNgL9XbXrXvLJVR7vLWQS7VJkbj8jNnlEqf/C6DgOclMUo2voY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265508; c=relaxed/simple;
	bh=xWsHTtxp06iwM8OIJ/sxMDAokVckR1Omw1LR0uB0DPU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=qwGMhfS4flA6eQ9V7zSRSPHjblhKuIAFCrF7IoqMY9XkwbiWeDSyAhsCpCCFyARG4FX6R7taIxz5gsS+gW+aRQ0zqC3qXD/2hwQ5CdAeQhsatuebOacuD5b3QaykURE1G3DdLpWU6a9UNVApV/1YmCtnXKkcDlKTuIeCraNa988=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfnwMu4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587CBC32786;
	Mon, 29 Jul 2024 15:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722265507;
	bh=xWsHTtxp06iwM8OIJ/sxMDAokVckR1Omw1LR0uB0DPU=;
	h=Date:From:To:Subject:From;
	b=WfnwMu4ICxPsFRsF3feoUqi4CaNxPqXovWg7x51XQzT3i9ZvFcWYi9PrQ0CLzuz8J
	 CuHm25QYeu2cuKFQvjc8CDcstMjt9eZKfU5czwq/aSh1ZFSapGPVHE8CveeAQCR8o5
	 DP/+IdZbdjfdUQBPY3By7AujaU/r3JFL/dTL/5vqG51/DAcp5nOJeAXNc4VHUZ1Up3
	 K+7bVgfOTng9RkLyFA2T8YQCGHtmJtze/Dh7QB/xFaATk3M56cJD/THtGz+DLp4fFW
	 EyXoLD2jjV8HxRPq504OZYeLTNCsKPy4TvJzjgbm5agdXFrhiQbGUmRk6gE9vWVkud
	 E6Yhw/xcl99uw==
Date: Mon, 29 Jul 2024 08:05:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20240729080506.5eb3dec2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Back to normal development, let the code flow!

