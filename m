Return-Path: <netdev+bounces-127317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9140D974F32
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8221C21F7F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4959517B51B;
	Wed, 11 Sep 2024 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EJbIgNXH"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE5614E2FA;
	Wed, 11 Sep 2024 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049059; cv=none; b=RMLf9EphmbKIW7ljlek1vJR69yNxly1hddSYvPKlzc1m12TRMuYyLEX15utIQkI3gYdsZ4D2g0nsMVbQIwoL9mkWJAMD60gScHCjS/d4cwZpI3BTg9Z2ByQS/LKsj7J7JFLMW5ECYRP0osrhE7rwLdCUXJAz3C5BOEv9vzdU5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049059; c=relaxed/simple;
	bh=7y7xPgYKXb3zcEsuhLID+clTD9U4En7/zdAsEwy/mzA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHBqevbrJFyh9cafGzW3iVcgv3hyI2lZo9OyLAcyBwMRbS3OCInljWNwusd1ySlqWzuUZMSrcdNUtkp0HTbjUDFM5U5lbkSKglwtYFlqyct+qBITOeRT+1YTmyZ3Qx3FzG2WhRWNhN8YH+LNBZnXZ0V7RI6AI9YcLYxhn7w8bZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EJbIgNXH; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF0F820005;
	Wed, 11 Sep 2024 10:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726049048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzoGSD5CTrrPugX53bwAOAggDXMY+GDBbkq/c3bB/8E=;
	b=EJbIgNXHSg5OfozjhGgyoq/eGmGMCMtRsGIr/1632K5nT4vXYSUzie3Kt7h8rFtoMlK4Nb
	04h53Xw/NmeqU1PWJXF1wA9amyho/B8zg9G1NTY7jfly7jGZ59HbH8LqhKe+iXRPX65mSa
	ylpga52zbMMghGTvjJpx/YVOeR6FjBFZRue8zGuDraQousuJHcKA5CiGqrrhfm0s8Xf+Ze
	NsMHtJXWqKM0tjH/BcUTKVB02Xa0IW1sJF1c4ee627D6ZlxPLomzSCftyYwHSpsHyltd68
	nBjavjMDB2OZE1j80da6WbcaES+IM4Ae4IQyRFfrZxiD5V4zqEaFj5F2vlYJZQ==
Date: Wed, 11 Sep 2024 12:04:06 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: syzbot <syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com>
Cc: christophe.leroy@csgroup.eu, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: refcount bug in ethnl_phy_done
Message-ID: <20240911120406.123aa4d4@fedora.home>
In-Reply-To: <000000000000d3bf150621d361a7@google.com>
References: <000000000000d3bf150621d361a7@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Wed, 11 Sep 2024 01:00:23 -0700
syzbot <syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a9b1fab3b69f Merge branch 'ionic-convert-rx-queue-buffers-..
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1193c49f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=37742f4fda0d1b09
> dashboard link: https://syzkaller.appspot.com/bug?extid=e9ed4e4368d450c8f9db
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14bb7bc7980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b0a100580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0459f959b12d/disk-a9b1fab3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/337f1be5353b/vmlinux-a9b1fab3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0e3701969c4a/bzImage-a9b1fab3.xz
> 
> The issue was bisected to:
> 
> commit 17194be4c8e1e82d8b484e58cdcb495c0714d1fd
> Author: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Date:   Wed Aug 21 15:10:01 2024 +0000
> 
>     net: ethtool: Introduce a command to list PHYs on an interface
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1034a49f980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1234a49f980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1434a49f980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com
> Fixes: 17194be4c8e1 ("net: ethtool: Introduce a command to list PHYs on an interface")

I'm currently investigating this. I couldn't reproduce it though, even
with the C reproducer, although this was on an arm64 box. I'll give it
a try on x86_64 with the provided .config, see if I can figure out
what's going on, as it looks like the ethnl_phy_start() doesn't get
called.

Thanks,

Maxime

