Return-Path: <netdev+bounces-74489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007D1861793
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 17:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8EAB1F21035
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A511B128360;
	Fri, 23 Feb 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqpkBsyG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7990F126F3B;
	Fri, 23 Feb 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704966; cv=none; b=CqGyC83O8lPwXT98yjWZvgjct7CMLGR6iWzMvrBNrizjPF3py4CXw8QBuKCk7Fkq37bLzAtV7IFJPp2BiKGZFHJltmdfwaX8z544bGPnYBFysJKoDXy1RngyS5ONlj78+5re6w21WDqyTspdgf6yX/tgMur4G82ivpPp35u2LOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704966; c=relaxed/simple;
	bh=1YnlxBtWerc76c59ZgIB/7RUIVE5bis6HKjzVhdWqGE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=LikXHCtneUFRUNBmLD/rLbpEwQFKMa4cLpCpF6AzS26XdNfz3tfUFs6d3CMMsJWkCVbTBtbBD+AtCSGaopTowbiTTSYI/GpEwd5EBxWg3pQW+t4hIj/iGR198PeEoyiyUbynXE0mMw5mlrbI99n5Qmga5fRpAH+RYr+K7Chrnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqpkBsyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6985C433C7;
	Fri, 23 Feb 2024 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704966;
	bh=1YnlxBtWerc76c59ZgIB/7RUIVE5bis6HKjzVhdWqGE=;
	h=Date:From:To:Subject:From;
	b=RqpkBsyGl0siGRyHGbe9pFqvTshfdsbRDwFpzHgMsYiQa+k8eIHllTvYKxJLtKrpM
	 IR+JATyFh/M9/Sa74Czk4dflrWJnHT4O83s51ObfeDiEixmJMksNUtogiwvhHHWlUp
	 V8aPzvAx4NBqtbZcCen7kJmZmU+BJT7sOZDJWxoIOnm5kA6O0BPpNji6IM3gX+W3ir
	 L/uu7i+aIemKgPmrIWp4wSF4FL8t3wCzTiiF+spH0Ngn7ARwUzlVGAFS+Y2s9e2sD3
	 pcjfcoZL1PNzN9qsU5CYW7hFCM1QwRFbj0r62FBuUKmu1tVENBvavPohkAhCSTxGow
	 TS8z3eqO5eCtQ==
Date: Fri, 23 Feb 2024 08:16:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-driver-reviewers@vger.kernel.org, netdev@vger.kernel.org
Subject: [ANN] netdev.bots.linux.dev has analytics
Message-ID: <20240223081605.16a311ca@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

I hooked up netdev.bots.linux.dev to privacy-focused, cookie-less
analytics. Traffic dash: https://plausible.io/netdev.bots.linux.dev

Please LMK here or privately if anyone has any concerns about it!

