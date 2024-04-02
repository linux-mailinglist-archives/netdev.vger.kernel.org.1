Return-Path: <netdev+bounces-84071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FE08957D1
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 17:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337CFB2C619
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF312CD8E;
	Tue,  2 Apr 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMq6MCQG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705E12C530;
	Tue,  2 Apr 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068827; cv=none; b=oeF/mSunae113M9K4H8NIticRdlRn+CNuCvZJDwQYF1XezTuGsPjvsFcaEiqxcxZGRQymZb/NpYImiuPVHw4cWvN27Ft0BCPWuQvDXRgznRYe1KkLxrX8SCQkImY0WQ3qEE17Zumndf7AA46QkezbHP2yrCQH9YnC8o4/2LtsHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068827; c=relaxed/simple;
	bh=62z4OFrlwRX2DwL5DO2N3sH9wxmXxzFHEPHn99UjBm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dcSPe04TivrX4CqQdK6rszocRPGyEJUEHli48ar5WFH2+2YjEgRpRMtAdR/5GjtQo9DAffZ5pKiXjz0xL/jBa3BjSGFUMNhhhb07i/wSP79sQ0YTF16YlrNYPkvJs3ZXKbeIw7K9/LvLxG7wUathngdO+ThifM327ZoTRgZWHSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMq6MCQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CCF4C433F1;
	Tue,  2 Apr 2024 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712068827;
	bh=62z4OFrlwRX2DwL5DO2N3sH9wxmXxzFHEPHn99UjBm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NMq6MCQGMsPncy7vYRjTdEaKEbmQX+S7VLL5Nx6GXqFbaT2pj3edZXxa7GsHHaLMx
	 rhf2BMA4lHWJyHC32OuQJchTJVB9djvD3Bi5rBH02mk+zNrCgw9eMPfphP0i5685+x
	 d7DuMCXhXJWeJbpM0w9YGVT4FuivLU2aiBcUe3sBdRaB72xFF/fJdo9XgVOMrwLxPp
	 ttpWq/ql5IKeqKta9xzRy0a+nKbXGzw/Z9hz/8ECft0Fs3R0/w6lZOEIcQeSjgsAPg
	 2TklO+SZ6Y13tq4NoIaIW3Agtc2lnOeABfRcUBPISwuI5Zh88iJJ0hzoayE2f0Oz/N
	 P6mMl0FVul83A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D1D5D9A155;
	Tue,  2 Apr 2024 14:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf,
 sockmap: Prevent lock inversion deadlock in map delete elem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171206882711.27281.12209723664828654389.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 14:40:27 +0000
References: <20240402104621.1050319-1-jakub@cloudflare.com>
In-Reply-To: <20240402104621.1050319-1-jakub@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, kernel-team@cloudflare.com,
 xrivendell7@gmail.com, samsun1006219@gmail.com,
 syzbot+bc922f476bd65abbd466@syzkaller.appspotmail.com,
 syzbot+d4066896495db380182e@syzkaller.appspotmail.com,
 john.fastabend@gmail.com, eadavis@qq.com, shung-hsi.yu@suse.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  2 Apr 2024 12:46:21 +0200 you wrote:
> syzkaller started using corpuses where a BPF tracing program deletes
> elements from a sockmap/sockhash map. Because BPF tracing programs can be
> invoked from any interrupt context, locks taken during a map_delete_elem
> operation must be hardirq-safe. Otherwise a deadlock due to lock inversion
> is possible, as reported by lockdep:
> 
>        CPU0                    CPU1
> 
> [...]

Here is the summary with links:
  - [bpf] bpf, sockmap: Prevent lock inversion deadlock in map delete elem
    https://git.kernel.org/bpf/bpf/c/ff9105993240

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



