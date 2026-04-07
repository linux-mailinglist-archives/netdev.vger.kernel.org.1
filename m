Return-Path: <netdev+bounces-275801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJXxEeVa1GlLtQcAu9opvQ
	(envelope-from <netdev+bounces-275801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:16:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2441D3A8A0A
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DB54302DF43
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 01:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7E11E5B63;
	Tue,  7 Apr 2026 01:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCg5/qA4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFCF1C8603;
	Tue,  7 Apr 2026 01:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524487; cv=none; b=HSBlmVbfhjSpqBvOn8+uYw+NlTUo9euRQeOGe/z7BhNCu0xDMwzmyReNvXR9ps/6mPGYBBwt09yfURLUhEtZD6j077YKImS5Lu0YMjjHiAhTICEI0pdbQTlFG0MZZXOQ2uobRl/w6IPfBcaZu/Izj07wPpFcdlsk8T+j59w1354=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524487; c=relaxed/simple;
	bh=nugQbYKYvAr/gmc2VAWOdgc13hjHLlNGAno2/c/FZDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUcLqQIf8G8MFimBqy6zcqWDzn6kHZCfFXMThW6qQTCqK4oJUJYx8cLEEiIAkfKWVGC3KmC37lonTNyxYBSjdhTUJVS67MOx3BkKg59L9Yg+5WB4Cz0iyakZ3a5h8VWivbJnY4J9RlRf01iC3URRF+5IXaL/AhH6VCqYuXQ/xwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCg5/qA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BAAC4CEF7;
	Tue,  7 Apr 2026 01:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775524487;
	bh=nugQbYKYvAr/gmc2VAWOdgc13hjHLlNGAno2/c/FZDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KCg5/qA4UI0QhkFDVBI3efb8SmDry+XsnrMcWgR6zZwc3X/YFwVdVEL3jqMbFPU7s
	 xJgibqYXj1z76dq6DV6yxc0c/EP6ZFFVtKzjJF32PtoBPDR70K7WLGSC05qOLcuaVz
	 6yLi3LmkwqUG+UwJkz1osRXfIukJlkbVnkJXlNnOFqVQDBIIm5qXQZdYtQEqh+FiY8
	 XG040DcwAmU2PCwl61CV6iMuYx6ON/H877WXCGc/Z8xNu7xnZoWHDTuWh1u0avNxQs
	 7dHVfGD+Iw9fg6pcv7QN6jGjZNxnHtmUCzugzxW3TdGXj12SYPBVyGJhGCFGGNoZDZ
	 pJhHw/7HSxBgQ==
Date: Mon, 6 Apr 2026 18:14:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, willemb@google.com,
 daniel.zahka@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com,
 ajit.khaparde@broadcom.com, kiran.kella@broadcom.com,
 sachin.suman@broadcom.com
Subject: Re: [PATCH net-next 0/3] psp: add crypt-offset and spi-threshold
 attributes
Message-ID: <20260406181445.1fb8308e@kernel.org>
In-Reply-To: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275801-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,vger.kernel.org,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2441D3A8A0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon,  6 Apr 2026 15:23:02 -0700 Akhilesh Samineni wrote:
> This series introduces two new configurable per-device attributes to
> the PSP (PSP Security Protocol) subsystem: crypt-offset and spi-threshold.

Please read this document:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pw-bot: cr

