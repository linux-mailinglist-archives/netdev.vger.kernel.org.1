Return-Path: <netdev+bounces-230245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE577BE5BBA
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 00:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B5619C0024
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C62E06D2;
	Thu, 16 Oct 2025 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JStvj4gg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9828749659
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655453; cv=none; b=gWBk1Psd75e54HYHHl971vyswZLS5cYtIfB314Al3clHy0D0wjPdW0gY7KApDps8NyxoxfKseDf7/utn93RLuc9qKn6AlDEHmpS+jpdAyDKJzvPmzUrbLudA8GsDAecopmRu8ikqpw60qHA16VjWt9gDBfLwYP7zvWHAJVQrQB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655453; c=relaxed/simple;
	bh=QYtN7wuhmmSaXNLqF83etSNJ9arS3Qaxsnyu7DDBVuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYvzRrNBmisC8OTiFCgUNKYvhlNcNCQ5AR7hUDlPFVsgKUPTIzqR5qh3hdJtfsEYu600uxGhTbzEV6hE1+MaVjsHqMH7ENWC/4LaHkKFe0Korwn4JTtVkuvCXHWuSGaZjrvQa1GD/t2e+a8ox8Nz8Efg0XOHDvXrv6CnRewRCmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JStvj4gg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AC6C4CEF1;
	Thu, 16 Oct 2025 22:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760655453;
	bh=QYtN7wuhmmSaXNLqF83etSNJ9arS3Qaxsnyu7DDBVuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JStvj4ggr8oWszXFaw/IVnOKzrky33FxID7IZp96uY17eQPMgalDHrDBZen+JoasL
	 1CXzHphMXUnhzwO99w6EEIphZvSGl/c5cuMUAYN9PvK7NpbRCH4h4/sVp6x7hyP1Ea
	 g1PrSJEo7m4mkvmgEsmOaj6zuyYizUOqo6WIwj7lT+giRNi+5FgbD625yaov7JSd7T
	 aa3edqYSx/jLtjjTrySDQdeW8/iHlkqQIcWfHXZcMTVV+5rEcifxw0JLicqklU7ypV
	 NaHIpI7sCxLtRdtBDtjRueP7w2xzP35ylxMXKfOAjm87eBWfqJGVwiw36yXiUorrux
	 JMiH67u3YyU3w==
Date: Thu, 16 Oct 2025 15:57:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jan Vaclav <jvaclav@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/hsr: add interlink to fill_info output
Message-ID: <20251016155731.47569d75@kernel.org>
In-Reply-To: <20251015101001.25670-2-jvaclav@redhat.com>
References: <20251015101001.25670-2-jvaclav@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 12:10:02 +0200 Jan Vaclav wrote:
> Currently, it is possible to configure the interlink
> port, but no way to read it back from userspace.
> 
> Add it to the output of hsr_fill_info(), so it can be
> read from userspace, for example:
> 
> $ ip -d link show hsr0
> 12: hsr0: <BROADCAST,MULTICAST> mtu ...
> ...
> hsr slave1 veth0 slave2 veth1 interlink veth2 ...

Not entirely cleat at a glance how this driver deals with the slaves or
interlink being in a different netns, but I guess that's a pre-existing
problem..

