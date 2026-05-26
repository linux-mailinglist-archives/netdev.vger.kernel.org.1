Return-Path: <netdev+bounces-291565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO7wAtNOFWpMUQcAu9opvQ
	(envelope-from <netdev+bounces-291565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:42:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 886B15D1D25
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D82FE3008243
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821783CC306;
	Tue, 26 May 2026 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="NKvgWCRK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C492D8382
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781326; cv=none; b=iKnGyZ82iwyxCMHb1gOlhR8/8Q8mrnCV03BzuMucS4FTMvH6vl72JGL77IVQ6UckiJpyANoEEsyiUshEdx7TcwiOiP7Sc+e+/BYvQzOsTado2ych7cSqCaJD8JYWe6ehLZWsl6NwmxDURbRwwoee7i+jJ8IWFhdDaTCLpNR1cDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781326; c=relaxed/simple;
	bh=E/qFLtmVUNW34+Ixf++D++sSrm9KXhLgjM3d4kgyiZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feHjUeiJtGJFwrcnW11Goi5CL1Ru6QZy/v9/c8Cnolyz4OUsjR2vEHAh0Bf36PqLnJoYP7y6TmDCfUtYnZA4fFbtDDoQC+Aadca/JW/iLqfzHapAvieC0C/L6hcb3eNB0m9r1CuAGf41Wg6IXOQnDjUrOesIHIQKH66azlw+gyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=NKvgWCRK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso5668587f8f.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 00:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779781320; x=1780386120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/qFLtmVUNW34+Ixf++D++sSrm9KXhLgjM3d4kgyiZI=;
        b=NKvgWCRKQAxei3XOKqtyPqJk4M3SHlJ4ifdvYXIiwEnQ5aXiynfRwcz/nSWDaopK3l
         ZEMPiaD3qWuu0edhQkZ3vVixgGfySaFwv9jmPkLfcOqcNePhiVj1n6IavLhPh8Ro6OSL
         Fbc73d+w0KDbvdkxjN2eAiePbpEpeCLH+NYf6OuBHKlOwBrjQ9z1RwRcS9Qr/FlO3oGu
         bfVYvC/V5QgLXZTgmVOrMhg5H73tsSqvJQlHkfZBlkcX068aCzp7hXoBe0IMoE76dRHE
         T9NMKheRAOvBFZmmWKRyw/P7H2HJ+IJpQoJU2ZTOhVL4DFZpiuCov+OzZ/xo2pGAiTJ1
         8CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779781320; x=1780386120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/qFLtmVUNW34+Ixf++D++sSrm9KXhLgjM3d4kgyiZI=;
        b=RLregIFWrxES1ih1MtQi8r3NYfZb7FQq8aDcCCRTqklpQGJRYmp5rQxyeOqaA07RWt
         CeFMljz4ikbkq7eCVgS+3PhmE9GHy0HN+HCIeaVRl0/bimJhzkWHd16X2vycbai+0sEf
         tBO8T31LqUVB3bK1sbRiwi/0R6AaUpix4299j6XBD7KqacEoOQQeQ6QdbNBXnxN6qRcM
         4GMqXrURCAa0XHbMs1CeZNbl7+pG/nauz0ToxxpTR+eG2t6TOPnVY7EqI0GvKvNEcsR8
         fnkGbnTNV/BTeK5GzTf3IzLfcat50FGO/+lZA8CcaM9a3HT6S/SCDwBL8MlxdkqHUWcr
         oEpg==
X-Forwarded-Encrypted: i=1; AFNElJ9LTeVLLbe+fQm+kFi6Z3t6HN9cAwn5Vfcbft9bNZEafLtl0Fxv0xHS3sUza8IXnc2JUekBWcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKqJhw2BhDCyas98WuOEUdboCiAgngbd1xu49GPl88lHJHj/ad
	F90L9FiE0rg4iA8BGJJdbPkU7fKu6l0j1kFVUlVj8dv0yvp9ecVo8wWKDp99whNCJOc=
X-Gm-Gg: Acq92OHGNA1GFuO0AiDYg680kQZUlkRhb6XETKpvLQwrRGWstbjqAySLU+px7aCeqqm
	wrUrbgCZOoI/PDm/gIvFlNaJxIAStk0rzdCbxnaLquVE5eVekpE0ZksIqlBrcQmCprR+ZpLkl1C
	LcVi8dMXWCyrl2NMww5Y2rt4+WGmcZxYq6o41uXYXTiksa/boPbVJf21JzboPICAVKHSX4JbqGk
	ZvDo2qqhPoG9hYTdhvCepsKdTsgy0Pgvhpr1/JvF2D+w/t1uoeBH1ZfkE/hhPqQCTqWMmnC1Tlk
	1eP8oJkKhUohlc/nc4k+w7GUoZDD9GCX3A6AvIcPINdKML1g37zHvzAGz0R/mWs1vf8oCGLDyxg
	xRBVTyE87P61OGQxUPGpvKNA728ekkIEB2Y/G8+4ZJDx7VCE/pXC2WGQb7wsVqFTlv+wy9QSFNL
	RTZycNddVQtiENbkOjHuSXlHfw7f9z5G+U3PkE31bwu4E=
X-Received: by 2002:a05:600c:c83:b0:48e:60a3:220a with SMTP id 5b1f17b1804b1-49042250219mr286320275e9.0.1779781320072;
        Tue, 26 May 2026 00:42:00 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5caeesm34281078f8f.29.2026.05.26.00.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 00:41:59 -0700 (PDT)
Date: Tue, 26 May 2026 09:41:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, 
	Li RongQing <lirongqing@baidu.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 0/3] devlink: Add boot-time eswitch mode defaults
Message-ID: <ahVOlJdfgkRa5z0Y@FV6GYCPJ69>
References: <20260521072434.362624-1-tariqt@nvidia.com>
 <20260525124256.650fbd9d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525124256.650fbd9d@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291565-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 886B15D1D25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, May 25, 2026 at 09:42:56PM +0200, kuba@kernel.org wrote:
>On Thu, 21 May 2026 10:24:31 +0300 Tariq Toukan wrote:
>> This series adds a devlink_eswitch_mode= kernel command line parameter
>> for applying a default devlink eswitch mode during device
>> initialization.
>
>Jiri? Are you okay with this?

In general, yes. Couple of details perhaps. Let me check it more deep.

