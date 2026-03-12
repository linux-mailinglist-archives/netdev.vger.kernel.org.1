Return-Path: <netdev+bounces-267103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAhpKGfOsmmPPwAAu9opvQ
	(envelope-from <netdev+bounces-267103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:32:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7E927365A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 527D0300BE2C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CF336C9F5;
	Thu, 12 Mar 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kt1cPIX4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B5C35B64D
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325802; cv=none; b=fabfB2Qfi6PBlDR1jIT00PraP7GU1dcRavv4PLM7ssMF9yYz6b3DDMo0GW/A8+lrd2hiuo7WNLfKQFUmqHzOUK7l/F+/Q6JwxXUnaQURfo3k78B9heZjZcBm4GwqyJXZxKKLxfPciYVojC505klMRW9ByVhQUtnH8UvX8TfaUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325802; c=relaxed/simple;
	bh=UWFL9/AlWB4G82QemscP/h3YWNXqRlJRdDFLB62NK4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/wj7U0Hvk91XvX60uB9d+BKKrSG/a8vLNej7JyYL0xPgOO8AGPk6H8H1z0BybjFAoNq/INxYyphxOTibb/P6HOrzbgNfL3EvEHmsr+TsJCfXOr17UtwQAc8PQNtCi9uFbUFqI3kBEDxbRs0twBmibEziyCwCgTqCU8E4czQlQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=kt1cPIX4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439fe4985efso950676f8f.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773325797; x=1773930597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EujO5n+9D3v/kt3E/tW4gqS3T8Dw8WwoBPDrs2+L3Eg=;
        b=kt1cPIX4SQMB3s7vdIw+iPpUjsp3fMEmpWCWkgExSGiljACs3dH/SJEMPuwFTVyT5Y
         QmcjwoYDTsnp0U1t/uc5GiqxTtSymRj1UHH89MIj7QAHXJJhhOH3KEO0Pu91F2b5I/yp
         2Zn2OZiNSS2REBgKuYUmmrgpj49h3LAWb/SmYINg6F2GiI1ijqgww1IQM1v6y6VrBLuJ
         aJ9x/lwL06WR7B+RlG1L80o7MtVM67Nk2sCZIsJGUv7taEF6pWthUs9KYZ03ymFvNgPi
         xZPYN468g4F8vKHGozCDxG4eVhEqgihGfhvQ7bgSmUsMkM3m0aUTPG2lzTDPzQzyy7kH
         Wc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773325797; x=1773930597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EujO5n+9D3v/kt3E/tW4gqS3T8Dw8WwoBPDrs2+L3Eg=;
        b=jtjUxw2w7AUK+bzONk6a+RNWXYdsu27BqIG/tyqMhus2diZOFarlx6ik5ZZbanSrWh
         s0vXToHI7ckZbKaAPkcdtYsdnS7v+zJKX4SXMbSt5aJh3ZvgI8gaW6UuJQAnFA0vfMx9
         h/SAB3XKFzdKAu0OxiAvzC62sJ/5xRCWXcIIaXZHXBxVI6cYRWZfHMQhgTTmZQNpKbVp
         krnSxc6bZorpkkGq/VcnXC59QIPIiMP/fh9lRZZlwChQ200uEaapey58olj7DOcEvYp7
         BcTit7hi9hYjVZ1qZAptnDk286x1P0E+ZgMvpUwO5FrOp9fHzwW/owK3EsJIVHBJOc67
         rHvg==
X-Forwarded-Encrypted: i=1; AJvYcCWXcQNWbeGqF7sw271QUxCoVBNj1Qs6FmtmWXPZigxnE0iSdplhsWdaJL5LGglMNx8mnEWULGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+FV5Idgc0i/TQat0U0lVs8YD/wm9dj8WlwEDcVGftfi/sx/J
	WRo3mRiSvIxoEM/VoYroDwYeRR+eL2KXWYTir60T0fmtJnXTIAsSIZA4q9BU33SG3x0=
X-Gm-Gg: ATEYQzy3tDHo8MXRhw6KiuwQKh+Q5qzKHgnmbkcFMBxeze6Wqqj373y4pqtsIbrRA+u
	l7Wg2aSO1/9IUzURP4x7PvnY77Jl98L48U6T4EKJXtDcECQwz1+PvA0Ro2XcoXRm60ntkKPaMmQ
	9220ltCQVXdvUSaKdd/XlxVksA8XmoWwe/hwBiYsoS8FlAYet1xJqNm3QRftMadKsBkzpuF963f
	3/1Zbwt60QskY+Ywln8CnI1ntPbSOGFwty0dc1p/KkT9g+GftQXprDqefIVWD1OVGMZbdHpjyyX
	oZyu/iBCz6CpfYbDacYqjbKT3EZSpamNmJ1IZEsWQ3CIIKFT1b4r+Qqx0AYWzkJGKZY55GNjrxZ
	Uoa0erwXFleoG2PUuWM6RTB4TaQbZ+BLiRhaIB76p3jDnDBzLolfJgQpNFa0JQ7s5aXDz0uVWsa
	xd7Z0e4yMSXH6JOdmKeiTAbpgssfE0aqY=
X-Received: by 2002:a5d:5f86:0:b0:439:c279:32e9 with SMTP id ffacd0b85a97d-439f8423c4cmr12520707f8f.39.1773325797433;
        Thu, 12 Mar 2026 07:29:57 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1b287dsm8471226f8f.17.2026.03.12.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 07:29:56 -0700 (PDT)
Date: Thu, 12 Mar 2026 15:29:53 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Or Har-Toov <ohartoov@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V3 00/10] devlink: add per-port resource support
Message-ID: <fw6blzybx7hmvxvqoiy7civmzbf4yuhn2xzdna4apypkuwvck7@xh7iwjt27vi6>
References: <np44uzfn6jea56uht4yq4te5clapgj7pk6ygyvkl22wxumwnvt@nrpvzjqzxenq>
 <20260305063729.7e40775d@kernel.org>
 <ni23r4jiwgc6zjjsubtl4ujjgxzwpxrylumofdwxgozfnieynm@zirlbneaz6p2>
 <20260306120301.0ebe1ab2@kernel.org>
 <74dcd7c5-8a2b-49a7-a23c-174d17a61955@nvidia.com>
 <20260309133341.7e08b35d@kernel.org>
 <5de5103e-e2e4-4b72-9c3c-22847728fbb8@nvidia.com>
 <20260311145126.7dcca532@kernel.org>
 <go5wr5qa7wxe7i4kkcbmecomshpkesr26alq4qmlbpjr72hxgt@mpwq6eufylpn>
 <20260312071916.6b759c3f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312071916.6b759c3f@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267103-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 8E7E927365A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, Mar 12, 2026 at 03:19:16PM +0100, kuba@kernel.org wrote:
>On Thu, 12 Mar 2026 09:34:52 +0100 Jiri Pirko wrote:
>> >> devlink resource show scope dev
>> >> pci/0000:03:00.0:
>> >> <resource>
>> >> pci/0000:03:00.1:
>> >> <resource>  
>> >
>> >LGTM  
>> 
>> I don't see the benefit of exposing the scope to the user to be honest.
>> I mean, dump would show all, dump with "dev" handle would be used as a
>> selector to dump only things related to "dev". What is the use case of
>> this "scope" granularity?
>
>If we follow the logic that dump should show the user relevant
>resources, no matter which sub-object they are attached to -
>having a dev specified should only filter the objects to match
>the dev, including resources which are on ports of that dev.
>
>IDK if there's a strong use case for allowing the user to set
>scope on CLI but also - I don't see why not?

At least some small sense of consistency with other dumps? Health
reporter and region does not have scope and output mixture of dev-based
and port-based objects. Why to confuse user?


>
>> >> For the do-it command:
>> >> devlink resource show pci/0000:03:00.0
>> >> pci/0000:03:00.0:
>> >> <resource>
>> >> pci/0000:03:00.0/196608:
>> >> <port-resource>
>> >> pci/0000:03:00.0/196609:
>> >> <port-resource>
>> >> 
>> >> devlink resource show pci/0000:03:00.0 scope port
>> >> pci/0000:03:00.0/196608:
>> >> <port-resource>
>> >> pci/0000:03:00.0/196609:
>> >> <port-resource>
>> >> 
>> >> devlink resource show pci/0000:03:00.0  scope dev
>> >> pci/0000:03:00.0:
>> >> <resource>  
>> >
>> >Do we have to touch doit? Maybe we should let doit be what it is now
>> >and consider it legacy going forward? doit which is in fact a filtered
>> >dump is a bit of a mistake in the first place, from Netlink's
>> >perspective.  
>> 
>> I don't think we should. If user wants doit, he is going to specify the
>> object (dev/port). If user is interested only in things related to
>> single device, he should do dump with selector (dev).
>
>Could you confirm that you're agreeing that we should leave doit as is?
>I'm not 100% sure after reading this twice :)

Yes.

