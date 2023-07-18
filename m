Return-Path: <netdev+bounces-18715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8307585B8
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 21:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF152816D0
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5382171BE;
	Tue, 18 Jul 2023 19:45:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954EB10946
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 19:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F86C433C7;
	Tue, 18 Jul 2023 19:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689709550;
	bh=94qN7IxSeuyb7pEQYiFkSuDjUouVRsu/gsID7UmjLsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rPsOyVA7/PABWabDCwLsaJiEIzold1feSFOLd21VdtYtOmwg1+MgFTrfFdEahbjYJ
	 cLKYT3VnO/S1zyb/kSuQCOrfEj2+TTkZraKhOCmqOz7SxvgkZZzCg2T4I+ZIGglZE6
	 iOvWaFfax7yREr2Rb5KVySLopQr7jEoSEy1VQ4eFwSjfwpEEyMlQdP0oJP1v2nbMuP
	 PMASQvA5uda3+QGF34YE0F+/yIkDGstbhXLzItw5KzpJag7oKSCFuKWjaFzuIDeJ+y
	 LRweB2pzUFC+Eps48Ag9TS9taTyfjFXIp8FF9/1pwP8msO0bl3MrgYsSLor9GoBIko
	 a+o/frAWTgHeA==
Date: Tue, 18 Jul 2023 12:45:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: syzbot <syzbot+c19afa60d78984711078@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, hdanton@sina.com, jiri@nvidia.com,
 johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in
 hci_uart_tty_ioctl
Message-ID: <20230718124548.7b1d3196@kernel.org>
In-Reply-To: <00000000000077b5650600b48ed0@google.com>
References: <00000000000049baa505e65e3939@google.com>
	<00000000000077b5650600b48ed0@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jul 2023 13:22:24 -0700 syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit d772781964415c63759572b917e21c4f7ec08d9f
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Fri Jan 6 06:33:54 2023 +0000
> 
>     devlink: bump the instance index directly when iterating

Hm, don't think so. It's not the first issue where syzbot decided
this commit was the resolution. I wonder what makes it special.

