Return-Path: <netdev+bounces-272556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFocIE6DxmlALQUAu9opvQ
	(envelope-from <netdev+bounces-272556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:17:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1592344F91
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA59230D8C28
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5973E868A;
	Fri, 27 Mar 2026 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aElAa59X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE293BD24A
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774617089; cv=none; b=D9HCs+sdWQWSu6holIhYJuNvK7pz5wmw4GpvrYzg6tADTEzJLtTmMzYQUD/R5CrmmdqIml8a1uFIW1e/amZAAiVG3huOwcGBMa4DHuCGAGBnL+9Hni2Q7VJuF+p1LZnR347hDsgURG7jdWFjs83GDA0sAA3WW4C4f9oyGipDVO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774617089; c=relaxed/simple;
	bh=nzoQaay+raQjhTgYBaF5aWNmIVaEh6xyvzO/+HCw13g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hvy2tS5FApsiTTBfzWNPhxlEwe9MIKIovKKFkyJUxHfMvSkZsUcEUPpyZRtS409ScMVtFLVrwDPvcU59QkraJ/KT5MCllcHPEgE5ODUUYMZ70zYxEb3rfFIE+KbsuWBwieD5RvJskxt+D292X3TdY5qc86E+EGtGst96iyu+2G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aElAa59X; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486b9675d36so18628045e9.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774617086; x=1775221886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ccf0sTgtLqz3zlYVLqeO3X4QYfoZ2D16OMDmsuZJ+v4=;
        b=aElAa59XdQxBmlRKGy/6PHKqf3dejpCsQk1ZTdlDe0EaDoJKHf7iaTaIojgE/SyWa/
         T4vfxQDjQCPB/19OkOaOEQywUrv3RInGgLW2Dh9r2wW2bZ0WYMVaBFpr21HmlswMx3NV
         RpbDuaJy0eM4U7CW0b2PG/FfcsorEJDvRrtx4gW/sLl67rfV1Vp+tarO5FlArhyawTln
         KoRmUlMctIa6w1RgM60R/KN5lPSXnC1KEIGly+BzQxj63jNFyjkvBSUVgOGIhx+2Nlid
         pgcnmLOw05cEXzaC/C0VkeD6MaNfUjRiBXzCGaSmtyXoPR5GE54jlixLkdPTLJJtu2e0
         Vn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774617086; x=1775221886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ccf0sTgtLqz3zlYVLqeO3X4QYfoZ2D16OMDmsuZJ+v4=;
        b=eyBZtK7Vh8AsnkPqI0lOUDe/wr/n8jbmc8d/5Fce1T39KJtaVXyAz7sYWpAIwpp9ZY
         QPaJzsxSHMFJgc3s2fhCWCNn8i5TtO8717RCqIGfL+279mXQydCWcpUROpR9rbWBlajC
         OBfZXZEUggaMG/tMmXUskX/clnUH0ctsOlgc03Oc1+2Gp8p3j1/kQ7sajDdsI/nhZPR6
         JNu06cKF+0ZMjuBOwWUXVuZLw4HwarMzA6H8Kqc6HqDF6jySai92C/XR2HQ04nMHVrUI
         RTG77FLUSiux6y7WNavPiEifjqVorSxEaD4Dq0LcuiHnXRKkLcqLmoNW38WpDtUNCqFB
         cPRg==
X-Forwarded-Encrypted: i=1; AJvYcCVXDD/F3krpAh5UK+mEMIlcpStSm8XVuqdBWPgp4aAXdmhsUaJkl4R1Sgd5523h4d1HInbiwHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YznterTMCgtYHRsUWUrSp9iEePZ5eWbfavDxIprAlzJMI/791fq
	qv2ro7l20FGly0bbqiUS1Ead+/xOnVuhMpvXpW2END2QPHTuo1vtJ0DY310eirv/BB4=
X-Gm-Gg: ATEYQzzF1NpIXUWvY0iCa8dZ8bDqQn42yg/upvbCwPTLjKWKq4gDjEYJiStrCBuEP9D
	A76CiJUoEpTGj50IwWAtC454o2H71eZqTNSVnjLgux0jWGN7cLIjhnmxB2MDM/57oamZGSs8A1Z
	MadxYjbGWh62NmAcTyFal3jJE15zKiQHa/BAJrvoiR9ojzK30XQK24E/ykNXNhBVcRFdg8nI9L1
	/spMIatAtWNCikqj/bdv8Jg/MzWNNb7oBfkDQSdNQdimHjDYwDKq36SmcQTKqx2H2TMAEvPgZ/y
	pRuL256wCEexFGDtQMM64LHHIzjyFFbFeDsdqMWeqlSTveNsUbH/V/2OGFWCCT4+03h8Ta1gEVV
	zZhSdXnnWadITn99fZvk91ohAc6bw/Oz5tOO5yMsXRxbzSLvey9fvWct2qQz/bo7p/zQWqzvA5+
	RT1brhz+pJU+rd2n7hdeDTuDkXJA==
X-Received: by 2002:a05:600c:a108:b0:485:17a7:b9c7 with SMTP id 5b1f17b1804b1-48727d6f6d8mr35069435e9.10.1774617085665;
        Fri, 27 Mar 2026 06:11:25 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e3e8sm17747282f8f.5.2026.03.27.06.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 06:11:25 -0700 (PDT)
Date: Fri, 27 Mar 2026 14:11:23 +0100
From: Petr Mladek <pmladek@suse.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next] netfilter: nf_conntrack_h323: Correct indentation
 when H323_TRACE defined
Message-ID: <acaB-0VR1sAXPsed@pathway.suse.cz>
References: <20260326201819.3900-1-david.laight.linux@gmail.com>
 <acZSPeowuYC7ivgA@pathway.suse.cz>
 <20260327125527.13aaf590@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327125527.13aaf590@pumpkin>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272556-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,pathway.suse.cz:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1592344F91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri 2026-03-27 12:55:27, David Laight wrote:
> On Fri, 27 Mar 2026 10:47:41 +0100
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > On Thu 2026-03-26 20:18:19, david.laight.linux@gmail.com wrote:
> > > From: David Laight <david.laight.linux@gmail.com>
> > > 
> > > The trace lines are indented using PRINT("%*.s", xx, " ").
> > > Userspace will treat this as "%*.0s" and will output no characters
> > > when 'xx' is zero, the kernel treats it as "%*s" and will output
> > > a single ' ' - which is probably what is intended.
> > > 
> > > Change all the formats to "%*s" removing the default precision.
> > > This gives a single space indent when level is zero.
> > > 
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > ---
> > >  net/netfilter/nf_conntrack_h323_asn1.c | 38 +++++++++++++-------------
> > >  1 file changed, 19 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
> > > index 7b1497ed97d2..287402428975 100644
> > > --- a/net/netfilter/nf_conntrack_h323_asn1.c
> > > +++ b/net/netfilter/nf_conntrack_h323_asn1.c
> > > @@ -276,7 +276,7 @@ static unsigned int get_uint(struct bitstr *bs, int b)
> > >  static int decode_nul(struct bitstr *bs, const struct field_t *f,
> > >                        char *base, int level)
> > >  {
> > > -	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
> > > +	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
> > >  
> > >  	return H323_ERROR_NONE;
> > >  }  
> > 
> > The change is important for making the kernel %*.s handling POSIX
> > compliant. The dot '.' without any following number is handled
> > a zero precision by POSIX. It would print no space "" when
> > also the field width was zero, aka when level == 0.
> > 
> > It has no efect if the field width (@level) is always > 0 because
> > vsprintf() would add the required emptry spaces ' ' anyway.
> 
> That looks like C&P AI output...

I believe that these days AI would be able to formulate it a much better
way than me.

Best Regards,
Petr

