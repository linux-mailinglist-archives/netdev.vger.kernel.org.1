Return-Path: <netdev+bounces-75389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C45869B5F
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04861F21FE0
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA91146E78;
	Tue, 27 Feb 2024 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRFr+82x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91514690A
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049367; cv=none; b=ciXPza9WUqtFzgwirJGaBLhNhV5x6JJzQjrxgdCwHD0J0EuGB8eziHE25fxz1YNUisKWS4GTvy9py+501F3p469Dmq6BuakSyVZYlYNFJkfc4kW8WonlhxuThBCcFrz+mJvSkwQHet/OfS1aGyONC6V5rT+uV20NcmOBharNRw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049367; c=relaxed/simple;
	bh=QFelD9gLAoanges+RCJzjDEagMHCJVtY8FQKqVkcovE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EL4TiEroN9qzRA7bhIoAL2svWj5WUaTy4pwLL15snYDhxi/xnrXJvkMSinZ6BgMA0eaZ+CWv6EkV1CBywbOuPsvBCxrKXPZ1JnCsDWoYTyoWTpucJVNcmDVslbB5RSdw5xJS87QLahaYgoDxzstwZjuHdIY+AkiN00unc1tA7M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRFr+82x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C118C433C7;
	Tue, 27 Feb 2024 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709049366;
	bh=QFelD9gLAoanges+RCJzjDEagMHCJVtY8FQKqVkcovE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TRFr+82x4dL6Yqsk+GVlsE101cD4SkAjUdmIne0ns+ADGbppPaqrtwayEPMudVoTm
	 qfiiqQeRfBJE1jBFoosSqEApXYgOHEyF1xXfYmOaeku+7j1xCuTR5Tjdi0KczoG39U
	 taoBX819szPdLmn/DwcaqYlONQjEpwWrtaoF2DguHXj2YncT5z8BqSWFDmJ/D+HG0w
	 ZCojIbAP4KlHnQTbrWokshBA99ezS/VK+CsEGMsuaIC/AcPcEaLVqmvcdg24a22o3I
	 j1+BWpJzBH01ORN9tK7DEWAduz03B+2dfBtMoVZmmmo+I3vyC8ZYVCIRN4/e1A2V5s
	 TS1N537b4EwKw==
Date: Tue, 27 Feb 2024 07:56:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, sdf@google.com,
 nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 00/15] tools: ynl: stop using libmnl
Message-ID: <20240227075605.18ec70b8@kernel.org>
In-Reply-To: <m2ttlumbax.fsf@gmail.com>
References: <20240222235614.180876-1-kuba@kernel.org>
	<CAD4GDZzF55bkoZ_o0S784PmfW4+L_QrG2ofWg6CeQk4FCWTUiw@mail.gmail.com>
	<20240223083440.0793cd46@kernel.org>
	<m27ciroaur.fsf@gmail.com>
	<20240226100020.2aa27e8f@kernel.org>
	<m2ttlumbax.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 10:49:42 +0000 Donald Hunter wrote:
> > +static inline bool
> > +__ynl_attr_put_overflow(struct nlmsghdr *nlh, size_t size)
> > +{
> > +	bool o;
> > +
> > +	/* We stash buffer length on nlmsg_pid. */
> > +	o = nlh->nlmsg_len + NLA_HDRLEN + NLMSG_ALIGN(size) > nlh->nlmsg_pid;  
> 
> The comment confused me here. How about "We compare against stashed buffer
> length in nlmsg_pid".

The comment should give context, rather than describe the code so how
about:

	/* ynl_msg_start() stashed buffer length in nlmsg_pid. */

> > +	if (o)
> > +		nlh->nlmsg_pid = YNL_MSG_OVERFLOW;  
> 
> It took me a moment to realise that this behaves like a very short
> buffer length for subsequent calls to __ynl_attr_put_overflow(). Is it
> worth extending the comment in ynl_msg_start() to say "buffer length or
> overflow status"?

Added:
		/* YNL_MSG_OVERFLOW is < NLMSG_HDRLEN, all subsequent checks
		 * are guaranteed to fail.
		 */
SG?

> > +	return o;
> > +}
> > +
> >  static inline struct nlattr *
> >  ynl_attr_nest_start(struct nlmsghdr *nlh, unsigned int attr_type)
> >  {
> >  	struct nlattr *attr;
> >  
> > +	if (__ynl_attr_put_overflow(nlh, 0))
> > +		return ynl_nlmsg_end_addr(nlh) - NLA_HDRLEN;  
> 
> Is the idea here to return a struct nlattr * that is safe to use?
> Shouldn't we zero the values in the buffer first?

The only thing that the attr is used for is to call ynl_attr_nest_end().
so I think zero init won't make any difference.

