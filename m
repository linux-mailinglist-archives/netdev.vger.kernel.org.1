Return-Path: <netdev+bounces-244224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C726BCB2976
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 10:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E8BA30C4041
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 09:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D542F9C37;
	Wed, 10 Dec 2025 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B35kgfia"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2828221543;
	Wed, 10 Dec 2025 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765359669; cv=none; b=MSoVP4pCg3II+YVFMRpPmMjJjJmFNDNeYsIfCx871Z6PSMJdWhltzzYJssHLUeMiIsnyXN0nPxMReWgltXhpQbZ/9A9hcu9dBmZ1+fzRlwiycCqFeu0XZpDZhNrreVj4qpKn+9LaHcz5KwIg3A8H3n2lo4AXUcYZjtwBHuYQylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765359669; c=relaxed/simple;
	bh=LzWO0JcXprNZY6it3VCd7deEX1hUefCblhQkrRAi/+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nmyq8FewCDx85GUq1Ap4HHYIvpcWyHfNYJoFJjTZgcq3Q/WhKFw8ElMKMxTL9/LZWSALWq6HIVNz0aO/lrlJGVpMQgjynFKfpmoXds+Fbb/rLPoC8jz7FKJBVWKMdWap17npW1uJl3X7T5dd1XinuP2YS91GtHdc8yyMOP4BMm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B35kgfia; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765359668; x=1796895668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LzWO0JcXprNZY6it3VCd7deEX1hUefCblhQkrRAi/+w=;
  b=B35kgfiaw9g1kcxxJ+5pjfyVQFw7JZHF6CSJpFmwUsmMu+rpDko6oGf8
   +p8DBYQw/pDJoQAVhXSRwsLDpCQqAN/u7djgxpivWYCwp2oyJtin5yeg7
   z8MI2dMpPvH/GuewJJl2V3lt1ZvHmjG4RIZZIjc/Ogtzu6DCBmn/QVwQm
   4UBRnva5pcPy2zklqdgFkIWSVp6A3WXOJSwutXyvLqYhv8rhhov2OlfLN
   CoFmJZlLp5QaYPwezokBhhOfSXiJgftjrKu83AQWAe8yG/dtYtNpFMlG+
   HuL50SUSEfXC+kNm5ir06lMsdZCTuWs4b6EEmSibpgR07tVUJpv1/E1S0
   Q==;
X-CSE-ConnectionGUID: /GqXSxy2TjW9B2tJCZtIcg==
X-CSE-MsgGUID: 9QWgYfiaROa3E6/2PB18XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="92804683"
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="92804683"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 01:41:07 -0800
X-CSE-ConnectionGUID: k3vHo+EZR4Cf+0vFxfhyNg==
X-CSE-MsgGUID: Srnq+gtYQL21JexhZm7LyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="196074271"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 10 Dec 2025 01:41:02 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 20ECD93; Wed, 10 Dec 2025 10:41:02 +0100 (CET)
Date: Wed, 10 Dec 2025 10:41:02 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@netronome.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 2/9] thunderblot: Don't pass a bitfield to FIELD_GET
Message-ID: <20251210094102.GF2275908@black.igk.intel.com>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
 <20251209100313.2867-3-david.laight.linux@gmail.com>
 <20251210055617.GD2275908@black.igk.intel.com>
 <20251210093403.5b0f440e@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251210093403.5b0f440e@pumpkin>

On Wed, Dec 10, 2025 at 09:34:03AM +0000, David Laight wrote:
> On Wed, 10 Dec 2025 06:56:17 +0100
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > $subject has typo: thunderblot -> thunderbolt ;-)
> > 
> > On Tue, Dec 09, 2025 at 10:03:06AM +0000, david.laight.linux@gmail.com wrote:
> > > From: David Laight <david.laight.linux@gmail.com>
> > > 
> > > FIELD_GET needs to use __auto_type to get the value of the 'reg'
> > > parameter, this can't be used with bifields.
> > > 
> > > FIELD_GET also want to verify the size of 'reg' so can't add zero
> > > to force the type to int.
> > > 
> > > So add a zero here.
> > > 
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > ---
> > >  drivers/thunderbolt/tb.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> > > index e96474f17067..7ca2b5a0f01e 100644
> > > --- a/drivers/thunderbolt/tb.h
> > > +++ b/drivers/thunderbolt/tb.h
> > > @@ -1307,7 +1307,7 @@ static inline struct tb_retimer *tb_to_retimer(struct device *dev)
> > >   */
> > >  static inline unsigned int usb4_switch_version(const struct tb_switch *sw)
> > >  {
> > > -	return FIELD_GET(USB4_VERSION_MAJOR_MASK, sw->config.thunderbolt_version);
> > > +	return FIELD_GET(USB4_VERSION_MAJOR_MASK, sw->config.thunderbolt_version + 0);  
> > 
> > Can't this use a cast instead? If not then can you also add a comment here
> > because next someone will send a patch "fixing" the unnecessary addition.
> 
> A cast can do other (possibly incorrect) conversions, adding zero is never going
> to so any 'damage' - even if it looks a bit odd.
> 
> Actually, I suspect the best thing here is to delete USB4_VERSION_MAJOR_MASK and
> just do:
> 	/* The major version is in the top 3 bits */
> 	return sw->config.thunderbolt_version > 5;

You mean 

	return sw->config.thunderbolt_version >> 5;

?

Yes that works but I prefer then:

	return sw->config.thunderbolt_version >> USB4_VERSION_MAJOR_SHIFT;

> 
> The only other uses of thunderbolt_version are debug prints (in decimal).
> 
> 	David
> 
> > 
> > >  }
> > >  
> > >  /**
> > > -- 
> > > 2.39.5  

