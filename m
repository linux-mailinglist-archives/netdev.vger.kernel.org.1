Return-Path: <netdev+bounces-277074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DxGEp/b12klTwgAu9opvQ
	(envelope-from <netdev+bounces-277074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:02:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D90933CDE28
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33CAE300D743
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 17:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA283DBD7F;
	Thu,  9 Apr 2026 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRcdE6ag"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934A40DFB6;
	Thu,  9 Apr 2026 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754138; cv=none; b=IkmMgzPlUaCNnXrU35NEoGKzYf8zDeE5tLlLp2i4w/zI1eFgdBg4CBuEEZESZ/wrYGU/IBcsxruAX/EQIsoYGitDcdro8RTKuiOtdW3U13K3nQ4KO/tq6LF1EBnWRKwoWYHALjUKw83Ed1KTT0Lx0oh5mPzTS+X/ufUVBviLUgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754138; c=relaxed/simple;
	bh=RvRHyUcFxxG6wQnNxZOrIM1hO6bj0DP6oMU3xXPQdeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCwgR3q4Mj9Jrqyk/HOrUSOahtsyYTKyc2P3X7/vU05BupVtBpZn4DJ6KRSrHRlxdMkGSeD0EJcALY+S+qsUdXtTeClDP6rbe0rEJOntujxE/CsoM8XPWXieSCM/Lesz+np7XShsR0V8K1FBv2rfZa0jrPfosz4N5paaQJFKUMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRcdE6ag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3072C4CEF7;
	Thu,  9 Apr 2026 17:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775754138;
	bh=RvRHyUcFxxG6wQnNxZOrIM1hO6bj0DP6oMU3xXPQdeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mRcdE6agHCWl0jOZxFR77KFqXcliDz9Qnt+6874D5ymB/i10NEmchCus6XBVK53tU
	 itNDTl1wPt09jKxiGBUp9nWWO3npeUAS2bNj3MjEFvp9IyK2fYrHCvnk+uCFY1zTAE
	 HJ1ejVZ8Kd6KaW4oqW1DCgNwzLQiqYnt0X6IkDGtVcnHpYAn9tfKSkwKlAdwHm3sou
	 RnI9YIwLQAAP8whvlUShO2iMu+VBe+lFYLIFowHgpbBR9Uvk1S2rDpSYf30Zf3gy2A
	 jw9C/dOVxmTdjD6pKNOVnHoEXhTE0DElKscQ5bYwoOXCNCjZ1ze3keuR912OZ1W6eB
	 Fr3874Rxq9nzg==
Date: Thu, 9 Apr 2026 18:02:14 +0100
From: Simon Horman <horms@kernel.org>
To: CaoRuichuang <create0818@163.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests: vsock: avoid mktemp -u for Unix socket
 paths
Message-ID: <20260409170214.GR469338@kernel.org>
References: <20260405195709.85957-1-create0818@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405195709.85957-1-create0818@163.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-277074-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D90933CDE28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 03:57:09AM +0800, CaoRuichuang wrote:
> The namespace tests create temporary Unix socket paths with mktemp -u and
> then hand them to socat. That only prints an unused pathname and leaves
> a race before the socket is created.
> 
> Create a private temporary directory with mktemp -d and place the Unix
> socket inside it instead. This keeps the path unique without relying on
> mktemp -u for filesystem socket names.
> 
> Signed-off-by: CaoRuichuang <create0818@163.com>

This patch was sent twice in quick succession.

Please don't do that.
Instead, please allow 24h between posts of updated patches to netdev.
And please version patches, like this:

Subject: [PATCH v2] ...

The process is intended to help reviewers.

For more information, please see:
https://docs.kernel.org/process/maintainer-netdev.html

