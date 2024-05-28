Return-Path: <netdev+bounces-98749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2F48D2473
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F6D28BDAE
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 19:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7294E2C853;
	Tue, 28 May 2024 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjwWoGpL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1BB15491
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923820; cv=none; b=nc+jp+gh/XcHHXFlzbLikscLIgN2mCC7z4OssnFd7duF1in4Ep8lGDlKnqPMxuEV1VR9NG3Z+LYCMRB7L2NTCwUyoYEltkVvsImv0ItGZqDdwoAboVyQiCzERPeFRxeRAN7hWbT3zGvxBvqiRfva0U+njR89/isXgJBXj132Dyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923820; c=relaxed/simple;
	bh=U7QuO3zXX7GbfWwbA7Ahakee4jNDpsIstX+7UK/Da7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d37ST85aRx2YSk8QldSuLfeNyWSlsI7rHRZlCLipohZ0FBRIlS+ZY33Ab4XX2WvaOlqkGjiVW86fkIDFL6gxXMy1U0Zim3WokpktMfdxZTA0QZcvB+1uJwhblivLxWkOOW2zCbx/VfRVvlu/lnVFa5NBivk8cjrc/rYJjczombw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjwWoGpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4270C3277B;
	Tue, 28 May 2024 19:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716923819;
	bh=U7QuO3zXX7GbfWwbA7Ahakee4jNDpsIstX+7UK/Da7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KjwWoGpLIo/ICcdluPu+5DcAOcibQhD/yoitlw+jzalqrj2UXB97ej7EwjSJ0q9Zw
	 4k/anXZ++f+By6tOpN0IXzuxwywpXPOTqzihSecsfRMqCqNvz6Och1ts3UdHH/1lCr
	 p3EPfWIFRet0j1ry3iqmqotOn/dd780Rvh+6npxle+kh+Ey5Iha3Dq0/oAeoxQFvlF
	 pcC3lWpJ4q+yzXMpjHTmgINCzGoGWPTz8vFYH3zss65Gznyq4KeJ0jT59YUM6rAlez
	 qwQxR/YLrPx5CrXsK+AdpHr1fZOMyezWJjEvjoZyJpm+mgu7WS9lu5s0r/vko683FD
	 6otUFWQmd+Q0g==
Date: Tue, 28 May 2024 12:16:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 jiri@resnulli.us
Subject: Re: [PATCH iwl-net v2] ice: Add support for devlink loopback param.
Message-ID: <20240528121658.0bb99e8e@kernel.org>
In-Reply-To: <20240528110132.483447-1-wojciech.drewek@intel.com>
References: <20240528110132.483447-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 13:01:32 +0200 Wojciech Drewek wrote:
> Subject: [PATCH iwl-net v2] ice: Add support for devlink loopback param.

iwl-next, presumably

Param makes sense, although the name keeps giving me pause.
I expect "loopback" will control either port loopback or something 
like hairpin. Would "local-forwarding" not be a better name?
Not a big deal, I guess.

> +        ``enabled`` - loopback traffic is not allowed on port
> +
> +        ``disabled`` - loopback traffic is allowed on this port

The meaning seems inverted?

