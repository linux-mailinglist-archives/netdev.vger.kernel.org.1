Return-Path: <netdev+bounces-180248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5A7A80CA4
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60BD87ACD9A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC8E18E743;
	Tue,  8 Apr 2025 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StVc2n4G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C418DF6D;
	Tue,  8 Apr 2025 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119738; cv=none; b=T1DUZgwM3NozW7k0MtlYmwRWxddegtf6nxV0SN/BvIxJ1PdJT/zCuD0cUWYPmF03m/cUgdbl8c6UFCPmRSilQQuvmGaPR8V495W2Aphcy/0iVFWzg03egh2WA+NAMqW2p6UdWJBnFx3E9F5fANv2diyRkhpKDWNIE22eOQVgCpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119738; c=relaxed/simple;
	bh=UnXIF6kfuqCfXwaiDcPOgSms0qu9xU/EtXMNf6PeAPA=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A15Uy5IDwrI3PQ9lVmYGQUQaUgvpaFDikDLYpP3do6iAvZrGJ5ppRL0yyLK1uvplifKEReeGCyrmOXqfhlDnNirBRjUPn/iHNDELVlW3P4TlVEBoxOPQsflQ18x5yuXEF/JtXs5WDNcJ2x4sNXV0W8oCoU7D1hM/sLLi2KfdZWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StVc2n4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794A9C4CEEA;
	Tue,  8 Apr 2025 13:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744119737;
	bh=UnXIF6kfuqCfXwaiDcPOgSms0qu9xU/EtXMNf6PeAPA=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=StVc2n4G0t2s2XM6Sa4bsBqqqDyPOzDs9pHwGii4FyfUO5v2nRuoAoGqzMJ1GaXzW
	 wjJiLBSS01kPWzx40dX1LIEFAHrD5uarnd1DopFhVV8mx3R7Yl6HXU5pcs8/s6MczM
	 c7sJRDZJbS5TQ/noUk5LK6vKlOOciBrdZ1OWxvjvjrtwTXlpoJRlZoNAjf/AZsXGGH
	 jModnE1J6R/tdZ0mAoLKpvQTLr3EvPdUtbd3z3BuGl5D3tVHdn4fegT0vQZ172IPkW
	 +jAWz475HpsB7IGFJnwfzqXVTImhUP0CvceET57oXI4GPhVsOIb3EWTYxQvsXMQcl7
	 doFvyovqRO9dQ==
Date: Tue, 8 Apr 2025 06:42:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Apr 8th
Message-ID: <20250408064216.77569104@kernel.org>
In-Reply-To: <20250407071523.216102e5@kernel.org>
References: <20250407071523.216102e5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 07:15:23 -0700 Jakub Kicinski wrote:
> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
> 
> I'm not aware of any topics so please share some, if nobody
> does we'll cancel.

No topics, canceling.

