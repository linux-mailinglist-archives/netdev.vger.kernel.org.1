Return-Path: <netdev+bounces-254952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1QM7JRH0e2meJgIAu9opvQ
	(envelope-from <netdev+bounces-254952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:58:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE21CB5C86
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41F2F3008751
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7D6377545;
	Thu, 29 Jan 2026 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhZKFI9L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C32D329C4F
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769731086; cv=none; b=CI16uzHOJ4Ojkw573wPJISaCzGMcdAJdXddreMHaZ4p9I1jTCWS34jzzGmL7RWFNoggr9FRhIZMzCkBkOnOQDaCqqh3usTdBmgmkQz4s54Y0X1EFq6hhTXTq+fQxGk2FBIU8FPM4TI9xJrtHnKKGz+m/xz4Aj/Evmq39ziA0NNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769731086; c=relaxed/simple;
	bh=fkkeinuaFYJ4hsnWxfVzhlTOE0z38x6eOGNeP707EFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgcdfFYIye7I0eJ33h1NsnpEh/QzivG1EtzkIGV/eNejp4YCW/u7cZFp8qxBluIT6PC2E6w6qRnYicu6UEtkTgyuksuk3oLAf7cG8Ral8jJXRzy7VcZwXfY0JX8J3WvZrrwcMqZdnn/U+w/dYCv2Vkmrib8eLPjEdErlvTuGhw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhZKFI9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83163C4CEF7;
	Thu, 29 Jan 2026 23:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769731086;
	bh=fkkeinuaFYJ4hsnWxfVzhlTOE0z38x6eOGNeP707EFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OhZKFI9Lqgv4u6kLxYYA4OeRjv6kuer51uM2OilgqMkZ90z+nvtiiT3ESZAvu1mwk
	 4OzsYa35vfbtmlMXX5aDfe3l6QrsZnaZfCzdYIdbVAeOJEiNSbjIC+ETkrkqtWLGG+
	 /4hyBx8frcb42IZuyeJHIc6tj0xrL9Y9xcIXX+Xw5cnDDDbzqtUvPpn8LQ4m6tu6Q9
	 q2Zg+Afw7EizUUivpteeOnHBainc+6s21dtJx6EBLFuY1Yx8xByx2bDaTey/ldU7lx
	 iHNMiXkXzx2rXU7XSwIKywcRfkykae1VHWSMS2/UgOGg83jD+w6PMcHxj9pRDt9dZ5
	 /7IInMv6zMlaQ==
Date: Thu, 29 Jan 2026 15:58:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
Message-ID: <20260129155804.492ca32a@kernel.org>
In-Reply-To: <aXvA11H0AvNcjaWJ@devvm20253.cco0.facebook.com>
References: <20260129061646.1417185-1-michael.chan@broadcom.com>
	<20260129061646.1417185-5-michael.chan@broadcom.com>
	<aXvA11H0AvNcjaWJ@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254952-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE21CB5C86
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 12:19:35 -0800 Joe Damato wrote:
> >  .../selftests/drivers/net/hw/rss_ctx.py       | 117 +++++++++++++++++-
> >  1 file changed, 116 insertions(+), 1 deletion(-)  
> 
> I feel like this one might be net-next material since it is a new test and not
> a "Fixes" ?

Quoting documentation:

  Co-posting selftests
  ~~~~~~~~~~~~~~~~~~~~
  
  Selftests should be part of the same series as the code changes.
  Specifically for fixes both code change and related test should go into
  the same tree (the tests may lack a Fixes tag, which is expected).
  Mixing code changes and test changes in a single commit is discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#co-posting-selftests

