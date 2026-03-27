Return-Path: <netdev+bounces-272480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDsuHF1TxmkkIwUAu9opvQ
	(envelope-from <netdev+bounces-272480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:52:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DAB34206E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34FAA3043BF2
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCD93DB62F;
	Fri, 27 Mar 2026 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U5TUWOg5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DC03D3334
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604867; cv=none; b=e74ir3JzoccKsjT2kLHuvb1X6kNcGfYU+gLjKJ4IMt5RSQNZdPfhP3vUPRklBLTkCpK18xcRpXrHKfdDDfFe/Q3xnQzLPPIhZTyrbag42iXmZ7hm93V4I+cJSKkDAON+OYCrLSxRmdo6jDDzn+kzmPRI4KsFMvu7YvAGEOxUqeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604867; c=relaxed/simple;
	bh=E6E2z4FS73XjsMfcdTdAK6V4UK7Fr/CAf1sLTo8wqPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nT5Dsda/Ygvle6/aTuM6FfG47dRaI907BzLdxiNw+ulN2+532lxtdHZKIz+iBytLYRYPilgylyESJGmSlXusKmLWNfTFCuGKHRZ5QC5Ry3khlBJ0q20/5nypVMO9aQ3Dz5DBhYnPh4fO0QkM6NAJXySEsDY5tO1+VlNEWZjsz9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U5TUWOg5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b983bb07eso765799f8f.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 02:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774604864; x=1775209664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2mdluSqt1yk4k5MVkcX8zZG5tNI3T4/zHh0y72VEmZo=;
        b=U5TUWOg5d8cHyanp+3uJebuL3p9oGXAOSXqYe7auYwtoKOHflKfmNuHk6dZKkyBSCZ
         au7VrkXiaf3Jg6f8HpbLNcO68Ya644FUo7tr3pceOnEQnkKNu/9LK/dDocMGBAMYpQX9
         COBBc82QROH2Gqva3TyFlCRAbCth1c8qn40jpJp2lQy4qXZXnaqAO8mBnzpChHdr7OyZ
         s/D3MJ8F0TakSgjZdfJqafE+F/kJVHBVPetytwSWpajACLrU8bqIdOV/saoBBNG6JCXv
         pjRjSsV+Tdoc6RhcSRJPPJvXPsPV2qnqDNtctU2X2NpK3hLYyKewq8dtghsgWj/09TDB
         2mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774604864; x=1775209664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mdluSqt1yk4k5MVkcX8zZG5tNI3T4/zHh0y72VEmZo=;
        b=Mo+2bdQUzY20PkpGyFNAPbUMYwoW8GyOAFxDwnPCO5igyIpq78tbs6Ff04B6UOexxB
         m8xSncHaKQklQ4RvtqSgE9xt1M4LABWluIznz5YeqIOUobYu67QRyGPN9n7t0hMcTBsd
         GRI3t8LUaFBWp1knxFfM5L05YOEMvxufqIGEyqnnbOSSXb9txjlVGkydHzGv7CVDB0W7
         N0LFUm2xmcLVWylYPeQSVQRdFn5qTfnOuFndqaSXsF0TqJm5QzMiyWXsI+Y23BtBdqia
         GAbhqEhuddwUQtEzRAhrsOYtJzKTeSAs6+StO9hznaT0P1/Xf4dweNghO907KYtGC0wv
         49Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUfgLkfGiNJb0M8bWbNmVs2xGN9YfISX8HJF+ba6tzhFTMWA57AE1XaLqhNW9GEk6fdfvjSPIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Ar/Mx8i3WPz6J0FlbsOq6DjintTcxJXAYiLZ4Gb/R7B2fz/s
	AVni9pG242+I/cUAmLoWZSSP6N6t1jfwXpKS30yQdWGZTpf07+i41SjP0fUZnFFWGDo=
X-Gm-Gg: ATEYQzxopFd8dd0y7yUuRse+MVQy8IFXWjofiQ0Gc8/fKP/1yyfFnB+G9SlF6IeCnTh
	6nFjXqyFGVGh5cWXbRl6FGlXK+7cyOfLb3I+H+476xRm9D/CHWPybhQ4/buwJk1ewi9mS10Kba0
	bfgtErMJAQqnBC/APUoxvm9JfRCVYGvvg/V0ugCiDSFsr00KuXYW8nSHA0R9zedFwsUdUZeVkP8
	KC8jA86epJ5ZjM/qIonAu+TH4JTMrj8+lcVFT3uwoqICCqdrOosfKEZsNH9ZSfnXCZANtcDgl1N
	KzC9q+s6J0+wwHAwvf640LrfVw4fH6fpRDosbvIcxEtk0dQ6QnEbtN6ncZvDQKFNuABKDisum6g
	DnruQpnIfszUWij3jaOC3SQEFOByq0L9s+Hz9IW59X4FlHLN6MuVeeXe3wwNmXDs/WYcqfbgzgQ
	ZnvLg24NCMBfIs5guy8EieUiYe/A==
X-Received: by 2002:a05:600c:8489:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-4872809fdb3mr29506825e9.25.1774604863667;
        Fri, 27 Mar 2026 02:47:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9f58fsm133350695e9.11.2026.03.27.02.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:47:43 -0700 (PDT)
Date: Fri, 27 Mar 2026 10:47:41 +0100
From: Petr Mladek <pmladek@suse.com>
To: david.laight.linux@gmail.com
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
Message-ID: <acZSPeowuYC7ivgA@pathway.suse.cz>
References: <20260326201819.3900-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326201819.3900-1-david.laight.linux@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272480-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pathway.suse.cz:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 19DAB34206E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu 2026-03-26 20:18:19, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> The trace lines are indented using PRINT("%*.s", xx, " ").
> Userspace will treat this as "%*.0s" and will output no characters
> when 'xx' is zero, the kernel treats it as "%*s" and will output
> a single ' ' - which is probably what is intended.
> 
> Change all the formats to "%*s" removing the default precision.
> This gives a single space indent when level is zero.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  net/netfilter/nf_conntrack_h323_asn1.c | 38 +++++++++++++-------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
> index 7b1497ed97d2..287402428975 100644
> --- a/net/netfilter/nf_conntrack_h323_asn1.c
> +++ b/net/netfilter/nf_conntrack_h323_asn1.c
> @@ -276,7 +276,7 @@ static unsigned int get_uint(struct bitstr *bs, int b)
>  static int decode_nul(struct bitstr *bs, const struct field_t *f,
>                        char *base, int level)
>  {
> -	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
> +	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
>  
>  	return H323_ERROR_NONE;
>  }

The change is important for making the kernel %*.s handling POSIX
compliant. The dot '.' without any following number is handled
a zero precision by POSIX. It would print no space "" when
also the field width was zero, aka when level == 0.

It has no efect if the field width (@level) is always > 0 because
vsprintf() would add the required emptry spaces ' ' anyway.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


