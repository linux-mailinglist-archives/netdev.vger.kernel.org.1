Return-Path: <netdev+bounces-145488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB5C9CFA2A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C803A1F28A8C
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4AC191F78;
	Fri, 15 Nov 2024 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2y03c5o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F90A191F62;
	Fri, 15 Nov 2024 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731710281; cv=none; b=a8XWFhX0uPkSRV2BROr8LraEzUMwhvnoGzq1uyx1/U5lfLCDUrmQKwVsrIZ7ncOoHmoAfhoJHSuequ54amie2l5dnSMQs7uwhGmKTsoNs7Pz5zvEGlo4Xbd+b3/t6eAy5l3TaKfMsv/Ub4Ik9cuvmt/fq+xssP+s+vIQUMIccxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731710281; c=relaxed/simple;
	bh=3wc2Cgh3NsWC3hVt3DwtLxVZKtw2ERtUmbZJZ6wjBug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DR/3+k1QehUz/TQhJNSXKqQE8jVNDbOkFDUcmZgG3M6v4Tn9xCDmTlUV0RmDCnIimMaNiTgo3FkqjYbggC4KqJX7C+RFFWxxjRSHlfRc9fNGA7IVQZ4VuAJlCLOm776cOzqiC+yc5KaDouNaqd7yBRAhKVuWyw/JkjvpxdQO29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2y03c5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6633C4CECF;
	Fri, 15 Nov 2024 22:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731710281;
	bh=3wc2Cgh3NsWC3hVt3DwtLxVZKtw2ERtUmbZJZ6wjBug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K2y03c5ohHWZtXNf8NgbT8n+PPJa/aNr+XfxyLM5nzVTfG7nrX17dy0GQ9qfVhv1i
	 lQpwCzrSE+Jp1tYgrs1L7ZmkMN/SjI1bPR4kTIUHRLfOtUKrsMFjuZsTO05mX4CtCe
	 hoU3wWdOIcqhfFc/pPPQvpsqSDPUAQ5JT1awfG+MMZX5KHsLKU6frMrO2zlIdmg+Bu
	 5xxQ1396uvctCuXOfHShA/5StqTztgvU9VhYMu/DNCIIPQxUppRpGcouOyn9Ly8hwF
	 ZJk2dv+wrwJ5IY4Cakhq7xPXYvYzmCQbhN1hQNS+v6vljwUeXGT8NGpcuFY3dySvfX
	 k6SwJtWCSjTwA==
Date: Fri, 15 Nov 2024 14:37:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, horms@kernel.org, corbet@lwn.net,
 andrew+netdev@lunn.ch, kory.maincent@bootlin.com
Subject: Re: [PATCH net-next v2 7/8] ethtool: remove the comments that are
 not gonna be generated
Message-ID: <20241115143759.4915be82@kernel.org>
In-Reply-To: <ZzfDIjiVxUbHsIUg@mini-arch>
References: <20241115193646.1340825-1-sdf@fomichev.me>
	<20241115193646.1340825-8-sdf@fomichev.me>
	<20241115134023.6b451c18@kernel.org>
	<ZzfDIjiVxUbHsIUg@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 13:54:42 -0800 Stanislav Fomichev wrote:
> > These comments could be useful to cross reference with the IEEE spec.
> > Can we add them as doc: ?  
> 
> Absolutely, I did port these (and the rest of the comments that I removed)
> over as doc: (see patch 4).

Ah, I was looking for them re-appearing in patch 8. All good then.

