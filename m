Return-Path: <netdev+bounces-261409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAeAB1ZsoGk3jgQAu9opvQ
	(envelope-from <netdev+bounces-261409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:52:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B131A923E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6988C30071C3
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD86B426686;
	Thu, 26 Feb 2026 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="nqZsp6LU"
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903BF425CCD;
	Thu, 26 Feb 2026 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121112; cv=none; b=XrjJuwXmS9YYgTEmQ+xi1O0hbwnH7NBvKdHGBqFtLVXbqYu5VUSkNxqDifMkbhernSn9a8CgBqs0qrHlYz32yx4hqU5JN0faFmPiVMPTLI3Q6GIGbFqrFK5NwxZ+G6rxTWucueNfTLgVlvKUb7k15UYEC5rb6HWbP9vh68nPJT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121112; c=relaxed/simple;
	bh=TcFOcz7fVcjC6w8g43rMVq5FWzZ9P0cBZWi656YgK/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv1ZPJx10H1JCBA+/dqd8ea9z74ipqG9fHrxg6Q2WIUZ+zvViA3FuzCl9sH6OyD5UpTb/FFVBOXdg974/D48RMLl3FHXiSDidDnIzxEpHGh/9U+Y4dyz/9Ag1W968kup4tFvQsb85TNDQNlx2jHgca94gA19CY7xeSl+GB8Msas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=nqZsp6LU; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-transfer-encoding:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date:received; s=oak1; t=
	1772120509; x=1772984510; bh=TcFOcz7fVcjC6w8g43rMVq5FWzZ9P0cBZWi
	656YgK/I=; b=nqZsp6LUvVcYPsrEPhD2xELJ5WKU56XLYZMRUq4SIjzjVO5zYgT
	Yo7IpaJmm74sCwiWriUQ0JrHuouYLvzh8NGO/o37bprSBt4A7arlMw7bDPwdbuQC
	jFYP/hgGqigMx95zlvMyUwlXVozPhHqJLO7wqw63YEc10i8Ge3qWsWr/0nfISoMP
	XNpEf3OVrPuMczZl/Nv62e5SUvvEeD+7H7DovnKqQ0Km5FzuGLO1nqRGQnNJn5YP
	uOEysgcHBmdP+OGBNgdENZjyq5AC1oAXoyI+ENPuonRzUET8k6MglHX4N6w/D9Eu
	i3vIXTqAeRp16DiSAlnCqHBTkfqBKhBcLtw==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Thu, 26 Feb 2026 16:41:47 +0100 (CET)
Date: Thu, 26 Feb 2026 16:41:45 +0100
From: Antony Antony <antony@phenome.org>
To: Yan Yan <evitayan@google.com>
Cc: Antony Antony <antony@phenome.org>, Nathan Harold <nharold@google.com>,
	antony.antony@secunet.com, Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chiachang Wang <chiachangwang@google.com>, devel@linux-ipsec.org,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 3/8] xfrm: allow
 migration from UDP encapsulated to non-encapsulated ESP
Message-ID: <aaBpuRFrbnpMPeK4@Antony2201.local>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <7c30e7f8543048a384f693684ccba5f71fe8543b.1769509131.git.antony.antony@secunet.com>
 <aXyV028imsUPWSyq@krikkit>
 <aYCfVAeKGqF7MIRq@moon.secunet.de>
 <CADhJOfbkUFaPfxTBrmOnrEh2JvxPKpkxaRrSdJHZGxeoQsQTcw@mail.gmail.com>
 <aYD9O5qiA1R2KIJ_@Antony2201.local>
 <CADHa2dB+-nCHQK5nu0wKXKw+ut4wieUtoB9Gd-csr7sn8ZKjtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADHa2dB+-nCHQK5nu0wKXKw+ut4wieUtoB9Gd-csr7sn8ZKjtg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phenome.org,none];
	R_DKIM_ALLOW(-0.20)[phenome.org:s=oak1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261409-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[phenome.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,phenome.org:dkim,Antony2201.local:mid]
X-Rspamd-Queue-Id: B8B131A923E
X-Rspamd-Action: no action

Hi Yan,

On Mon, Feb 23, 2026 at 07:28:06PM -0800, Yan Yan wrote:
> Hi Antony,
> 
> Sorry for the late reply. We’ve prototyped this and confirmed that
> Android can be changed to explicitly provide the encap_tmpl in the
> MIGRATE requests. Also we are excited to have kernel support for
> encap-to-non-encap migration.

Thanks for the confirmation and prototype testing. I will send out v6 soon.

Would  you like to add any tags Tested or Reviewd...

-antony

