Return-Path: <netdev+bounces-122094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919DC95FE09
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 02:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5927B21F3E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A1D1C32;
	Tue, 27 Aug 2024 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P96fOCGc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEC28F40;
	Tue, 27 Aug 2024 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724719332; cv=none; b=Vdcw4AranHAJByw1voyzQzQigELieWn+NY5dtiNe98NO3SP0GBuiOFC8SZ2X2ZcGs/D1xo64cwOfUmX+A/+w4qZdMzgmIcWOVflF/g1yQ9W+kSt3M0xQdp26XX1OXLGjEdEEmibXjzgH+VXuGYnS8BbXiI2wWVvdCASgxmtkBwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724719332; c=relaxed/simple;
	bh=oWJ7PAZTe7Jk4gL2XaHS8qJByqVUg7dUG3dy2Yh4Wqs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=LwnlXJqcobPyu/coUcSbvwDe0iTOK1JJGDOMwrguLL0uWLfM/UqrQez7H/7HXwiE0YQaNqKJpN3VmICm+3szNBDM7/Z/8ml4kFJhAgVa02+LtipdL0gIjEQp0B5WxYfyd249JJ2/K0N90jn32Hy11ps1wp++NqEjchub3tK8xl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P96fOCGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B763C8B7A5;
	Tue, 27 Aug 2024 00:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724719331;
	bh=oWJ7PAZTe7Jk4gL2XaHS8qJByqVUg7dUG3dy2Yh4Wqs=;
	h=Date:From:To:Subject:From;
	b=P96fOCGc+slTXe0scODj9W1jTvkOtGFqNN6Zy5PxliAcBVkXoFt7iXKaIAdRrv8Q8
	 cgcKN97UQYyPZXcWhkg6TlPub5paUpdkb3nBmORvzlbMKIsO1/1QS2koPPlj/ISC0P
	 RpWmv6bWVzb+GqwIwVqgRYQwQ1yl2sfyuCuSOtnFEoAaF7xoATnoWYg7Tx4j2B0g2G
	 udoyuUhzKRwUM8czf4FYDlMoic+YYzyDk7+XNtUpv2XjRbENkmXifS1DuFEJ13MGy1
	 YAqjj3N9MYmdgbzMvSHisjHwdaBG0AVV8oseof0ox2ElfdCT0JQtGq8b4bYJuBAT53
	 lp3FZAhDeThBQ==
Date: Mon, 26 Aug 2024 17:42:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Aug 27th
Message-ID: <20240826174210.5691fcb7@kernel.org>
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
5:30 pm (~EU), at https://bbb.lwn.net/b/jak-wkr-seg-hjn

No agenda, yet, please propose.

In terms of review rotation - it's an Intel week.

