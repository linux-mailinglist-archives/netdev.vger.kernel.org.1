Return-Path: <netdev+bounces-197800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0BFAD9E95
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 19:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48953B06F0
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 17:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321B919F101;
	Sat, 14 Jun 2025 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buKMpWlV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001292E11CB;
	Sat, 14 Jun 2025 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749923199; cv=none; b=gahpxQNk63JqmkAt3aeUsz8HiE2ulvV1mDqn0z83nYhZVl1vb2IvMLFz3H7p2J/mA1rux5Z2+KODTzNxSsUz9V2m630RV3QpfWwzPGsVwcsySpjTGtBett8bn3sIoXftaoskyeALjEKXfppxyHPmz+uViqxfDphy9KRmjMsd8+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749923199; c=relaxed/simple;
	bh=GNkxHeLIntl+XCRb6I3HDnxagoxNOfJiiSN5S334ZUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cM8Mp2a0p12wUtRyUB5BdUJiVFUzlODVu79tZ7nXjTJV4y8oq3YRwAub6EgLGPl2MJtee6l7JKDjprrn2gWbldsPSRWCTin8m6LezrXusnT6oKDz70iBbYBrxrkbCKcmPt+NTV8vwZmFcrIUknxOWkeQ2xRQ3KQi3knsOdcMPEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buKMpWlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FE2C4CEEB;
	Sat, 14 Jun 2025 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749923195;
	bh=GNkxHeLIntl+XCRb6I3HDnxagoxNOfJiiSN5S334ZUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=buKMpWlVBv0WWAPBQj4YiJyF1MkZ+eNPy7wfsA4tvIsrVlTzck5O3tkUqlR/0kKpv
	 av6zi8ufbgOv7GpPLu9YvIde3YZ5iCAqEYPkWTGH0DtlvjgLxGwfg+K+ajB7DX4UX5
	 HBkRLHGc4cZ4YlOHuBbZRyaU7g50Psnqo/IlPwX4lF588Xq7l8av8EyECXsCTlj6Yh
	 TmuSmOuGVvadKQYrTWlrPQqy2X0Ivv77XWZ2CrCP9MVhv8RTXExiduEyaCZPzIC2AI
	 Yr0eRfoMf8lESOlgK2WWkPBMz4VozSY66YaPgr/MyhcsQYaB6JJJZpaF8thsTGTg7F
	 fvIbTzZ5RQUgA==
Date: Sat, 14 Jun 2025 10:46:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, pabeni@redhat.com, linux-doc@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, skhan@linuxfoundation.com
Subject: Re: [PATCH v2 1/2] docs: net: sysctl documentation cleanup
Message-ID: <20250614104629.1b857375@kernel.org>
In-Reply-To: <20250614092542.66138-1-abdelrahmanfekry375@gmail.com>
References: <20250612162954.55843-2-abdelrahmanfekry375@gmail.com>
	<20250614092542.66138-1-abdelrahmanfekry375@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Jun 2025 12:25:42 +0300 Abdelrahman Fekry wrote:
> Changes in v2:
> - Deleted space before colon for consistency
> - Standardized more boolean representation (0/1 with enabled/disabled)

You need to repost the entire series. Make sure you read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
before you do.

