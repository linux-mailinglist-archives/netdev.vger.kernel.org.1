Return-Path: <netdev+bounces-225349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6326EB927C3
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C071904BEE
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED00315D5A;
	Mon, 22 Sep 2025 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUkfEHjl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F911991CA;
	Mon, 22 Sep 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563673; cv=none; b=teGHXJYx2gs+Ccor7PwfRh05StthmwrFyPClZBkMYqiFSFtBedvGMShtYQf2yWvfDvY22TYN83/Vxys4sM6MaZCbkS3W1lunXKTYPk/mAcouHL8fU+OAJpkrbX5deMFKn6X3KP6vlcmfUv68KZnKcw6nqqEr3Nnla1LjB+TQ9H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563673; c=relaxed/simple;
	bh=J1MwtVp5jXRKRwKBsk/a5nbUIUOcP5J0L/DzRHadM/0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Xhzpp+gdBX+mtiA2BMbj57BknH3CtYOU/wHsYja0yR8Hc6TYTl21PREFWIJAXYqSolqP4Zl9qs8culEiuXwrgh/yWAHQjdo6qvCFZm9fOO9gY4CSIni2cH9QJ6AY8kAwQmfsg4fkLqcA9P2e1PBi++YmwmeyIvlasns7dMhV/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUkfEHjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FE3C4CEF0;
	Mon, 22 Sep 2025 17:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758563672;
	bh=J1MwtVp5jXRKRwKBsk/a5nbUIUOcP5J0L/DzRHadM/0=;
	h=Date:From:To:Subject:From;
	b=tUkfEHjl3VqrjsNJgFHAZEUZapoeIF4MOxXfhbAf2eoBSx7uxt+xUTJmRae6UsO1i
	 QW2KwpGbcoxiUgH30yAgFSRvCeiFdIj5TTL8Qttgt/p0TbN5w8S7MAfjP/wtgqgIyX
	 y/xI4pRgCG7HsJoqsevIrA1H/u5OLH+hu+kwwREyzvbqgHbOz8oScQPLsa/ZC61lE9
	 cTHtYx0RNg2PeEaCDcWP0z2zkTBLoFEbzfCWvH5yNTOmXME7DcJnaW1t5Q2SmkyyZb
	 DIkBoWLvSO9E81aTmnXuPrWE4c35hLTDInGRCuLyu4foyGCZUqFCwfLyKGQVprfTUO
	 I5upwtkPzetTw==
Date: Mon, 22 Sep 2025 10:54:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Sep 23rd
Message-ID: <20250922105431.0389a849@kernel.org>
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

No agenda at this stage. Please reply with suggestions, if no topics
are proposed 2h before the meeting we'll cancel.

