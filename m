Return-Path: <netdev+bounces-47130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87D87E824A
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247F41C20321
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9E43AC23;
	Fri, 10 Nov 2023 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8UeBQHa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0133A28E
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 19:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBA9C433C7;
	Fri, 10 Nov 2023 19:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699643544;
	bh=IDkJf9q/qJFiQ7tkUVGvravDFMJPMy5QQpsSAsjYTNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T8UeBQHaCQwHes7sv1XY8YK0kaIOgq3TLAflaNs33FHhx53cKPFv9YbTCaLkMgM58
	 Yul3LTQSzhK4A7lXCWHmy3dP4vljIjIXnT/16XJwwefFKxJsBE+u+auaenycQi8HRz
	 65qVGY3vZIC1rtVWDO7oagtYjCR7Ueir60ZdaPuXHlex3OwPpN0ZMJLNq0cJIssIwc
	 ON+jYNqR57YWBlLA+ZSI3ddi3JPbsaCYSBtVcClHB0/UjjD+I6+Mc1t52SGjQpzFNW
	 rpqz6ChRBUITHhE6se6UBFO9tf2pli7l8CWhMcEQNIQwbMKsvRXAmOTuVodsfCb6l7
	 IRAwqF6RIrQcg==
Date: Fri, 10 Nov 2023 11:12:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com, Stanislav Fomichev
 <sdf@fomichev.me>
Subject: Re: [PATCH v2] Fixes the null pointer deferences in nsim_bpf
Message-ID: <20231110111223.692adbd7@kernel.org>
In-Reply-To: <20231110111823.2775-1-kdipendra88@gmail.com>
References: <20231110084425.2123-1-kdipendra88@gmail.com>
	<20231110111823.2775-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 11:18:23 +0000 Dipendra Khadka wrote:
> Syzkaller found a null pointer dereference in nsim_bpf
> originating from the lack of a null check for state.
> 
> This patch fixes the issue by adding a check for state
> in two functions nsim_prog_set_loaded() and nsim_setup_prog_hw_checks()
> 
> Reported-by: syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com./bug?extid=44c2416196b7c607f226
> Fixes: 31d3ad832948 ("netdevsim: add bpf offload support")

Don't think so. It's probably due to Stan's extensions / reuse of 
the offload infra.

Please put more effort into figuring out when and why this started
happening. Describe your findings in the commit message.

Current patch looks too much like a bandaid.

Before you repost read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pw-bot: cr
pv-bot: syz
pv-bot: 24h

