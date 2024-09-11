Return-Path: <netdev+bounces-127267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DE2974CB6
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ECFD1C21B75
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B399C1422AB;
	Wed, 11 Sep 2024 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlwycM/f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B713AA3F;
	Wed, 11 Sep 2024 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043697; cv=none; b=hoI7O79Yi8Y1IgcLJZIgKbzM1wOvu6oEcMPkunLuA/NcSrr7J7gqWyHjdaSzUbx1cAnoFvqpcO/w24x2cRAcCswe8gRBLFlWgpSanqpXKKeYyBic8VAkIbBbSjyRFbyVD5q7UAcU9jbm3NDb5ROQk8o6iOilW06Byr4Mi6gUefw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043697; c=relaxed/simple;
	bh=9CVlaoSuTSEKSMX92T0AothxH70JMzuFOid0gOQaNU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft3HFQ4pPcEXtxL+UllBtq16dCHp5SiAEP4e9Tfs9gwgGy7ZKRk+3qxD8NDsfKTP21jOIwbdTiHk1QOrU1gKxEjNi9vqhDoEKzkZS2lMmRkXw5m4t4AwHmplOcbZYguy0iUvSD7PsI3FEpNy2ZuPexVhLKiEk0yrWC3f5DIP5sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlwycM/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494F2C4CEC5;
	Wed, 11 Sep 2024 08:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726043697;
	bh=9CVlaoSuTSEKSMX92T0AothxH70JMzuFOid0gOQaNU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlwycM/fs3Wf+BCmWQJICLazc/QOA6KULk/LDl+BTKIpdREAZo6+Jo7scHs5F1Vuk
	 w+NAOzdtVMhJy/ZsZsF9K1yo4Oz0AAcB/hhTwHdrtqYgr3s6g++wHZ1j0VyYixlvGw
	 RqyDx3ixFrl6iWyRN+sxiwy2mAOTeU9474CiHV8esbvipW64mHsARYug2whbz7Hu+9
	 T/9HfLTQZkaRadDPn5cIWf+qcAiRpKfZnKGEnrw2pnf2K1zyjosbwHyuNwtxxrhsMm
	 1aqd/esFq5ilazR3TdE4b2ppGX2kWz4JnsG6llHqn4IFAU2esadqAXm6sPGaCtDslo
	 ehVV2N+uT1vKQ==
Date: Wed, 11 Sep 2024 09:34:53 +0100
From: Simon Horman <horms@kernel.org>
To: syzbot <syzbot+c229849f5b6c82eba3c2@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
	Edward Adam Davis <eadavis@qq.com>
Subject: Re: [syzbot] [net?] general protection fault in
 send_hsr_supervision_frame (2)
Message-ID: <20240911083453.GB678243@kernel.org>
References: <0000000000000d402f0621c44c87@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000d402f0621c44c87@google.com>

+ Edward Adam Davis

On Tue, Sep 10, 2024 at 07:00:33AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4c8002277167 fou: fix initialization of grc
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=12f46797980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
> dashboard link: https://syzkaller.appspot.com/bug?extid=c229849f5b6c82eba3c2
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

...

I believe this is a duplicate of another report.

#syz dup: general protection fault in hsr_proxy_announce

https://syzkaller.appspot.com/bug?extid=02a42d9b1bd395cbcab4

