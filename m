Return-Path: <netdev+bounces-56662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34242810662
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9E61F2125E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167AF191;
	Wed, 13 Dec 2023 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV3ljwpP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96EF7EE;
	Wed, 13 Dec 2023 00:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB37C433C7;
	Wed, 13 Dec 2023 00:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702426642;
	bh=byq8UrKLG6eAfqdGKqYVFQwQtrWyvf9QV6eyfR+pwA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WV3ljwpPLNgjx8vUhCJA2TjUMgl4/RMm0JoyQcSbmRXdFCPnCxmg99b2kKGrkdLCZ
	 n6WNL/Qb499dGL3FiWoy8Nv6fGBqja27O3uLgdhPvabf7jHpVxxTMAS1pEfsEh9D8F
	 /SEEh0lrETwweak+zJV0DNIWMHob7H+iZc5MgEA3n9HrLKRRHYHgmD88lNjGS9mvQb
	 Kk1j+7j9+8L9jN1GADZ0X50JdrFuIKNynERAbXf5hggTAelQ94ZWDmY9SYiU7X81k7
	 MkLvKWFVFNIwGbg4omxUyhbqRAnQUQmt3qrHsrO+nZ6HScioeH090xoFc2geTFcXU4
	 caljRG9INyuNg==
Date: Tue, 12 Dec 2023 16:17:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, Breno Leitao <leitao@debian.org>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 03/13] doc/netlink: Document the sub-message
 format for netlink-raw
Message-ID: <20231212161721.7abfe73f@kernel.org>
In-Reply-To: <20231212221552.3622-4-donald.hunter@gmail.com>
References: <20231212221552.3622-1-donald.hunter@gmail.com>
	<20231212221552.3622-4-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 22:15:42 +0000 Donald Hunter wrote:
> Document the spec format used by netlink-raw families like rt and tc.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

