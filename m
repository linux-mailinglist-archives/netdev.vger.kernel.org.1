Return-Path: <netdev+bounces-93750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E37A18BD0C8
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931D51F21938
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36077153822;
	Mon,  6 May 2024 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiDgvbTM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD66153579;
	Mon,  6 May 2024 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007179; cv=none; b=cywj8G3aIilJIFULQZJnqpFuNQpelqrwvjD+i12UnujdZ2GTC/c1oWz/Z/e6SE8vADrhf/ha5Sj+oYGMshZlG05gYvjHYQ3JMj/2YYWy8MMRB5zBPxpLU1mDLxRlVty/AiBYYz76DEQ+m8j3IibJSyDrUQoz2btc5vYBXwUOkOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007179; c=relaxed/simple;
	bh=tREjeMOe15n322+DQqiJtdzoG/In/RjRNpp6SWC0ets=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=SsZyNJO9eyy1IpZP8rQJipuFXtb5H0A4IUQyHxLke6gPjZRX4ZjQFkf4IAt03dygOaCz4qOLRpchBl3CmGDXcoRp9iiWN5yyFCjGrFJxuHzk/naQSJHJir3+/Tv5VrbylfIGLEJhDtkQLfJ8ge6ofGAyq0kdpGSv7lJjtdGW4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiDgvbTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6E0C116B1;
	Mon,  6 May 2024 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715007178;
	bh=tREjeMOe15n322+DQqiJtdzoG/In/RjRNpp6SWC0ets=;
	h=Date:From:To:Subject:From;
	b=qiDgvbTMDR2cFfFZsDDCEZKi5RcTpFsXjhIanD+tULgY8JZv6fAMdSrZ1EYW+l+rs
	 HMNL8yhyvexVoPYFrZuNO7LQ5oxh2thTEBebfGng/A6v+PmO4scMX297xVvE4QJCg/
	 lvaiI/spbv/WDIFza+mMERiTXQUDJ0wMLHI0lIlDtjbJj6PZmwjBX24h4Dqoxgw24U
	 gJcpfn7kqNrv3Us5/PxxIv/Xfr2ZXx4z8VsD5W5dkoj6IMXjlU9z5DequIPNY3LgeG
	 ncybFLnGdxgOPpT2PzWSkcvWDFQ8ytbMknN7ZqNKzFonJxl61SRA5Er5q8mKeWKP/A
	 e6rFXf6Z+3tVg==
Date: Mon, 6 May 2024 07:52:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - May 7th
Message-ID: <20240506075257.0ebd3785@kernel.org>
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
5:30 pm (~EU). Last call before the merge window. No agenda
items have been submitted so far.

See you at https://bbb.lwn.net/b/jak-wkr-seg-hjn

