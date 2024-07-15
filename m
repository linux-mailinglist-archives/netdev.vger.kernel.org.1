Return-Path: <netdev+bounces-111505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C060C93165D
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14471C213C5
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBE618D4B5;
	Mon, 15 Jul 2024 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loCl+8Fr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46627180A70;
	Mon, 15 Jul 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052357; cv=none; b=aQriyG4erT3Z/gHMZfUNwFV9K9z/hkYipanLDp4/rNhCpAC2vZl6ET/xeynKOeZpO0xD5cpp6SpH3sZ4Guu/GLML4BUSvYrwRzEifvoKSQM6R1llTE4JaLb257j86GBhcaW9npK7Qw5Pkxi7/CLATjlsk4ekI9ST9vjjDmICf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052357; c=relaxed/simple;
	bh=jv1UJF0Yr2g6D8aCkEx7VdD/PoqrXCsZV7kGQ73zM88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+4LjFVssIFEGNIgwZXTZXLDFVjp3kruAFt12Mgtfr6CJIVGwcjEcdmKTwoi5O4H04MIy9Yq5h6cWJR9yw/QxIx+Zw5BgoQqsqhjiEb5CzYDfWMn2IP4y/eGmWXGgx2Y+6KvUK1tTarw3seYsamE0WAFKIke9taWg51lM26uQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loCl+8Fr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D171C32782;
	Mon, 15 Jul 2024 14:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721052356;
	bh=jv1UJF0Yr2g6D8aCkEx7VdD/PoqrXCsZV7kGQ73zM88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=loCl+8FrMOREWBSEX9oancIpWwIssNPHmwj0KiuEqH3FkEj1QLQCmibu1GyyI+CJ5
	 HhLKVacEreFCAviN/564LEIYjcZ2C7LB0n50cG7uXvV18lHamnC3eN5sFyjlu4walk
	 vmWsdQTZCEFltrMlVKCBsJt030qLH8nqvG3+xqW4ASObwF2j6CjRFAWbxmtXbnhhbO
	 SwZPphMuI99yrMUyN5D6kRtJfz1hXrIbD8ClGnDbNISUaLdukcocQ/uD6Pl/y6VaMG
	 s2I4PdS8b5hY9mYoLzNF6l/cCWrceMtyneeSOLvEUkIkiIO7bIeVbnApaSVTU0qi3w
	 l1WO/t3ElsiKg==
Date: Mon, 15 Jul 2024 07:05:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2024-07-14
Message-ID: <20240715070555.64c2773c@kernel.org>
In-Reply-To: <CABBYNZKudJ=7F2px9DYcqgpfEJX7n1+p4ASsH24VwELSMt8X4w@mail.gmail.com>
References: <20240715015726.240980-1-luiz.dentz@gmail.com>
	<20240715064939.644536f3@kernel.org>
	<CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com>
	<CABBYNZKudJ=7F2px9DYcqgpfEJX7n1+p4ASsH24VwELSMt8X4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 09:59:57 -0400 Luiz Augusto von Dentz wrote:
> > Luiz pulled the immutable branch I provided (on which my PR to Linus
> > is based) but I no longer see the Merge commit in the bluetooth-next
> > tree[1]. Most likely a bad rebase.
> >
> > Luiz: please make sure to let Linus (or whomever your upstream is)
> > know about this. I'm afraid there's not much we can do now, the
> > commits will appear twice in mainline. :(  
> 
> My bad, didn't you send a separate pull request though? I assumed it
> is already in net-next,

unless we pull it ourselves we only get overall linux-next material
during the merge window

> but apparently it is not, doesn't git skip if already applied?

Sort of.. it may be clever enough to not show a conflict but it doesn't
fully skip, both will appear in history (somewhat confusingly).
It's better to rebase back into order, if you can.

