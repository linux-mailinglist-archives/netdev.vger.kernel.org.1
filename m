Return-Path: <netdev+bounces-100630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A7B8FB63D
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9196E287774
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8806C1482E9;
	Tue,  4 Jun 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh53DyEb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B1913C69C
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512721; cv=none; b=SRrbtmKhlIXbB3S2TIxicSBMm9YYQL73sphugenIJT8l3hrUXZLhIiZXnb/ElXYwlQHCWS3gUQTLoH8N1Fuec7wTLQ+QDQKsReZApjQwWeb5CeZwkCVqEh+IDig1YJl3UG8Gfk1pOFSQsdgm2L949f8gHOlYmEJ9qn4v5dJMlj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512721; c=relaxed/simple;
	bh=a4eWUbb1p9Hqfs9bSVsY5W7BAcfhQRINWNiuo41nbVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNZOfSsP+Tu6KQ21qQra+RucZFzx6S1AwX34IvEWxuJZHhwblJ/ZTHAchjlQ4Imx/M3jYwT1P/bHayyMWIIkn5bCbDj54pTyL/Jt6axIJwqWd9blu/H7BR2GvpgW4VkvLgNTqOUjkGUIvAEOGOYH57CCz3dVjeRi6hHEh5ja1K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh53DyEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A0AC2BBFC;
	Tue,  4 Jun 2024 14:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717512720;
	bh=a4eWUbb1p9Hqfs9bSVsY5W7BAcfhQRINWNiuo41nbVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kh53DyEbZ+zEC/UxX87YkEEmYBCjRk9G2SeCHKK0Bk1u/r6ooEUeQUtTculcV+fFS
	 /Y55nDHrLd3dYGnM6hHCGVVZikCS7TsclTyGGzCotmGci6XDgu1ag0tAUtpnxTEpfW
	 G3/080/QRcGtF6sHZiGr1NQBaxvmsyr0/1Ozm8buQd3cH9G60YK38/K7JE75603KIv
	 V3yxMR/K/lWD85Fu0sISTo+WdV4g/PIuPQmbCfD8oYRRwhds8anMXtSbZU/fCW0LpZ
	 QZJR9DuLQOuKKN5QWRDqzlxiHJbMn9OOr8rYz6TT8y9XKuDaac3Js1K4mTx2J2qsBs
	 8WZSqqW/crEow==
Date: Tue, 4 Jun 2024 07:51:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, horms@kernel.org, Tristram.Ha@microchip.com,
 Arun.Ramadoss@microchip.com
Subject: Re: [PATCH net v5 0/5] Add Microchip KSZ 9897 Switch CPU PHY +
 Errata
Message-ID: <20240604075159.1271401f@kernel.org>
In-Reply-To: <20240604092304.314636-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
	<20240604092304.314636-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jun 2024 09:23:01 +0000 Enguerrand de Ribaucourt wrote:
> Back in 2022, I had posted a series of patches to support the KSZ9897
> switch's CPU PHY ports but some discussions had not been concluded with
> Microchip. I've been maintaining the patches since and I'm now
> resubmitting them with some improvements to handle new KSZ9897 errata
> sheets (also concerning the whole KSZ9477 family).
> 
> I'm very much listening for feedback on these patches. Please let me know if you
> have any suggestions or concerns. Thank you.

The v5 patches did not get grouped correctly by patchwork:
https://patchwork.kernel.org/project/netdevbpf/list/?series=858591&state=*

Don't try to do fancy --in-reply-to, please, just resend as a new
thread. You're already adding lore links for folks to find previous
versions (which is great!)

