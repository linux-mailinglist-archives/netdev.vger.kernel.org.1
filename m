Return-Path: <netdev+bounces-141296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942009BA670
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 16:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50C81C20CBD
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542D1171E6E;
	Sun,  3 Nov 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCTw92J8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036915D5C1
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730648478; cv=none; b=unfIPhxKGzZ6/c3Rru/zYaoGvAXmhy7FABDNP0v5Y99tzEvROUuSHh6VDkjWFQUtM0+j/N3Mfdd0RmeBq/pqGcHTeQ4CfZeBSOP/ErTCSXUXF6dDNsXOhzvwASnSfDH7AAI0xv+wr7zryBTqlKdebVL9laox+mZFim7LN5TalaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730648478; c=relaxed/simple;
	bh=mq+a7uap3x7ge3zppShRWYFEV/6PsH2++2hZs2HurQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdWDCXsOzdru/rLhvNUy4dfyfMj8LjzyNzhh2/yy1A7mrJnq0xI2m4Pq/9iHfaMzElYCsIW6Y10Mne2TTwGTbgQ9c0yNbik4H+dKJ3PO5OMjvfj9DzKgROk/8n1/IFeIve9rqZNIv6tH6oUY7e1stIjbSR2DEGKEg3OsbIyyDPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCTw92J8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A92C4CECD;
	Sun,  3 Nov 2024 15:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730648477;
	bh=mq+a7uap3x7ge3zppShRWYFEV/6PsH2++2hZs2HurQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eCTw92J8cC4RlQSpzmcVor+6yfmESoPFfMzldOwYgbzLkKg9sX3CMSKca9foUDahZ
	 oNCR43h9mPnC9RTNLKys3UYq2AFaDyVX5cjBCxjKe+2/c8YFrnjNMDeJqi66WLCLJK
	 WhO9XCWFwolYGiFZH68XOzY3fW6T7UVybFH0/yEQXb3m5Bs9/hTPXDqDb/H2UYdbo1
	 agzOQdpgwGYJzZB1TDFBWunlHysLeCqRVkhzaRbOFADKhlcgqG3G75Tfd/GqKZRy0U
	 qE2UmkbB3SkRkAApMUOqY9Xz9l7XMT6mAXiBUFoaj7pHYy2gfBu3V9oi2kPy/DM2v1
	 dWWCAMlwIOycQ==
Date: Sun, 3 Nov 2024 07:41:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v2 0/2] support SO_PRIORITY cmsg
Message-ID: <20241103074116.2061b6d6@kernel.org>
In-Reply-To: <20241102125136.5030-1-annaemesenyiri@gmail.com>
References: <20241102125136.5030-1-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  2 Nov 2024 13:51:34 +0100 Anna Emese Nyiri wrote:
> The changes introduce a new helper function,
> `sk_set_prio_allowed`, which centralizes the logic for validating
> priority settings. This series adds support for the `SO_PRIORITY`
> control message, allowing user-space applications to set socket
> priority via control messages (cmsg).

Could be a flake but it seems to break this test:
  tools/testing/selftests/net/fq_band_pktlimit.sh
with
  # unexpected drop count at 3
please double check if you see this failure.

