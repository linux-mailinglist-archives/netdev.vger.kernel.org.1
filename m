Return-Path: <netdev+bounces-292524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sExaIR+oF2qhMQgAu9opvQ
	(envelope-from <netdev+bounces-292524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 04:27:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E605EBC36
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 04:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 485783011C48
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE92F290E;
	Thu, 28 May 2026 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGi1WKia"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A92EE262;
	Thu, 28 May 2026 02:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935072; cv=none; b=rpdpxgiKPLa9xEi6DGPLuaa+k7ImMr2PexAktglELVbROdk46iYBxh65QiQ/Av5yzbhtPwbrqrAhN5eMSBuPT3Xchx/CFU80uHsohZhuvpiB6Q1KL5gSlmsxnyofWSR6By65OaC5065CMGVeQ8qY0aXZxuPICwmboyhnkefH2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935072; c=relaxed/simple;
	bh=FrW6PftFBAVq3gevUoJO1cg6Pi9ObKSk+65QC3n7FfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3ao7FRwcrNctDHRuwYBCNGVe4T4ib1ksEW+1hZs9SSjD7b7Kw/sxUiMehnhDeEyFLcZED65nnPw16l2ULQz7nyJm3dzNt39949rIfFxYMGVlLUfJCWJbGw5jZTXbrnYhFphB3E/IgShaNzLpjvLKLlwBwLmMqALOroSR7DBhbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGi1WKia; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0091F000E9;
	Thu, 28 May 2026 02:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779935071;
	bh=71zXM8ehCxjxqijFW0yk7Di/LCroQJafshpfLzrG8Hc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aGi1WKiaihe+TVzOzo94L8e1qsqhBxZXjqjF1q3q+1amlkqSZ1lNI3qz3II7wGUdB
	 dDwLICoKRIH3LbbgcU6jVcVslIWKSzYnvApQfHxnMd/w3addpxjX48iw368x00QJiA
	 gcpmc8eHYZFi/4HrlYVCJYOqYs9WJwrjGhlCbDla/y/KfYDWPyIEjSZ2cInMTM5ydS
	 TmENjv1N+U7U6X3HaIARw3ojE+tIeZRyeW0VzDnjzbshxM2xtMQWJ0fAb6+bklWlEX
	 IyeNKg1o3dzVlGFOmyswSEMEIs0JfsNRAYxGkey0/3XFevxWR4z1k++34Eeob9B3pF
	 9LR4npiPe0Glg==
Date: Wed, 27 May 2026 19:24:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-05-27
Message-ID: <20260527192430.1b490571@kernel.org>
In-Reply-To: <20260527211246.371451-1-luiz.dentz@gmail.com>
References: <20260527211246.371451-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292524-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E7E605EBC36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 17:12:46 -0400 Luiz Augusto von Dentz wrote:
> The following changes since commit ab1513597c6cf17cd1ad2a21e3b045421b48e022:
> 
>   Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del() (2026-05-20 16:35:47 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-27
> 
> for you to fetch changes up to df35e8e0c8c4160c881bb673e3c7ee010824fbd5:
> 
>   Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2026-05-27 16:44:02 -0400)

Are you still rebasing? Or did Linus convince you not to? :)
Looks like we are missing your sign-off on:

Commit c3d01980c64a ("Bluetooth: l2cap: clear chan->ident on ECRED reconfiguration success")
	committer Signed-off-by missing
	author email:    kipreyyy@gmail.com
	committer email: luiz.von.dentz@intel.com
	Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>

If you're planning to no longer rebase your tress - don't worry about
it. It's not a deal breaker. If you are rebasing anyway - could you
amend?

