Return-Path: <netdev+bounces-222999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD77B5773B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F1A3BA1DB
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004FA2FDC51;
	Mon, 15 Sep 2025 10:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGbIIsyr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06D12FD1D9
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933365; cv=none; b=RCSxEx50A21LmDK1W7fraWZVMIFhVdk7X6cxbYSIQ2HRgjoTXl+W5cxyP6ASfZpW+ncrxT7zTv5eX27NbyAAdAtxq5+UfZ5uA0z+323WzZkXJrSj+KG9Qm6BGmpa/xt2tLgon01FDnYZ2B6970eUF2LohAz4JVf9xI9tAu1YW1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933365; c=relaxed/simple;
	bh=pL84eRmQjdlAF14dc3+Lw+K+PxkN/jnGac3OpDneC5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYB0wNtEGKHFVf8aSNdkYbMqy9tUENY9k7BAZ1VAKPMp8qmQI6Q+lIWdeD7JQZJ7tngGeGqYtCBzgGu/MY6Kq1jPfpriZ2KzsPSIGkvW3vd7TIPxc5lgOTf266pPmo3CbHhLwA/Vfb8P9NfgBUVsHFWiBcJD4yvjpkxDEiPTvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGbIIsyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E745DC4CEF5;
	Mon, 15 Sep 2025 10:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757933365;
	bh=pL84eRmQjdlAF14dc3+Lw+K+PxkN/jnGac3OpDneC5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lGbIIsyrJ8wWF0HDBXbN9nYvy6uoDR6lA1WAgaXXwzOdsve9T/ieZXcqBdeFg6DUd
	 xjQmFK+isyEfI5d7nUYw/1lD63x0Xq7smE21wjecVWyfdv/HlcZbIqWEg9RedxHXoT
	 z3HNjd7ufAdU6PAg/GAw6jVSDzemMkP6vhTBKj3RVO6sODq/ZByNtIzmB+jN/5+hCs
	 zDIJYz5cSNjK1vWkbSVWmDql1uouo/C4OvQbSG7/bhb/n67ul7q8quV6f2R4//BTKi
	 MDlm9ny/xEhxwqHeqdCeVkdDcctymFrP6SQPbfN+kmbVQmnp4VY7zfmeTlTLkpp6VP
	 u2PK8bgwyn3Ew==
Date: Mon, 15 Sep 2025 11:49:20 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: kuniyu@google.com, sdf@fomichev.me, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: rtnetlink: fix typos in comments
Message-ID: <20250915104920.GR224143@horms.kernel.org>
References: <20250913105728.3988422-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913105728.3988422-1-alok.a.tiwari@oracle.com>

On Sat, Sep 13, 2025 at 03:57:26AM -0700, Alok Tiwari wrote:
> - Corrected "rtnl_unregster()" -> "rtnl_unregister()" in the
>  documentation comment of "rtnl_unregister_all()"
> - Fixed typo "bugwards compatibility" -> "backwards compatibility"
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Simon Horman <horms@kernel.org>


