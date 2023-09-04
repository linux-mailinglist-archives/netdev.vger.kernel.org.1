Return-Path: <netdev+bounces-31890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 735F6791364
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 10:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8E8280F42
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 08:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291721379;
	Mon,  4 Sep 2023 08:27:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61A61371
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 08:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4017DC433C7;
	Mon,  4 Sep 2023 08:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693816060;
	bh=OrcTGqNiXMYO2qYJLCb9/wiZRepTOlxxFsyxT3JuOcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6QlT8XHJMqioU8IQ/VWqfrooEKxmG7WHjFh+mF6GzWzClEkQb0iGDgl+5OWA6+8B
	 qTZaIVwb6VSE1krxjzgFZ6cZPE7l+UaEnOs0t8ZjeXKOB/1pnbIyQDT4cYkvR/g7rc
	 wkqETjXYPZUOTjGE9cun1UH/mHNhVuvQD22EhDIbl8i+Q4QuP1g7EbUcmes5uF+Mm7
	 1pNrPJ36o/BTsluVp3+uilq2AExn6+5HRr/LCCVbKgEVHOE8jY9fGl4Xbo3nGpSRna
	 Me0lB01yIL2bzohhb4JUsneDxIRN9Xj6HPzJwGjj8dfIRKtvfrFlmvYwQRRsH9WPI9
	 fzaz66h7zK5Bw==
Date: Mon, 4 Sep 2023 10:27:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v2 net] af_unix: Fix msg_controllen test in
 scm_pidfd_recv() for MSG_CMSG_COMPAT.
Message-ID: <20230904-wappen-glaser-db7a7db6a26c@brauner>
References: <20230901234604.85191-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230901234604.85191-1-kuniyu@amazon.com>

On Fri, Sep 01, 2023 at 04:46:04PM -0700, Kuniyuki Iwashima wrote:
> Heiko Carstens reported that SCM_PIDFD does not work with MSG_CMSG_COMPAT
> because scm_pidfd_recv() always checks msg_controllen against sizeof(struct
> cmsghdr).
> 
> We need to use sizeof(struct compat_cmsghdr) for the compat case.
> 
> Fixes: 5e2ff6704a27 ("scm: add SO_PASSPIDFD and SCM_PIDFD")
> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> Closes: https://lore.kernel.org/netdev/20230901200517.8742-A-hca@linux.ibm.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Tested-by: Heiko Carstens <hca@linux.ibm.com>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
> v2:
>   * Correct `len` in compat/non-compat case
> 
> v1: https://lore.kernel.org/netdev/20230901222033.71400-1-kuniyu@amazon.com/T/#u
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

