Return-Path: <netdev+bounces-74232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4378B860927
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 04:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E260D285C1F
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 03:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C573BE5D;
	Fri, 23 Feb 2024 03:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJOwo+jD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FA5C122
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657527; cv=none; b=RbEt6RYybzNAc93DegwAuP+Jb759o7LCt/Bp3V2Fy2HDUsx94HhBVtld5VInl16hYZVl1cavy43K8eBGXmfXCRrDvgAiBcFzAG2p0dn4vZ02LDghoUeAJWVRV+avf+j4057hckpAfWhUZ7VR0LdTPshePZD49u1TkHGv4buSPD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657527; c=relaxed/simple;
	bh=KJpv2DVwkF9VAufKYnVNifX0K8PqxSDGUdbTZmMBDqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvD9Vz87yDs48MKpWiW0gleXnsdnE4pIxgd8kXbLfoxdQ5qY6z/DiUmxVKDdCklUbdmJ/nWl+ZOLzs1EdI+8IFhLV/RRO7C7mC4xCNTfIleovsJgMzTi3geOIk8NiFoOi3ZUkmuCG2+3/RZleakx5CJOABHRA+9Wqvzkoyxj1ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJOwo+jD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7618AC433F1;
	Fri, 23 Feb 2024 03:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708657525;
	bh=KJpv2DVwkF9VAufKYnVNifX0K8PqxSDGUdbTZmMBDqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CJOwo+jDbWxEGPM+pVfq3Qjn5wmQnOpw92PHD87kyoY3QXUjRm6f/tM/xO/MnwsQf
	 o5ZoJBrs/WEi1q4v7vrQEOlFQur70JbCOnHrEra7SRC/Rmr/dWxSDIgf3SDPmPBdPA
	 0ZLW81XyQ07gzWovq6m8FLbuIKKg/lza/3Afxgh4BdcrMLSBnhSMLZmUW1ARsAjGig
	 H5M6ciSS/orIS0ycjVcWAygh4cJlXrP6UPEypyM6WzEJOJyhjNtgYnmeDlayVrQh6k
	 +CRRKabNjpnNFTYtfgTt9Z3YehIcNIjb4fHznNJwwb0E6VtkZURHKkd/OjUHTg7oWg
	 HABoejgUTeNxw==
Date: Thu, 22 Feb 2024 19:05:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: <netdev@vger.kernel.org>,
 syzbot+3f497b07aa3baf2fb4d0@syzkaller.appspotmail.com, xingwei lee
 <xrivendell7@gmail.com>
Subject: Re: [PATCH net] netlink: add nla be16/32 types to minlen array
Message-ID: <20240222190524.137fb84a@kernel.org>
In-Reply-To: <20240221172740.5092-1-fw@strlen.de>
References: <20240221172740.5092-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 18:27:33 +0100 Florian Westphal wrote:
> Note: Other attributes, e.g. BITFIELD32, SINT, UINT.. are also missing:
> those likely should be added too.

Not AFAICT, FWIW. The sizes of those are checked explicitly in
dedicated switch cases, rather than the default case. We could
still add them for the sake of nla_policy_len(), but not a fix.

