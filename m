Return-Path: <netdev+bounces-145135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 909D79CD551
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDFB1F222FE
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447CF13AD11;
	Fri, 15 Nov 2024 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHpFN8nq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F260810F2;
	Fri, 15 Nov 2024 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731637292; cv=none; b=SNrYopF7NP4dwJFg3IGoaLIPU5e3KUyC+IVGhK4+n3gHtczEcDFRrkablY5McuE+MWgCIsdlWeEjHB0XR2Evy4iU9hrOqOqHa/LVJjy90Y4maJLB5WOCgr13btBCYyoVhPzvifqZ7/Q1jUNjvw13xqT5llnv3NZX1QHOdwp6xVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731637292; c=relaxed/simple;
	bh=Q8Ybzo1fId6IBFRGK6t66WdQaQjuTFAu8RDFlvU8oD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBLZxeEYnA1b7CHgt4/yehR4vCIj3La2MJXxdsLnri62IVQajQ5TrC2BQxSm4zQmUYabnYqyCqKImOyixA74aHjkPWzJ85uZf0jnDo8/l63+JbXbGHCH7MqH2yFeEYUiMqriGVjI4aTzkkHgecMEyX1uUQUSHaTdrKXFzo5EzzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHpFN8nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8F0C4CECD;
	Fri, 15 Nov 2024 02:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731637291;
	bh=Q8Ybzo1fId6IBFRGK6t66WdQaQjuTFAu8RDFlvU8oD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VHpFN8nqYC6JJlCK4yIe/fqJyowZ6Byk1Lo9qxkQf0fcrAP58M9VCoUo1PotuNYDR
	 pTyafyT3Nrus8GdJHxugAx+A9drmBh30nC01feya6EQYkQ5mwMW7JnX6rZoQF4bV66
	 4gsi0tTs8U5UsCmi122jDnA7FlMRcd+tbucropIGjJcBlT9xUe4L0fu4ku6v6W9bKp
	 8Qqej+eA0T/7MPy9QqetE7DbiQBWgiXU8cUJhWTs+Kc0ThmdW5/Ewtf+VWygWZIqYy
	 EqLswuxRjlC9fs6wfZvqlUPoqJF6gw9nTG3YrGQDhmmNxMQv7+qo55DyZlbuuOY8MA
	 jVySonrl4/aPg==
Date: Thu, 14 Nov 2024 18:21:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <jiang.kun2@zte.com.cn>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <corbet@lwn.net>, <jmaloy@redhat.com>,
 <lucien.xin@gmail.com>, <netdev@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <tu.qiang35@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: Re: [PATCH linux-next] Documentation: ticp: fix formatting issue in
 tipc.rst
Message-ID: <20241114182129.0b24d293@kernel.org>
In-Reply-To: <20241114200611368_vpMExu265JwdZuArEo_D@zte.com.cn>
References: <20241114200611368_vpMExu265JwdZuArEo_D@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 20:06:11 +0800 (CST) jiang.kun2@zte.com.cn wrote:
> Subject: [PATCH linux-next] Documentation: ticp: fix formatting issue in tipc.rst

typo in the subject ticp -> tipc
-- 
pw-bot: cr

