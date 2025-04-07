Return-Path: <netdev+bounces-179630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02939A7DE4B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9437A3AB6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F592237173;
	Mon,  7 Apr 2025 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suGAebaG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077FC22F3AB;
	Mon,  7 Apr 2025 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744030445; cv=none; b=cHrf3JDfeRGeQcrtZdVW6XkHJyQNhz7VgQ16u9queuOygTK6jerH8FOqLXiL8YJtol8tY9qqErvPKqV1dLlrUqpLzqCqnvmyTGKmHSlJHv6+8mGl2i0NxhNGdk8uLeGo3VFBJBuDEAfUfenV1WT1llsFby0/gS2zUMlc6NRYxWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744030445; c=relaxed/simple;
	bh=xCGSE9eE/JfuxiFesfCDwxJalrCiHec7hntAQjfsHfw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=G8mD1XYgJHP+oXGjKfnClZBcZe1kofSm7NYnNESlvqIsjci6Ein6hxB9tZZDKYfhlqKUw32FnKaOGafFr1wWI2I4a9OOixYi2YsR9L0xUiGyy3A8xif9VBFR20pixejcsSVICGQss9rgg9oSj5WY+DNJHIQcDseZhuglLCY3rCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suGAebaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E782C4CEDD;
	Mon,  7 Apr 2025 12:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744030444;
	bh=xCGSE9eE/JfuxiFesfCDwxJalrCiHec7hntAQjfsHfw=;
	h=Date:From:To:Subject:From;
	b=suGAebaG6CwCexzeRrxsUBac3bQ7QXMjRkv0P0aX/hVh95iitsuU21BSn8fSLRnrE
	 IAYURu85jcB7gf4ivZr4BDYsjgLB5XPjFrAswun6BHUV4kgDqPRSJVj1bleS193Ll/
	 5ddSU87MrMKBM3RfjqDhLJoIkiu/O2A4ncyNTdxrF1eZwoInH3SWL9SRKH//atoBM7
	 7B6+w+Z+21syRN5bxBlLDdANCZ7s9O2mE9LJjba9BMlE/lM9U9NySvOWxEwItRVv5Y
	 XkmD4aZ2SgB1MSklANlry2U9YGsiHi0XOh+UwgDP93DOq8wrClmhmq06CYcrlzsJvZ
	 I0UMUzGa06nqg==
Date: Mon, 7 Apr 2025 05:54:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: [ANN] net-next is OPEN
Message-ID: <20250407055403.7a8f40df@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Let us begin working on 6.16. net-next is open!

