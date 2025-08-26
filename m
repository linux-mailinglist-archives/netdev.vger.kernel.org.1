Return-Path: <netdev+bounces-216948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99011B3666A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84ABD564919
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A730A343D62;
	Tue, 26 Aug 2025 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAL/4YKq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D140321457;
	Tue, 26 Aug 2025 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215860; cv=none; b=K9987YmuaZDjyrzVswSsHcg2TWl3sOCsAbemGLsi0nCquGhTixYB3JTWbLrWkwHpCEcoIflfedWdauvAWEBZ07XlZkpEIDcuNmnYAb6M1we3IUgVs/NK6EU6txlv+HsY2FNUP0SpMm/n7skPZ94vjXPrfJOMh4zjs9eeDcf8y6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215860; c=relaxed/simple;
	bh=vJpk/AtpCCZyD2VG5xgaeXL1nuD6Ek9i68Dm+v3O1yc=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zg6rqxTvgM2jfq2juJiKog3oNyy86f93WSBH75spTqfh4PfDLFr4qPXpEAQ+qw3uyxD8IOiVyTGL2JO1OltY1w+Ti4RUOfpkVJxUTtlcmN4AsQsuaL5bwGwSPPSURkEJntvDgjMDPypPGWa9lo+2Hj/zqfL5HMuwqmIep+nrrC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAL/4YKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BDEC113CF;
	Tue, 26 Aug 2025 13:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756215860;
	bh=vJpk/AtpCCZyD2VG5xgaeXL1nuD6Ek9i68Dm+v3O1yc=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=jAL/4YKqOVca9zVy49x/n42dM8Ktd8iv0kTyW2CufoCvlpnvKEpAyIw+5XENiHtEj
	 Mv6AcuBpGewE51R02jWpqzk/Pnv2uvg+fo0jspIVQevVJEOZXeB8prcQo8fNw+fywm
	 u4CnQ5O+1tdcmfMklzLFKM4yjqwyu4aGbAM50nNRH72ASz2NhvYD1fAmTWJX65S7RO
	 jPU3YhduXFf+ufSVdZ4w979nSGZ242n5hiyb3RxIqSUEQ9o3gyUhpmxkAQNmSxccT7
	 7KLHZkixuOI+a3WJRGpWuDEJjLoGY4EfJVRRASnfl66s/jCNqkY24PIsNbTKyS0Tep
	 XtU636LYwc1pg==
Date: Tue, 26 Aug 2025 06:44:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Aug 26th
Message-ID: <20250826064419.07fede4d@kernel.org>
In-Reply-To: <20250825111454.1cd36e5c@kernel.org>
References: <20250825111454.1cd36e5c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 11:14:54 -0700 Jakub Kicinski wrote:
> No agenda at this stage. Please reply with suggestions, if no topics
> are proposed 2h before the meeting we'll cancel.

No topics, so canceling.

