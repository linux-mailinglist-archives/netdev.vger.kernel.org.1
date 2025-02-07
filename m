Return-Path: <netdev+bounces-163741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE7AA2B751
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66DBE3A5F61
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0A31799F;
	Fri,  7 Feb 2025 00:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgLT8tMN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A484C96
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 00:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738888685; cv=none; b=VPUyC4hpsmXg3sj6GXqZ3+s9KmZ+sEQP9FejQnwm8vfUoCgQ4/bdxgaMdeUGdqkn5Z4NH2Hn+zoQ2G/8fTCXx+/XWVasqJPj6Z3RQkZQWKAJYPxrOZvXJJwN6ePrwPYSzjp32HtB37PesQuoV4XysCjBGHJ5V8FZNidcH5NcT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738888685; c=relaxed/simple;
	bh=3e8n5fPu4pJa6Q7Ljh1mfpHJN+zYcI7+d2OEfaYC1IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOMnraFYslP0IAlti8xpd55zvES7RL4wjOjE+pRmiFMAOj6nceuZRqduZxFRM6uNNEAXvMKC40Uh6XMs6ZZlSc9yBYL8+QlOfyc0ePn4V+Gdn+Nj/u9O//2xvCQOE++j2vJzq0n0zFejFrYtoE/uKjtrlRWWI+SKYsAdVKnXCCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgLT8tMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6C3C4CEDD;
	Fri,  7 Feb 2025 00:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738888685;
	bh=3e8n5fPu4pJa6Q7Ljh1mfpHJN+zYcI7+d2OEfaYC1IQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CgLT8tMNLqrmnOPEfnwkB6UJnn3B2z9r2CC5Clbh7oes8ZiP+X35tblbNUezmoczt
	 5OtjCJsVBmGX4RoO4chlaD1IdypQf+wymikUhM29bBGq2RrPRiC5Eq6sDnF2r/0AEu
	 iAWeVQfwVlmXk2uUS1s2ifLqgCnB7M3nu7TqxbmI4/hrisJ9NqOVYIRfuCF/La2u3i
	 sUfu/9NMNTHbqUUJ4hKLEfKCP0+pVWVzxEv4X7omJnXbqRMlPRwKD7ObKxpwltCtaA
	 jQ9n1iRlefDchCWoNfs1VSD/Apk1VuYcdZyeUUm54pkMyLq1g2zNkiFIr2piHrq8G8
	 39mAKBpP+hn4Q==
Date: Thu, 6 Feb 2025 16:38:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <mkubecek@suse.cz>, <matt@traverse.com.au>,
 <daniel.zahka@gmail.com>, <amcohen@nvidia.com>,
 <nbu-mlxsw@exchange.nvidia.com>
Subject: Re: [PATCH ethtool-next v4 11/16] qsfp: Enable JSON output support
 for SFF8636 modules
Message-ID: <20250206163803.281f24f2@kernel.org>
In-Reply-To: <20250205155436.1276904-12-danieller@nvidia.com>
References: <20250205155436.1276904-1-danieller@nvidia.com>
	<20250205155436.1276904-12-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 17:54:31 +0200 Danielle Ratson wrote:
>         "extended_identifier": {
>             "value": 207,
>             "description": "3.5W max. Power consumption",
>             "description": "CDR present in TX, CDR present in RX",
>             "description": "5.0W max. Power consumption, High Power
> Class (> 3.5 W) enabled"
>         },

Commit message needs updatin', code looks good.

