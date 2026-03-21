Return-Path: <netdev+bounces-270130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zvkQE8rrvWkjDwMAu9opvQ
	(envelope-from <netdev+bounces-270130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:52:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A222E2A99
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F2743025E63
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A17C3264FE;
	Sat, 21 Mar 2026 00:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRVgqBF7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B02FDC57;
	Sat, 21 Mar 2026 00:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774054342; cv=none; b=Z/z3Mqt1zacsUGwgF/ajL66t6swE3jjRiAJWV2LQ0pyLIS8fKsmXLjbtymUTZayH+Ol4kvBXD7SWldXtpGnE8SePc86AeIe8Dxbx8/EbEobvjaDI2vebkMFE0DIZudbpkQ/u0SsGM23Slg8s24SVldUkmv1geQ6eN3NEvcxkDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774054342; c=relaxed/simple;
	bh=L7+PxV1aS7scozLyw7rk75/7lLkAfMoe2xMLsfwLF7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFP9CYzRMDpm7XRNmjFdRRFODhxbcgd6W1Omve6S8aznDCJ4aup6hUjcB+kb/doWvhCQ39IoWCBmtKt7N+wGZF3k4HiNurx1Z5h0R+5d4Nj2vnGYmsFPERcVs19Qx2fk2v/uytt5OckDxJpouI5aDBqQ2+lNK0CZ7IOtI0Ahpic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRVgqBF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55ADEC2BC9E;
	Sat, 21 Mar 2026 00:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774054341;
	bh=L7+PxV1aS7scozLyw7rk75/7lLkAfMoe2xMLsfwLF7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DRVgqBF7Ts1yH62Yj8OKaWf42vxYb6mxAhLKMIyAjLqtYC8Jw3/6Y/K/HFSfKS1Vz
	 RKe/tdJiotXUEQRitH21kMBsSqvKKaG77tR2B15D+Bh4w5xZaHaLuRkx8EdUdz/Wkw
	 bHScJpy0ryjC8hjS9/iAQBhx9Q7B5+1A+VoG4zM3kQ5G8DS/2EnHKkWNdAYoVkhFm0
	 tbuNCOZxeb2yzmwFnzW8niUOF/VCDmVhU62dDjM6Q/iGvCy783h0+16pW/n02Rq6/9
	 IosWJrrDnR1dmfHAFOzdZyi/psI/Y1k7NjqrFKNIdreQPAnWS6pTAmMBIZeIYBU24O
	 qcfW5Rt6nONMw==
Date: Fri, 20 Mar 2026 17:52:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-bluetooth@vger.kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: bluetooth regression fix likely to miss -rc5 (was: Re: [GIT
 PULL] bluetooth 2026-03-19)
Message-ID: <20260320175220.47147285@kernel.org>
In-Reply-To: <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
References: <20260319190455.135302-1-luiz.dentz@gmail.com>
	<177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
	<6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info>
	<CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270130-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3A222E2A99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 14:02:34 -0400 Luiz Augusto von Dentz wrote:
> Afaik, it was tagged as regression on March 1st afaik, according to
> [2]; traces were only provided on March 15th, so yeah it was fixed
> within a week once the necessary traces were supplied.

Hi Luiz, I don't really care about the complaint, just wanted to check
whether you know that we always send the PR on Thu (either AM or PM
depending on which maintainer is handling it)? If you do then nothing
to see here, we are all doing our best. But if it's not crystal clear
I should probably ping all sub-trees to remind folks.

