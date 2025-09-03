Return-Path: <netdev+bounces-219592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CADFB422CC
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761E0174E5B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC0F30E848;
	Wed,  3 Sep 2025 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ty5EwT7e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D64D30DEB5;
	Wed,  3 Sep 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908000; cv=none; b=IpCHcDLZqk/fpBtKNXyRCz3SIcn0DlAqiK1D03/PTyZn5Q9WhAFdPFWH0ld1rNV+z/BSWx353CcQ9IIPPH5MICxrmsfoHgOa9SZ9hYb+qTc+Mu/vvjvVSo3K+ApWaprJS9syoWKivfBKVOOPZAaw+uE7UWcSWUoIlDcDJwrToi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908000; c=relaxed/simple;
	bh=x3phQ0k2M6A2obJbF+VgiN23EDWeKgV+7RqkpU1URkI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Du+rFyYtU5Z/cEc9aNhfEpofXdJriJRdgZKd0WqhyCz2UQKOZC/F8ipg06TsUoz9+W7qxN/WAu9CWrW6BGo9Rs9a+fxtFCk9p6MMZ5nUohSVuCBbl9LnhyMYE/c9V0SqC3bRFRYiFhWVHyjOUbl+CghN9Dfkj2Klq877/gUiLqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ty5EwT7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5305C4CEE7;
	Wed,  3 Sep 2025 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756907998;
	bh=x3phQ0k2M6A2obJbF+VgiN23EDWeKgV+7RqkpU1URkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ty5EwT7egmM7Uyf4H5BRwW7LY4oBz32HRF2PFTfOsa2UWEmZQB4AzVeFOsbZGwTD3
	 h414FsK+7apqtXUpu3mF43NUwaCHkskYRWrS4Z0fNMuxyPegoFcpSEz6sqBFPGtijW
	 WBet8Oka8F/YZ1hoIiTB2aj8DhBjccrWJ56u2XLxQKXyf2H9e2xwf2jft9fy9yPZ41
	 0yrKjhjba9sewa9rBff/+HhknaxmqNy0suEjnEDua8iKmLwX3rQlUi0eRC0Qb6ysCp
	 qgRhGSI7n3xjFgz0oN9oAEVknJvTGxvcvPSPFizR4H/bXw50PPdu1amNnQ0XKyBNC5
	 b6rVSiY1rdBgA==
Date: Wed, 3 Sep 2025 06:59:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Harvey <marcharvey@google.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, edumazet@google.com,
 willemb@google.com, maheshb@google.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: Add tests to verify team
 driver option set and get.
Message-ID: <20250903065957.3ebfcb2c@kernel.org>
In-Reply-To: <CANkEMgnghooTAW-VqodTpwSUHicb6fb6c0mBi1vpxPHnSNQccg@mail.gmail.com>
References: <20250902235504.4190036-1-marcharvey@google.com>
	<CANkEMgnghooTAW-VqodTpwSUHicb6fb6c0mBi1vpxPHnSNQccg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Sep 2025 18:01:09 -0700 Marc Harvey wrote:
> I'm aware of the shellcheck errors. Will wait to send v2 tomorrow for
> the 24 hour rule.

This test fails for us, I think you need to also adjust the config
file, please see:

https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style#building-the-kernel

[...]
# Command failed: No such file or directory
# TEST: Get 'fake_option2' fails                                      [ OK ]
# Setting 'mode' to 'activebackup' and 'loadbalance'
# Command failed: Invalid argument
# 'setoption mode activebackup' failed
# Command failed: Invalid argument
# 'setoption mode activebackup' failed
# TEST: Set + Get 'mode' test                                         [FAIL]
# Failed to set 'mode' to 'activebackup'
# Setting 'notify_peers_count' to '0' and '5'
# TEST: Set + Get 'notify_peers_count' test                           [ OK ]
# Setting 'notify_peers_interval' to '0' and '5'
[...]

https://netdev-3.bots.linux.dev/vmksft-bonding/results/281681/11-options-sh/stdout

