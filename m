Return-Path: <netdev+bounces-173962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74797A5CA38
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF5018967D2
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6B125E805;
	Tue, 11 Mar 2025 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT/G00r9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA48410E5
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709113; cv=none; b=pZFVyX36ZijJWIYa4fVd1IBs7jgZ3jhKp7yjNoFsF6yc8MiyPPz3BZ7HKQMSokB282FEb3fB3R05K+iQ29Xd7yZucEU4g1EXpNRawRBlpVGeR8RAABtB10CPIG6Sgqiz00wi84p6jffzI6NvH6A8KTkJRFvQK7Hsa8NoPlIkxNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709113; c=relaxed/simple;
	bh=ZVoVSy1oTCxFOfAYb+1oiETcC0Nkz0FK5s0B24sq29s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gB6/irE+uazcq4c6uKoPKWu6o6oX2xbYCr/vbrU0HbK/xVMe4XhNqWOUsUIos4DLJJoBq3vRC1zUnSk5Qq7QoEICPoZt/cH1T/f6ZtGMW5G7SptBrKPexOsYSSm/C7ljhicgVFa6IzaAXwzsNiSkZwz1p2LlDhTrdA+DDN+4dio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT/G00r9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBF9C4CEE9;
	Tue, 11 Mar 2025 16:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741709112;
	bh=ZVoVSy1oTCxFOfAYb+1oiETcC0Nkz0FK5s0B24sq29s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sT/G00r9ioSNzB6T7JOx1gjzYQhNWlNOlJ2FAZ1rIn8tKJ5unNmfazqDSjs9/vIHE
	 1Fq9psL515XnsLHjpkoSbasty5fUOrDsSXklJumJ8QzkIXL7AA5lZAEVS3oapljIka
	 dQykZiQzCi0Suk2gT76D7ZPpHQyZKHGg+QIQ5Hb2rDcR4wQktw6ENxfiP1J1SjwWtX
	 UrLeBXj7m5dRm7lb5SOdpdXEGDDxBhaMTl++5idxmxWhekyg4mgKfV+UMY3yPQ4RAd
	 wEt2FSKDeTKG4tNqDuHCs8lRS+6r6AjWP5k/Q/9tty6t2K9lQB0Qod2orlcmy/o67G
	 iTv90no6V+8TA==
Date: Tue, 11 Mar 2025 17:05:07 +0100
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	mincho@theori.io
Subject: Re: [Patch net 2/2] selftests/tc-testing: Add a test case for DRR
 class with TC_H_ROOT
Message-ID: <20250311160507.GQ4159220@kernel.org>
References: <20250306232355.93864-1-xiyou.wangcong@gmail.com>
 <20250306232355.93864-3-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306232355.93864-3-xiyou.wangcong@gmail.com>

On Thu, Mar 06, 2025 at 03:23:55PM -0800, Cong Wang wrote:
> Integrate the reproduer from Mingi to TDC.
> 
> All test results:
> 
> 1..4
> ok 1 0385 - Create DRR with default setting
> ok 2 2375 - Delete DRR with handle
> ok 3 3092 - Show DRR class
> ok 4 4009 - Reject creation of DRR class with classid TC_H_ROOT
> 
> Cc: Mingi Cho <mincho@theori.io>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


