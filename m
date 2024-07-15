Return-Path: <netdev+bounces-111494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B68D931614
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC231F2117A
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EDE18D4A9;
	Mon, 15 Jul 2024 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9lnXJwN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930691836D4;
	Mon, 15 Jul 2024 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051381; cv=none; b=ocyohd/9YIjUn6HUDMjuM5bNnqvVc+I+MvfpLnshctblua4GMokq87mMqLyYdcgywjxPvJ38SAKquVngBEL54AADCddMMsXls9kbRAcny8NC11T2rsG93kuK2oMMV+RJzhu7Ckoz5k8rVdiIAL2FeP8l5Q4Bv/FUdR5Tpykueuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051381; c=relaxed/simple;
	bh=A9DZgxnIbR75iXFnIQtTCJmbz1eh8oOqSCv5guVQi5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBzzlFoEKDiVahP7UuT3gQrWQs7QEntrw/zwCwYIacDvH0zKeOtjFDlJ6j+xccDDmWb+OY1JFBgj/kT42je330SuVwDO0n8ZgtZtUS8ujyQy6XYhEYhf7d+FZ/GZCtyxqSU0RjKNDamb32oZ7AImdfzpm2ZPmu+mQgHurXv8EEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9lnXJwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C37C32782;
	Mon, 15 Jul 2024 13:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721051381;
	bh=A9DZgxnIbR75iXFnIQtTCJmbz1eh8oOqSCv5guVQi5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I9lnXJwN7FkBrkKModJisBdX/o5D0opMrJf3iOeACjKtyEHDvLkPpbRX8VfR/HuPe
	 b2W+ONR9XJdCVPZU/Re8v6upBZ81WLhFVZXNBxzinvM5mT8YN71ytjOQGOTbjFy37V
	 IMgddbyFgyW1VjF/GKT1FVDR+o/66vCZzlofm/thd0a2ySPuPuF/rLqnWhxiuG1XaR
	 g7pexrxgMQqfyIKBpj8uGpRAaivkzFwgp3gBgeieSdVyXRMcl2OYPtUCjvFdVfAPFW
	 ACNrH6j5KGnsWxGBtHVQr79ZGOBnts6iugPjpwU3/Awyh4LzAJPDGVI3ayqVL2qf8K
	 lz9N0PIZFrb5A==
Date: Mon, 15 Jul 2024 06:49:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 bartosz.golaszewski@linaro.org
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2024-07-14
Message-ID: <20240715064939.644536f3@kernel.org>
In-Reply-To: <20240715015726.240980-1-luiz.dentz@gmail.com>
References: <20240715015726.240980-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jul 2024 21:57:25 -0400 Luiz Augusto von Dentz wrote:
>  - qca: use the power sequencer for QCA6390

Something suspicious here, I thought Bartosz sent a PR but the commits
appear with Luiz as committer (and lack Luiz's SoB):

Commit ead30f3a1bae ("power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets") committer Signed-off-by missing
	author email:    bartosz.golaszewski@linaro.org
	committer email: luiz.von.dentz@intel.com
	Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Commit e6491bb4ba98 ("power: sequencing: implement the pwrseq core")
	committer Signed-off-by missing
	author email:    bartosz.golaszewski@linaro.org
	committer email: luiz.von.dentz@intel.com
	Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Is this expected? Any conflicts due to this we need to tell Linus about?

