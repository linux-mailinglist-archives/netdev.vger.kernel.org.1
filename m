Return-Path: <netdev+bounces-161190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92B1A1DD35
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 21:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543601645A1
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 20:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7268D193079;
	Mon, 27 Jan 2025 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeFx3ca3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC94191F74
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738008780; cv=none; b=CIwasUet5jdsTpUb2u0gc1s89s2OKpyrscioj9AkxxURkwmE2yAibEMDXQNhKhAccJXm6aJ5PM57nt2FY7+6y8SDO8RuFutMd34dRuWMPKob9N+ibTM7RWKn7KJ1Vft3O8oV4+UNCHj3zNvzpGXIxsKSaO/62w93Bjw6oSisXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738008780; c=relaxed/simple;
	bh=yjvHBTJLKo9QN1LVPfFVutMfT1TdgTmsJaAXHzX8jZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxvirW+9kn5z6pCqYJyHYuIcnWFWJ1jUFrGDRXfa8fkL/wsyWdzE3AZikCNktdSih855yNZTK2JjXanpEgp+mVxMG97gIdc/WKY/PmQSScyJDI7RGEYnnrJtnLOyaHByE1L2JHTmk84PgzUSlZIYKr9Wn2wu6okw//Uo/ufopfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeFx3ca3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F946C4CED2;
	Mon, 27 Jan 2025 20:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738008779;
	bh=yjvHBTJLKo9QN1LVPfFVutMfT1TdgTmsJaAXHzX8jZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LeFx3ca3ui450Uv6e9qht6OUb6kxZmErmcoLyOLytvcKV3vMPgdbqOX/2Gy/lMidc
	 mW23lNsNwYBkeIjT+1QweETfyqRgsvyKCFgPUiyUNSKKJZ9KCp7oH6zyDVoejWnX1o
	 v/eF5oCkobXn6zqeOoWjLARt9SP16XiQI7VP4fcEJvdwiViqIxT0HeWEMIfBqX33qY
	 trQMzy0v64R2hq3fRFGPAhi34+TfZ6rt6Yb2lv9HO1OcwxNsYhPngdSk4NO7vVfouu
	 attkXR44pCc0wYYkxKZLXWa+n6fDz3UiBOW21+ac65Tor65Tb5UcswDw3kh1ILS5K5
	 zTkhwk2iq+jUA==
Date: Mon, 27 Jan 2025 12:12:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <mkubecek@suse.cz>, <matt@traverse.com.au>,
 <daniel.zahka@gmail.com>, <amcohen@nvidia.com>,
 <nbu-mlxsw@exchange.nvidia.com>
Subject: Re: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Message-ID: <20250127121258.63f79e53@kernel.org>
In-Reply-To: <20250126115635.801935-9-danieller@nvidia.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
	<20250126115635.801935-9-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jan 2025 13:56:29 +0200 Danielle Ratson wrote:
>        "tx_loss_of_signal": "None",
>         "rx_loss_of_lock": "None",
>         "tx_loss_of_lock": "None",
>         "tx_fault": "None",

Why "None" in this case rather than true/false/null ?

>         "module_state": 3,
>         "module_state_description": "ModuleReady",
>         "low_pwr_allow_request_hw": false,
>         "low_pwr_request_sw": false,
>         "module_temperature": 36.8203,
>         "module_temperature_units": "degrees C",
>         "module_voltage": 3.3385,
>         "module_voltage_units": "V",
>         "laser_tx_bias_current": [
> 0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000 ],
>         "laser_tx_bias_current_units": "mA",

How do you think about the units?
If they may differ module to module - should we aim to normalize those?

