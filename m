Return-Path: <netdev+bounces-68261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E9F846562
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 02:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20231C245A1
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 01:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC07BE59;
	Fri,  2 Feb 2024 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mle8mWI0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E49BE55
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706837077; cv=none; b=u7mdJDDpg6LywYcaTAaI1WVpy5e3mnBX/oBaMSw2/nu0oboGIEARg6NHS0YOc6kI2SmS3hrzjvYh06Nh8qwd5vIV7Ii81uPzxZU1wKF/snZwJjAnqk5mgcPV6KlRLngeLGaAi2BKm1sxFBpPY4COFfhy6gnjYnAd5G01kMeL0U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706837077; c=relaxed/simple;
	bh=ZMFg9aMmYEcvittqxuoJAHUrrVGw5BpEBs3Oavdepd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gbjl4gOuosyun+//129KHM2UoHTHq4o1qYJvStFWAaRva9l24bsfAvtDSdBOPZLaRQ/1a1b2J0MFa0HxVD8YDEXAHwP8HJ7r21M/FbG9uwySNkqGn8fQwFlooNKi1vNY9zczgwxn/m4Y3pqMJHOg3XeBL5nUKtPOKVdxz6C2WSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mle8mWI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9C1C433C7;
	Fri,  2 Feb 2024 01:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706837076;
	bh=ZMFg9aMmYEcvittqxuoJAHUrrVGw5BpEBs3Oavdepd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mle8mWI0z/plQAkqRgEiHpQuaoPiIDRzdKpD/9ALeEMcgKqcnIwho856pc+USwNkW
	 jEaC48wPVEorNiJsI6T8l5EE8IjJcFQ9bAyf9ZhlHN74YVbkmzwopxa8JbPFpf5nJb
	 B7dQM39F/SIp+DHrJhWC/txfQceABpaU8pmx0G/hluOJkhZW67bnY1tqbGxV3Pzp8y
	 6vsKlc4seQELzsLkVP8NtD6/p7AAW5TnJ98I6uGYFIt3LIMiJ+AHKRAGSOyGnl+cxa
	 BDlu4QeX8XWdhb1L0PkYUhEk6GyVaYQVShjxqMu0HwxQjeOsTIWtfgItuzWlBKCyvE
	 zP532XtixFYgQ==
Date: Thu, 1 Feb 2024 17:24:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, sdf@google.com, chuck.lever@oracle.com,
 lorenzo@kernel.org, jacob.e.keller@intel.com, jiri@resnulli.us,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 3/3] tools: ynl: add support for encoding
 multi-attr
Message-ID: <20240201172431.2f68dacb@kernel.org>
In-Reply-To: <9644d866cbc6449525144fb3c679e877c427afce.1706800192.git.alessandromarcolini99@gmail.com>
References: <cover.1706800192.git.alessandromarcolini99@gmail.com>
	<9644d866cbc6449525144fb3c679e877c427afce.1706800192.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Feb 2024 16:12:51 +0100 Alessandro Marcolini wrote:
> Multi-attr elements could not be encoded because of missing logic in the
> ynl code. Enable encoding of these attributes by checking if the nest
> attribute in the spec contains multi-attr attributes and if the value to
> be processed is a list.
> 
> This has been tested both with the taprio and ets qdisc which contain
> this kind of attributes.
> 
> Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
> ---
>  tools/net/ynl/lib/ynl.py | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 0f4193cc2e3b..e4e6a3fe0f23 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -447,10 +447,19 @@ class YnlFamily(SpecFamily):
>          if attr["type"] == 'nest':
>              nl_type |= Netlink.NLA_F_NESTED
>              attr_payload = b''
> -            sub_attrs = SpaceAttrs(self.attr_sets[space], value, search_attrs)
> -            for subname, subvalue in value.items():
> -                attr_payload += self._add_attr(attr['nested-attributes'],
> -                                               subname, subvalue, sub_attrs)
> +            nested_attrs = self.attr_sets[attr["nested-attributes"]]
> +
> +            if any(v.is_multi for _,v in nested_attrs.items()) and isinstance(value, list):

I think you're trying to handle this at the wrong level. The main
message can also contain multi-attr, so looping inside nests won't
cut it.

Early in the function check if attr.is_multi and isinstance(value,
list), and if so do:

	attr_payload = b''
	for subvalue in value:
		attr_payload += self._add_attr(space, name, subvalue,
					       search_attrs) 
	return attr_payload

IOW all you need to do is recursively call _add_attr() with the
subvalues stripped. You don't have to descend into a nest.

> +                for item in value:
> +                    sub_attrs = SpaceAttrs(self.attr_sets[space], item, search_attrs)
> +                    for subname, subvalue in item.items():
> +                        attr_payload += self._add_attr(attr['nested-attributes'],
> +                                                       subname, subvalue, sub_attrs)
> +            else:
> +                sub_attrs = SpaceAttrs(self.attr_sets[space], value, search_attrs)
> +                for subname, subvalue in value.items():
> +                    attr_payload += self._add_attr(attr['nested-attributes'],
> +                                                   subname, subvalue, sub_attrs)
>          elif attr["type"] == 'flag':
>              attr_payload = b''
>          elif attr["type"] == 'string':


