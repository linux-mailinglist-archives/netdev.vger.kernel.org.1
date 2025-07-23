Return-Path: <netdev+bounces-209461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1629BB0F987
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96AD6189932B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62AA22068B;
	Wed, 23 Jul 2025 17:38:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDE81FECDD;
	Wed, 23 Jul 2025 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292285; cv=none; b=FSPDxsj8hx6qq1Lwe6RsSEnDtTfV0eWLSQ+IANjx98J5J9sqrp/C6UHbqPB5QbZ3Ur1UJyxKjFrndWI85nXvWMZcDJKD1WAlyknVnAWvi7kRFb5UkAdJOVFA5nJHwxK7Af1LFi/ppZok5aTy79biVg3LhAlTC6D7/vpWZiEBGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292285; c=relaxed/simple;
	bh=4H/8cvAlzzijGnO45p+GF9IzfW2DCmApE2O4FWgIqCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDqhd0W3xWuYQuehNtHw7kYItUzji6+bETj9fMWnF6VgbSFINvpiEpwq+SQ/6EfGkLG3bLC6VC0vljv850OESLxcc+//UlX1EXUO6/8JenbF72WpOAtQPDNl9SQlVFfwJB9+E6za4lSC/YzbPJ8XdTahMAZZQvWXBoGk3t5D3xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so12266366b.2;
        Wed, 23 Jul 2025 10:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753292282; x=1753897082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLib4tbx2PfQpPOdJVFlUTHL/WscmwWuW3AT7VBz8YQ=;
        b=PNd4cFnxUzJwq/LZKK2kSnbKukRI3zsK0KVjc7Go54k0peFbifZc0iQBU21/PBI4bR
         CkbDBRGowxDHS3Iqzd9j3gAuGiqHsZqIftktCI1mcuvWr0Ps7htyrMn8BhEIeOHPnoWu
         B0fP6mV6yFjt49fGLRGsPonftZpazyL4/KDbsb+CjQJlCsMCwPz9TFNMnc5jrMki/kMB
         XFFL+RUrjxd2rEcVBCwraw3XHfVW7TGvfiukwyArh0mrHBW9QHyG5BqUff5k/391ZhWb
         YjwRDO5alTllTpOYQ4sUeSAfF1Y9xNWVn5LL4z77efMC2mdr4rSUoyWWW0VNBvFWUUdB
         HwOg==
X-Forwarded-Encrypted: i=1; AJvYcCU7snrmXdTYN330A3lbQswvYU1WLLipysJUVqPviHLBaktaDB8jCy4dF1RrShfiGb5W+907hXVLyNkrnIc=@vger.kernel.org, AJvYcCWrPYG+3Sh4DabZoBm/VdEvVUQDRYpvQi3DYqF+hXO31PjXQGNpcCaEY6WulVQ9OcaR/YdTryWS@vger.kernel.org
X-Gm-Message-State: AOJu0YyIIaB2kAEXQN1ylKh5QWOelsYq06HcxKznEDdsPhU1WpaA1b0B
	oEZYVqQ3woNV+Vrg3OtQtPoAcV47EAx/SykPLCxzi98jslXcRcy81UCx
X-Gm-Gg: ASbGncuz1s9HdZfRKMOElsR3g7y4DMYWYBtYSjfhNd6GYJXlZCoJG5JElymzI5vBMyc
	ebj/R+vrBWsh063vyhE6MxX2aCOjuZ+phpnojx/25MKMJ6JV/bJaKmovq7hCzBr2K+H6I4zXAEf
	N9lVUXRJUTeBr0x2GmENq2dDGHxNWa/oAA0cL1fpFtwGKXpr56i4EKXSVGjo1MmdSp1ZvDpMi9r
	y7srtDZjQe9oeqMcB8WUfG2VfsMxPEH3B70qKP8KFm/2M6sDGkVNaSypjBlVi6/N/DK7XPDJtdd
	hqlsqDxQ0lUOh3fh5e7YWqpb395z4UbFfSxK/B3oNRpfCtl3Fnhdh+iBVjLm1h+PenGsxOnVdU1
	OkZageHlOfZw2nJ7x5k6JusuP
X-Google-Smtp-Source: AGHT+IFKyx3Q9wuSh34URqG6zrn4DJvRJZyiO5qZBHB1GbSWbom2jQl3SXRF3LSwnqhPTehFz6YkWg==
X-Received: by 2002:a17:907:7294:b0:aec:65de:5258 with SMTP id a640c23a62f3a-af2f64bd1b4mr384490466b.3.1753292282133;
        Wed, 23 Jul 2025 10:38:02 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f543ddsm8656219a12.30.2025.07.23.10.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:38:01 -0700 (PDT)
Date: Wed, 23 Jul 2025 10:37:59 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 3/5] netconsole: add support for strings with
 new line in netpoll_parse_ip_addr
Message-ID: <ptspqvcgbwmyyyhtfhna3jsdzffvo2tffyl4mugkozvyen5oze@ek2i6q5kkgtq>
References: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
 <20250721-netconsole_ref-v2-3-b42f1833565a@debian.org>
 <20250723144933.GA1036606@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723144933.GA1036606@horms.kernel.org>

On Wed, Jul 23, 2025 at 03:54:11PM +0100, Simon Horman wrote:
> On Mon, Jul 21, 2025 at 06:02:03AM -0700, Breno Leitao wrote:

> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -303,20 +303,21 @@ static void netconsole_print_banner(struct netpoll *np)
> >  static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
> >  {
> >  	const char *end;
> > +	int len;
> >  
> > -	if (!strchr(str, ':') &&
> > -	    in4_pton(str, -1, (void *)addr, -1, &end) > 0) {
> > -		if (!*end)
> > -			return 0;
> > -	}
> > -	if (in6_pton(str, -1, addr->in6.s6_addr, -1, &end) > 0) {
> > -#if IS_ENABLED(CONFIG_IPV6)
> > -		if (!*end)
> > -			return 1;
> > -#else
> > +	len = strlen(str);
> > +	if (!len)
> >  		return -1;
> > +
> > +	if (str[len - 1] == '\n')
> > +		len -= 1;
> > +
> > +	if (in4_pton(str, len, (void *)addr, -1, &end) > 0)
> > +		return 0;
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +	if (in6_pton(str, len, addr->in6.s6_addr, -1, &end) > 0)
> > +		return 1;
> >  #endif
> 
> I don't think it needs to block progress.
> But FWIIW, I think it would be nice to increase
> build coverage and express this as:

Agree. While testing with IPv6 disabled, the netcons selftest exploded,
so, this explose a bug in the selftest. This is now fixed in:

	https://lore.kernel.org/all/20250723-netcons_test_ipv6-v1-1-41c9092f93f9@debian.org/

Thanks for the review,
--breno

