Return-Path: <netdev+bounces-205990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ACDB01060
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 02:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E778F1CA1B64
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9695111BF;
	Fri, 11 Jul 2025 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDKsRBQt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35BB2745E
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195172; cv=none; b=GnNVXnZJNa6jf78WqYqU8Td+GGlqQMXlFqLIY1pczJG8krgHVVh2e+4IGsN4TmhIPHblnpOV4bZmrJhduDlvQnJOI3jDIZtzep/7e/Ipdt5rhn/ZU0/s2kHB4eErJ5gHMOEEupyoDfEvIqvZCx4t3gLZ+JqLF0odKFm9mlPljj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195172; c=relaxed/simple;
	bh=qQifV2qn+PnwgyR02U6RoY7mX1mCHZklcQsXRgO2+RU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwrNi9lsc1V3yLf5U/0Q/wCPyLFyOxjEvT3YhVVKhg3uILVO++jiHI+vcoare0bTmsT7ARvUfLhdTfXRzOmYfgsVliHHv2x9PTA0wDCVyiyPkLkd8ux03mKULYxtmIUMiPgqg/0VQFwNE9XflYFQLXzg07MNR/rg8KHCXdp89y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDKsRBQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058A4C4CEE3;
	Fri, 11 Jul 2025 00:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752195172;
	bh=qQifV2qn+PnwgyR02U6RoY7mX1mCHZklcQsXRgO2+RU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rDKsRBQtBy/lMuvdcFyGe8dgbSa/svCcK1do+Q9iZWpesPY8SB1F59y6qxJa4hE7D
	 M7qnHKVe+Vvc5gUCN7HyMnMqR/2WhKrdZ3yFF7XSpFpo2GSnvleRb7yruMiWtOPOni
	 Zg59IpxPuEHWRCqjNv6bxD2Ex6JIArlzgTWvsAet6b7COHwCY8ZvTZ6ATlrqqgniEj
	 ntrZ+4imU3jxTE9VM6LT0Sh5DK1kkpGx8kfncKZIFQS8RlbPtgDfsaZBbRHUD2+jP1
	 ZTamT37mrBXacUGKZle+N5/xYTvSfag0/cMdmvhkmxAsLCxveUJ/6Wz4l9V5dwo5Oa
	 o6/akOUg+1EjQ==
Date: Thu, 10 Jul 2025 17:52:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v3 2/8] net:
 s/dev_get_port_parent_id/netif_get_port_parent_id/
Message-ID: <20250710175251.5b2004f7@kernel.org>
In-Reply-To: <20250708213829.875226-3-sdf@fomichev.me>
References: <20250708213829.875226-1-sdf@fomichev.me>
	<20250708213829.875226-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Jul 2025 14:38:23 -0700 Stanislav Fomichev wrote:
>  /**
> - *	dev_get_port_parent_id - Get the device's port parent identifier
> - *	@dev: network device
> - *	@ppid: pointer to a storage for the port's parent identifier
> - *	@recurse: allow/disallow recursion to lower devices
> + * netif_get_port_parent_id() - Get the device's port parent identifier
> + * @dev: network device
> + * @ppid: pointer to a storage for the port's parent identifier
> + * @recurse: allow/disallow recursion to lower devices
>   *
> - *	Get the devices's port parent identifier
> + * Get the devices's port parent identifier
>   */

At the risk of annoying you I'd suggest adding a Return: statement
while you touch these kdocs. Here are some popular phrasings:

 * Return: 0 on success, or a negative error code on failure
 * Return: 0 on success, -errno on failure.
 * Return: 0 on success, -errno otherwise.

