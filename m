Return-Path: <netdev+bounces-86697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D846D89FFE2
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 20:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E84C1F2B5C7
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 18:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E8C8FF;
	Wed, 10 Apr 2024 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahEsiKi6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0229C1CD25;
	Wed, 10 Apr 2024 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774094; cv=none; b=YyLcDOsMcjTjsnvnyWNMg0EH9SAskD0tAl8XNyf9HUehjF1IDmCGf8izJdiUp4T6AwVjQtv1MWkOMegHi4jUpcgf6a7UdVXCG0uWe8UaQ0ZySjivq1nvrPKx9/FsNha7jm4fdTxrlsi1jE8wYK2cdu7ALHdJ2tm2DQtf4YWn+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774094; c=relaxed/simple;
	bh=F61Mkhuy93wl4DonLy9eLfoKURKFPgWtPlD/DWAIyQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvM+z7FvDQ2P+Qoy5RLsVCyl35PkCEOFcU+tRXTP8JtN6/QrYlxwEEBGR4WS1WIGdsZB0Yb0pqAQIeV7gdrPPRdZndIj98KX5HWEJrUAbYpYMThjVSp3pTSAgfK7RqtJ0tAXJsRd4o8piDb9KSMrq7qumXYYFfSr2HdVi5qo7sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahEsiKi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C85C433F1;
	Wed, 10 Apr 2024 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712774093;
	bh=F61Mkhuy93wl4DonLy9eLfoKURKFPgWtPlD/DWAIyQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ahEsiKi6VT15hhK+qifkk+tCVRTzPBViY5FpVnP+isfqwx93MSOkYrhErhinBrU0D
	 JAsx4cbcwfysl4QIg0xJdLmpnYkZy5InggQ2WOgnyJboxjfhP0fFXqacrVXEFC9SAR
	 ukLNciQJRNeeVfSdMt5F1zJe5khuyEHtgH1lM9L+Z6ycGUGpXFIuRA7cIki/rj7Jy0
	 2cF06xyl1uZJVfMlnc8QhRAiIezM0aAqgQWLBU716aFokcjxXboW6fU4baloXI6PWP
	 NsCHhsv7/y+84sGiPLUP1jWAeHV8RcU4AZGDxRnSoa39KnV6VshuTxpNGmZLZXbLGQ
	 L1UJiXCqd9IQw==
Date: Wed, 10 Apr 2024 11:34:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH net-next v2 0/2] mptcp: add last time fields in
 mptcp_info
Message-ID: <20240410113452.56f156f4@kernel.org>
In-Reply-To: <20240410-upstream-net-next-20240405-mptcp-last-time-info-v2-0-f95bd6b33e51@kernel.org>
References: <20240410-upstream-net-next-20240405-mptcp-last-time-info-v2-0-f95bd6b33e51@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 11:48:23 +0200 Matthieu Baerts (NGI0) wrote:
> These patches from Geliang add support for the "last time" field in
> MPTCP Info, and verify that the counters look valid.
> 
> Patch 1 adds these counters: last_data_sent, last_data_recv and
> last_ack_recv. They are available in the MPTCP Info, so exposed via
> getsockopt(MPTCP_INFO) and the Netlink Diag interface.
> 
> Patch 2 adds a test in diag.sh MPTCP selftest, to check that the
> counters have moved by at least 250ms, after having waited twice that
> time.

Hi Mat, is this causing skips in selftests by any chance?

# 07 ....chk last_data_sent                            [SKIP] Feature probably not supported
# 08 ....chk last_data_recv                            [SKIP] Feature probably not supported
# 09 ....chk last_ack_recv                             [SKIP] Feature probably not supported

I'll "hide it" from patchwork for now..
-- 
pw-bot: defer

