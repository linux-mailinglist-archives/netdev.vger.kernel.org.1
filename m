Return-Path: <netdev+bounces-111179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC99930303
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 03:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519032825AA
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 01:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE28DDAB;
	Sat, 13 Jul 2024 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohPD0Fop"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88051101C4;
	Sat, 13 Jul 2024 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720833946; cv=none; b=S7d7vDRhoWH/lYiJESupj//PsQQ3hbjn3FYwcPcQG5+wG5orv5ntapM+qyLvl4DhZ27tCASu/G0E8SGRQERV+t7EaHddykI4be5Whg8rRmkW7LnobjPF2ZFPc9Yt6H40Jvif+1eIVAL4tm8OXrdRWOE8XAIzxv7NS2KHUccBFn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720833946; c=relaxed/simple;
	bh=p1nUlYgdt3tqPXoPu0qd2hTKMKSsqXPSrshmVNEggxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZdu385P8b1A4Poz9RrGTZgidKyyikarqMafhym3+R0IHquDiIFWGcAKqEf6bHYJnJzW8t013NGD1pA0WmWEKL7KpP2g/TY70O3m87DADn7uQ0dqCb0byrW7YEUww49nDY8nNZq86D4asQfk4wlOGnGaCYRPaDzM1MlNfpjPyfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohPD0Fop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CA1C32782;
	Sat, 13 Jul 2024 01:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720833946;
	bh=p1nUlYgdt3tqPXoPu0qd2hTKMKSsqXPSrshmVNEggxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ohPD0Fop4+am4LRBr8GU3uoVebMFdMt8xWwSuPL3aAp0ineZUCrw+8cScwUApIn7G
	 lJkGVpI/Keh1Vdxof4dr1mR+AToON68M14LRi0lhIVNjI+pdACRKUTG5BoC5g1H7UB
	 NSK8xmv9afrLtIUBK5UuE6QPOsF6s+eVoZafr/hjIs7JNHgc4K8MTBx9hb8vFYw2X8
	 KhelxTavZ2AOoDMzpNQ1FD87KCzfikUh072LFvX/q70rq+mS5+OgQVo/LfkDFJjP8L
	 ADiXJfVewL6Q+kHtuu+JqnF+yYkkgyqTXSUJ88A23D9IBFeClxD7jFK2djpczmKDfB
	 L9kPW2io/Q6wQ==
Date: Fri, 12 Jul 2024 18:25:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for v6.10-rc8 (follow up)
Message-ID: <20240712182545.172d0f5d@kernel.org>
In-Reply-To: <20240713012205.4143828-1-kuba@kernel.org>
References: <20240713012205.4143828-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 18:22:05 -0700 Jakub Kicinski wrote:
>  Friday

Sunday..

