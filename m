Return-Path: <netdev+bounces-61671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5BD82492D
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 20:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0AA81C22295
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 19:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DF62C1AF;
	Thu,  4 Jan 2024 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvj6eliA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1AF2C1A1
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 19:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FD89C433CB;
	Thu,  4 Jan 2024 19:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704397225;
	bh=kyXbx+q//WxfqpdcboyeT3yQBNePkwAVNA8BHciatx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dvj6eliA9q/fOnwo6AbqgMOkWwf8ezhv9d9F10LhzH1asdQ6OGZL4PDUX/iUORFTN
	 fOQluEyEerQdIQci8Cu7BiRzn0hRi0+38Nv4n+4+VAwDNHb0dsw+FbRbT4yxqJuoic
	 KjBtRhmdbUeCsPRqRuz3YyQJ5IW9h0l7I3wqcrP6TK/IdBW/mh8ibFLtVPAae3MMSU
	 e0rgZwZdEkY4dqSgQS6TlO0ZwRVV3jLN93ekClrlU9AH/wMwrPJuvGp4UstfzzOpcv
	 kw9VQJmZhsRyPBCyEaqCQC+snv5dhz/RhyK2vpo081yPkfrRuHvFJ5uNYL6sDGlGv4
	 Y0LECZ/UMw5nQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02CD2C3959F;
	Thu,  4 Jan 2024 19:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpfilter: remove bpfilter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170439722500.21897.13508657753346073758.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 19:40:25 +0000
References: <20231226130745.465988-1-qde@naccy.de>
In-Reply-To: <20231226130745.465988-1-qde@naccy.de>
To: Quentin Deslandes <qde@naccy.de>
Cc: netdev@vger.kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 quentin@isovalent.com, mykolal@fb.com, shuah@kernel.org, jikos@kernel.org,
 benjamin.tissoires@redhat.com, brauner@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 26 Dec 2023 14:07:42 +0100 you wrote:
> bpfilter was supposed to convert iptables filtering rules into
> BPF programs on the fly, from the kernel, through a usermode
> helper. The base code for the UMH was introduced in 2018, and
> couple of attempts (2, 3) tried to introduce the BPF program
> generate features but were abandoned.
> 
> bpfilter now sits in a kernel tree unused and unusable, occasionally
> causing confusion amongst Linux users (4, 5).
> 
> [...]

Here is the summary with links:
  - bpfilter: remove bpfilter
    https://git.kernel.org/bpf/bpf-next/c/98e20e5e13d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



