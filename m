Return-Path: <netdev+bounces-209478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617F0B0FA82
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B334E169A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 18:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98822221280;
	Wed, 23 Jul 2025 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHGo/i99"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2221D3F5;
	Wed, 23 Jul 2025 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296651; cv=none; b=jRjPd+5Hqw//qMoollIw/TH2MNq1zvBeolc72r5mNqv9xgsmb9ERtQWkdqJAj7V2rU2Xf3SKrkMJGL/rl+kxsudut5UFtcv6FCh09mAfYPPsimj+VIqu/zNhw/cTaiIYSZoPd0XC1YUk03+I68xTjWOmUGTArbW65rXEl9tzae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296651; c=relaxed/simple;
	bh=RXOYLDNicKQoltUaW0luwByl2WWWYpgXXuteOXBrbxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyQ0+9J7+f8RtU8C+DFRhei+U+QShWjzwZFgcw6R3rUKCzF8CRR19Zb94v1D6jc7U432WXXvYCNLYcpNNhqbffeaWk4Uj6KhDqANBjgNBQb+zzsNOUkq1nynmkiqfDrjR4Tpv7p10nDuop8hEedMOWsPJykkiOSgZepX4es61PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHGo/i99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B52C4CEE7;
	Wed, 23 Jul 2025 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753296651;
	bh=RXOYLDNicKQoltUaW0luwByl2WWWYpgXXuteOXBrbxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QHGo/i99c8nDxKsS+28Ul2un62l327D3BZFDCqACRDanXNKXSoP1RAFf2PaBbDATz
	 +Zzm57NggmXt0WL2J0I4qVCmG1DHn/PdfystzcJbMeejvO0IygIV6qPSi9gsEV5GHd
	 Gb5pLUTWOAFUTExSwXIvUEx0qDykYsThVMef/6JxdNjvo0MdPdLgW7vbB7oI+hJNSk
	 hXNOM+V4U+9wuYsWe9nX5uXy4LU2fj5R1AsEjZeGaiK/tltG17tCYloZuD1kPre410
	 Qj7xm/b2TFmGuy5TE21YD/pLlJ3T/MeE6BZgFe/5wS8JeQOc2Q4XCDzWoZzh7BrqUH
	 KAYrcujitfG3A==
Date: Wed, 23 Jul 2025 19:50:47 +0100
From: Simon Horman <horms@kernel.org>
To: Ali Ghaffarian <alighaffarian9@gmail.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] Net: ipv4: fixed a coding style issue
Message-ID: <20250723185047.GL1036606@horms.kernel.org>
References: <20250723084736.521507-1-alighaffarian9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723084736.521507-1-alighaffarian9@gmail.com>

On Wed, Jul 23, 2025 at 12:17:36PM +0330, Ali Ghaffarian wrote:
> Fixed a coding style issue.
> 
> Signed-off-by: Ali Ghaffarian <alighaffarian9@gmail.com>

Hi Ali,

Unfortunately we don't accept clean-up patches of this nature
for Networking code unless they are part of a broader set of changes.

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~

  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:

  * Addressing ``checkpatch.pl`` warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)

  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.

  Conversely, spelling and grammar fixes are not discouraged.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
--
pw-bot: cr

