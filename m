Return-Path: <netdev+bounces-103366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F8D907BC3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609572829D7
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B7B14AD22;
	Thu, 13 Jun 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XSbKrK5h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2D484A48;
	Thu, 13 Jun 2024 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304871; cv=none; b=kjVFEZ8C+lgcRhNd7MsmgsstjzJwiqsAOK3XwDoieqlZAEEejw5F1mfisGkHd7ut6Qk2/yBvp+3LPxxHgqAzit1bU/LoXLa8crzj6nn/aF8AIchbugHN/nZnQHHP0NReeKVCdTrbB46KQq+zxcgjQGNB2HOLqfuo2siCmKYjWmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304871; c=relaxed/simple;
	bh=hCGrtrINHBpW558RK/yFkwqvKEYoovaZ98BUv0iszyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw9A5bTIVGqcwtWVkSfmP4ACp+iV/8rfMhMsqEGocjV4CqCpYvTNFaA70GcaUIOvyYwI66tjUBwiAXxNj2vWBS2B2vl/AXZ/3O6GXvFnPYKHbRkQysU3JSRE+H0/gxCnD6DemnXHG9st2Q6SOezCIW3+B+gEl2bXITNh2fgpvlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XSbKrK5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB4CC2BBFC;
	Thu, 13 Jun 2024 18:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718304870;
	bh=hCGrtrINHBpW558RK/yFkwqvKEYoovaZ98BUv0iszyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XSbKrK5h6M94wYR07RnLRhLTlp4okpucVLIZ0XEjbyeIu5mkqekKQzLrnWh/BQyVc
	 1Bvvq1lLxSI6vyASrGqqah4MNNQBFhDKzSnH3tekXWuDTZmFS0NqDThgOSFrudG05k
	 9ce0vUokhDDtxmS7CJKQWo5OzeJvz9PtDXWXhn6I=
Date: Thu, 13 Jun 2024 14:54:29 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Networking for v6.10-rc4
Message-ID: <20240613-satisfied-righteous-mongrel-73ab7d@meerkat>
References: <20240613163542.130374-1-kuba@kernel.org>
 <CAHk-=wiNgwEpfTpz0c9NXvZvLFPVs15LeFfmhAUO_XhQTXfahQ@mail.gmail.com>
 <20240613113726.795caf6f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240613113726.795caf6f@kernel.org>

On Thu, Jun 13, 2024 at 11:37:26AM GMT, Jakub Kicinski wrote:
> I only uploaded the refreshed keys to the servers ~minutes before
> sending the PR. Next sync should hopefully get it into pgpkeys.git.

I run the sync from keyservers about once every 2 weeks. My key has to be
present to sign it, so it's not a job I can fully automate. I just so happened
to be running it today, so it's already included in the latest batch of
updates.

> Not to excuse my incompetence but git tag -s didn't scream at me last
> week that my key is about to expire :(

The "your key is about to expire" notification bot has been on my todo list
for the longest time.

-K

