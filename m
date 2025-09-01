Return-Path: <netdev+bounces-218860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68847B3EE06
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB421B20605
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325DB32A823;
	Mon,  1 Sep 2025 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFSEnRvM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E23816132A
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756752286; cv=none; b=F7pFn0wQtUGVkLnFeArMITYhmUVmIw0yk+16Aq/k+spYcERxKO6ZE5QFANuVloibFaMn5r8irFlnKSNwCIsjfs6f1q9pQ8Elix89giC5wA2fpsuche6G909c44r3/uw1sxxODkmFdChE/I1lJ9Wv0NDbeI/+gU+43mD7nWWvwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756752286; c=relaxed/simple;
	bh=RqM/qed3gqcWw2BqsuAjfSdoDvDCV9oahDuBZBJ1rbY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwnzZJkLmFjiQpU/h0frYvMhTaAOMAQWX7e+9MsCM7HxmUXGHubELBRSWQGxwikp5DrCk0G6M7ClY2Gmw1EUTRxmj6wA5JVEkyUcWyAZEYJH1rsO/qK6AhigGRs67W95GbcEs7V8U6NBcvrQ2NFLtKH2WqhLwLYoeAqeeF+/m48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFSEnRvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876BCC4CEF0;
	Mon,  1 Sep 2025 18:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756752285;
	bh=RqM/qed3gqcWw2BqsuAjfSdoDvDCV9oahDuBZBJ1rbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RFSEnRvMQO8coo+QRSwaBKboaf8GaBcb3rWuP2kY7KzxBUeyLCeCKbx18477WjQ6h
	 3Xpx8YMtsYStiJuapF1ZNP5fG+8iT1U6KdDyXzxe26Gb9GgSDsMC9cKIeEAOJfgrzq
	 /dCWIlzEld5jxXgAYRn6bm+xjGtPRgIFHRCA9xHhPidFHoXUWO4OYOsF3ognkMZjjw
	 xeXvWZxA2c6Fzf4zyZlppuGPBkEvQ9sHFWUwdy1fvPQv+Swg5YUfcFgmnKlVxhvX7E
	 9g0YffftV5WV+j11Eyy49544TOK5cPdaBzaWwaQQBNhA68bmvvZJYXSGiLMBBLidw1
	 ojsMk1KcOBr7g==
Date: Mon, 1 Sep 2025 11:44:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org
Subject: Re: [PATCH] net: export symnbol for skb_attempt_defer_free
Message-ID: <20250901114444.37c53a6a@kernel.org>
In-Reply-To: <20250901181623.5571-1-ouster@cs.stanford.edu>
References: <20250901181623.5571-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 11:16:23 -0700 John Ousterhout wrote:
> This function is useful for modules such as Homa but is not
> currently visible.

It has to be part of the series which contains an in tree user.
We only export symbols for in-tree modules.
-- 
pw-bot: cr

