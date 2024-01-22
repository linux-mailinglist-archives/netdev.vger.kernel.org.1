Return-Path: <netdev+bounces-64818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CD4837304
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 20:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2099B1C286C1
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D1C3FE54;
	Mon, 22 Jan 2024 19:46:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53124642A
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952779; cv=none; b=VsA2S2H6QdG8oOSQGlFLTaMFDMwQ98eRksre2QPXJsz+dUq63Zzwd8cym/Uv1jpqaY2ZJqv8vPS5tHcFslx+cbFAR61ewc19LOgTQdKi63uZFfr/PBHEpr93L80/HS2wcbRlOx+QTKTJZHuyVSXafG4RYqstgD8zzT581M17jgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952779; c=relaxed/simple;
	bh=46NDaPiy2WLKjYXbFo/0c/RBVwt2Ll8GtphP9coHijI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aaz1wGy/qw+lK52svbvbgmVUo79j+gO9MZq5JSSs1v3qxMjgO7aVrVhEq087jopIoj4Pi+SpkXSqMYB9J3J56kcq0e9jnnoR8MZPkTed7hQnzGWOITXwxhgUn8JX7PhhaekMJ4U/tx00pPd2H6t1kFMVwBP6WvxTpHoFtQcC9eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a6833c21eso2477053a12.2
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705952776; x=1706557576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ydx7YfC7UNG8U2pQk+ORB1XbZAnxJNoWn1IMuvWKXDU=;
        b=oyDWiJMkT8u5M+4Ai4dgoL3RUZK6SeLUER5Pk6VVH+WQdey4fo24zqBL7xEV4IchIr
         5TqSLfA8fGflLhroIZQsj4G1zPJ57mY+vMMMXMsAu1drDEqeoAO2n+gjB0ek+s4qVvgA
         Jrnm0eiXOnFAhHWqVS0law2j/CEjfP4nQhK4VJfrRJB93sWyFyw61Wqoy9DlVhpQXRL+
         5+IN12k4vcayr4lY/fbC0RRqd3YcOleoagDVfiC+jtnwyowH0eeS3VV5ZKAw3DM75vPi
         zUfAxSkZCKzqUaIBmmE2RMRDTedlFOdamJQWMtkDtMPlVXCeCtFWSyutXDuvmwIYiQvb
         r2mw==
X-Gm-Message-State: AOJu0YyzOCc3STKu9fWSKX4PjJ8ZZ9V7wOtjtugWu66Fq8V6Bx4FA3vD
	GYZyGUzR3Q4yiAUX1fe8zXr5BCJxUGUhd97AHng9HRGEvmryas8QpeHfQnHDjRMt7Lpy
X-Google-Smtp-Source: AGHT+IEPFk2QHn3u7lzk7T+Ihv2gL4rTj/OjAJuY783N/B9K/DTrSYlM0hnbu9PWUpCXIedc+53MpA==
X-Received: by 2002:a05:6402:d5f:b0:55a:8874:9d with SMTP id ec31-20020a0564020d5f00b0055a8874009dmr227121edb.64.1705952775786;
        Mon, 22 Jan 2024 11:46:15 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-019.fbsv.net. [2a03:2880:31ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id ig6-20020a056402458600b0055c5410b36csm993014edb.81.2024.01.22.11.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:46:15 -0800 (PST)
Date: Mon, 22 Jan 2024 11:46:13 -0800
From: Breno Leitao <leitao@debian.org>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com, sdf@google.com,
	chuck.lever@oracle.com, lorenzo@kernel.org,
	jacob.e.keller@intel.com, jiri@resnulli.us, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] tools: ynl: add encoding support for
 'sub-message' to ynl
Message-ID: <Za7GBaCiE+LUv6ZZ@gmail.com>
References: <cover.1705950652.git.alessandromarcolini99@gmail.com>
 <0eedc19860e9b84f105c57d17219b3d0af3100d2.1705950652.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eedc19860e9b84f105c57d17219b3d0af3100d2.1705950652.git.alessandromarcolini99@gmail.com>

On Mon, Jan 22, 2024 at 08:19:41PM +0100, Alessandro Marcolini wrote:
> Add encoding support for 'sub-message' attribute and for resolving
> sub-message selectors at different nesting level from the key
> attribute.
> 
> Also, add encoding support for multi-attr attributes.
> 
> Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
> ---
>  tools/net/ynl/lib/ynl.py | 54 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 1e10512b2117..f8c56944f7e7 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -449,7 +449,7 @@ class YnlFamily(SpecFamily):
>          self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
>                               mcast_id)
>  
> -    def _add_attr(self, space, name, value):
> +    def _add_attr(self, space, name, value, vals):
>          try:
>              attr = self.attr_sets[space][name]
>          except KeyError:
> @@ -458,8 +458,13 @@ class YnlFamily(SpecFamily):
>          if attr["type"] == 'nest':
>              nl_type |= Netlink.NLA_F_NESTED
>              attr_payload = b''
> -            for subname, subvalue in value.items():
> -                attr_payload += self._add_attr(attr['nested-attributes'], subname, subvalue)
> +            # Check if it's a list of values (i.e. it contains multi-attr elements)
> +            for subname, subvalue in (
> +                ((k, v) for item in value for k, v in item.items())
> +                if isinstance(value, list)
> +                else value.items()
> +            ):

This is a bit hard to read.

Is it possible to make it a bit easier to read?

