Return-Path: <netdev+bounces-110373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EDE92C241
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2FFBB28132
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DB8180054;
	Tue,  9 Jul 2024 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jF5ukqw2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8FC180051;
	Tue,  9 Jul 2024 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543700; cv=none; b=RI55so2EYWByK7ZR+3xDX/FPupcGHyk837jHeu0WwoZ2SFmZZ60xMAvurKKjX/G/H6PtWDAjmwZjWEwSbCSpyi+blCvXf7bUYLW6HGihUsijPPwoywzoRggIOVJ3VQ+tM2k6oiBG49muk4D5KAtLwBD1ZGUercLYk+MnCxtQKqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543700; c=relaxed/simple;
	bh=Bg5aIU3nrdv8r1/DrRyCfIcRAZ2e7bmLQVHhNox83G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDjvKkrvmoQMYueytN0UsyrO0kjg7/s2ZCV5pnncYGU261U0jLKz0TVMAwJ5VKW6u359Z0slWA+ikOIFuBmLk9X7rgv7QiOhpwjDZr/k+9Mzov1F7vLOdftErzCDjWsvIgfv+1Pu09h2xGyZnpWOp7AQl4SZI2dSVViKonkj5wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jF5ukqw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38109C3277B;
	Tue,  9 Jul 2024 16:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720543700;
	bh=Bg5aIU3nrdv8r1/DrRyCfIcRAZ2e7bmLQVHhNox83G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jF5ukqw2nNAxmI7sAAu1/eUfayWmRxPiz6yeFILbpoTYpEd/LsxN40Z9k7+bfiDbo
	 eUS66vdp9AdZG+Z2vl39abJIW42bwQcTULjnU+jP00t7ypDcVmxL2FCX0kSIBZIUPC
	 IhQ4SHqcQzWYd1EJo0M0QK+Glo/6NpJzJvPCCCYIr8YUm7zS5Uj0v+KQcP5Q+YxBtK
	 +Ag1Cio6NrlyrRTnj6F6iIO1saa8gAAOqeCI0+4jQygzvGt/Jxf8SO6up9eCiiisVe
	 JBjMpIq42dyUM2edK0hdYLyocopUXXtuA9IChk53kJzqt3F0+4IjTNkoLvCexfLzVZ
	 qk6zpWrg9g+hg==
Date: Tue, 9 Jul 2024 17:48:15 +0100
From: Simon Horman <horms@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/sched: act_skbmod: convert comma to
 semicolon
Message-ID: <20240709164815.GL346094@kernel.org>
References: <20240709072838.1152880-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709072838.1152880-1-nichen@iscas.ac.cn>

On Tue, Jul 09, 2024 at 03:28:38PM +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Thanks,

This is a good cleanup.

Reviewed-by: Simon Horman <horms@kernel.org>


