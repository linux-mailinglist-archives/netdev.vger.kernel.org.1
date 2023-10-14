Return-Path: <netdev+bounces-40930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4E77C91EC
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CBD1C208F5
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F47637;
	Sat, 14 Oct 2023 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfDz+aq9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C6E7E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3CDC433C8;
	Sat, 14 Oct 2023 00:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697245009;
	bh=Ewf/8EEk1h51YC9lBfBTBd+oxdXqQNWCHaPAPkk3Ipg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OfDz+aq9l3+JccEPQHLQwaW8hfd0qB9Lcg7Uc+nMaVPdLQxjneBaFwMdwAk4Sziuy
	 x0tn6Um/EKSoaIYx6ZZ6z/y/OanBavAkkgIEktNCR3s+0gHLnrJQqUgN3hI+pmjKPr
	 MYr8e88kwV5VIM6Vxi8VTa0S35dHKjis8HbMhB/mwdJiC1VuNIjCLX8SEb5SMtwEZ6
	 t5xWUzeiEMc8mubqMnZpBYKGI5Ag2KieKCLEbrMFPHR6i+/mpfdehEIfjP82Z/RVoZ
	 RjAzS3ShhCP9Ppco15Gs/ze/jeoJJ5Q0OenWC8VXCT4q/FAoMMakouLtWanhSencTk
	 jygVmBdQscCQQ==
Date: Fri, 13 Oct 2023 17:56:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2023-10-11 (i40e, ice)
Message-ID: <20231013175647.323c0394@kernel.org>
In-Reply-To: <20231011233334.336092-1-jacob.e.keller@intel.com>
References: <20231011233334.336092-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 16:33:31 -0700 Jacob Keller wrote:
> The following are changes since commit a950a5921db450c74212327f69950ff03419483a:
>   net/smc: Fix pos miscalculation in statistics
> 
> I'm covering for Tony Nguyen while he's out, and don't have access to create
> a pull request branch on his net-queue, so these are sent via mail only.

No worries, next time do fix the subject not to say "pull request", tho;)

