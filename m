Return-Path: <netdev+bounces-239294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21942C66ABD
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCCB84E0386
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672422D7810;
	Tue, 18 Nov 2025 00:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbSq2f8P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40575134CF
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 00:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763426315; cv=none; b=rqWyr6dKB2+fnyFrQdYDyzc0ezN6bVPjPQD/7uybsSAd/LsMHveXumgvjX7+tdJJPatg7XmWzXEpqwWKem8Yxa5JEeIAdCikjn8WbTFVawcLywTBpHkdHqfKp+Ekl8eVMXq5DofA3irWrLa7dqgpRJWJOIWYUgXh13OI8XoaZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763426315; c=relaxed/simple;
	bh=/pW/4dt/exM+nlhAa3u1CRxzPLc3VMK4rDMqpO+7MUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mej2bDTVQtbbtwXyGW69lidQdaRLSWjHTVMicmBsNisAiQAWYC8yUNld6t5u//Y4rIUPH7Kw7pLGeaiBxisscC53RkONhxSaPuN4kwo6cg4cYBlspigdbOyQMvq/WZs65LYTxlNxXFVGorKrO4gcMO6D9LcaC/22t5WiU4g+iBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbSq2f8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E541C19421;
	Tue, 18 Nov 2025 00:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763426314;
	bh=/pW/4dt/exM+nlhAa3u1CRxzPLc3VMK4rDMqpO+7MUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NbSq2f8PRtbYQugYl4g4tH+IZkaU9OqGku98fM9wGCqP+V1OxGJXtjoylMdpyMXgZ
	 cPSFbpnmLsXK+DP60Bv3N0Q7IZaj3Xm4hA13Dx8Q2EGV3EMHz9XMqWZvD+CORYX7C5
	 JwgYL6cloripnAop5t0T+ZPgZQMG1AVg4+3hnpc9NqrjybNbPoCR+3Hz6fWH/v3jAG
	 Zvf5R+vzZDucRz6AWZ1u6LYG978U2mvs83hf0GqOpKEas4qscVUaZHhmhV/lWmPO39
	 3SnS+DVadyp7zq5lFWMKPmj+FZ1Gc4zFGLLeCxwNine6XAFTkV3bs0/6po/oJe8fBj
	 mwYo9eht++xMw==
Date: Mon, 17 Nov 2025 16:38:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1] tools: ynltool: ignore *.d deps files
Message-ID: <20251117163831.25d08e90@kernel.org>
In-Reply-To: <20251117143155.44806-1-donald.hunter@gmail.com>
References: <20251117143155.44806-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 14:31:54 +0000 Donald Hunter wrote:
> Add *.d to gitignore for ynltool

Perils of having a sensible ~/.gitignore :(

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

