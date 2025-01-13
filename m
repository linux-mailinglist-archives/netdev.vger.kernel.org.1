Return-Path: <netdev+bounces-157782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDD1A0BA5B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7D27A47BB
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DB423A11E;
	Mon, 13 Jan 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyNBon9P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1FC23A0F3;
	Mon, 13 Jan 2025 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779740; cv=none; b=Irw6/urlhYsEwt+KPbg4QdntlamlOdifhYCO9MhxJVC6bb3Cyl49CTk03uUDky9u9uRwcCwMqmLM9ArMUxeedH/DdCEwPUPEWNaKdV9mOmzKhpvXJcZGO0pVZAgJf1ZkA00hVDw4C6EsSrQQI9LZ2HU8ZRXG8lSbmgSW7v/KswA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779740; c=relaxed/simple;
	bh=k6m+Zjs0JkU/HMbs7jXDMQvbnjou5/iptW1HXs90IJM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=gPu4ddQppVZRAAMcv95FsaLOfs9neR+7mv3NwWhrKZuzMG4giUiLWHqLkhQzyVP9z9APIoyoNS9ZWS8PG8QlWXOF78Dv9rR7VIt68DYg2l5BwcvNiH9swFRg100PfV7NwIpwwoxRRAwM44eMJ6NokTdz1AOY/gb8WImkXGMSNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyNBon9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A434C4CEE3;
	Mon, 13 Jan 2025 14:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736779740;
	bh=k6m+Zjs0JkU/HMbs7jXDMQvbnjou5/iptW1HXs90IJM=;
	h=Date:From:To:Subject:From;
	b=KyNBon9PBWGIref7qR1qGDuUyhVL4bIfhuYQJKAzXa8GUxbTQkVvbwxfemmYIWIUz
	 00MuqDjklxn2KGaD7Yg2IpFge6L77dwXI+8+5lOgGde5LpToEEVm4U4QrC0p0lf5r3
	 Da2s4CssTKkJf4LqsOl6eHzoa8+8HIOweKRmaFxFo8zx6J/3B1UW5/M8AlrOAO24Uy
	 N7B8E8bLAuQYhN/H2sme3Lc0xk83Z5gQbUF/rC7HxpFlDaz4kmiGoW+nKVIfIVmMQK
	 kE0fAki7ja25jODe7qoGwjDTHZsc/dzflGM0ulNBhbmXGJVhXXDXKhEHPTdLDjVmmq
	 FH60uw1ZUOymA==
Date: Mon, 13 Jan 2025 06:48:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: [ANN] netdev call - Jan 14th
Message-ID: <20250113064859.47a99f5e@kernel.org>
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

There's been some progress with Linux Foundation, and I posted
the CI requirement officially downgrading drivers:
https://lore.kernel.org/all/20250111024359.3678956-1-kuba@kernel.org/
So there's a bit of an agenda but please suggest / come with other
topics.

