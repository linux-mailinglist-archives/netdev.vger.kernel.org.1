Return-Path: <netdev+bounces-37774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DA87B7177
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 21:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id D31D11F2126D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 19:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D94E3CCED;
	Tue,  3 Oct 2023 19:03:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD8D3C688
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 19:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B56C433C7;
	Tue,  3 Oct 2023 19:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696359780;
	bh=suZXgFxQ4zV1QYIU40dPflLZY9Mx9HOz24DVnFy6DRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U1jHvBUY9yOEnlptDs42Z3K9NHB0aPr83aH4+gx+5K1pXzP7/+o6Xo4P2osWReDjJ
	 Fk9ghuW7MemB3U0NphT0aUa4inxB8Rzu8R6rP7r6MHApF2w9pyrfJfSnbjZZoTClKc
	 mC2IaxmoFPmUNQZGPTDDhTDuxj9jWxeLgLbzJ7hXXL3Ub6+jjAQLqaSUtCakDnG009
	 XQKOWv6m06boHpwTgyUHQj+4T0OJwhKbJwZDwELwYPwuB5/UQhRLERfCK0jrVQwB03
	 3EFpnGmdciEwTITQMDRYM9QGXX05dDlzTdZGOdGnnr7p8gIgK2GeC5HPK+/0TK0N9B
	 /3bVeGhH7jR5w==
Date: Tue, 3 Oct 2023 12:02:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, Lorenzo Bianconi
 <lorenzo.bianconi@redhat.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown
 <neilb@suse.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v8 1/3] Documentation: netlink: add a YAML spec for
 nfsd_server
Message-ID: <20231003120259.39c6609a@kernel.org>
In-Reply-To: <F39762FD-DFE3-4F17-9947-48A0EF67B07F@oracle.com>
References: <cover.1694436263.git.lorenzo@kernel.org>
	<47c144cfa1859ab089527e67c8540eb920427c64.1694436263.git.lorenzo@kernel.org>
	<20231003105540.75a3e652@kernel.org>
	<F39762FD-DFE3-4F17-9947-48A0EF67B07F@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Oct 2023 18:40:29 +0000 Chuck Lever III wrote:
> I've made similar modifications to Lorenzo's original
> contribution. The current updated version of this spec
> is here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-next&id=55f55c77f624066895470306898190f090e00cda

Great! I noticed too late :)
Just the attr listing is missing in the spec, then.

