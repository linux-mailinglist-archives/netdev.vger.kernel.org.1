Return-Path: <netdev+bounces-132208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8724D990F97
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF141F23047
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0BE1FBC80;
	Fri,  4 Oct 2024 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yst10O6w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE5F1ADFE1
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069161; cv=none; b=IjnhUwUuToM+Ge5f60+WGzPHULm62WGahzuHDpcf4Xp6okwO4JZ3ra2V5DDbBvZ9w2k8q+nKgoaNaDxbRTnWXtgaV97Y44NFnYA9uWC/RBzV+mCpO6siPQ+AGaw+RDs0uYa15oGZhz9qMQZeqWjH7HMj3Z53sbbyfDvi9MusioQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069161; c=relaxed/simple;
	bh=WUtroShpx6IrK5IAoAcOFA5uuQ4g+v14bm9L8455ysw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lA3vC3qnbVfw2zbORQDJv4vn+rowTx6Jt7PG2CNV7JmTIxmOl9fAiLJdIOJT4UUCvS3pNHn9ALtcZWgdbksxseXBRffuflJ9lLhZcA59XHI6pkT0EieJt+TWBixpET5JoBS5OMA0b8z1PtqdoAsGYDwWnq2uHVkgGnb+koUUFjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yst10O6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686B4C4CEC6;
	Fri,  4 Oct 2024 19:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728069161;
	bh=WUtroShpx6IrK5IAoAcOFA5uuQ4g+v14bm9L8455ysw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yst10O6wDa1hlwv2aUScoPZ9Fl05jHplIpWfSZ4uHpNiMQMDYtTsxH4UOhxLIPPhB
	 65hpRR4KnJc89wdNOIcgMM38jaSBow6JoLHwVzqGE9WX4Syi4/eMOLh6joyu4SZ7zO
	 qMktvs6WTOjWgA0vDLThGjwwPcuUe4hRPm5bqI4mjsJZQoywGdfL5LlPRqhY05P43h
	 8l0CCvywirnjuG5cdj4rJOkB1js97T2zbTzcmkiCJuEvpFjZWh2d21DdLIBxa4g50q
	 t4LEjHBvMNOChE09CAzpD52pfBkt8fQf2y8vNFJga5hdrkN1LfGveAMndxk0Bh1Md3
	 sUjvZkZuIeY3w==
Date: Fri, 4 Oct 2024 12:12:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] forwarding: bridge_mld.sh flaky after the merge window
Message-ID: <20241004121240.45358881@kernel.org>
In-Reply-To: <20241004121116.1b9a2e5e@kernel.org>
References: <20241004121116.1b9a2e5e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 12:11:16 -0700 Jakub Kicinski wrote:
> Hi Nik!
> 
> Looks like bridge_mld.sh got a little bit flaky after we pulled the
> 6.12 merge window material (I'm just guessing it's the merge window
> because it seems to have started last Thu after forwarding our trees):
> 
> # 240.89 [+21.95] TEST: MLDv2 group ff02::cc exclude timeout                          [FAIL]
> # 240.89 [+0.00] Entry 2001:db8:1::2 has zero timer succeeded, but should have failed
> 
> https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=bridge-mld-sh
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-forwarding-dbg&test=bridge-mld-sh

Hm, maybe the merge window is a coincidence, the IGMP test had been
flaking in a similar way for a while:

https://netdev.bots.linux.dev/contest.html?executor=vmksft-forwarding-dbg&test=bridge-igmp-sh

