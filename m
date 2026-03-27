Return-Path: <netdev+bounces-272307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHlvIg3YxWnQCAUAu9opvQ
	(envelope-from <netdev+bounces-272307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:06:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E26D733DB6F
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E6598301EF80
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288DC2DAFD7;
	Fri, 27 Mar 2026 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRHKQlFD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FC02D1913;
	Fri, 27 Mar 2026 01:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774573574; cv=none; b=IrTk9JqZ8EI4LVAmLHOog4Ig/Ub4Gnk1tUIZrLjdNNnOLwFeIo3AUF0oOHqKLSXUm4nimyP7xtt4rfpsn8SGSqv7r/iGNjp5Yx2zpk4p7zVeAQFJPGxoUpQ7kelbY+y+G+UtSt0mTGaePD0BFjsOitwZKd+XbjDyZkw8X87joOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774573574; c=relaxed/simple;
	bh=CpW4Iba18ntMPY+defwSwftFxvJNSdODVY+gGWhKNFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K44EMlIpP6y7fxC2TaGFTLw3pEpA79To6Bz0wXKl6cDRHCI0ekgLBpNOLYOWNglFl+xnavZ9Ah7G3jv6+c+aoRpXn3cr3xtAf4ZPBtNuNvBbKxw8AiNLPrZZNY4IoURMSyru4DoMw2fvwZZ/yKgb3h2mwc/mAkj5CQfJV6VX4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRHKQlFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA06C116C6;
	Fri, 27 Mar 2026 01:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774573574;
	bh=CpW4Iba18ntMPY+defwSwftFxvJNSdODVY+gGWhKNFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eRHKQlFDLW5+sXoqD0RB7xc1zs0JoStJfzEYV6RT0ZIvJd6zABeRTOMIyf6lbq16n
	 jh336UfGlRkkNGPIInOUJnlTFA5+CpdnFcV1gjzMSckPzWGYFotJm7ERTo6gPuV1NA
	 LJdyAQGTKCoEoJiZwlaLkeJisUrRdY5eTZgKpgI1Na5pZGQ9KPLFsDx7NjGimmor6W
	 IawoHcw8hZd3YOW96WeVE2ilRPuKKGTbHHZoF7wqvD0v8p++7DZpEbfeqFZjMLQ+1j
	 3Vu5LlQWUBwRp1FB9tomHMWJeBrseXttHqPlkW3gNp/Kp2TsfTrw/THrulloomxFOP
	 l+DAO+GLHvCYQ==
Date: Thu, 26 Mar 2026 18:06:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] bnxt_en: validate firmware backing store types
Message-ID: <20260326180613.7f3e0ca0@kernel.org>
In-Reply-To: <20260327003845.27877-1-pengpeng@iscas.ac.cn>
References: <20260326142033.82313-1-pengpeng@iscas.ac.cn>
	<20260327003845.27877-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272307-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E26D733DB6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 08:38:45 +0800 Pengpeng Hou wrote:
> bnxt_hwrm_func_backing_store_qcaps_v2() stores resp->type from the
> firmware response in ctxm->type and later uses that value to index
> fixed backing-store metadata arrays such as ctx_arr[] and
> bnxt_bstore_to_trace[].

Again, please do not post in replay to previous posting.
And wait 24h before reposting. Read this:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr

