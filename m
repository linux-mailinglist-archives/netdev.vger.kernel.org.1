Return-Path: <netdev+bounces-78024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA640873C5B
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783E51F27F92
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5C130AD6;
	Wed,  6 Mar 2024 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xunoj4js"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3271C1C02
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742836; cv=none; b=Qlau0RUkSjR8V8ZsCBc/s1HW+IwXzlmDBPLb49S4JYxrVvatfHReaOTG7F/F4sM3ye3EmT9kc5SN2SB+AFr9Q5djHYPbTSIeHtn1jL7w4ryuuhRLUCVcOmeSjRqh/gh1H8BdQj3xEFIrol5SP+yvPIsgelm9RiXD2fAUvgqIZ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742836; c=relaxed/simple;
	bh=mzlu+JTjvi1uXG6ykWNQYGL71taHysh3ZaWF7Ru0094=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/g3JcBp+/Fui2LE+Tnp/OBuYr+kpXsxafRcNyBQSw9Z+wMXnLnnmv1jYl1fCKvWEzCFgONEtR47s0Z13nn28ZM1/edVRQ8Wx6I2RfOd7KelPYtIKh8pYI8t7Bu4+R0OtUD5eN3IB4IyTtVzrteAZgRRtH6uG+vyPFTIMbTdMsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xunoj4js; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E410C433F1;
	Wed,  6 Mar 2024 16:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709742835;
	bh=mzlu+JTjvi1uXG6ykWNQYGL71taHysh3ZaWF7Ru0094=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xunoj4jsI+e6e7CTiRm1irfcNpLxbIcIHzij5JbG2CxwRF2hPRvOOsfk5/Luzxza3
	 4Z5x6cG1pKSfthOIqEwTEqa173sdibj/5il+EB7Er567g/iJJhwptEL7Ppxvwvl9Kz
	 Fpg+nzpKduzVQ0UVXeSDvSAwYv7blKxf/SFlgcEXNm3f3LO1WyHjm0EFIIJpkxW77N
	 KZz8Nr1ZqVSQPG2rH6tml8xy0f301jOsFEfCmKPlVoIpzVpGiHAXn/v1vvW9ly3Lmp
	 xe9SBxH8q9nF4bN90cWWnqJZB6B+k96KzGLEHLl2hYhAYG8CLoRUL5LOJxSmUJeoG8
	 sS91TRkbcDsPw==
Date: Wed, 6 Mar 2024 08:33:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 2/5] tools/net/ynl: Report netlink errors
 without stacktrace
Message-ID: <20240306083354.5469032f@kernel.org>
In-Reply-To: <20240306125704.63934-3-donald.hunter@gmail.com>
References: <20240306125704.63934-1-donald.hunter@gmail.com>
	<20240306125704.63934-3-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Mar 2024 12:57:01 +0000 Donald Hunter wrote:
> ynl does not handle NlError exceptions so they get reported like program
> failures. Handle the NlError exceptions and report the netlink errors
> more cleanly.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

