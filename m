Return-Path: <netdev+bounces-242737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E9DC94625
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 18:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD6993444B8
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 17:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35DE310650;
	Sat, 29 Nov 2025 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLrOB9qf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0CA257459
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764439082; cv=none; b=WdHfTAPmjXfHniSL10yyAUmOmAG8iAPYecRplUeeZTyBzGnfeZeL1KwqhDHApXYSbbtNKAWNmuU9AxnacaQkEuTQrMsQgrr61pEzdhGC6vQPY7clL520z3FHfu+gvlzN+JbhBWBwX9mTp78AW3M9LwKlpfq8+vfORZfgpCe44ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764439082; c=relaxed/simple;
	bh=P5ea6rhg1tn33BxF1mRW9QFLEqo08tbuxXWGiosvMWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSmUkTa0Q1zuhgNpkLK638KY9QsNvS7xwVExfQj/OgyJ7zOtSEkSzSDSoHEZtnR3iqfrOSrLWoRZTgJ+keh/yrq58mDVvLcc7zMvhO16IWzYll0TTuiZpiCcA08sOrWniDjyaxFvxVVMJ2SsckxDweaEnuYXu8P0aY8Xnk6STjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLrOB9qf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99287C4CEF7;
	Sat, 29 Nov 2025 17:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764439081;
	bh=P5ea6rhg1tn33BxF1mRW9QFLEqo08tbuxXWGiosvMWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rLrOB9qf6sBM+sfZMMRCGsuhgNQpJzjlYG/kmKeVmmPKDJ1yR9SPCAmeyLzHr4qJ1
	 cAASEqjmntvn9XAefHa4n4qYcUo0ecc9R4fyBQGBhALzkeVU58FWvShShX1fD14G2x
	 zynnV5gx/dK+BU5emoPJueTGarnImYTomUF7TwitXVznL5UGCep5ztDUe6PPC0cL6c
	 I8H1B4oLxCKAXoo3V5q0HRDVSnEIh5cz//aSh4IMP36tHhYijUZKpNb2B9vmmlJEnV
	 J6Zboj7RUuec8JkxD1hhrgfH4WAKL+/92FNLM/7yGGn/LWRT8NBOS88kg7floNajqS
	 JX03pSh1T4g3A==
Date: Sat, 29 Nov 2025 17:57:57 +0000
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next] l2tp: correct debugfs label for tunnel tx stats
Message-ID: <aSs0JRkNEw7wj2bw@horms.kernel.org>
References: <20251128085300.3377210-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128085300.3377210-1-alok.a.tiwari@oracle.com>

On Fri, Nov 28, 2025 at 12:52:57AM -0800, Alok Tiwari wrote:
> l2tp_dfs_seq_tunnel_show prints two groups of tunnel statistics. The
> first group reports transmit counters, but the code labels it as rx.
> Set the label to "tx" so the debugfs output reflects the actual meaning.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Simon Horman <horms@kernel.org>

