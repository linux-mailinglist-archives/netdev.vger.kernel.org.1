Return-Path: <netdev+bounces-39251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDF77BE7BA
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 19:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE2A1C2094B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A57C374E3;
	Mon,  9 Oct 2023 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAqxMZSY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1CD18E28
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 17:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609C3C433C8;
	Mon,  9 Oct 2023 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696872151;
	bh=UQzgVmbU7gsr1ATOdxc/X5l7enh5XqJnAd02vTnC8T8=;
	h=Date:From:To:Subject:From;
	b=NAqxMZSYBtoETCeU0j8LO/bQo5P6Hqp1Dxr+w//IrlARApxp/47CZdN7qqX82wIb6
	 CyQHKhcvQzavUan51KJkJ6M0V2yMAaXpkzKEYDsL48isHMXKp1bdkLrP2RMs57218a
	 TIIGVXna+UI5i/oR8+bBiBHJjniIlGUkiFUI+yHCG/iZX5gmk90XXnzhRYlNnKy4lF
	 3WvoDl9rCSJZAInpvDVrN68EY9WKnkJHpBthXj/vPMjHetBH+d6mS1Db3zd2JtT+vs
	 ySAWFi9XOw8vZcuExt8e37+YrMWXLmJZ4G0K/2Zh2w2Mz5js7UeDrsWHQUc1oZp8Bm
	 1meFgtjLL4fPA==
Date: Mon, 9 Oct 2023 10:22:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netconf '23 presentations are available
Message-ID: <20231009102230.6f6a0f25@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

We are returning to the tradition of organizing yearly face-to-face
micro-conference called netconf (not to be confused with netdev.conf).

This year's gathering has been held in Paris (co-located with
Kernel Recipes). Presentations and notes are now available at:
https://netdev.bots.linux.dev/netconf/2023/index.html

Feel free to start threads on the ML if there are any questions
/ follow on discussions. We will also look back at the conference
and the conclusions at tomorrow's netdev VC call (8:30am pacific time)
at https://bbb.lwn.net/b/jak-wkr-seg-hjn

Previous edition took place in 2019 in Boston:
http://vger.kernel.org/netconf2019.html

