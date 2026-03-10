Return-Path: <netdev+bounces-266370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOF8DZqcsGnwlAIAu9opvQ
	(envelope-from <netdev+bounces-266370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:35:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD89D258FB6
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF4E8313211A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034B13B3895;
	Tue, 10 Mar 2026 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxC2lXFK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF8F293C42
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182084; cv=none; b=lvA8+DkOe91/QRWWvo1rjH31paWZtgayMTd3hOO/o7zzsLPtE8DfXd1L8VF3u0uCV3Ld+Ou8ndNUBuUcGF4qZM3ldbJAXYn4PHvShhYsRoBCAfnZOrpnK/lnU7DXEEEX82rV1gXShUqM7hnaLJdTmKceQfd8TfSMY0dBOOTzr6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182084; c=relaxed/simple;
	bh=gA1+6V/KieO2PhMuLUC9X+yRGVh4ZS5XyQKNHLvoAmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+Y4PI/tWKXN+i5ltvqUxxmHley2XQI2QPwwuekJYzUN6+x42bM2NXxqojxYF43kzwaBp4zo4+suRDrPKq/AJ7x9fFoW4ytbi0sQW15+dOodJpJYeOSm+bWwhG8Bobx4rEBv8wBfkQzUALNonL5K9kH2egLgvoHNoQ/4oFzPT2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxC2lXFK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso22795355e9.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773182081; x=1773786881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gXU4YewdIeXEw5CIQLJ4hSfe0f5ekUOc0dg0Lb4JccA=;
        b=lxC2lXFKmikseA3TsZfT4NIQsK7xWAcFkKW6J+HU6f2PT3X4CBsQezAGCyWm9gFA6U
         TiBJYbaJnI22lwBBBmNzXhzDx/IMiwrNmyy5uROFPdM1/3fJC9ejwHcBfTGy7PoUjmDW
         Ec8NyWghX7iis/PLFwjHXLPJb5DeNvcJnzp/gPq81KQNdCLVkEO+uQT8DiifUq6kPxc6
         PZaMJzw1+anMtAsCEoat+wkGd8ntDu/rwfU6A0qlaAsU3VFOWnXb1vIl9t8KLHyM/B42
         EnvUMtIw4o0hm0vMSffj4H8k6JYZ7vJIKxLyh1gMcc7jyOA+9wlI2I37BqvTjT96ZoFE
         4nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773182081; x=1773786881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXU4YewdIeXEw5CIQLJ4hSfe0f5ekUOc0dg0Lb4JccA=;
        b=Qe9qhgW5vdYOrIOBWm0yFGNEFsYo+Jv2L39YTHsYoBf/XBbH/1VpYjMa+/oCTg7Sm8
         6hjz2NNTLUR+o+68wFIsyI+q3978xRradXRyfRtLkomqwsxRZMC2L7HX+a6HTBfkf6cm
         YLnTMQayOx1S8dIOArx/aGGn4kFf4YsyPzEe/PFrVlexDfgcITtVqkDrmprIpv+1GPkH
         QssBvLOi+xX3JTyLMlm1L/N41+Le+rsynzcSwpVMHn9UQ1R++v77OYLP83U2uGzLT2wR
         RVliRk91KDgdrw5m9qwtqYPmmXMzZvjuERjw7D4JyYVle38+IMD9o0ij3HFgab3LBdI1
         aByA==
X-Forwarded-Encrypted: i=1; AJvYcCV7InLQXrVai79SK+z438LN5WnMtH+XU5pdie8Xz/+cTdLmM6x/SSB3J7ECpYbmlZa+BDxfnsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu7/tWALCIhaSlaJkbmPnxW3ZWL+TnM5eyXtl0NYrkNXJBAeKU
	f71HCCEkndee8dU17gLZZF2X5cYCyeZzTQaGzikM9cY82acMOsqTOr18
X-Gm-Gg: ATEYQzzzsKav+dzMIXdPvQxumA7AM01JXh46NgL7Rgv95UhpA523y2A0cqVmn724pBY
	B39UoO7xoidmA1ArtJYEs8lGi4ArZnPVMUJOYcBQPlHAz/ecnQ0Ti9T87y81tFacK5zDwxXtMkr
	RiwXghHwwV7q2diaxLzkog/E4OAIoNtc0sRkyK7oJyfhS6v2EBfZy/jw15LdS9o/1VGC3KBZ9fk
	P6qYovwahcLoaJRRRr51H+W9amG85+T9QZsLSCz4zEHX23p9WMDjMB/5kQQk8leRnGt9M/TQD8F
	F9ydrcqdABNnrnooWN6fUgkrM5hehjK9UHrGpuQO9T+RyX3ZaIvu6E8xFwAAQHOMomWDHoRs5rj
	hJ3C+YQ2J4lOfMPxMGiK5fWvDMZTBbIp2CNi86LCkFVBxLX7Da8UF/ND3Se9GUO+vaQwDTCWneZ
	I94cmOS4f8L/poIj1gJ/3LHAZ/ITYWM0xCjiUwIiNu2cOwEyFl7X8Gnph58tXoKE3wcNte6MyvN
	yaRYwyvSKxnrw/+5altXoQ=
X-Received: by 2002:a05:600c:1f8e:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-4854b0ca217mr8508535e9.11.1773182080137;
        Tue, 10 Mar 2026 15:34:40 -0700 (PDT)
Received: from gandalf.schnuecks.de (p200300c14f1996009e6b00fffe39b8a7.dip0.t-ipconnect.de. [2003:c1:4f19:9600:9e6b:ff:fe39:b8a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a307bc4sm7973655e9.3.2026.03.10.15.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 15:34:39 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 21673302C729; Tue, 10 Mar 2026 23:34:39 +0100 (CET)
Date: Tue, 10 Mar 2026 23:34:39 +0100
From: Simon Baatz <gmbnomis@gmail.com>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Ahern <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com,
	Shuah Khan <shuah@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/6] tcp: implement RFC 7323 window
 retraction receiver requirements
Message-ID: <abCcf1opVAr8CvpL@gandalf.schnuecks.de>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-1-4c7f96b1ec69@gmail.com>
 <20260310095806.121d198f@elisabeth>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310095806.121d198f@elisabeth>
X-Rspamd-Queue-Id: AD89D258FB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266370-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,vger.kernel.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,gmbnomis.gmail.com];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Stefano,

On Tue, Mar 10, 2026 at 09:58:07AM +0100, Stefano Brivio wrote:
> Simon,
> 
> On Mon, 09 Mar 2026 09:02:26 +0100
> Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> 
> > [...]
> >
> > diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> > index f72eef31fa23cc584f2f0cefacdc35cae43aa52d..73aa2e0ccd1d7a6314a00c27950b019b62a3851c 100644
> > --- a/include/linux/tcp.h
> > +++ b/include/linux/tcp.h
> > @@ -316,6 +316,9 @@ struct tcp_sock {
> >  					*/
> >  	u32	app_limited;	/* limited until "delivered" reaches this val */
> >  	u32	rcv_wnd;	/* Current receiver window		*/
> > +	u32	rcv_mwnd_seq;	/* Maximum window sequence number (RFC 7323,
> > +				 * section 2.4, receiver requirements)
> > +				 */
> 
> I didn't follow the rest of the discussion but, at this point, what
> does this mean for applications (CRIU, passt) dumping/restoring socket
> data? Do they have to adapt? I couldn't find this bit of information
> anywhere in v3.

Based on our discussion, the "Setting the TCP_REPAIR_WINDOW socket
option initializes rcv_mwnd_seq" v2 change addresses TCP window
restoration.  As we said that information about window retraction is
not crucial, the window will be restored as "non-retracted", matching
prior behavior.  Therefore, there is no change to the information
that applications need to dump or restore.

-- 
Simon Baatz <gmbnomis@gmail.com>

