Return-Path: <netdev+bounces-137797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4EC9A9DBB
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69007284226
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8069019343F;
	Tue, 22 Oct 2024 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn3eqQOH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A42E2BB09
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587565; cv=none; b=A5YXoEokYLwWGUqHB2UaHNMrU9zftt0Yjw95/eqvvuPk2fSeGg5Si2BPWWR9r3VgF9R95m3/HU0Vx2KsVNXcEJc+jvFU9rQhvxVu4ShrxyprGXzseQcXu5FwrBtbw19MR7D6I51mnoETxtSwopeVxYEKicNJKo4P474i9IV/Xzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587565; c=relaxed/simple;
	bh=5eXpd5te8xm/yapD8YQMh4TuNbGd84GpOKGaCnsGhr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX+3jdV6WooYj2nPGUcOIsRzpFQRz9vo/JRSgXY1gZojNhBPBswXEZvQO7zHJ90Ig7qm4teA14o94afs9khWrCyaUtQwgm+XsAI+IMEuW9yB/RE5fxJcs3gFhFlVRL2dFZnKehzEgxCmrsEjOuT+UWVLSULXHeHBhyiFkxkOoh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn3eqQOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2303C4CEC3;
	Tue, 22 Oct 2024 08:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729587565;
	bh=5eXpd5te8xm/yapD8YQMh4TuNbGd84GpOKGaCnsGhr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qn3eqQOHvIBsOiKBdRxaSfIqwBgD6P4aYA61vglvTOwSA5Xdk9FjY1Umb26ARtCA9
	 U1FGEI9+nk9E+q4a9/dDDEmMwI4ESEzNLkneeOCZ5m1cx+ZEWcB3qOd4l0BJxnsA+h
	 iLjb7Rg3teJ0kpzHqhhg9bVmLA/zo2aq1lLJCOtkZgRS8lOwETLOs1pU6x5GIJxsqK
	 OIiDK0NQB/C6sQJ3qb4HKg7RToB013lmEFkW3ENjSOL5LtnkwFLogApESv4GTDBo4x
	 gzEoHLLlpnuts2+8Tw054PRJlZjW+W3Tz3qxHIn/AgqrD+eIWr2I1tgg/6EP1VR2yq
	 YAcfClETQZ4bw==
Date: Tue, 22 Oct 2024 09:59:20 +0100
From: Simon Horman <horms@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>
Subject: Re: [PATCH v2 net-next 13/14] rtnetlink: Return int from
 rtnl_af_register().
Message-ID: <20241022085920.GS402847@kernel.org>
References: <20241016185357.83849-1-kuniyu@amazon.com>
 <20241016185357.83849-14-kuniyu@amazon.com>
 <ec78e7dd-a0c4-45e3-afe6-604308f7240e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec78e7dd-a0c4-45e3-afe6-604308f7240e@redhat.com>

On Tue, Oct 22, 2024 at 10:53:32AM +0200, Paolo Abeni wrote:
> On 10/16/24 20:53, Kuniyuki Iwashima wrote:
> > diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> > index 445e6ffed75e..70b663aca209 100644
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -686,11 +686,13 @@ static const struct rtnl_af_ops *rtnl_af_lookup(const int family)
> >   *
> >   * Returns 0 on success or a negative error code.
> >   */
> > -void rtnl_af_register(struct rtnl_af_ops *ops)
> > +int rtnl_af_register(struct rtnl_af_ops *ops)
> >  {
> >  	rtnl_lock();
> >  	list_add_tail_rcu(&ops->list, &rtnl_af_ops);
> >  	rtnl_unlock();
> > +
> > +	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(rtnl_af_register);
> 
> kdoc complains about the missing description for the return value. You
> need to replace 'Returns' with '@return'.
> 
> Not blocking, but please follow-up.

FWIIW, I think "Return: " or "Returns: " also works.

