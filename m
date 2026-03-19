Return-Path: <netdev+bounces-269355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJf2GZezu2k8mgIAu9opvQ
	(envelope-from <netdev+bounces-269355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:28:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C44762C7DE3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 244C23058B85
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FA03A5436;
	Thu, 19 Mar 2026 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHPVmjn/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA33A1E70
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908825; cv=none; b=NEyEXrRoZCtBpepo26SRK1I1qAooFkYqU6Us1D8fpU09mizx/UAlsOkYL5ejULsUCFHRtPbSBtl8PtR7w+ZJWhM6oul9vEpM9MEQ9EIXfoJ7+lUwk7HiVmES3zm60EUJPF3WeLsn5AfqVlAYCItfLwolTO7gyDHXCjHt6x8gKEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908825; c=relaxed/simple;
	bh=HqYVtC3mc6dGwkJAJUifm8KytHDrzUNEa7mkj1LNQL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjxrXhOIGf0PzrQPUT6lyUTVHTMZ/jJX/a7KDFgrne3RtcAeIQkKIbpf5SEwqx8F+D/pvRLmNStvpZFsbXKgo/JpKo+ZBbeDJ1D+V2vcsXiU57B1lUksgKsYMmyg7R1Lz2GmduhZx6BkP/GRS7B/45i1+YGbwQjqpqrShtUK6uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHPVmjn/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aaf43014d0so2915255ad.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773908824; x=1774513624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPBsDPiJEKw2x49CZDz9l4LVQspvPGZC2EXwUPQyego=;
        b=DHPVmjn/uDNHHiES+sbGJXqAPzJX+oo03bcZ2mRldCsMGlq/9xG4/XXqFz48Ut6itY
         WZNtoK241awVXYFHsArje75otJqw5LvzMFYOvBIn1Nu1IgLrnWxvLF2C1Hy7rxb9xxpp
         PYaxdPbEBLKdAebnHl8SAlSitzrBQMYQz8AaG4ZZpbu1NGr+PswS7U1coRACJSZtcTAG
         ih1gyEyDjw9bxprwtpI+jUgZ/N5Dbjmrk+xfg/h37xyGUC07j4Me9LAhkmdgu+/q2dgO
         38AKdZv26XU9n6wq5VCqz6yUEJpOQriBbuFox+eVaecFOAXcRQROYNo8bUzCZKcFG3dq
         WuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773908824; x=1774513624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPBsDPiJEKw2x49CZDz9l4LVQspvPGZC2EXwUPQyego=;
        b=OzcirHQ05J92aqe4CbHJ9VYhuYUsMwm5vktb3W1ZD/YBRLmCPy68vkkVpYhnndG/d5
         7fVaQn+ku/J2nsQPC5BI5Ynj8JO9w9G3/6QsEtXpcbRiduEGlB+kfqsnGzEtTH2qC05F
         0iR7FcVZ/lAF+jTD9g/suJB30EVxVbwlJdpqENTjDLLldk/QncNLL2uyNqXGIbr88RX3
         /bHCz6o5Iia7rnrfKuQwB8Zp5aHR6uDl9UG3cRSl13i1kPg8l4ccJ6tL7x8pPWl328d6
         KevQoVPlzrIv2aXHsr3yKoAyWRHruaY0VZi1hAXWuSxOQUsPqJa17p2R2WXrHIjf43WJ
         vjHw==
X-Forwarded-Encrypted: i=1; AJvYcCWjtj4iYMG3yuhglZQKgTxejfvwpE+XcAr9ByiUP58y6JRrGlxMuNX+DFaTBolDQkZ2gp8+YgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhYOj4FZF7Ng4TJnmpgm7GOSySsoBkBykjfQ+L4DwEiajgX3bq
	aWNrAwfMKJkX7LaF3UEe5WJARIR9Jd4AN9AhKRpzSY4RLqJ0DQLVof9u
X-Gm-Gg: ATEYQzzrNLeHAfSQdXPwqj4rzeCdOY1QoGJiljFXFxe/n4ictjf5i1UYwpx0kHqruQl
	d+iPdyr9mwgS15FtNd5o94CZYyiurCCHQl0cKcCpMybX0Yebdn6V2gfXHrJyzIXZfEbr/genQ9x
	0GeHZ7fyGZIl0jYTqHmmRnoZX37bapNUmFiqsDuUZyZap2D9OU5ohVNrbfn+cOl/gyg+ZQjSwBn
	VYEryxvp9ocw6N67hpSg9glZpWemyUEIKskm4+zwXKBAHt5W/9KhcwIzlhFIYBinjC/XXoVFcqD
	f5lkss8ap2ov7GUkz6e+5nKSbOPz5W5W6glsIURYd7tC4FwiCgSBvakO0mja9TJFzScZANQ50LU
	hHhsOhyWcvi28R2DlUSxXNS9Odgf50WUzjOsAKVmXTnuULeMlGBRsvx+4laNxUNcLDKn9vU+CHd
	ARp5saCMThkle+PS4HE1kl7PYuKR7ECy4x5LWgWyAiAn0u+uHrV2xng4xxyGc=
X-Received: by 2002:a17:902:e88e:b0:2b0:52b7:e82 with SMTP id d9443c01a7336-2b06e34e6aemr58905515ad.16.1773908823911;
        Thu, 19 Mar 2026 01:27:03 -0700 (PDT)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e5ef519sm51444565ad.49.2026.03.19.01.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 01:27:03 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:26:59 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xmei5@asu.edu
Subject: Re: [PATCH net] nfnetlink_osf: validate individual option lengths in
 fingerprints
Message-ID: <abuzU_JBGITyp0yo@SLSGDTSWING002>
References: <20260319073243.1176330-2-bestswngs@gmail.com>
 <abuuKHbFhnwZ4vwM@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abuuKHbFhnwZ4vwM@strlen.de>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269355-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C44762C7DE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-03-19 09:04, Florian Westphal wrote:
> bestswngs@gmail.com <bestswngs@gmail.com> wrote:
> > From: Weiming Shi <bestswngs@gmail.com>
> > 
> > nfnl_osf_add_callback() validates opt_num bounds and string
> > NUL-termination but does not check individual option length fields.
> > A zero-length option causes nf_osf_match_one() to enter the option
> > matching loop even when foptsize sums to zero, which matches packets
> > with no TCP options where ctx->optp is NULL:
> 
> Would you mind if i squash:
> 
> diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
> --- a/net/netfilter/nfnetlink_osf.c
> +++ b/net/netfilter/nfnetlink_osf.c
> @@ -302,6 +302,7 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
>  {
>         struct nf_osf_user_finger *f;
>         struct nf_osf_finger *kf = NULL, *sf;
> +       unsigned int tot_opt_len = 0;
>         int err = 0;
>         int i;
> 
> @@ -320,10 +321,14 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
>                 return -EINVAL;
> 
>         for (i = 0; i < f->opt_num; i++) {
> -               if (!f->opt[i].length)
> +               if (!f->opt[i].length || f->opt[i].length > MAX_IPOPTLEN)
>                         return -EINVAL;
>                 if (f->opt[i].kind == OSFOPT_MSS && f->opt[i].length < 4)
>                         return -EINVAL;
> +
> +               tot_opt_len += f->opt[i].length;
> +               if (tot_opt_len > MAX_IPOPTLEN)
> +                       return -EINVAL;
>         }
> 
>         if (!memchr(f->genre, 0, MAXGENRELEN) ||
> 
> There is a runtime check (WTF) for this already, but arguably it
> better belongs here.
Hi Florian,

No problem, please go ahead. Thanks for improving it.

Weiming Shi


