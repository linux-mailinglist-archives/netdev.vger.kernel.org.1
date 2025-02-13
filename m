Return-Path: <netdev+bounces-166115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EDEA34900
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7801621FB
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E1D1FF7AD;
	Thu, 13 Feb 2025 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6mEk0CU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3DC1FECC0;
	Thu, 13 Feb 2025 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462828; cv=none; b=EjsJPgSMnMzxkCIJBOAoDOgDuV0/ntrlp8sZlfj1iCVdbreO6N+v6rtNH3Fyf2EeaYEvCMYB8gLks7N4HBPULeNlxPeZhY2Pea9qU6lM+TDtCRbtgrhO7SbhaYFmVoGUNheKujEgfuFMY4b/COeORVPX9ZtlvjjNTZurUxwLos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462828; c=relaxed/simple;
	bh=6TptaH6mIwwb4cSquno9Cd+PUL93XOJzCPqfJ4I/B6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkPWPAKG/+XO8Ke5oiByzQbHu91eSogSod70HvWOJdOkFr2URceRAxqOn1QZkRcQv2EhZpM8Rss0CbR/wLOiZSKLh5qfK3tejfbw3ijPGNovv52QjiOfzqePc8Cwy0w5ZQQ2tMPLxRXOPoOQI2tv31nhcIoGIriAqOgrxhSp93w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6mEk0CU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6BBC4CEE4;
	Thu, 13 Feb 2025 16:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739462827;
	bh=6TptaH6mIwwb4cSquno9Cd+PUL93XOJzCPqfJ4I/B6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q6mEk0CU7pDMbqSrOlnbcpLc4XFnlRrX2R7KzOHwzvdbj6/9+8b5vPIhLYFInIs51
	 lz7840hVm73wQ1kpAaQa6wgtnW8BYUMGGlgaoNlRPff2REhb7WnCXF77iMRQFDeQb5
	 lrIBfOrJNOGVfRYPwfd8MQLoZb+FVTVALe1pWDItjF3AalG4WnPCLnAj7k+Kv46J6d
	 FtSGtGfexBBUG8SlB3wEQWPooQb8IAjAA4drb8OA6qVQVsLQm/lhOzDlHH5orGaRxU
	 e3NxnOGdbWW8HVChE/3cD2Uu9FQNX831yIGMQxbq2uwtv8Bmhuxa11CKJinE4oy5Xk
	 ZvEVur+cGAWPw==
Date: Thu, 13 Feb 2025 08:07:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 7/9] docs: networking: Allow creating cross-references
 statistics ABI
Message-ID: <20250213080706.19c1f940@kernel.org>
In-Reply-To: <a34ab9bef8f4e6b89dcb15098557fd3a7a9aa353.1739254867.git.mchehab+huawei@kernel.org>
References: <cover.1739254867.git.mchehab+huawei@kernel.org>
	<a34ab9bef8f4e6b89dcb15098557fd3a7a9aa353.1739254867.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 07:23:01 +0100 Mauro Carvalho Chehab wrote:
> Now that Documentation/ABI is processed by automarkup, let it
> generate cross-references for the corresponding ABI file.

Acked-by: Jakub Kicinski <kuba@kernel.org>

