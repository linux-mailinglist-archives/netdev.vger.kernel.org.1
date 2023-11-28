Return-Path: <netdev+bounces-51715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E787FBD99
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A448A1C213D3
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C7C5C08A;
	Tue, 28 Nov 2023 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXIl3mQa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CEE5C081
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08DAC433C7;
	Tue, 28 Nov 2023 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701183716;
	bh=sMnYOB8L1SwL3ciBBDXLq1lHVhS0WDYNcQcKrKXu7aA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UXIl3mQawuOK0Pj6zNfnpMrySaZuaqJGQZ38y9k6+GhkQmQviqw/QHHE7yzWbLuPB
	 FRbkikDZyhwBnoon5LVJ8Dr8Uw7vQiR1NfcTiaANyKJ6r5VS5OTStjhGl2w3WW13iT
	 ReaGqaeYAJXbULeT4H5VbQsxVaNZyJoOVV/GgpOAWuZ3duUcfovQdjGk996Cw+0LKh
	 OS8GSynk21d2f5/0bq6EZPOeR/1iYfePdCKdidKraDopPc6+NLA44KrAm682aV9DLu
	 85u1uMkKZGCkj8sn3DaupkBR8CQj0su0qpkCE633KfxpNuiIqZnDtRMA7wIxNpK2zR
	 nQSZTrWwhZsyg==
Date: Tue, 28 Nov 2023 07:01:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+listaba4d9d9775b9482e752@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] Monthly net report (Nov 2023)
Message-ID: <20231128070154.2beee02c@kernel.org>
In-Reply-To: <CANp29Y77rtNrUgQA9HKcB3=bt8FrhbqUSnbZJi3_OGmTpSda6A@mail.gmail.com>
References: <00000000000029fce7060ad196ad@google.com>
	<20231124182844.3d304412@kernel.org>
	<CANp29Y77rtNrUgQA9HKcB3=bt8FrhbqUSnbZJi3_OGmTpSda6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 15:54:00 +0100 Aleksandr Nogikh wrote:
> Maybe it could be worth it to add "X: net/9p/" to "NETWORKING [GENERAL]"?
> Syzbot would then eventually also pick up the change.

Good point, sent.

