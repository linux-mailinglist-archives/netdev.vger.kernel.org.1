Return-Path: <netdev+bounces-142034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD439BD22C
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906B12883AA
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F7117DE06;
	Tue,  5 Nov 2024 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzLyCVyG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3893917CA09;
	Tue,  5 Nov 2024 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823518; cv=none; b=Sb8Etns/NCH8T8nJAssfX7B8G00xEQ6gz67M58uDf2kHHSOy/LQ4k5FaHX2yl4u1shhnMmxfuHc+5+SXKqgeUlRjcWJjxUfmTp/GRFkZs7HKSrtGSRoCun9KrrwVKC6ayfBeCFh9jgUusUj36qz4+0VjvKXi1w9RIzaoYN+pjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823518; c=relaxed/simple;
	bh=9xrCyEJYHaZq8k0OoFI0Shbu0aRQqgodxtF2MeeVWnQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=qAN4XcauVTBq+Ogf5zXAoPR31Rui29LH/AThZ7pnrXCLvxGGAJLiBWQleYfSeg7KHK58QZv7qruq4E4nn7KWp1E6sMNM1582lF/+2O3WNA5b3S0+3l0rJoE1MG2uUFIJthEOWwBWNQVDDvPbmRkKLMCnS68PUmieqoh9mR5wdHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzLyCVyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA417C4CECF;
	Tue,  5 Nov 2024 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730823518;
	bh=9xrCyEJYHaZq8k0OoFI0Shbu0aRQqgodxtF2MeeVWnQ=;
	h=Date:From:To:Subject:From;
	b=kzLyCVyGqh48j39Hbj2IsCPFUPkt+K5czZh/XX8KI+2y1uYVK55keY2/iUemHMicI
	 boEjFisPl16dGEjdrqSfHgWDZOQTHsUK/P+39H1h81uizEtfhbRrjGL+KTiHjcEzmC
	 pn0w0a4QaB5LP9HwRAsmhSrK5d7t4EQvdzvDts+PjLaiBdunyLLASHf7NplUltZf+N
	 3coXvfdDQsIot4l4Ji2myzw2WVN0YuhBHMDgGjVKQqX/JbzxKTr53EUcwf4n6ybpoh
	 VSuLXWQlJWd4ECLj7+pxhLDDWVWfHiX1HIATNdxxJ87aVKRbQNpfAPtXQPFGdeJ55b
	 4bCJfVhZhYPBA==
Date: Tue, 5 Nov 2024 08:18:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Nov 5th
Message-ID: <20241105081836.5619d7ad@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly call is scheduled for today at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

Sorry for late notice, but at least I can unambiguously tell you that
the meeting starts in ~12 min, without worry about daylight saving time :)

Small agenda, we are pondering creating a foundation within LF
to pay for netdev CI.

In terms of review rotation - it's nVidia's week.

