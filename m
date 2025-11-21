Return-Path: <netdev+bounces-240636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9269AC77215
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 04:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B10B4E1A1F
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93FB2E88BD;
	Fri, 21 Nov 2025 03:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqZnHEGf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E7E2110E
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763694806; cv=none; b=XBaS2wxLG3ib23uCDGEU55iH5yANg9FSeUFw7d4h7aMBgHgwzs/XmsIi1z4XCs/Cuc7sEHurSFsMrZWx+4BtFoSsFVnzOS+XX7ysY5VRXbsy6NUrTZ7808sYQWtxeCTMGxhwXc//ScJpstGkcUIvc2RCI4q/PZf6Pa5QZZc/k80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763694806; c=relaxed/simple;
	bh=1Z6snQzLcVnk7zBB6rKH9U5HfGkRtWK7rStcGrbCGzY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlH8M7/jsqMRsPba6IH/un5rvS0HL7YBGFLnffdudY/BVjMYcT+VAEcy7A2bcoFfCCTfWuhv7JchqDDtHCoOQZaYHKVdAo6c4qbpMm7kDJ32YR1y2ROOjuQx/bdV2Hdu5/wiYXEZ2uor5QGvSgPV75xDhSuLc9FJq3RqW0bWegU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqZnHEGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3E9C4CEF1;
	Fri, 21 Nov 2025 03:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763694806;
	bh=1Z6snQzLcVnk7zBB6rKH9U5HfGkRtWK7rStcGrbCGzY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KqZnHEGf5Dhq1BqEn8xzKgredLcw+UpD8Wkf1t6wJ5KNYUQtzgg7y6Dj2ZbXvnaoB
	 jX/knvEkCBvr4uIDB8QVtgVrg8mU7XvUQmeiooP1MLlov4NX7rz6Eh8kPjYAi8b92D
	 jMFWqaT5AnM7v8xqtkcTyO9uCChQikomwqcCdelz3WeFtlb1soV1d56Ncb8yLjGmJH
	 NMLHC1DoNO/jm9GpZqFxwYC90D14gfjuZ3Pq3Dbn8vMU0GgCYOHhvME6fpxn/mxuoJ
	 PPfw2tnY21ZYW1EvTjwpCsTmNUI4aM8ck35h5A0igoiTcYmsNdHEq+prA7mKjBRDlJ
	 0zV4Ix0ZbAy4g==
Date: Thu, 20 Nov 2025 19:13:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next v1 1/7] selftests/net: add suffix to ksft_run
Message-ID: <20251120191324.1384d419@kernel.org>
In-Reply-To: <20251120033016.3809474-2-dw@davidwei.uk>
References: <20251120033016.3809474-1-dw@davidwei.uk>
	<20251120033016.3809474-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 19:30:10 -0800 David Wei wrote:
> I want to run the same test cases in slightly different environments
> (single queue vs RSS context). Add a suffix to ksft_run so it the
> different runs have different names.

Please TALL at 6ae67f115986734bc, does it help?

