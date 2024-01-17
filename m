Return-Path: <netdev+bounces-64073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B055830F2C
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 23:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FED7B21ECE
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 22:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0717626AC2;
	Wed, 17 Jan 2024 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odyWtMxy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11A428DA0;
	Wed, 17 Jan 2024 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705530384; cv=none; b=PmwHpSnRWNa1PwHVenNn8CBD4IXnxAyYxePwSsfiEjhNAOyJz4Wi7gevZeZz2bAb4RlGAglHAd/52i+jI7DTaPoaa4a7c5y1f0BW4r9lIIdB5MCd6vtR9MFIMyvHCNg8agkyLyT/2tBQGPYQ7EIBdR8uTDe3UZOdBn5nhx8xB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705530384; c=relaxed/simple;
	bh=NpjprDlVTp5Ad9ZgTUCJJeY7aVwl59Frnx1rlrCdCOU=;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=qT6I8uQIj9u6sWDIc+ukSmcSoriHSmm3fsCJ8o6iloomQrUdhCbDqyTk3m6Sa94Uq51iCtlxVcXX6C5+l71dm32QsUjslXNYeRRZW7uAYyBC5jJugez/O9GS1URSIPlc0KwVoiKwXPrIaX7e2BUio5mQcTV81kWxxxmHsvMgmYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odyWtMxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6425EC433B1;
	Wed, 17 Jan 2024 22:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705530384;
	bh=NpjprDlVTp5Ad9ZgTUCJJeY7aVwl59Frnx1rlrCdCOU=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=odyWtMxyjZylPamwqgW8hXQ9IppxeIBP7aQUMFFiyNHKB0/DPCqpQrxyrqf0/8dOz
	 J55SSUlexZCdixuMWafxbIfhmG9lsTr01ECss9/oXJ5IxzLZb801CsSxbE+TcJxi1Y
	 QmwfZMKNqf3hnqLszIyVoaPL73Fv7RglUv/O76+u0ZSfM3c3cNmIZwA7sGKWZJqPnw
	 ZU4ftQy33jT4RCSKhXLQ9v5dTeV6Ky4gic3Zz7CDNDKn5zxyvTJrZu8F/DfckN/CvE
	 AYEtcIrUCpUMZnkwEeYdD1mbrXxL1Hk6nfkGq6HXyh/xKvqBp0SFyEPRJKmbOWhOF2
	 89xyS3n6OOaSA==
Date: Wed, 17 Jan 2024 14:26:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Jan 16th
Message-ID: <20240117142623.1cce7adf@kernel.org>
In-Reply-To: <20240115175440.09839b84@kernel.org>
References: <20240115175440.09839b84@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jan 2024 17:54:40 -0800 Jakub Kicinski wrote:
> The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
> is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).
>=20
> There's a minor CI update. Please suggest other topics.

Sorry about the delay in sending minutes, here they are:

* BQL (Dave Taht)
  * Embedded drivers missing BQL
    * Complain to the driver maintainers
    * Driver review time is best to request basic features like BQL
    * Some of the problems are in the vendor downstream drivers
  * Are vendors running flent and other latency tests?
    * Jesse: yes, although they struggle at DC speeds
  * Multi-queue BQL
    * Not much interest among attendees
    * Andrew: try to keep it in the core, fewer driver changes the better
 * CI
   * Most of the networking selftests are now run on pending patches
     * https://netdev.bots.linux.dev/status.html
   * Not reporting back to patchwork, yet, because there=E2=80=99s a bunch =
of
     pre-existing failures
   * Paolo: we should extend the tests with mptcp tests
   * DSA tests may also be useful - Andrew to investigate if they can run i=
n SW
   * We=E2=80=99re looking to integrate with other people running tests the=
mselves


Unrelated to the call, but we have also posted a "2023 netdev
retrospective": https://people.kernel.org/kuba/netdev-in-2023

