Return-Path: <netdev+bounces-200379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C41AE4BC0
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 19:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45510189D7D7
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E15287519;
	Mon, 23 Jun 2025 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF6AO7DR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4162F24
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699453; cv=none; b=DDHe8Eo4HLrFfPum8fQrwrD5wGoJ7eBoBdPejR/qMh9BoIhADpv9Q2eo/NhU5+DnVzW4uGWzuR4AWs62z5nEmDCbo1xjJighwNKH8GsUUAQacdhBIYrrp3HZBNeGxX9ZmIV5XA/Jd5tlyGUQESKF5nUic5lpjWdx0LNWoy4h/4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699453; c=relaxed/simple;
	bh=zdfAa81yC2XNX1V/L5ZHyeuzBLG33Zcgq9gDONbgX3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfXy/Um0YU1UwQ5KeNycVQRrugl+p/M3v55eEZcXb6puvdh2HoEzMA4hGNzZUEUhupOsFh21y+9O9le0tUSnHqaGUbR1W6unQCjyeHzas9vJ5NUgdO5Zh+JR/nHY+SpGJATuzkVJasHqHqF2i11wzzYRvDdme8Raj4xbo3oWfJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF6AO7DR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C02C4CEEA;
	Mon, 23 Jun 2025 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750699453;
	bh=zdfAa81yC2XNX1V/L5ZHyeuzBLG33Zcgq9gDONbgX3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gF6AO7DR2fWlWAcLJQ34VCPbwOVCbn2dE1VQLhGbpzEqvDzP+mo8xgrjgT0xrj+vF
	 +b5/MRGbSt9QT6OomiGA7/sfXtZMOzALPXchsOWg6FFclckXl9A/uH+GGsJAp1ZqlK
	 E9XktJ7CUHD9xPK8xTOrrUjIAR67Z2CKOdqxBvpKONdY/FyKpU+AROCuvd5x5v1T2n
	 jUqDzmaZ1WoQNjogeGJmTVCSPQZt0z8uTDQ7rt1YbYcI+ep8iqJ0GeLgsP0woRPijj
	 LfAWEgUxkfBujybRoLQhI6QjSfjbFzH0RK7i3rr5gLkz0wIgkenap9Ss1fG2jEnh0N
	 bpS5vDlkqoikA==
Date: Mon, 23 Jun 2025 10:24:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, jdamato@fastly.com,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 0/9] net: ethtool: rss: add notifications
Message-ID: <20250623102412.78c348e0@kernel.org>
In-Reply-To: <20250621171944.2619249-1-kuba@kernel.org>
References: <20250621171944.2619249-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Jun 2025 10:19:35 -0700 Jakub Kicinski wrote:
> Next step on the path to moving RSS config to Netlink. With the
> refactoring of the driver-facing API for ETHTOOL_GRXFH/ETHTOOL_SRXFH
> out of the way we can move on to more interesting work.

I will apply patch 8 from this series already.
Without it pylint generates a ton of warnings for driver tests.

