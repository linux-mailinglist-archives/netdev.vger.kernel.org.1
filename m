Return-Path: <netdev+bounces-179673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 945DEA7E0E6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15307168890
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204681D90B3;
	Mon,  7 Apr 2025 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5mAmMPO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6251D54EF;
	Mon,  7 Apr 2025 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035325; cv=none; b=IZOlFdeVlKMKf9Csi4BH+bCujrnwruFz9r8uK99PzYh5Ra3My5Bs0nvY8KAcYtj1F4BOn0jBaIV6LFBuBXf9Zx1xrrhlQ+CUNQp1idFVsRkttWD/pvi3XhcQOQrJP2ccB8WKOQskMAeRyqQKfkLzRpUT7LXzEmxJuRvvAt2Gj4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035325; c=relaxed/simple;
	bh=QpeiK2sRkZo2IkL69SEukYBewbXtcL/h1uTz1zaXmac=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=uHilDS62O3ZGzXksoNmx00GwJ7ZsONCIplbkdOSRaKsYHmk0YhbhEFCyJlfDrpFd59Pxnuv63V6CxeaGHmcKt1mmG0iCgfKQ1fMXemXPappBIq13sy+eqE/U0ICoBZ3LuDVUtyeRK4GgxvSTnuBX7jdY0cYEgJWevwzTxjzjqVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5mAmMPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D54C4CEDD;
	Mon,  7 Apr 2025 14:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744035324;
	bh=QpeiK2sRkZo2IkL69SEukYBewbXtcL/h1uTz1zaXmac=;
	h=Date:From:To:Subject:From;
	b=P5mAmMPOzb4oLNj1hdduZ/m0wZfxhs/f2P4S4kxoKqY1j93zCYpz6QefGdX9Y8vrq
	 1j57YZ8Yi/4Zq7dQTcoNsVikHvJp6E0mGGaF/EqF6o5lgwRlqOxou4keK44FbrcJna
	 7jBPD74LE1bLSHsTdegGpne/RofcOc2L9DCgHmfNK18zX11cE5uRY0fWnWIsWzZ0QF
	 v1v2qrpNJnKlwQXmExb3bQQyhwHCe07Obio4Nbap9uIOuYxGyZe3WcPeKPfuYqY+a+
	 jNIt6lqLf/OrC/sPaA4bIWuoyKcflrrhwiEX2SLx2LAZ9sPKUBYBmTDtPcwqEFSvWA
	 q/OAfCDfSO8Lw==
Date: Mon, 7 Apr 2025 07:15:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Apr 8th
Message-ID: <20250407071523.216102e5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

I'm not aware of any topics so please share some, if nobody
does we'll cancel.

