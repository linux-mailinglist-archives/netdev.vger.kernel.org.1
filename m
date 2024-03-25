Return-Path: <netdev+bounces-81685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D992388ABAE
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DCB1C3E032
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F88F133983;
	Mon, 25 Mar 2024 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVsOZ3Ps"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388CA13328D;
	Mon, 25 Mar 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383836; cv=none; b=ZlBx1mj3HpwuazLNv7+Gz9B5SAzwN5nHHKr3HdVgTAsUvDkLin/f7w5xKZk5gT37BBFbKC9Zyy6WpM6hSQKsRniElfKFwi1sudu4f/wTTYsXSn9PlL6pzvjJr35QA32ENjAStW2Hje2bwn2F7pf1d4Y6qNdWliCi4hPBIxxiC/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383836; c=relaxed/simple;
	bh=Giai7eJzM5YPcIlhS/wnfIUTluX1u+Jkq8oFnKQ/G2E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=aTNIc9p6MFWaaZt+97flaAPBDPZcGAbXaazOr0FblGSghv9KcE3VL+vKQ/3/xeOy/c8nHZ/NdKCPdu3msd2zyYr2qctP1jECIyJj/xs99S3WYupRAFgj1fEw4JQr2/zxeyCLJkMzVnvP4nkLNUiHU3W5gtR7BiUEYUUFzU3hJPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVsOZ3Ps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961E7C433F1;
	Mon, 25 Mar 2024 16:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711383835;
	bh=Giai7eJzM5YPcIlhS/wnfIUTluX1u+Jkq8oFnKQ/G2E=;
	h=Date:From:To:Subject:From;
	b=BVsOZ3Ps7Kiz+gOwQ7VAmozBM5Yajbz/NYOFw0dQ9jWy0JgIwfp7iI2H85yYgj7vP
	 Dy6sHiTT4uqWxK23DhDKPQdPTClJq8/9j6xDQ5bgFqFc5rrkOoMRQU5o1PGfno6/5T
	 0LkprrkzIyMBaK9RqRlbZlS98+RwO99a2wUB9onIIUiMxgtE6AWaRwci1d7LnhA1kL
	 dUUp3bavwiu8bJSfyGUet9v25LRW4VzNl7JoVNZRZbThJf57979EgzHhKrHSbNDVP2
	 4nkB4REoJ6CvK4JUh3w30rxzXKfWQFcbgv4yB/PEqV4dUaYJJJuYui5uRytc8HnSB1
	 xWy5xF2XuL9SQ==
Date: Mon, 25 Mar 2024 09:23:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Mar 26th
Message-ID: <20240325092354.05706557@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
is scheduled tomorrow at 8:30 am (PT) / 4:30 pm (~EU).

We have no items on the agenda, please submit if you have any,
otherwise we'll just have a casual chat..


NOTE! We are already on summer time in the US.
So for for those who switch time at different points
this call will likely be at an unusual hour for you!

