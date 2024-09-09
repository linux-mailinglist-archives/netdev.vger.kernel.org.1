Return-Path: <netdev+bounces-126733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB81D972577
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626791F23B3C
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0865E189B99;
	Mon,  9 Sep 2024 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWo0w4oQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D315612E4A;
	Mon,  9 Sep 2024 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725922307; cv=none; b=JwcGclQP/s49wEVR00dBaNrYQelkc0kCQHmNsYIAqb2seCgN19HwjcEE/+PwXUYXycMGE44BP9q7nhsnZZJOUE+cZkdbavJuPUcTzVPHaaULQlsOd3IQj0aun0LqfJEUJY4nEJR7TRU1gfsXy/L5vzQ1dz0Av4iNRK5V3X14Q/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725922307; c=relaxed/simple;
	bh=J8wOolHPf2gC0P32PkrgfUF88Z3e11iAZ1pbQh79bqs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=XCfHU5maJiI2gDQehswr0dgTBHGDC1dmBjgvgvSyCri/H1flmfMa8OEwOXZ46LPTQDyNrgcVMv/YiZN1Q+163UCS6kFozBNeV2kOlkkJOdueWNQVq7Bo5JvXhCkH2HPNH9S5B8bMB2cihu5xygENFBVETqXt2rB/alB4OG7TxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWo0w4oQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348D4C4CEC5;
	Mon,  9 Sep 2024 22:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725922307;
	bh=J8wOolHPf2gC0P32PkrgfUF88Z3e11iAZ1pbQh79bqs=;
	h=Date:From:To:Subject:From;
	b=SWo0w4oQGa+6rrMnPtxWfx5ihJK3/Bw0U2t87rrSPkOek6LhPF4SVRRDHgV9LS08v
	 c8EfiDC+OSCxe1ye/0ulpMn0L8hXNBJJyrsJo690x5op2+Cj+Bp4B3HUw73TcxoA/w
	 QvpEUcS6wyHFQCQVLqfQ6QzLHB+uCO4BwTzzZK2tUiQg3PzPuH0umqcfjVbQbc8aRE
	 at0OCvX7vDqtl/iYHWYpWtRFLPQ6AquJafwPra/Qs2AW+IVY3/tNIa3s0oKt5Fy0HE
	 KoIM/iDl6Jz0NGoBECQEP7KzX/aQPaumFDmMPOURQUUfawfNPChMTUUWv7Go5tiHcJ
	 Q7rVA100ATXpg==
Date: Mon, 9 Sep 2024 15:51:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Sep 10th
Message-ID: <20240909155146.1c19d5c8@kernel.org>
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
(yes, that is the right link, sorry for sharing old one last time).

No agenda, yet, please propose. I will cancel if nobody replies
with topics on the list.

In terms of review rotation - it's nVidia's week.

