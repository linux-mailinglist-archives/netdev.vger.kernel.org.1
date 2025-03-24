Return-Path: <netdev+bounces-177098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A2CA6DD80
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9321887B6A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70E225F986;
	Mon, 24 Mar 2025 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgOn0Rch"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA1125D536;
	Mon, 24 Mar 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828147; cv=none; b=rqBTeqwsHPEFogO0YJC2k3V5OVkf8pJ6e0qnP7KSqZVv4DSzn8gCC3hZbh0bqn5paYBFswYvYrF9UFROVlF5x7kdWFqlo5+RB7YMWR0A0UQX63uo6krmJwvLQBeFe1VBRUSOEO0jKr0oUKXud/H2M1ouq7xUCc94lo4tUjJzfkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828147; c=relaxed/simple;
	bh=puB3VZIVrGH5LsZGV6s9SMTd+ACrQY7dB/P8W9MnJFY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=BNSBYg7ahwGj5RKDKnEh+D6d/5vgDebrmNWmh9dGs8Sd4lJ+M93SC3yIsma7p8H5/NdSHp9hONZijtzlg2txwf5Pm3DR+AhlcDl19ni2cgyqYVZnmbdnWsmnECDzytucV8EOqxbo+edMbUVNfO3JKZ7By1sRNXZdg2mBQ6mKowA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgOn0Rch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8840C4CEE9;
	Mon, 24 Mar 2025 14:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742828145;
	bh=puB3VZIVrGH5LsZGV6s9SMTd+ACrQY7dB/P8W9MnJFY=;
	h=Date:From:To:Subject:From;
	b=HgOn0RchQdfte9u7H8j9mTH6FaTXIw2TOqCNJKQTaJOhLtA8k2rt0SgPCz5EbsO+d
	 Qri8/ku6qmHVJ/MFXAf32SnFYPsq9rWxA/ZolRqgZS51ZQizHh0k/TnHx059w3c+4s
	 uWfu0m1u/DV2sDygNPN+gT5jVMFs2xIoizZOt4gmHpY4qxwCeiolLNenSIHDB51jig
	 QX4UXEkSVwlW0ojldTX45lSdGWw4bOOLCq6Ld/gg8ppu4iPTsxXmFrfAc9KQrf71ZG
	 2BaFWLk/W+ApCrLQoaWzzxzz4+NNPXgT2MG3dFbe61Qquqy+pGNbUbOF3FKcT5LX9b
	 FN8aJUiWLEZ1Q==
Date: Mon, 24 Mar 2025 07:55:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is CLOSED
Message-ID: <20250324075539.2b60eb42@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Linus just cut final v6.14:
https://lore.kernel.org/all/CAHk-=wg7TO09Si5tTPyhdrLLvyYtVmCf+GGN4kVJ0=Xk=5TE3g@mail.gmail.com/
a day late, coincidentally, kicking off what we expect to also 
be a fairly messy merge window for us. Multiple core maintainers
have taken time off in March, and we're sitting on a larger than
usual pile of unprocessed patches.

Our PR will likely not be ready for another couple of days, 
so net-next will be "closed" for real -next material, but open
for fixes to already merged patches. IOW please don't post new 
features / drivers any more, but continue to send fixes as 
"PATCH net-next" where appropriate.

