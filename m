Return-Path: <netdev+bounces-231439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB04BF9386
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B81018A485A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40642BEC52;
	Tue, 21 Oct 2025 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHe5n9kh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C926B75B;
	Tue, 21 Oct 2025 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761089087; cv=none; b=LeFDe1DCv13/3OWCmpxkC900lqfRKpXuvl8mu+bPIJWrZqC3PDfcvG+lUhFlDNCZgw/AG8B3VK266ttfFxbiaVAFfqUdEh8p01OpSF1lgqcjsay2A8kzEzTLvbHMYugS53TGfpbBKG4z3hQv6eULmeBdUpkQ0U3eEzJ4VBacL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761089087; c=relaxed/simple;
	bh=TPCXgE60GmPtHm18QxucqPr2gfNZsn5bxzXTzZGCbSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCVybh2T41+Tkl6aE2Nx5serEKe1w7sL2Eo1W1nu7vdCx3C1CFq3Sg73ZJiO3IEhJqoF+kvjU2vUnt+NcIJIHGoIiYgR/wZ6xFEOMde0chiKLh1+sdQJifFK6ZcsY61tU/Zxr2I3H7DsnDHXUBF7BnOqJeTI7EjOTrV+bS2vaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHe5n9kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B00C4CEF1;
	Tue, 21 Oct 2025 23:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761089087;
	bh=TPCXgE60GmPtHm18QxucqPr2gfNZsn5bxzXTzZGCbSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JHe5n9khKAtxtqPm2Nnk1V/QhrBDtaiy0ijOQZHnXXWYw0KHBPVYSf61QCfZDY8fZ
	 SWdDn5CUxdo41gnzHvrfF1iQEeEvjB4epxSfqSUg8AAKGSHaoSPfPcTxDukty3fxtL
	 rKnb0zAbEnVQ9Rbh8UlfbcmGGSmGs+hd10J5+yA4+mhhte+6HqQB5+K5++YAIV4laB
	 +7m/2dJ9crLf7y5pAeRhVuk+NDp1ON/03VVqzkzwXCmfsLpHY/iTE26FYbjBC59z0f
	 o98jmsPjQztCdIfqRSZwgGkS0EdFgOE6zDx2UixXkpfCMWksaCMKTQ43uNQ/ZhSRnO
	 eaWoiBaP3avLQ==
Date: Tue, 21 Oct 2025 16:24:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com,
 ast@fiberby.net, matttbe@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, johannes@sipsolutions.net
Subject: Re: [PATCH 4/4] tools: ynl: add start-index property for indexed
 arrays
Message-ID: <20251021162445.4df0f832@kernel.org>
In-Reply-To: <75gog4sxd6oommzndamgddjbz3jrrrpbmnd4rhxg4khjg3rnnp@tlciirwh5cig>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
	<20251018151737.365485-5-zahari.doychev@linux.com>
	<20251020163221.2c8347ea@kernel.org>
	<75gog4sxd6oommzndamgddjbz3jrrrpbmnd4rhxg4khjg3rnnp@tlciirwh5cig>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 20:50:03 +0300 Zahari Doychev wrote:
> > We need to be selective about what API stupidity we try to
> > cover up in YNL. Otherwise the specs will be unmanageably complex.
> > IMO this one should be a comment in the spec explaining that action
> > 0 is ignore and that's it.
> 
> I am not sure if this applies for all cases of indexed arrays. For sure
> it applies for the tc_act_attrs case but I need to check the rest again.
> 
> Do you think it would be fine to start from 1 for all indexed arrays?

Not sure off the top of my head

