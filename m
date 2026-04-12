Return-Path: <netdev+bounces-277910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGFPJIMK3GkTLgkAu9opvQ
	(envelope-from <netdev+bounces-277910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:11:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CCE3E609C
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68F5030097F1
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F315530100D;
	Sun, 12 Apr 2026 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLE03Y4L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D053B2D5932
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028275; cv=none; b=RlSWWRZRmz9hXFbfAD7d5srSGYtmtzAr/F+Cy/3KVEKHo8JJGikyF1e5KJoBtt7QV0CRnx3xZ4To+mfW34foSIqORRvddi9Ebd0o1y/TYp9iyrXrDZL/Qeol7w5PjoXQlMq6Ha4VZbsmT31BIRYZO3EraGH52E+tsoS3OyWHbF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028275; c=relaxed/simple;
	bh=7h72O8J1t6GQdbWDBIiZ/xoi8r5SCMuSyGW9OZgZNHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQ9J3IHVdPQ2GKN3pYsCkUwCE9Zg8jjQaR9id6VAsvK7rZOssZKDq1TnLiCvlMvGZZKIL2dLPl8AKwKu1t3vohZlnKtLU1sNNIA/s21frsgqm2VZRdPKEVtpF7v672zVcrv6cbz5VjecZRdqRdmtoRMbJ2eHeIhfLGC7eMM2Tx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLE03Y4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D91C19424;
	Sun, 12 Apr 2026 21:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776028275;
	bh=7h72O8J1t6GQdbWDBIiZ/xoi8r5SCMuSyGW9OZgZNHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VLE03Y4LP7DR+N6Uri8oGO1EEawfE2dUfH3pcqBfCAuc1RzbPucGUmMdFNBAWdhXQ
	 INXgB5CuA9SS5dEfz2vWHkJfKyLBU/vB7lWFQowGfc8wBISe3Wl2QH8LokEg1d0CRJ
	 nbsct30LqH3yQguDdvKmquZX971VHK1uBfFq8etu8nofab4GKemaHzCmubCHYG/wrv
	 FegzbkcJnReYDZA+/wbcZ6MtWPv0DHxn2Le2BIPj8wwO6URSRKn8fuMarbl3r5jkhq
	 kwi8i+bfsN7Hf9v6FHGxmx/hyC8YaKkFw8o6c9QpKU6pdMXKSzw7un7G9HMWrvWMVG
	 JJ7/U1iYeRouw==
Date: Sun, 12 Apr 2026 14:11:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 00/15] ip6mr: No RTNL for RTNL_FAMILY_IP6MR
 rtnetlink.
Message-ID: <20260412141114.143d0858@kernel.org>
In-Reply-To: <CAAVpQUAnpk+A2M=Or=0C=ksbTMo0zuBst3aKC3wpAdP8AKpRzg@mail.gmail.com>
References: <20260410211726.1668756-1-kuniyu@google.com>
	<20260412075856.68f37eb6@kernel.org>
	<CAAVpQUAnpk+A2M=Or=0C=ksbTMo0zuBst3aKC3wpAdP8AKpRzg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277910-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 57CCE3E609C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 12 Apr 2026 13:50:59 -0700 Kuniyuki Iwashima wrote:
> > Hitting a bunch of:
> >
> >   SKIP      no netlink MFC interface
> >
> > on the new test here. Do we need to add something to .../config ?  
> 
> No, I used SKIP() intentionally becuase only IPv4 has the MFC
> netlink interface and IPv6 does not have the corresponding one.
> 
> Should I just return 0 in this case instead of SKIP() ?

XFAIL

