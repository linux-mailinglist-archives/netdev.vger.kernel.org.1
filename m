Return-Path: <netdev+bounces-191976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5119AABE15E
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA557B0693
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0B626D4E3;
	Tue, 20 May 2025 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxS9VcKJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FB2242D85
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760186; cv=none; b=XNJdoXNjOINjMFQCQao3VDNenXGlXmD1Rn4CceB6AUkhzzJKWFIm/dcQ/mhPDq3JqV/x9J9L8vE3aahYWERmFqrVzNtEpkLTRTsNeT7XVA/nGvp1PSP0YIDOgHLXSfroUl+5CGSbQAtfGXTabWu0jQxBJ2Z4xuD+yhsF4QjTRm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760186; c=relaxed/simple;
	bh=9Inz0toezFP4D2gKQJj4Y8KVy6orTwrue0HwMcf9AL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSmQHf/d4xbaE3FUA5c19yHRM/vy5brKxhB09hsAum6swP2O0qPjaz1Mecve7NFRRj4YRJVQjJe2bUHTpcbzkGh1gjn/hB33asM0JoGAzRyCfts7L6T5OzlATpLzMM4XJq5l1Mnvwwgd9Y2PvxSk7NsnoTOXm2rioQuBkxTBRBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxS9VcKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D715C4CEE9;
	Tue, 20 May 2025 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747760185;
	bh=9Inz0toezFP4D2gKQJj4Y8KVy6orTwrue0HwMcf9AL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QxS9VcKJYVuVkrNpA4aE/2FdRjzNECj3RoLhkcQlby7IhIJcfaee4J3aCp4cbHOyK
	 MqADjmEtuRrm/q7lQmnYwc8DUA/9GqXYlVi2tzeEpibVM93ikIKnDr9m7h8SabcxmY
	 r3ySkne1E4IPCiHw662yt3MIwdSmsBUSSfh1YFkOL80K+/15cvuirCOKa/CBC9ZpGY
	 JLfYtRiJWfPNTTrAjK1MnpyDTrLJmrDmudXf5AjSzl3R3UDVcX6LdYgNa9RvxH9PC1
	 FSpuw2BbrzeXvmn3+W001+El2nLjS0xZYw+6SkvTkz3wWtrkaw/g6DIzzhB3GszIO5
	 zGarYCGTuUkOA==
Date: Tue, 20 May 2025 17:56:21 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com,
	linux@armlinux.org.uk, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 1/9] net: txgbe: Remove specified SP type
Message-ID: <20250520165621.GG365796@horms.kernel.org>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
 <4DBB8BAA9740F2E2+20250516093220.6044-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DBB8BAA9740F2E2+20250516093220.6044-2-jiawenwu@trustnetic.com>

On Fri, May 16, 2025 at 05:32:12PM +0800, Jiawen Wu wrote:
> Since AML devices are going to reuse some definitions, remove the "SP"
> qualifier from these definitions.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


