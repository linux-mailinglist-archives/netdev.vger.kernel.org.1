Return-Path: <netdev+bounces-192055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E964ABE648
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 23:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B1E1B673CA
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 21:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E2E25D8FD;
	Tue, 20 May 2025 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JF9mr4k6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C825D1F7
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777843; cv=none; b=F2wOUyByV1pDUP2QsjocjXjlNOKOS+U/xZhKPHShUm7RPy+70FL23vtAzf8oYpYIs6ismjiVBklr/JRdoA+Y/GqMUOnhoV27OJie4oKCRQPCpUnC3du+r4ytdWR037RN3zFJn7yrGkrOyD4Dbcc24wpGSxceJxLjnGwflFGb69g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777843; c=relaxed/simple;
	bh=OKq2CM1/C0CHdoQvr0mvbJtnFvLGjqjM9opfFc65otc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0eIovqkjyBlzIOvuElcWin9iKgAoiHW39F4KG/n9tZdZJ0dgAbEf1aPtqoWnYx+0sohcLkxN1cK2Ex7ivnc4AEqGvZzSJoZ5/Dq5JtcPsi6e+5w7YW0tznYg3fFv+++OoG4nvr093tCjR8m9USiB9aGl6dTHD2EHu7IbgiSck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=JF9mr4k6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C95C4CEE9;
	Tue, 20 May 2025 21:50:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JF9mr4k6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1747777838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKq2CM1/C0CHdoQvr0mvbJtnFvLGjqjM9opfFc65otc=;
	b=JF9mr4k6Ll3tSuxTLSfKpYW7gqMrcQW+3iJIDgQ5cThoX8Lr4TSULVn0SmupPZHEtBMRih
	ODfnGT9b6E9wZg+u/ChmCxHPZi8sBKWrPmqBNKYX6RCcu2MOfC5WhSjABbP/XJSQ/3pCGc
	iyjCIqV/q/+JoSbW1DD+Kx0D5Ny78cc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8d0070c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 May 2025 21:50:38 +0000 (UTC)
Date: Tue, 20 May 2025 23:50:36 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jordan Rife <jordan@jrife.io>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RESEND PATCH v3 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
Message-ID: <aCz5LO_VhOGYkFl7@zx2c4.com>
References: <20250517192955.594735-1-jordan@jrife.io>
 <20250517192955.594735-2-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250517192955.594735-2-jordan@jrife.io>

On Sat, May 17, 2025 at 12:29:52PM -0700, Jordan Rife wrote:
> +pub1_hex=$(echo "$pub1" | base64 -d | xxd -p -c 50)

There's no xxd or base64 commands on the test harness vm, but also this
line isn't used, so I'll just nix it on commit.

