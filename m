Return-Path: <netdev+bounces-272102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHSzBrNKxWkU8wQAu9opvQ
	(envelope-from <netdev+bounces-272102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:03:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D3A33739E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D11EC30822D4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C24B3FCB18;
	Thu, 26 Mar 2026 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Equ3DaHw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0929A37E2F8;
	Thu, 26 Mar 2026 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537083; cv=none; b=t6c8g/n6zIIWuudTpHNtF8fAf2jl0Id3qEti/I6R/xrlc9ddFlTq8ZjvFWhwuKtMX0nLtsgxPH4uFp7w6/wTG3njZgaLSjcTpMsN7R6jXECGYI1iKEfCXSPD0KcRanzjJHCZn/St2RbgIygj2gJSbmVXsJXRwTSxBuNtu58FAcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537083; c=relaxed/simple;
	bh=QZUkNsCFhQFnDTTotpu6BkWZFLkXNgC1j5lp/RNUq8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVmeCb11cfMma49LRCwclb6RJ/SSUsL9uLUhz0OtoEVL1ocFf27DSEY0Jqp75AVqyKNmpNgJOEBx0vfwP190jcXlSj0XhBG5F032afPQRtJxn1VWORhV5my+eCv5BMAOL+fWFUNOqu9oKFe186NuIc6lnQz6dsj+8O+gu8pANag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Equ3DaHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D06C116C6;
	Thu, 26 Mar 2026 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774537082;
	bh=QZUkNsCFhQFnDTTotpu6BkWZFLkXNgC1j5lp/RNUq8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Equ3DaHwOobSxIcvn+xckDPPVRvPOsm1UYCVbju5b3bZqXnABkyKqs2+1U3M+f9df
	 SqoU4ke2CwV2kQYgE9BuLxYyBbXx3rck7AF4Gxt8tgRPDuYiUgXt8XqkFCeNDleyDC
	 jRYWSuno2JsG0+aQtYZJH+1Fxo4ba+j+ek3q82gcyoqw2n7BzudKxKK+XKsjhvPC6O
	 KxM3M4fwCbLRlzaOZgDZzUOFNADPCCxatmBqZFjwdel2qNhNlWDITmmaXWTew24ylI
	 aPMolxFB2cOc7/u+lKYy/7GLu2HdeXNQglN6DOnZAz0crOeC39g9Yau2ajsDa27yqh
	 eRj4KWQX1w2Tg==
Date: Thu, 26 Mar 2026 07:58:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: fffsqian@163.com
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Qingshuang
 Fu <fuqingshuang@kylinos.cn>
Subject: Re: [PATCH v2] selftests: net: broadcast_pmtu: Fix false failure
 from incorrect ping exit code logic
Message-ID: <20260326075801.41e83b35@kernel.org>
In-Reply-To: <20260326094219.2160239-1-fffsqian@163.com>
References: <20260326094219.2160239-1-fffsqian@163.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-272102-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A6D3A33739E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 17:42:19 +0800 fffsqian@163.com wrote:
> The broadcast_pmtu.sh test verifies that broadcast route MTU is respected,
> but it uses an incorrect criteria for test success: it relies solely on
> the ping command's exit code, which leads to false failures.

Still failing, does it pass for you?

Also please read this -
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr

