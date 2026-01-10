Return-Path: <netdev+bounces-248732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB5DD0DCE2
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 21:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B1E83004E37
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCD327FB21;
	Sat, 10 Jan 2026 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWGlrjRr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781002459DD;
	Sat, 10 Jan 2026 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768075237; cv=none; b=pgXx3BQzOnBdqYifEH0DqWYuOLpVJ4/BQ8HZ4WPDH/tDdKonVswqpQfMSWLis1Q10Evkk8Ygiuq3K4Cy1lHbLeOEDe5P3Sj14fMMHhQI8mLtT8MXskGNl+NPmrmkaSuTcu7Z7pOeXDGWjJFBLAyzb8Q3Cc8fD4/IYcpXM85+tkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768075237; c=relaxed/simple;
	bh=6n0Rq0OiBANCFcn+DMER7m7vQ5Ubj0a0j4fN6tuONeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qoKxZUao65c1QWK0kmkJE35fsFphou9elJUw04iCF+zssaZNCeTBTTfc8biiect5QFcxnZRFQeFiKd4MRg9ZQl663Wz7KjT5BOb/y6Wl5v6XpJrhJzZVxtxKSCEx27ievqaukcbcUxueV0B16jrXXMRp+pfcGxldZgp+cZZoOCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWGlrjRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CC0C4CEF1;
	Sat, 10 Jan 2026 20:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768075237;
	bh=6n0Rq0OiBANCFcn+DMER7m7vQ5Ubj0a0j4fN6tuONeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PWGlrjRrVYR8AMzPRdP9yrzGQv0D1dhEGZnpF1RILry1xOXm1pQM/xz14cfIXtqX2
	 90QSsBOOLIc78Oy0wRf0rPudQSlIWPAQbYYkresFnkbgTeUrOJdA4VyKekJps3lv3q
	 AGlSkm5kLOgpiTU6jGLK8lbX24SY7Kn9hAp329f6efc/qNhbj1Manm/mai2QuDFgz7
	 787lig8oHutlUXrEfBxwhz5yDLqdubq0ob9r5sMLmp9mXfGK3cDzk1NTloGxtGmkeP
	 p9AeiWuhRUbSEWhr68tlaN/4H4/DOwhYerqSZyw5xvn9L4Y6IcGuJf6/KlooJNg6W3
	 0AfXNeuiIruJQ==
Date: Sat, 10 Jan 2026 12:00:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: horms@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
Subject: Re: [PATCH net-next v3] net: ipv6: fix spelling typos in comments
Message-ID: <20260110120035.11deda7b@kernel.org>
In-Reply-To: <20260107121812.40268-1-i.shihao.999@gmail.com>
References: <20260107121812.40268-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Jan 2026 17:48:12 +0530 Shi Hao wrote:
> Subject: [PATCH net-next v3] net: ipv6: fix spelling typos in comments

This patch does not apply to net-next/main.
-- 
pw-bot: cr

