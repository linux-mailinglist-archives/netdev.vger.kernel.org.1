Return-Path: <netdev+bounces-20542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2D176000D
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 21:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E5B1C20A74
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCC710793;
	Mon, 24 Jul 2023 19:52:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F34101CF
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 19:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1BAC433C7;
	Mon, 24 Jul 2023 19:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690228370;
	bh=kP9LFVtRs+Ccd680KNMd/rso4IU7MRNI/s2gQcTn8K8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qgSBdgWOM6O8dH0osz4XFlKo9jOWZ6gGAyBSleFY0cnmRksLenDlC26PBXmkn475s
	 6iD9hEfArzfCxkcjLk6q0oP5NLIVXeUc8djvArC2em9TW/KP4ztJWX1wkoP9sYiJQm
	 iyfLYlYGH2BpSXP6DDFec83DGL9tVYgF6vaJ98nU83TfzlZydgPZ+VBxsNOIyimlac
	 KxXtaEI6gaLpndVzh/s49gopZSdIqPf98IKnG7Kumg+aTQ3BzgNfIwb3L/obEFkYuu
	 mIf+pf6ozPuCmzGRk6NJt7GF0dMBc9ijV01zcbks02tkqYqraJgLm4sr6jIIbg7E/3
	 14s25cH8SkrCg==
Date: Mon, 24 Jul 2023 12:52:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCHv8 0/6] net/tls: fixes for NVMe-over-TLS
Message-ID: <20230724125249.319241b7@kernel.org>
In-Reply-To: <ad36e40b-65d9-b7ad-a72e-882fe7441e52@grimberg.me>
References: <20230721143523.56906-1-hare@suse.de>
	<20230721190026.25d2f0a5@kernel.org>
	<3e83c1dd-99bd-4dbd-2f83-4008e7059cfa@suse.de>
	<9f37941c-b265-7f28-ebec-76c04804b684@grimberg.me>
	<20230724123546.70775e77@kernel.org>
	<ad36e40b-65d9-b7ad-a72e-882fe7441e52@grimberg.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jul 2023 22:44:49 +0300 Sagi Grimberg wrote:
> > I'm probably using the wrong word. I mean a branch based on -rc3 that's
> > not going to get rebased so the commits IDs match and we can both pull
> > it in. Not stable as in Greg KH.  
> 
> Are you aiming this for 6.5 ? We are unlikely to get the nvme bits in
> this round. I also don't think there is a conflict so the nvme bits
> can go in for 6.6 and later the nvme tree will pull the tls updates.

Great, less work :) 

Let's see a v9 with the flushing improved and we'll apply to net-next
directly.

