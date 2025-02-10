Return-Path: <netdev+bounces-164914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AC8A2F98F
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5053A8ED9
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FA125C71B;
	Mon, 10 Feb 2025 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiDjqJPA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5730525C70F;
	Mon, 10 Feb 2025 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217127; cv=none; b=P0IgXUR4Inx2Kdi87sh7vGM/DrBN7S0G/4xC4X7kbwMx7NK40jqxVBnAUYFp8AfRCBjZUp8UDOwL5mXxnRvsVbclVoLuDGp+2aVdomYRPDDSeywRUy8WnfBw0xjDhcp9LxklLps/1hpRZI20k8T214xytS7neWwmUuYbOX6beJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217127; c=relaxed/simple;
	bh=gJTpmetGvIHULHei/NjaWKEQvG1i37jDKMRV15eWP/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRq0ZTpGOP2TqiABx9JlI/C6tj1oWip/N2qdXbEx0gH3slnwkWCjBrzyPz+xJ6jVBka7Brr2V6EoFmPIs3rWoUZL1kWxTlMoCki8RUC9NJ84pKKUfdIWJ8urYkBXMVX7ji/WxEbbNdiV19nko2E+6YoA3Gpr3eV5r9Lfj9FmjMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiDjqJPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84C2C4CED1;
	Mon, 10 Feb 2025 19:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739217126;
	bh=gJTpmetGvIHULHei/NjaWKEQvG1i37jDKMRV15eWP/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiDjqJPAsBd2B5NxTNeMdzFlrfnvO9r9r7B0svjJJ+cNpNLqCa5WW1ZnKdgHporzB
	 d0FIo9hgh0IZ+y511i0VLrQdw1P7qEJjv7o4ieqHh4Zx1wfg28C4p3kpwF6Ds+CWKI
	 8eT29mlXwH5I6/YYRUNt9jbk3Df7uuXy027hsm27wlMX1sHDosoUw184YYCcQ/0aRR
	 spQQBL/KbfNxZrwTDUq9w0n3nWG5v/5Yg5sxtfIyGqwoTMQMEnWnz+O5Pd5f+0orjv
	 U8MqFOE+xeFDEVJkHo+iyvl8o6cvTWqB+PyVyIVBgDCNNkXeUnXQAHGbxrCz4tg2WP
	 SBO6pidqG4iTQ==
Date: Mon, 10 Feb 2025 19:52:02 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 11/15] mptcp: pm: add id parameter for
 get_addr
Message-ID: <20250210195202.GY554665@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-11-71753ed957de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-11-71753ed957de@kernel.org>

On Fri, Feb 07, 2025 at 02:59:29PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The address id is parsed both in mptcp_pm_nl_get_addr() and
> mptcp_userspace_pm_get_addr(), this makes the code somewhat repetitive.
> 
> So this patch adds a new parameter 'id' for all get_addr() interfaces.
> The address id is only parsed in mptcp_pm_nl_get_addr_doit(), then pass
> it to both mptcp_pm_nl_get_addr() and mptcp_userspace_pm_get_addr().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


