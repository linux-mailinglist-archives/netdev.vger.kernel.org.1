Return-Path: <netdev+bounces-265797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJnQIsVYr2lJUgIAu9opvQ
	(envelope-from <netdev+bounces-265797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:33:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02003242B14
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F01B8301A400
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 23:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E2137C921;
	Mon,  9 Mar 2026 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRv559xf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D8A298CB2
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773099201; cv=none; b=PLfAVxn+EMYO3uGhze/YcNvJgNUSTPaQViD7XljDwmWN+2bX+iMY0sJazVU1gqkPE33WvzvqlxGJJ6iq/L7hDJtqk/NWipQPwyutZnHMgwr8gPPKCM65aMcQuckvOZMBpB82yPgsrrJOqOSABTGKjNtvRG76adTJiCf4jHZZRt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773099201; c=relaxed/simple;
	bh=7kkr+1TOtZSbaglVFoVg4KOaDU6whENoQ2TX1zfkbAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uE5pMQPf/jFi88iPLpXy9pIT5rMaOz+dLrkwCZGkJCimQ5IrzQXFqADHaKqV1b6IUrlOUJADOoyB9UGOP357s3uU4dz+l46F0rsqi+laczaeMBhq5XxT48uKCWDayEgQOIPUxFuPHMk77tmTC2AO62In7sjcLpb+0hCh4w/aoZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRv559xf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4853a5ffc05so3551255e9.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773099198; x=1773703998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=62yt7dEgPWyMK+aJk933j6pcd+oonuEwR1Fp5bvProg=;
        b=IRv559xftMMaeGE6fBtt5BXZv49mxiQL5p1IXIPA50KJfEvE6R3J5bQCMMAG1svveQ
         PiOBwdzKZ5Al7EsRp1HFj06omMeCWhphoFItq/WWjU3RujUJ9awG7h0HPNf6piPKeXIk
         dbWa1E9COswMvEmLe6tV1gzgC5Ti4oLNtSm1NrkzLsceUYrzk6FMM/F0yiE4f9yEJB7A
         5Nf+XcUSS/Wn+LijfYvTs37c+Qc5epQJzCPXRMTvDz8/2wbxLeKYJpmES5L4kTh3MnQ6
         VBmqWQLXnfg9un9QfN3GMA7wZEo3J6YYOmgWUf982MUjuo2YYrqSfYrH5LQ41lbr+lDl
         5GpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773099198; x=1773703998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62yt7dEgPWyMK+aJk933j6pcd+oonuEwR1Fp5bvProg=;
        b=QhA+1AmRSA7bS6Dw925BPL+nqxMUyaqR9E15+vnKl0TjgyXCQ+HENJCvC4r+Jkc/Ql
         AU2rOb09qsnb62NZOrpmAv9IOK2gYem9zNomnQr2YHtKhtIJQoDAvth0TRvlkWF6ZG55
         d4LAKIn/V9HNDv60kRTm5aGg2Be410Wf8uDNnZlB+fOOCWvIn4URC/bs64nP/j/RUvUG
         Hrxx7ENNrrpxAP1MRhwrcNDJxlipPeovz8bJeURbgL9gJyCJcCm2u060DRHg0FAR/gbd
         jHF9SscS3O+cbuXo2jnaF4PiBScwNtraVPId8A41JLmOahz+iHtsSSS6uPlEzyEEi9fv
         +jfw==
X-Forwarded-Encrypted: i=1; AJvYcCV7Ud6Akj0nSNcgCYE9sLcNpt+m1SVRv+OoQ8WYfbz+3O0OI3YoEUpn8g3J5cdXgJ/iDbOyav8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyUoKoGayXtf73F3dugzdqp2OMqEDCizWWH406wz0Ga+sj/+85
	iQIz1G5le/tgDwfwNtWpEHy7uCzHJwxI89YGKQXxiJ7qXM81s+kliC1SvEW2bX1b
X-Gm-Gg: ATEYQzyA6ildK4yw3VI/9vWpij5Y2OgRTHRmLo+fo8z1fao7FQZb7xFm93CWmX840kV
	5nakoHJzFcmQ15tuj/uue6rt1q8LLDfFwoKokiKs+Ph2mMSGxkUCdKuJrO5h6lleKOr7NUcQTqs
	1de+sht73PCcVPYFnJqDTMMtE1R7UCQdvWXEHOl2pFr73XZmU6kTZ0mU2THokbhVT+UrbCZ96xX
	h+7xM/X5aC/f5BcRPxIaOJ6Txg6FLtl8r8dZYb+XIIR4sloZoutx8LSatUJdIFkRQstatlIE4kc
	0rzy/go/37trNn8AxSVhoff+2aEz5DRfjO0phczJb7UclU/NPVZlwmpWY8lH7/T4YxB6QqdoKyQ
	8POg/rChSEzgaXdPVbM9viKj1c6JZx02uSggjo1tPtrPh56PdIcxb8XVesOKXAHhyQCZ0nyYl+m
	vFQTk+/H1ky7AJOIemnawzbMyH
X-Received: by 2002:a05:600c:4e43:b0:485:3fc3:e8e9 with SMTP id 5b1f17b1804b1-4853fc3ea5cmr25684925e9.3.1773099198283;
        Mon, 09 Mar 2026 16:33:18 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d00a:e00:8799:3a7d:3c86:3200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485419b8526sm30129005e9.0.2026.03.09.16.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 16:33:17 -0700 (PDT)
Date: Tue, 10 Mar 2026 01:33:14 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next 1/2] dsa: tag_mxl862xx: set
 dsa_default_offload_fwd_mark()
Message-ID: <20260309233314.7ihvn6hahafynowv@skbuf>
References: <cover.1772853341.git.daniel@makrotopia.org>
 <d9d8e6058e635c1fdd4689c875204d48d0235295.1772853341.git.daniel@makrotopia.org>
 <3bee5ef1-0692-4779-832f-193017810c38@gmail.com>
 <aa2TYxEHQ91SbT3A@makrotopia.org>
 <CAOiHx=n9_asSiAhB=aZKRenh6BsBAYP_3i7WxfBsbUBDz3BrWw@mail.gmail.com>
 <aa4OJ7hkqoR6oDxZ@makrotopia.org>
 <CAOiHx==-3Wa54Y+CbkVjwqDwjHk4Rf-uy9ujwc77tQn3kbN9sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx==-3Wa54Y+CbkVjwqDwjHk4Rf-uy9ujwc77tQn3kbN9sQ@mail.gmail.com>
X-Rspamd-Queue-Id: 02003242B14
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265797-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[makrotopia.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:07:07AM +0100, Jonas Gorski wrote:
> For dynamic configuration you would probably need to then check the
> destination address, check if snooping or trapping is configured for
> it, and then set (not) mark offloaded accordingly. While linux allows
> you do dynamically configure some of the groups between
> flooding/trapping, I'm not sure if this is propagated via dsa or even
> switchdev.
> 
> I suggest sticking to the default of trapping and not marking as
> offloaded. It's much easier to flood in software if needed than the
> other way round.
> 
> Best regards,
> Jonas

+1, good comments, thanks.

The group_fwd_mask isn't offloaded to switchdev.

