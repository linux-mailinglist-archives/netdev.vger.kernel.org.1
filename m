Return-Path: <netdev+bounces-165309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D914A3188F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 23:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074851888964
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DE2268FE4;
	Tue, 11 Feb 2025 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYs4ybNN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7F1B4243
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312606; cv=none; b=NHSr00VUosvp7cs7u44p8Nw551N++dWKqwwFIO1qlQeqlbMhOc0tqbesmTBgYbA+oujcndyp6n4xxwp4KZN71j3UI3l8M0zQRi3oUdj19mc1h3jY4VGotNGUbMbmkLJbye3BLk5+UzXfcCdosC/iZ0i2N/iXfsvNG1i1soz5yXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312606; c=relaxed/simple;
	bh=knHbM6BAs4OhGh9i9DJ7336a7/wrGiFUym+2BPkyS58=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=jY0HXQyhCAZNRlQBleLtOYRr8gEOb3lEeskkllbqVK7uaGmFyN5nRotSt7AiRKPVDB0HUZ9UOSZw+PNVN2jQj48CKBbcu2TANIJOeI4LXvYWEzx6CbbTIxqxzCFjLcH/hZZKnWp1ShJ7NW5waBbPmVGiKA9iI6yEt7YRC8eWMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYs4ybNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E773C4CEDD
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 22:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739312606;
	bh=knHbM6BAs4OhGh9i9DJ7336a7/wrGiFUym+2BPkyS58=;
	h=Date:From:To:Subject:From;
	b=lYs4ybNNsLKQ6OZmMTMCSipWIvwxcv1NG9eMtxCUSEtfF7SKaHsno68Y6SOpU1pQe
	 R8u9jmi67nxf4xYLsvdopSRSXJ10M03h3TohLyxzJPYk68f1p7b5BXSKDOb7azdS3q
	 tzL3hgd8G/a5ywq9BKsX1RtmG0EdwFbqLxDF0zrvldTVNBB5kYiBkBq0rBSYCj/qvu
	 i0ON5vbCPNcQfzr2Cnwjv7GJrfxbsxk9Y3x3m/0uaKOAvyyKxLtoPQ8Drb3GZRjfpj
	 YWYpLnQJbvb/La+8ZtiqyFQyLOH8X6DCKq10oowcBtgX4Do3VWwCZF0vzOnJx1qNq7
	 jeE3W4y2Ef1Gg==
Date: Tue, 11 Feb 2025 14:23:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [ANN] lore and patchwork problems
Message-ID: <20250211142325.3c882133@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

There were issues yesterday and today with lore and patchwork.
Please keep an eye out for things missed by maintainers,
also we may need to ask for some patches to be reposted :(

