Return-Path: <netdev+bounces-65514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C6783AE51
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B3CB2464D
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0349C7E577;
	Wed, 24 Jan 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6Ev6Cdi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6287E573;
	Wed, 24 Jan 2024 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113160; cv=none; b=W+YuHWsQsvMRbG3bxi3qp5RQ4UrJQjKrPQUvjyA9z+12r/ZK3wSRF9WcBf4DjTTSZI9OB3H+Z8IgilkFh7otBgn4d5Y4SSrp2tsLmGLd23IMPZDTxUdU/SR1/20AXD9QfMq1Z73UhEbNztaTckdyWBRulKRsT/6vetn630i0ayk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113160; c=relaxed/simple;
	bh=gc+NrWMHXCG+6oKZe/uTe/iqwIbCrNkTpI7nWx8PfKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcoK2G02xOIbSJGj6fLGaETcQGz8vcxN0sOSjOa3DoPRmClhAVIQh7UHFK2zLoo2tpmecMkwiW8XNzKYHasvnRWeo6kHbnSNU2YYQzxT/HPAx1mZNYj3kIRUksQp3AVyRFD3i8wZ1lZs9a9KDakUkNiCcdheNiz8Rsm7C/bSEE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6Ev6Cdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346D2C433C7;
	Wed, 24 Jan 2024 16:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706113160;
	bh=gc+NrWMHXCG+6oKZe/uTe/iqwIbCrNkTpI7nWx8PfKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t6Ev6CdifbR156NPdZ75QfErxr+QN1U6XCbvioy3Q+NfC+AoESTRhuZgkZ5xZNSNs
	 FwdO+zt6wtYlBHN4VIsFURqSdgz9wfpvMm7PKuj/ffFsKteOUJKJNJdSd90HXtv+w2
	 +qkElXQeRQBSvQOc9GZyYa9PumwdDtclSdIUc5ZYGXgxNh5XPm/FESArCl5ZF67ha8
	 jX3krpb8+/ktTAj7U9hyEfAFMJk88M6U+RAMmM59qWfjzw5p+bKcTuVGoqlUNxt6FP
	 WEGTYDDmTDAC9HZiq6+3ZMjvVOQojKcNrWVaL40bB6uqqexntEEMZNLVqx/dkky8J1
	 yureIiXv8M2sw==
Date: Wed, 24 Jan 2024 08:19:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>,
 "netdev@vger.kernel.org"  <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org" 
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <20240124081919.4c79a07e@kernel.org>
In-Reply-To: <20240124070755.1c8ef2a4@kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org>
	<Za98C_rCH8iO_yaK@Laptop-X1>
	<20240123072010.7be8fb83@kernel.org>
	<d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
	<20240123133925.4b8babdc@kernel.org>
	<256ae085-bf8f-419b-bcea-8cdce1b64dce@kernel.org>
	<7ae6317ee2797c659e2f14b336554a9e5694858e.camel@redhat.com>
	<20240124070755.1c8ef2a4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 07:07:55 -0800 Jakub Kicinski wrote:
> David, I applied your diff locally, hopefully I did it in time for the
> 7am Pacific run to have it included :)

This is the latest run:

https://netdev-2.bots.linux.dev/vmksft-net-mp/results/435141/1-fcnal-test-sh/stdout

the nettest warning is indeed gone, but the failures are the same:

$ grep FAIL stdout 
# TEST: ping local, VRF bind - VRF IP                                           [FAIL]
# TEST: ping local, device bind - ns-A IP                                       [FAIL]
# TEST: ping local, VRF bind - VRF IP                                           [FAIL]
# TEST: ping local, device bind - ns-A IP                                       [FAIL]

:(

