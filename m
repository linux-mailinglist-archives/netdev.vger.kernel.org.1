Return-Path: <netdev+bounces-150470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DAF9EA544
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B5118804F3
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC94A19E7E3;
	Tue, 10 Dec 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuKeKXC0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CF527456
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798428; cv=none; b=IUTXIe5o/4a5k0e9MQjmx9Zo0JSyKbeymnU8Om0C/c6AyqrWJRr/oUySUh+e+9Cg5rJiiYLJ6A1JR/rqtt5WpjtTadq++K0FmHCSt5jYs5p1zg2iZqJ+/1cFm8MFXzRil/aMVuw2TMKt7xP3muPrB89P65ThCC172S3VOaojcFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798428; c=relaxed/simple;
	bh=LBFxkqj12uLxfCFRax3p+PMnWn5MVpbaRCqrkv8D84M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KpeptClyvi5cB8j5sFSJM2XxwvMHPxn8Ujk6VzGyvDLfCoiEiC63i85g7LO4wbMOEBiCegS1UHN9mrJQuCAvss9CuWYN36p+/uOBBGbxUtr54ME6R1w2nEndnxj6P+BP0uGZjL0hd2mCH2fT296KDRlOEbdYD+OAYS1/VjU9LSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuKeKXC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1C3C4CED1;
	Tue, 10 Dec 2024 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733798427;
	bh=LBFxkqj12uLxfCFRax3p+PMnWn5MVpbaRCqrkv8D84M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AuKeKXC0bCSMtHG3fT7Gu7EXAapkG0NUrXnkNPbiFtUiUQktpNLx4duFtiplWd0Yk
	 Sf2J/mCIdBG3wqj8NscOe8SUMMrofTSXO7iS+BZZXLxKlowaJUo1kVMK3WA/tMwlAP
	 hCWB/zfACzVIitO5JtSajs/V1kHEJZ0mKW9a6d0VyA6lTqdLS4yI42mo1f/zok52Kb
	 2X+QSc3wBe1AJ+bEuLwzrbj5At2xyZAwDU6W4fYHdec8vai9XBEU/5TseIATwiOi+b
	 2qbUF6CQtlWwCx+nGaHzbxE+iHKMwJXQfYKbjUUldl0z/q+Ber0VDHzwTnwnyM4Tzs
	 821XWLqA/4o0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFB7380A95E;
	Tue, 10 Dec 2024 02:40:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] cxgb4: use port number to set mac addr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173379844265.320519.6236369591140283627.git-patchwork-notify@kernel.org>
Date: Tue, 10 Dec 2024 02:40:42 +0000
References: <20241206062014.49414-1-anumula@chelsio.com>
In-Reply-To: <20241206062014.49414-1-anumula@chelsio.com>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 andrew+netdev@lunn.ch, pabeni@redhat.com, bharat@chelsio.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Dec 2024 11:50:14 +0530 you wrote:
> t4_set_vf_mac_acl() uses pf to set mac addr, but t4vf_get_vf_mac_acl()
> uses port number to get mac addr, this leads to error when an attempt
> to set MAC address on VF's of PF2 and PF3.
> This patch fixes the issue by using port number to set mac address.
> 
> Fixes: e0cdac65ba26 ("cxgb4vf: configure ports accessible by the VF")
> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] cxgb4: use port number to set mac addr
    https://git.kernel.org/netdev/net/c/356983f569c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



