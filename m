Return-Path: <netdev+bounces-151261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B96489EDC9A
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 01:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC44283507
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C426F8F6C;
	Thu, 12 Dec 2024 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2EfLc4W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634C2A1B8;
	Thu, 12 Dec 2024 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733964024; cv=none; b=lZAMzmOQbYBuJtiMQ/fB45dZzHrmsKRLWQqkqsIzggtKo/KzTt+JGG90Vr9ZmCRN4rRcA4e6rG0OYGjRs4iB2boq6UtifFhpFsVH7aRXLQxybaRuOcpERN2RN+Pe3ziP9ST8GNKxsAsfT81SdKwH6ERE2859YhqkIHmA5CNWezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733964024; c=relaxed/simple;
	bh=OT8YytyiNryVofDMYxKDQ6AoAepT7nxNssWACgEdDV4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dgRTRoEPRjhlSgXsLRWW6n9OhaQ2oAk7iIgHfgfTeja8ThCnoWv7PQznmcrERyTADP2J9q6/C3Z7Zs8fk4nKeehvdDQOS2tEiwDkWLLgSjhBFR0ppOrByejortfEn5kHzATvPndWO+hVr4T94vrsotN7nXuKEqAsTPUcxsgp6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2EfLc4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB1FC4CED2;
	Thu, 12 Dec 2024 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733964024;
	bh=OT8YytyiNryVofDMYxKDQ6AoAepT7nxNssWACgEdDV4=;
	h=Date:From:To:Cc:Subject:From;
	b=o2EfLc4WSIS5QatpULaArJijId1LIT5e7wKfOu3BcQ0ohz4JVYigOgkwcBulYW4K1
	 JMxtu63COYPfVhFjvzu07FNiaBE67YpPEvh5Ef5MM692iDK0wUaL4w7XXc7DvJYaPs
	 OjlgqVH3XU4R6jdFH4SWxALNU+QnwHzU60Ec8Up0GScy0USBcKataVpTCYkGGGldHR
	 vg3NuQR4OiHqM4CdxChAUeL+MAJOP+ZDpVITdjUdCHaS4D9NuFXE16DJkmoT13cxng
	 1Y1ianGL0gVToFfBWyj6dEyhMY8a1Xj49Ye+0aedqXjheVPQJxV8QdqxGX/7ebUTtB
	 kSUEVS9QUWkAA==
Date: Wed, 11 Dec 2024 16:40:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>, pablo@netfilter.org, Steffen Klassert
 <steffen.klassert@secunet.com>
Subject: [ANN] net-next winter break shutdown plan
Message-ID: <20241211164022.6a075d3a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

tl;dr net-next will be closed Dec 21st - Jan 1st (incl.)


We plan to close the net-next tree for winter / end of the year
holidays. This will look much like the merge window shutdown,
but entirely self-inflicted. The expectation is that there wouldn't 
be much code posted, anyway, and we want to give maintainers and
reviewers the psychological comfort of knowing that they don't
have to look at the list. This is a third time we're closing 
the tree for end of the year, so hopefully it's not much of 
a surprise :)

We run a quick poll among maintainers and top reviewers for 
the previous release and it suggests that all of us will try to
be completely disconnected from Dec 24th to Jan 1st (incl.).
Almost everyone will also be AFK on the 23rd, so let's extend
the shutdown to the preceding weekend.

Depending on the urgency and volume of fixes we hope to also skip
the PR to Linus on Dec 26th.

As always during net-next closures RFC posting of net-next code
are not be discouraged. But you should probably be overeating 
while pondering the passage of time instead.. :)

