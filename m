Return-Path: <netdev+bounces-170888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77608A4A6EA
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 01:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A403B8F96
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 00:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD9123F37E;
	Sat,  1 Mar 2025 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJ9j82cb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA87317C91
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788399; cv=none; b=h32nXsUcgcOiylYsu4SLGkT5R+AWrvkJlnGlmHtgbj9IHgS08cO2czUL3SEO5i3p4KupjWkdVJulKo54Xs2kNdP1xglIHY3XuaoV+FxDIh8z7eXDaAfYSqa/RalUkaTwXbjcX289GA8NV7ifS4SK/GLU8zi9l/4TtObWLcy5Zc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788399; c=relaxed/simple;
	bh=qOOkXIwQoT0+IvHtFvlSYnfwEnAupBmFaKpoDetkzfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvOskjzST1xiHq8g5ksm6j9z3Gm4gRAaB0tfeDiGQ1GAGszjrzRV9T22MSEyl26QovjdD+3YgVWyeihjU4vjNF3iGMx7hx/jeFP04Sy0dMhqE5rqPfR5hGskZWfezeAprLDJ1/PnDT8/C46pcX7vzELO55q2SyUdgs2gexMSV2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJ9j82cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEF3C4CED6;
	Sat,  1 Mar 2025 00:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740788399;
	bh=qOOkXIwQoT0+IvHtFvlSYnfwEnAupBmFaKpoDetkzfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pJ9j82cbca+4hJ0FtlzYDnjPEJC54xZUxamXeUB9Wb5SfUlXmnitjHdXQWYKt097J
	 xnKxTQcnptl6wiS0brntjAu9MVfNSUnyAJlQGQwkd7dDiA1hmEcpk/9KXtuGk8fGrz
	 XG4kkwiTps/jgbo9eaHWE460VP+bYP6asjBruLE5Z7G0zTNFyP3YAKWV4vfXfgXlPe
	 IN5G8t7sPhEJIEpIJdTYCW1CxuTuXG93rACn1px7uWzV0K0lMJXRI6N+jy/gwoposN
	 sMjjoZABhOq+lgFaBx8Gx4oNajAYPZrZ8F/2P13SVNz8vmBYUuueb7fylsV9EB2bMK
	 du1SktGdAbEWQ==
Date: Fri, 28 Feb 2025 16:19:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: allison.henderson@oracle.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 4/6] net/rds: No shortcut out of RDS_CONN_ERROR
Message-ID: <20250228161958.74a4ead3@kernel.org>
In-Reply-To: <20250227042638.82553-5-allison.henderson@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
	<20250227042638.82553-5-allison.henderson@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 21:26:36 -0700 allison.henderson@oracle.com wrote:
> Fixes:  ("RDS: TCP: fix race windows in send-path quiescence by rds_tcp_accept_one()")

This Fixes tag is missing a hash of the commit

