Return-Path: <netdev+bounces-163751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15EEA2B79E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F1A3A55D8
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897F478F58;
	Fri,  7 Feb 2025 01:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTBo0kPL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FD26F31E
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 01:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738890464; cv=none; b=XfZ+YjHiKYYqjGB5A2N9xzTCFCloX1P3ognwlzCpXsJ+82r4hE+ma7PJ3fIvVRjkx8PIrsFWqSpPNmzQ59eA5SzmpXiOj0ggFUnOZ9PecsJyHbMcEmYFNDUkMmGCi/vg0rDFR40/Byzims4evDDhTmjK5aigcVxOQ9M7lHD8GaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738890464; c=relaxed/simple;
	bh=8O5BX3MsP8r9HX6FMJDlEjF9fyjp+t37UuWCwR8bs8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6xShH/a9jh79bot78Nj1DTYpw2TabX30I667gpMxHZxrdmpbbWgmZEzZhJNtyazU8UONqXhgr/lqc4gsa/SYKqm19Y03KNklnpKwUKa43bLRqpkrwQS9vCvIropxsTzV3aeVcPpGuEZ24HwD/zjNphGl04xBaOcYnjgW+Z0/uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTBo0kPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4399CC4CEDD;
	Fri,  7 Feb 2025 01:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738890463;
	bh=8O5BX3MsP8r9HX6FMJDlEjF9fyjp+t37UuWCwR8bs8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JTBo0kPLEUSJNOVcLyxGnlx2wvROKw7e4WgdiD9CgFFV5UCQ0ii/J4VmlavyfY8Mo
	 1w3a023YHmb1XA5HvulkUguLclXoi6j7k2to9rAKA4X5gIflEocFHWirKlK3CJtbA+
	 kTSDyWZYAP9Ib/yr/CyhcSrDSPHuO8G5k4jby0eQ1nFUccFj20G/09dnAOHEOR1BiQ
	 G1VxbXcpC2aym28XnlFx48yTEPWR4XtSHkEYRT/FIpjVHHPeZ8U+PM0NfaWWUDHIaK
	 6IC2Rhk3KBP9ywIspmccROZ5Y7YuVXWzv0g0FxQ38xzAu/dmdqIIy/4R0A+pWRN9/B
	 JWoCEtH7yrFFA==
Date: Thu, 6 Feb 2025 17:07:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
 asml.silence@gmail.com, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, hawk@kernel.org, dsahern@kernel.org,
 almasrymina@google.com, stfomichev@gmail.com, jdamato@fastly.com,
 pctammela@mojatatu.com
Subject: Re: [PATCH net-next v13 00/10] io_uring zero copy rx
Message-ID: <20250206170742.044536a1@kernel.org>
In-Reply-To: <173889003753.1718886.8005844111195907451.git-patchwork-notify@kernel.org>
References: <20250204215622.695511-1-dw@davidwei.uk>
	<173889003753.1718886.8005844111195907451.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Feb 2025 01:00:37 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
> This series was applied to netdev/net-next.git

off of v6.14-rc1 so 71f0dd5a3293d75 should pull in cleanly

