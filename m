Return-Path: <netdev+bounces-217746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CDDB39B04
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A9D1C26E57
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FCC30C61B;
	Thu, 28 Aug 2025 11:07:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3931F4CAF
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379244; cv=none; b=qxg5qSdo2ZZZB4wI8NIujYZyEfAskSRqs03F9lDc7TASDPGfLCWk9E2VrpKP0xChlYoAdXy2kOr2PUi2x3boKsqofBwYhO/wpphizSszWBheglnG+0Qj+9gfBlRx1WHjOGjqaLAR5f24Fjuvfe8YeFDG4hlt6+ZDdn5clt1v14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379244; c=relaxed/simple;
	bh=Nas3Yc0d+xnRKeHP94h5sYkVeRl3KlV0gfHSlr8sc74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohhol95OBeW2TjQVuOOfr+htYlYAmrYFk9dOVzf16fEKrGGDiB3kBLfGBoA7rF+27fYqBDPhpjZEsy0AVuzrtcyoqVQYrgO8l3THuJQCPIytuspyqbtdeE2GE6oMf3kv7kwX8qx6NgwEMAiTTl5iVUbQCrarWyNIpyRgx7BClug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 57SB6TST092890;
	Thu, 28 Aug 2025 20:06:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 57SB6TbS092886
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 28 Aug 2025 20:06:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2a58b0b4-1c67-46d2-9c2a-fce3d26fc846@I-love.SAKURA.ne.jp>
Date: Thu, 28 Aug 2025 20:06:29 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (3)
To: Sabrina Dubroca <sd@queasysnail.net>,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc: syzbot <syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au,
        horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
References: <6888736f.a00a0220.b12ec.00ca.GAE@google.com>
 <aIiqAjZzjl7uNeSb@gauss3.secunet.de> <aIisBdRAM2vZ_VCW@krikkit>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aIisBdRAM2vZ_VCW@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is still hitting this problem. Please check.

On 2025/07/29 20:09, Sabrina Dubroca wrote:
>> Hi Sabrina, your recent ipcomp patches seem to trigger this issue.
>> At least reverting them make it go away. Can you please look
>> into this?
> 
> I haven't looked at the other reports yet, but this one seems to be a
> stupid mistake in my revert patch. With these changes, the syzbot
> repro stops splatting here:

