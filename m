Return-Path: <netdev+bounces-48848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FF97EFB55
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 23:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9291C209B5
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 22:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3424643F;
	Fri, 17 Nov 2023 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixZzA2X2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB7B46435;
	Fri, 17 Nov 2023 22:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17850C433C7;
	Fri, 17 Nov 2023 22:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700259805;
	bh=6DSf0nVAntIkLaU9iNZUmUavKWJVfxe1caFDUs65/3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ixZzA2X26bUECEOcgxtNg2do6HNVXqKNT//yk0SBxN3MgFT5jEDTCdbaOFSWpojTg
	 VsK6GvtACJIGGBATK5YX5gsghJC7DG842otaPfUiNEP0/8hFPoRB5aKRXAEjzEIpFV
	 rNLIh7MNDaJtm87W0pBJ/Mj1xygY8yvnzVEMuU48Zvj8M/ozmvNEn+Zwy/Ey3HZ32R
	 ZeSrzn8+nyjG0uA35Cj293gtQkjs/aE0TCpFHllAUfOl+bLgIcB1VbTggElLeB+4ks
	 IBsaePJzYSQX3rGo4vSHUyYA9+HniIM9aQNJqOhWHb9KPE5mk8dLG1QiO5pytTbmDo
	 mMKNUeyIsvbrA==
Date: Fri, 17 Nov 2023 14:23:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, workflows@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add netdev subsystem profile link
Message-ID: <20231117142324.522fb816@kernel.org>
In-Reply-To: <20231116201147.work.668-kees@kernel.org>
References: <20231116201147.work.668-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 12:11:51 -0800 Kees Cook wrote:
> The netdev subsystem has had a subsystem process document for a while now.

I wasn't sure if it's technically a profile or not.

Let me widen the CC a bit and see if someone can tell us one way 
or the other. Our process doc is not listed in
Documentation/maintainer/maintainer-entry-profile.rst either.
Perhaps it's good enough for P: but not for linking there.

