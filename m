Return-Path: <netdev+bounces-279409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPgEBvCJ4mlq7AAAu9opvQ
	(envelope-from <netdev+bounces-279409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:28:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E26D541E427
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9218A301B8FC
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9C73CCFC6;
	Fri, 17 Apr 2026 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hjzyx3dP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1BD3C555C
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776454056; cv=none; b=Gu7tf9BPg5AR29hhSlbTRqqGiAlhYgCktzavGy0MG/AOZhBWRphLQgVeioFrtELaqQvKjFLaMPRnEQ6Ol9N+6dvlOxZmP2lanEYTHcW99aCdG0isOkW9+dXdZ4rQT+kMm+R8lT0HF1pk6aRPtiY8sEazXh6JMLjzcpyTzMeUN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776454056; c=relaxed/simple;
	bh=VD1dpDVeoOvo9DNemmyMtF3vP2OX5ZAXEaiRVAhP5nI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzvAYPFR5CIDbpvczFKVNtoeD5FUpyKzlxMHIUGe1k81R1jT1idE71Mkphb/XiRSzku83/z89phLTXaSpfPZukaCFfCESfQo4PVlHLt8SEzt8UgO3OVC5kCZ2dbpmiMEfhZhMyqK94wPOyJ9+E9kmn32b7d5Uf5+5c/xRW4EUVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hjzyx3dP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D700C2BCB3;
	Fri, 17 Apr 2026 19:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776454056;
	bh=VD1dpDVeoOvo9DNemmyMtF3vP2OX5ZAXEaiRVAhP5nI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hjzyx3dPlpp4Wj7DSwfWWX+xovsRHJGg/zee9wdt9F0U2dukbrMVyy6GGjtwVGQD1
	 Ni6UP2A/6GQaqrFo34sldrhOgA6kH41+7Ljxw3rZWa8dKDij+F3L1U6CGeGHZSFzbK
	 pfh4ZNl4jMRmGd/eX5+3f2dgWbkMPqnNsWsdKd/QPy6wthkDL1ZK97lNDpaawX4m0k
	 +DGgbzKF0x70Z2KSy6HS6DnxRK6KjLwl9ZvpMUc5kvFCiDtY+IJ/AKR7Y5rvlnHe/X
	 j877jxQYOLrdKayX0214sWj2D2xpba2ZxxAIFPFsNoNBu2i5Avbgq1dirHltXfPUK1
	 5J95AnsTasIcg==
Date: Fri, 17 Apr 2026 12:27:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Scalbert <louis.scalbert@6wind.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
 andrew+netdev@lunn.ch, jv@jvosburgh.net, edumazet@google.com,
 pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net,
 shemminger@vyatta.com, maheshb@google.com
Subject: Re: [PATCH net v4 4/4] selftests: bonding: add test for lacp_strict
 mode
Message-ID: <20260417122725.135fcf4c@kernel.org>
In-Reply-To: <20260417140505.3860237-5-louis.scalbert@6wind.com>
References: <20260417140505.3860237-1-louis.scalbert@6wind.com>
	<20260417140505.3860237-5-louis.scalbert@6wind.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279409-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E26D541E427
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 17 Apr 2026 16:05:05 +0200 Louis Scalbert wrote:
> +ip netns exec "${p_ns}" tc qdisc add dev eth0 root netem loss 100%

netem is not included the in the config for bonding tests, this fails
in the CI.

