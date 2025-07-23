Return-Path: <netdev+bounces-209569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE11B0FDC9
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 01:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F6DC7A8EED
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 23:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0603C233D88;
	Wed, 23 Jul 2025 23:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLcx1Mj1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BC823505E
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 23:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753314889; cv=none; b=pOf8n1A6EaLePJny7eUAYYYfpI9CTBIBgs8zui6yGOISBMwPjqhmj7VmySDHbNAF2C2/ZRCrmsVCY1kpx8zgJwP8B5h6ttHR7tA6MuO22ZKfy/0yTjNi3cSUF+PpXCqc1ES/ZmhjUOixXvlViC42VVrTRoSzcMHsLpmb8Qa15Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753314889; c=relaxed/simple;
	bh=eRWp27IUvdC8h+lyLYKCPq/Tlvb5QdHyCmW/GtpiV0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tarhUBPoLbDctIS3B9CNkXjKx25KnOL7lzqOH8y7iCW7DBJsKbCQ/RB6WziSoV12z4MzXhXu4yNWuWlWDg2tF7N/b8o1zYFYdKLpUAIkJbSFpLxrNqM0hkW9YNpBuFB/ujwcCahDC3gMrvNzl2fLwUnZ4FnBavm+y0dJbIY9IBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLcx1Mj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA662C4CEE7;
	Wed, 23 Jul 2025 23:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753314889;
	bh=eRWp27IUvdC8h+lyLYKCPq/Tlvb5QdHyCmW/GtpiV0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WLcx1Mj1aAjlSuiAf5V6VjnAO8SB+ueR5xlU6W3GkBuWl3eXBc3FEJKMlXXzdmf+7
	 FX+OqSIxdFSV4GiER1mmCFbNlbsUXo4up5l1lTmvoVW+1eHzWetuyCFy5hejTsbs6E
	 CYMtVJSLHd2ludrnfD/rbaHoCvPfEXIbWKdhZa2JsBoPuhd7kDWJmXY6mhxbYT20Fm
	 9V81Vx/upIx+s/oCd1fvaGnm29LX/+GW7sgX6JoDzVx79F2MeJhCdftPYFwIa2PB0c
	 QB88BFC7QRVYpWYK+9RUkxKGjYwqY8crLMuGdpCuIAJQDkeCOrH4mXc9hU0V5AGMju
	 017z55FHr5tUA==
Date: Wed, 23 Jul 2025 16:54:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, vadim.fedorenko@linux.dev, jdamato@fastly.com,
 sdf@fomichev.me, aleksander.lobakin@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [PATCH net-next 6/9] eth: fbnic: Add support for XDP queues
Message-ID: <20250723165448.2d07b5b8@kernel.org>
In-Reply-To: <20250723145926.4120434-7-mohsin.bashr@gmail.com>
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
	<20250723145926.4120434-7-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 07:59:23 -0700 Mohsin Bashir wrote:
> Add support for allocating XDP_TX queues and configuring ring support.
> FBNIC has been designed with XDP support in mind. Each Tx queue has 2
> submission queues and one completion queue, with the expectation that
> one of the submission queues will be used by the stack, and the other
> by XDP. XDP queues are populated by XDP_TX and start from index 128
> in the TX queue array.
> The support for XDP_TX is added in the next patch.

transient warning, needs to be fixed to avoid breaking bisection:

drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:622:23: warning: variable 'total_packets' set but not used [-Wunused-but-set-variable]
  622 |         u64 total_bytes = 0, total_packets = 0;
      |                              ^
-- 
pw-bot: cr

