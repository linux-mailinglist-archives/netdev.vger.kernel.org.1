Return-Path: <netdev+bounces-204121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A140AF8F48
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2C84A3234
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6212ED87A;
	Fri,  4 Jul 2025 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Yn4P6AJZ"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48722877C7
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622987; cv=none; b=ROy/0hv/F6jeuxETWts5MDDflfO+kJJcoK946sh85pL9CPwF9gb5emxj8Im9ZRUx9pIPpQ6OnaH2lZhkOLEPlmEhgo1dPxrWgvic8aAwdYJ84H1+aGSr/xOVYfetzux1d94BKFe2B0fV6KZ9iB5Tnb1Ek9tdvbPKe9XGIflgb80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622987; c=relaxed/simple;
	bh=p6ab+A8GIw9Q7+inX2Is16BfL4Tl9jA3vCzG1xLzaio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JroDaRPLOUk/vDNLLRtSZPODZ0AHAkw9QoXlbLyclGja93rPPDdONCbEDp0AKYYV1/qLH6Hek+piu2+o4j7W3XDDj+05Vuw84dM4wwoqXpvmh7T4Aumiehhi1vQL1YvdZ5X0O6zmN1YnF/QZff+4ubCaTodALxFUb+vySUa5kjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Yn4P6AJZ; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=S9D0lyLeeEXKXWj4kE4xVZvNUzjAtwv8/HEleRFEIGU=; b=Yn4P6AJZapElDop+pzvcRVkACL
	/heEFsHHJlInSL/UkgKRZFBjRNGbQzEY5SGF2wgRCa1brJgc0w5kWKMWQ1LXSCqzW2NGxpuEuVgLn
	yG+praBsgzXthFCAuxA7tcncCZmX3+RFjeyadeZMB/tHqCh5edIhFIFzDfweatsINPu7uf3SAXEaA
	czPGeU2uCLkEtcKLGRy8aIcr0sIwkvoOlU4FNys+BsdPDYQzWGINBBmyYQC3+U1wptjlWhMd4uKR8
	i/JgHeOtlHmVKZrAPaTigym61VioDc8nw9Dp8H2k40pwpDosg/WrfX8GPTDxF7oK3ia5gDLvN444q
	jwuNMEIg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uXcWg-003lax-1S;
	Fri, 04 Jul 2025 17:32:07 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Jul 2025 18:32:06 +0900
Date: Fri, 4 Jul 2025 18:32:06 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Paul Wouters <paul@nohats.ca>,
	Andreas Steffen <andreas.steffen@strongswan.org>,
	Tobias Brunner <tobias@strongswan.org>,
	Antony Antony <antony@phenome.org>, Tuomo Soini <tis@foobar.fi>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	devel@linux-ipsec.org
Subject: Re: [PATCH RFC ipsec-next] pfkey: Deprecate pfkey
Message-ID: <aGeflnqOpO-V9Tq7@gondor.apana.org.au>
References: <aGd60lOmCtytjTYU@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGd60lOmCtytjTYU@gauss3.secunet.de>

On Fri, Jul 04, 2025 at 08:55:14AM +0200, Steffen Klassert wrote:
>
>  config NET_KEY
> -	tristate "PF_KEY sockets"
> +	tristate "PF_KEY sockets (deprecated)"
>  	select XFRM_ALGO
> +	default n

The default is always n so this is redundant.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

