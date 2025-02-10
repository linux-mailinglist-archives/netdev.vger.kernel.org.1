Return-Path: <netdev+bounces-164918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F5EA2F992
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E821690F2
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1972E253329;
	Mon, 10 Feb 2025 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpzgbsCt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E6424C67D;
	Mon, 10 Feb 2025 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217180; cv=none; b=CUVyvJwUYLA2KwXmnaeioB0Q/K+AUZTUEsKS474+ZOPz9uvffRrBiuwhM3O+goGRthF1Aye3tw/otr7njaV0WrLGX9XSc70B99NeAWgFcJtocxVsP39n+GoUiJEf9nD+ACPntFRRbCHJGdMfMnRThMFXJGw3+d/vFU1Isxy2C1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217180; c=relaxed/simple;
	bh=u3go52+PIMtG/gTRInrarD+s26tZyiao9L8Re2LEBms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tu113AJt9qw4JhXhWmDXcbj6VnR7S73X0RKIydlvnN7igU0AG5vTFn1scI1kNMKl7AJIvYXtWPvlChDgwmqWpLk1vIxRDYsQhLU7BaRTEy3YQ9JTB3XPvLQHWGspWIB5NbWQ8CtLrPiZIfNBBr8xIQefbD6WcFbuZbxX2aB+3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpzgbsCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF588C4CEE4;
	Mon, 10 Feb 2025 19:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739217179;
	bh=u3go52+PIMtG/gTRInrarD+s26tZyiao9L8Re2LEBms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpzgbsCtMxNvC9NoLinpwqESnHcD4q5TuZAn5hDLZF6hUm3E1H54lt/ZTGAWOhmyw
	 Zvw4UMY9JjVsh4M5pHWaWZ9K1NWgSIAKZ9+H6OdAon17Y6mqLiz0ZpKVIYnxxGTP6H
	 rMq1IDzEXVZuO0GrK0nvQpU3bJM8gFMYLSTsRCQWWPBKYxEcdRptiaTyQ9yPs2jw3J
	 LcihPtKLa/Bgf1jDiRao1/Y/B+vXXhry9eEV2B4cjCvWCRbqg1Lf7JiDHEjN8ORImC
	 sGf06Soq324gfSYVK5xOSLF//CP+aDcsC59dS1PvFQp1sb4yvpeoQ17cyIxT4k6Gbg
	 WZgPWaPnMn2cw==
Date: Mon, 10 Feb 2025 19:52:55 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 15/15] mptcp: pm: add local parameter for
 set_flags
Message-ID: <20250210195255.GC554665@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-15-71753ed957de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-15-71753ed957de@kernel.org>

On Fri, Feb 07, 2025 at 02:59:33PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch updates the interfaces set_flags to reduce repetitive
> code, adds a new parameter 'local' for them.
> 
> The local address is parsed in public helper mptcp_pm_nl_set_flags_doit(),
> then pass it to mptcp_pm_nl_set_flags() and mptcp_userspace_pm_set_flags().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


