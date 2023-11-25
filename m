Return-Path: <netdev+bounces-51003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B6C7F87CB
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 03:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F64228136D
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 02:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4771361;
	Sat, 25 Nov 2023 02:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFABNI+H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD5710EA
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 02:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E42BC433C8;
	Sat, 25 Nov 2023 02:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700879325;
	bh=KSXbkpU8Fl5Y02CZ3Rw/HYbRfQgPK/1b+JdCV/e+Nuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IFABNI+HqmwLePnqpI/1FwvCMwo50U9NcZgWATkFx/F7mtJeMwygBYXIyQdLLwek3
	 HH8RjMv/ZMCJ7+49ZMWliceqtxTstv6K4jsJ9tZBnWbjUd2+Zn7MoVJVtND138OYOs
	 oFu6fYasEGUFBfGAkTIbjkU9DIkPll1hVzljVWfimCbw7tAGmS3/5qoPqFpz4ORG+4
	 vPCEUHp2VZUDp9eTbipRiAz+fELvR4x9qq90JtRmxmV+U+E4Wod6d8k8VfpulyA96t
	 ttA06iwa1MzCz+PYqhaXUE63+tfRenb/MpGfIHbhXs5P3uC2YzpVzGipLoc8S83ddX
	 FdTYbMh3KM8Zg==
Date: Fri, 24 Nov 2023 18:28:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: syzbot <syzbot+listaba4d9d9775b9482e752@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] Monthly net report (Nov 2023)
Message-ID: <20231124182844.3d304412@kernel.org>
In-Reply-To: <00000000000029fce7060ad196ad@google.com>
References: <00000000000029fce7060ad196ad@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 05:12:23 -0800 syzbot wrote:
> <8>  240     Yes   BUG: corrupted list in p9_fd_cancelled (2)
>                    https://syzkaller.appspot.com/bug?extid=1d26c4ed77bc6c5ed5e6

One nit - p9 is not really net.

Thanks again for restarting the reports!

