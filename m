Return-Path: <netdev+bounces-74433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D97A861476
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4010D1F21719
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282F3548E3;
	Fri, 23 Feb 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3Pifbet"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052DF224D8
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699612; cv=none; b=mOyuBkRnTZlop5VpsfrmeoE7ahUlRN3KorL38pdvkdcWaoX6e+Q14rop0lYruhj031gwYpfcKYxLP1k64aAY31cZGZV0dcE+6xa4gV6WQidPZp6sHHjdFdEM7N0BinENnbMTwSzLIOS2Ge44bsfaytEef/rfWkRMmWIJYrlYnTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699612; c=relaxed/simple;
	bh=l6zPO332dN3Fw/POtBhzz1Mbt/dP7BClRZRpR00jiFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhf7wgqHgjYSfGpfjYgDCGipyWkyAfQyiBnWVeSavfTPWk1ZGyUrOcGxEqzT50Jv1X3l9syelcYIChwB2GlTzpE0HgM2I74MkT7DfOmhYkBs/kROUGd/ulcdlsV5whMqOwylOAWYevUyOX/Ir9yV/mQTrRQHwtfFDD0Gv0E4q10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3Pifbet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E6EC43390;
	Fri, 23 Feb 2024 14:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708699611;
	bh=l6zPO332dN3Fw/POtBhzz1Mbt/dP7BClRZRpR00jiFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z3PifbetyKK2Wp9E48nka9b8gI2t65F0G7oNLZ5pDuQZnGhKbobjmDRiB6HRzMJK+
	 sjWvR/OUMX2sIJ/KG1va7LogNa3l+4vSwk56pNCGv0PbLzg1MWAM0PfsjmQ6ApSJdf
	 ZDuB51qPB3p4nek2lZYGSxXqanpnOLq7IIw57dp6cqlaxIgNvaMeyeZRHIgaJbgXvW
	 UGBQRsozCszwGbJkCMqTVpQEnNgs3HA9FgQWHO34hLyqmx2TBTW/saR+MCkVvJZOvf
	 RQ56FOP7LorATQpkvSS8ifg013fxpIUyKWU/un//rnkH/Gh7TNNO+2YyHgjFeFdCFo
	 zYWUV2/8TPHIA==
Date: Fri, 23 Feb 2024 06:46:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, sdf@google.com,
 donald.hunter@gmail.com
Subject: Re: [PATCH net-next 02/15] tools: ynl: create local attribute
 helpers
Message-ID: <20240223064650.7e7b5975@kernel.org>
In-Reply-To: <1b2fec9f-881d-48fc-bb11-b6269c4ad2f5@6wind.com>
References: <20240222235614.180876-1-kuba@kernel.org>
	<20240222235614.180876-3-kuba@kernel.org>
	<1b2fec9f-881d-48fc-bb11-b6269c4ad2f5@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 15:03:49 +0100 Nicolas Dichtel wrote:
> > +static inline unsigned int ynl_attr_data_len(const struct nlattr *attr)
> > +{
> > +	return attr->nla_len - NLA_ALIGN(sizeof(struct nlattr));  
> nit: NLA_HDRLEN ?

IIRC I did that because I kept looking at the definition of 
NLA_HDRLEN to check if it's already ALIGNed or not :( The name of 
the define doesn't say. Not that it matters at all given the len is
multiple of 4. If you think NLA_HDRLEN is more idiomatic I'll switch.

> > +		NLA_ALIGN(end - (char *)ynl_attr_data(attr));
> > +
> > +	nlh->nlmsg_len += NLMSG_ALIGN(attr->nla_len);
> > +}
> > +
> > +static inline const char *ynl_attr_get_str(const struct nlattr *attr)
> > +{
> > +	return (const char *)(attr + 1);  
> It's the same, but I tend to prefer:
> return (const char *)ynl_attr_data(attr);
> Same below.

SG.

> > +}
> > +
> > +static inline __s8 ynl_attr_get_s8(const struct nlattr *attr)
> > +{
> > +	__s8 tmp;
> > +
> > +	memcpy(&tmp, (unsigned char *)(attr + 1), sizeof(tmp));  
> Why a memcpy instead of a cast?
> return *(__s8 *)ynl_attr_data(attr); ?

Sure.

> > -static inline __s64 mnl_attr_get_sint(const struct nlattr *attr)
> > +static inline __s64 ynl_attr_get_sint(const struct nlattr *attr)
> >  {
> > -	switch (mnl_attr_get_payload_len(attr)) {
> > +	switch (ynl_attr_data_len(attr)) {
> >  	case 4:
> > -		return mnl_attr_get_u32(attr);
> > +		return ynl_attr_get_u32(attr);  
> ynl_attr_get_s32() ?

Ah, good catch!

> >  		case NLMSGERR_ATTR_MSG:
> > -			str = mnl_attr_get_payload(attr);
> > +			str = ynl_attr_data(attr);  
> ynl_attr_get_str() ?

ditto.

Thanks!

