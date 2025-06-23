Return-Path: <netdev+bounces-200384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ED0AE4C19
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 19:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1463AD53E
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF872D3204;
	Mon, 23 Jun 2025 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsIaowWc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440E2D23BF;
	Mon, 23 Jun 2025 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750700730; cv=none; b=CVVyqLpaLBsu6MHAeNOA6M2+C/UBJN2wz78/xCl0buQhiu1zCEEigsZCrimKiO8TQ17Q7rBQgemKBFhMmmNaAxXd4bPRBg3vwWIUZb5u6dscawqnecO1GwZz8bKmxM6OZ5r5fIY5zpnwl6NvgGpj+zxKZYjRQMlhH7mcUS6n2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750700730; c=relaxed/simple;
	bh=z+mTHekPicguApDc91NjslffEi7PoMbr2YzcPmjuxA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=smtag5vZq1Q9iXgsDnuEaTo9bmn6N0tq96rFfl6iD4Vkp08qNz2Si2tnpXHGqsHjenwMwYfio1qfGFhIiYka1b6TApAlZFZr/KJ8vpD3nniwIa0YrqWS77W8ufKo4IqpJ2w8mszkcFs8guINTK6pIJpCDIORhYo87L7I0ZLZKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsIaowWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D49EC4CEEA;
	Mon, 23 Jun 2025 17:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750700729;
	bh=z+mTHekPicguApDc91NjslffEi7PoMbr2YzcPmjuxA8=;
	h=Date:From:To:Cc:Subject:From;
	b=MsIaowWc5mfT8EzmdTiyIcuqDxMf4f9UUiX9+sTPPpy0rmBl6rF5vHZyEztGPIqYE
	 ngSG3hrgz6za4M/iOYnMhSWHpKGH+Dn+9D2NtvTq/XX/lFIygzH4Ec4LqXoDgD0RUy
	 jWxPmHipZ5A0Rqrep0fHxNHobfQaI6HwsqPaEV7+yrnckx1eix6jIUlA0WMNDGqTNp
	 8JvYgUyH2RiDMdAFl/s9OY9VetThsa/2ydKqTHVGb6JPQbRb66bke6I+cykytxpgKx
	 Ho8gX4ls2fJOkn5hVU93uhYdF+Zt3Xg0A3xJanTNaizN1UE9FngTsrTDJt8Wysb3pe
	 o/ZQW+gcJmPOw==
Date: Mon, 23 Jun 2025 10:45:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
Subject: [ANN] development stats for time periods
Message-ID: <20250623104528.74ce41da@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The first half of 2025 is coming to a close and I suspect some
companies are working through employee performance reviews.

Our development stats are are bit awkward to use for performance
reviews because release cycles don't align with 6mo or 12mo windows.
I added a cron job to generate the development stats each weekend
for the last X months:
https://netdev.bots.linux.dev/static/nipa/stats-1mo/
https://netdev.bots.linux.dev/static/nipa/stats-3mo/
https://netdev.bots.linux.dev/static/nipa/stats-6mo/
https://netdev.bots.linux.dev/static/nipa/stats-12mo/
This should hopefully make it easier to claim credit for upstream work.

HTH

